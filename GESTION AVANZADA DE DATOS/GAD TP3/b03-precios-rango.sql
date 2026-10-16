SET search_path TO public;

DELETE FROM medicion WHERE item = 'b.4';
DROP INDEX IF EXISTS idx_precios_precio;
DROP INDEX IF EXISTS idx_precios_precio_articulo;
ANALYZE precios;

-- b.4) Artículos cuyos precios están entre 1000 y 1500: los que tienen al menos un
--      precio registrado en ese rango. Un 10 % de los precios cae en el rango, y
--      como cada artículo tiene unos 80, casi todos los que tienen precios califican.

-- Versión 1: join y DISTINCT para no repetir el artículo una vez por precio.

EXPLAIN (ANALYZE, BUFFERS)
SELECT DISTINCT a.id, a.descripcion, a.rubro
FROM articulos a
JOIN precios p ON p.id_articulo = a.id
WHERE p.precio BETWEEN 1000 AND 1500;

CALL pr_medir('b.4', 'JOIN + DISTINCT', $$
    SELECT DISTINCT a.id, a.descripcion, a.rubro
    FROM articulos a JOIN precios p ON p.id_articulo = a.id
    WHERE p.precio BETWEEN 1000 AND 1500
$$, 5);

-- Versión 2: EXISTS. Lo que se pregunta es si existe algún precio en el rango, y
-- así lo resuelve el motor: un semi-join que no multiplica filas ni necesita
-- eliminar duplicados después.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, a.rubro
FROM articulos a
WHERE EXISTS (SELECT 1
              FROM precios p
              WHERE p.id_articulo = a.id
                AND p.precio BETWEEN 1000 AND 1500);

CALL pr_medir('b.4', 'EXISTS (semi-join)', $$
    SELECT a.id, a.descripcion, a.rubro FROM articulos a
    WHERE EXISTS (SELECT 1 FROM precios p
                  WHERE p.id_articulo = a.id AND p.precio BETWEEN 1000 AND 1500)
$$, 5);

-- Índice sobre precio: el rango se resuelve en el índice, pero las 800.000 filas
-- están repartidas por toda la tabla y el Bitmap Heap Scan termina leyendo todas
-- sus páginas.

CREATE INDEX idx_precios_precio ON precios (precio);
ANALYZE precios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, a.rubro
FROM articulos a
WHERE EXISTS (SELECT 1
              FROM precios p
              WHERE p.id_articulo = a.id
                AND p.precio BETWEEN 1000 AND 1500);

CALL pr_medir('b.4', 'EXISTS + índice (precio)', $$
    SELECT a.id, a.descripcion, a.rubro FROM articulos a
    WHERE EXISTS (SELECT 1 FROM precios p
                  WHERE p.id_articulo = a.id AND p.precio BETWEEN 1000 AND 1500)
$$, 5);

-- Índice (precio, id_articulo): tiene las dos columnas que la subconsulta
-- necesita, así que se resuelve con un Index Only Scan sobre el 10 % del índice
-- sin tocar la tabla precios.

DROP INDEX idx_precios_precio;
CREATE INDEX idx_precios_precio_articulo ON precios (precio, id_articulo);
VACUUM ANALYZE precios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, a.rubro
FROM articulos a
WHERE EXISTS (SELECT 1
              FROM precios p
              WHERE p.id_articulo = a.id
                AND p.precio BETWEEN 1000 AND 1500);

CALL pr_medir('b.4', 'EXISTS + índice (precio, id_articulo)', $$
    SELECT a.id, a.descripcion, a.rubro FROM articulos a
    WHERE EXISTS (SELECT 1 FROM precios p
                  WHERE p.id_articulo = a.id AND p.precio BETWEEN 1000 AND 1500)
$$, 5);

SELECT COUNT(*) AS articulos_con_precios_en_rango
FROM articulos a
WHERE EXISTS (SELECT 1
              FROM precios p
              WHERE p.id_articulo = a.id
                AND p.precio BETWEEN 1000 AND 1500);

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'b.4'
ORDER BY id;
