SET search_path TO public;

DELETE FROM medicion WHERE item = 'b.7';

-- b.7) Máximo precio del rubro 15 posterior a marzo de 2023, es decir, con fecha
--      desde el 1 de abril de 2023.

-- Sin índices (se deshabilitan en la sesión): Hash Join entre los artículos del
-- rubro 15 y los precios posteriores a marzo, los dos leídos completos.

SET enable_indexscan = off;
SET enable_indexonlyscan = off;
SET enable_bitmapscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT MAX(p.precio) AS precio_maximo
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
WHERE a.rubro = 15
  AND p.fecha >= DATE '2023-04-01';

CALL pr_medir('b.7', 'Sin índices', $$
    SELECT MAX(p.precio) FROM precios p JOIN articulos a ON a.id = p.id_articulo
    WHERE a.rubro = 15 AND p.fecha >= DATE '2023-04-01'
$$, 5);

RESET enable_indexscan;
RESET enable_indexonlyscan;
RESET enable_bitmapscan;

-- Con los índices creados hasta acá: los artículos del rubro 15 salen de
-- idx_articulos_rubro (y por el CLUSTER del b.1 están juntos), y para cada uno el
-- índice (id_articulo, fecha DESC) INCLUDE (precio) da directamente sus precios
-- desde abril de 2023, sin ir a la tabla.

EXPLAIN (ANALYZE, BUFFERS)
SELECT MAX(p.precio) AS precio_maximo
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
WHERE a.rubro = 15
  AND p.fecha >= DATE '2023-04-01';

CALL pr_medir('b.7', 'Con índices: Nested Loop', $$
    SELECT MAX(p.precio) FROM precios p JOIN articulos a ON a.id = p.id_articulo
    WHERE a.rubro = 15 AND p.fecha >= DATE '2023-04-01'
$$, 20);

-- Reescritura: el máximo es el primer precio en orden descendente que cumpla las
-- condiciones. Recorriendo idx_precios_precio_articulo desde el final, el Nested
-- Loop puede cortar en la primera fila que sea del rubro 15 y posterior a marzo.
-- La condición IS NOT NULL mantiene la semántica de MAX, que ignora los NULL (en
-- orden descendente los NULL van primero).

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.precio AS precio_maximo
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
WHERE a.rubro = 15
  AND p.fecha >= DATE '2023-04-01'
  AND p.precio IS NOT NULL
ORDER BY p.precio DESC
LIMIT 1;

CALL pr_medir('b.7', 'ORDER BY precio DESC LIMIT 1', $$
    SELECT p.precio FROM precios p JOIN articulos a ON a.id = p.id_articulo
    WHERE a.rubro = 15 AND p.fecha >= DATE '2023-04-01' AND p.precio IS NOT NULL
    ORDER BY p.precio DESC LIMIT 1
$$, 20);

-- Resultado, con el detalle de cuántos precios alcanzan ese máximo.

SELECT MAX(p.precio) AS precio_maximo
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
WHERE a.rubro = 15
  AND p.fecha >= DATE '2023-04-01';

SELECT COUNT(*) AS precios_con_el_maximo, COUNT(DISTINCT p.id_articulo) AS articulos
FROM precios p
JOIN articulos a ON a.id = p.id_articulo
WHERE a.rubro = 15
  AND p.fecha >= DATE '2023-04-01'
  AND p.precio = 5100;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'b.7'
ORDER BY id;
