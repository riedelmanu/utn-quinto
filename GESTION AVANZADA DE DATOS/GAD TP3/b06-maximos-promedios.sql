SET search_path TO public;

DELETE FROM medicion WHERE item IN ('b.8', 'b.9');
DROP INDEX IF EXISTS idx_mv_precios_promedio;

-- b.8) Máximo precio promedio por rubro: el rubro cuyo precio promedio es el más
--      alto. Es la consulta del b.6 más un orden descendente; FETCH FIRST 1 ROW
--      WITH TIES devuelve todos los rubros empatados en el primer lugar, si los hay.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.rubro, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
GROUP BY a.rubro
ORDER BY precio_promedio DESC
FETCH FIRST 1 ROW WITH TIES;

CALL pr_medir('b.8', 'Sobre las tablas, work_mem 4MB', $$
    SELECT a.rubro, ROUND(AVG(p.precio), 2) AS precio_promedio
    FROM precios p JOIN articulos a ON a.id = p.id_articulo
    GROUP BY a.rubro ORDER BY precio_promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 5);

SET work_mem = '64MB';
CALL pr_medir('b.8', 'Sobre las tablas, work_mem 64MB', $$
    SELECT a.rubro, ROUND(AVG(p.precio), 2) AS precio_promedio
    FROM precios p JOIN articulos a ON a.id = p.id_articulo
    GROUP BY a.rubro ORDER BY precio_promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 5);
RESET work_mem;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2) AS precio_promedio
FROM mv_precios_por_articulo m
JOIN articulos a ON a.id = m.id_articulo
GROUP BY a.rubro
ORDER BY precio_promedio DESC
FETCH FIRST 1 ROW WITH TIES;

CALL pr_medir('b.8', 'Vista materializada', $$
    SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2) AS precio_promedio
    FROM mv_precios_por_articulo m JOIN articulos a ON a.id = m.id_articulo
    GROUP BY a.rubro ORDER BY precio_promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 20);

SELECT a.rubro, ROUND(SUM(m.suma) / SUM(m.cantidad), 2) AS precio_promedio
FROM mv_precios_por_articulo m
JOIN articulos a ON a.id = m.id_articulo
GROUP BY a.rubro
ORDER BY precio_promedio DESC
FETCH FIRST 1 ROW WITH TIES;

-- b.9) Máximo precio promedio por artículo: el artículo con el promedio más alto.

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.id_articulo, ROUND(AVG(p.precio), 2) AS precio_promedio
FROM precios p
GROUP BY p.id_articulo
ORDER BY precio_promedio DESC
FETCH FIRST 1 ROW WITH TIES;

CALL pr_medir('b.9', 'Sobre la tabla precios', $$
    SELECT p.id_articulo, ROUND(AVG(p.precio), 2) AS precio_promedio
    FROM precios p GROUP BY p.id_articulo
    ORDER BY precio_promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 5);

-- Sobre la vista materializada son 99.000 filas en lugar de 8 millones.

EXPLAIN (ANALYZE, BUFFERS)
SELECT m.id_articulo, m.promedio AS precio_promedio
FROM mv_precios_por_articulo m
ORDER BY m.promedio DESC
FETCH FIRST 1 ROW WITH TIES;

CALL pr_medir('b.9', 'Vista materializada', $$
    SELECT m.id_articulo, m.promedio FROM mv_precios_por_articulo m
    ORDER BY m.promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 20);

-- Un índice sobre el promedio en la vista evita incluso ordenar: el primero del
-- índice en orden descendente es la respuesta.

CREATE INDEX idx_mv_precios_promedio ON mv_precios_por_articulo (promedio DESC);
ANALYZE mv_precios_por_articulo;

EXPLAIN (ANALYZE, BUFFERS)
SELECT m.id_articulo, m.promedio AS precio_promedio
FROM mv_precios_por_articulo m
ORDER BY m.promedio DESC
FETCH FIRST 1 ROW WITH TIES;

CALL pr_medir('b.9', 'Vista materializada + índice', $$
    SELECT m.id_articulo, m.promedio FROM mv_precios_por_articulo m
    ORDER BY m.promedio DESC FETCH FIRST 1 ROW WITH TIES
$$, 20);

SELECT m.id_articulo, m.cantidad, m.promedio AS precio_promedio,
       LEFT(a.descripcion, 30) AS descripcion, a.rubro
FROM mv_precios_por_articulo m
JOIN articulos a ON a.id = m.id_articulo
ORDER BY m.promedio DESC
FETCH FIRST 1 ROW WITH TIES;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('b.8', 'b.9')
ORDER BY id;
