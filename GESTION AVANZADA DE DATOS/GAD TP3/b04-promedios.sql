SET search_path TO public;

DELETE FROM medicion WHERE item IN ('b.5', 'b.6');
DROP MATERIALIZED VIEW IF EXISTS mv_precios_por_articulo;

-- b.5) Precio promedio por artículo. Hay que leer los 8 millones de precios y
--      formar unos 99.000 grupos. A esta altura existen los índices
--      (id_articulo, fecha DESC) INCLUDE (precio) del b.2 y (precio, id_articulo)
--      del b.4; el planificador usa el primero, que ya entrega los precios
--      ordenados por artículo.

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.id_articulo, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
GROUP BY p.id_articulo;

CALL pr_medir('b.5', 'Con índice cubriente (plan elegido)', $$
    SELECT p.id_articulo, ROUND(AVG(p.precio), 2) FROM precios p GROUP BY p.id_articulo
$$, 5);

-- Para comparar con la situación sin índices se deshabilitan los accesos por
-- índice en la sesión: el planificador queda con el Seq Scan.

SET enable_indexscan = off;
SET enable_indexonlyscan = off;
SET enable_bitmapscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.id_articulo, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
GROUP BY p.id_articulo;

CALL pr_medir('b.5', 'Sin índices, work_mem 4MB', $$
    SELECT p.id_articulo, ROUND(AVG(p.precio), 2) FROM precios p GROUP BY p.id_articulo
$$, 5);

-- El HashAggregate no entra en work_mem (4 MB por defecto) y escribe a disco
-- ("Disk Usage"). Con más memoria para la sesión se resuelve en memoria.

SET work_mem = '64MB';

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.id_articulo, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
GROUP BY p.id_articulo;

CALL pr_medir('b.5', 'Sin índices, work_mem 64MB', $$
    SELECT p.id_articulo, ROUND(AVG(p.precio), 2) FROM precios p GROUP BY p.id_articulo
$$, 5);

RESET work_mem;
RESET enable_indexscan;
RESET enable_indexonlyscan;
RESET enable_bitmapscan;

-- Las tres variantes leen todos los precios y tardan lo mismo en orden de
-- magnitud. Si el promedio se consulta seguido, lo que cambia el resultado es no
-- recalcularlo: una vista materializada guarda la suma, la cantidad y el
-- promedio de cada artículo, y se actualiza con REFRESH cuando cambian los precios.

\timing on
CREATE MATERIALIZED VIEW mv_precios_por_articulo AS
SELECT p.id_articulo,
       COUNT(*)                 AS cantidad,
       SUM(p.precio)            AS suma,
       ROUND(AVG(p.precio), 2)  AS promedio,
       MAX(p.precio)            AS maximo
FROM precios p
GROUP BY p.id_articulo;
\timing off

CREATE UNIQUE INDEX idx_mv_precios_articulo ON mv_precios_por_articulo (id_articulo);
VACUUM ANALYZE mv_precios_por_articulo;

EXPLAIN (ANALYZE, BUFFERS)
SELECT m.id_articulo, m.promedio AS precio_promedio
FROM mv_precios_por_articulo m;

CALL pr_medir('b.5', 'Vista materializada', $$
    SELECT m.id_articulo, m.promedio FROM mv_precios_por_articulo m
$$, 20);

-- REFRESH ... CONCURRENTLY (posible gracias al índice único) recalcula la vista
-- sin bloquear las lecturas.

\timing on
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_precios_por_articulo;
\timing off

SELECT COUNT(*) AS articulos, MIN(promedio) AS menor_promedio, MAX(promedio) AS mayor_promedio
FROM mv_precios_por_articulo;

SELECT m.id_articulo, m.cantidad, m.promedio AS precio_promedio
FROM mv_precios_por_articulo m
ORDER BY m.id_articulo
LIMIT 5;

-- b.6) Precio promedio por rubro. Hay que unir cada precio con su artículo para
--      saber el rubro: 8 millones de filas contra 500.000.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.rubro, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
GROUP BY a.rubro
ORDER BY a.rubro;

CALL pr_medir('b.6', 'Join y AVG, work_mem 4MB', $$
    SELECT a.rubro, ROUND(AVG(p.precio), 2)
    FROM precios p JOIN articulos a ON a.id = p.id_articulo
    GROUP BY a.rubro ORDER BY a.rubro
$$, 5);

-- La tabla hash de articulos no entra en work_mem y el join se parte en lotes que
-- pasan por disco ("Batches" y "temp read/written"). Con 64 MB entra entera.

SET work_mem = '64MB';

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.rubro, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
GROUP BY a.rubro
ORDER BY a.rubro;

CALL pr_medir('b.6', 'Join y AVG, work_mem 64MB', $$
    SELECT a.rubro, ROUND(AVG(p.precio), 2)
    FROM precios p JOIN articulos a ON a.id = p.id_articulo
    GROUP BY a.rubro ORDER BY a.rubro
$$, 5);

RESET work_mem;

-- Reescritura agregando antes del join: primero suma y cantidad por artículo y
-- después el join, que recibe 99.000 filas en lugar de 8 millones. El promedio
-- del rubro tiene que ser SUM(suma) / SUM(cantidad); el promedio de los promedios
-- daría el mismo peso a artículos con distinta cantidad de precios.

EXPLAIN (ANALYZE, BUFFERS)
WITH por_articulo AS (
    SELECT p.id_articulo, SUM(p.precio) AS suma, COUNT(*) AS cantidad
    FROM precios p
    GROUP BY p.id_articulo
)
SELECT a.rubro, ROUND(SUM(pa.suma) / SUM(pa.cantidad), 2) AS precio_promedio
FROM por_articulo pa
JOIN articulos a ON a.id = pa.id_articulo
GROUP BY a.rubro
ORDER BY a.rubro;

CALL pr_medir('b.6', 'Agregar por artículo y después join', $$
    WITH por_articulo AS (
        SELECT p.id_articulo, SUM(p.precio) AS suma, COUNT(*) AS cantidad
        FROM precios p GROUP BY p.id_articulo
    )
    SELECT a.rubro, ROUND(SUM(pa.suma) / SUM(pa.cantidad), 2)
    FROM por_articulo pa JOIN articulos a ON a.id = pa.id_articulo
    GROUP BY a.rubro ORDER BY a.rubro
$$, 5);

-- Con la vista materializada del b.5 el join es de 99.000 filas precalculadas.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2) AS precio_promedio
FROM mv_precios_por_articulo m
JOIN articulos a ON a.id = m.id_articulo
GROUP BY a.rubro
ORDER BY a.rubro;

CALL pr_medir('b.6', 'Vista materializada', $$
    SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2)
    FROM mv_precios_por_articulo m JOIN articulos a ON a.id = m.id_articulo
    GROUP BY a.rubro ORDER BY a.rubro
$$, 20);

SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2) AS precio_promedio,
       SUM(m.cantidad) AS precios
FROM mv_precios_por_articulo m
JOIN articulos a ON a.id = m.id_articulo
GROUP BY a.rubro
ORDER BY a.rubro;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('b.5', 'b.6')
ORDER BY id;
