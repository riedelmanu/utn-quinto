SET search_path TO public;

DELETE FROM medicion WHERE item IN ('b.2', 'b.3');
DROP INDEX IF EXISTS idx_precios_articulo;
DROP INDEX IF EXISTS idx_precios_articulo_fecha;
ALTER TABLE articulos DROP CONSTRAINT IF EXISTS articulos_pkey;
ANALYZE precios;

-- b.2) Precio actual del artículo 10: el de fecha más reciente que no sea
--      posterior al momento de la consulta (un precio con fecha futura todavía no
--      está vigente).

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.precio, p.fecha
FROM precios p
WHERE p.id_articulo = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

CALL pr_medir('b.2', 'Sin índice', $$
    SELECT p.precio, p.fecha FROM precios p
    WHERE p.id_articulo = 10 AND p.fecha <= now()
    ORDER BY p.fecha DESC LIMIT 1
$$, 5);

-- Índice simple sobre id_articulo: encuentra los ~80 precios del artículo, pero
-- todavía hay que ir a la tabla por cada uno y ordenarlos por fecha.

CREATE INDEX idx_precios_articulo ON precios (id_articulo);
ANALYZE precios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.precio, p.fecha
FROM precios p
WHERE p.id_articulo = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

CALL pr_medir('b.2', 'Índice (id_articulo)', $$
    SELECT p.precio, p.fecha FROM precios p
    WHERE p.id_articulo = 10 AND p.fecha <= now()
    ORDER BY p.fecha DESC LIMIT 1
$$, 20);

-- Índice compuesto (id_articulo, fecha DESC) que además incluye el precio: las
-- entradas de cada artículo ya están ordenadas de la más reciente a la más vieja,
-- así que alcanza con leer la primera, y como el precio está en el índice no hace
-- falta ir a la tabla (Index Only Scan).

CREATE INDEX idx_precios_articulo_fecha ON precios (id_articulo, fecha DESC) INCLUDE (precio);
VACUUM ANALYZE precios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.precio, p.fecha
FROM precios p
WHERE p.id_articulo = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

CALL pr_medir('b.2', 'Índice (id_articulo, fecha DESC) INCLUDE (precio)', $$
    SELECT p.precio, p.fecha FROM precios p
    WHERE p.id_articulo = 10 AND p.fecha <= now()
    ORDER BY p.fecha DESC LIMIT 1
$$, 20);

-- Tamaño de los dos índices. El simple ocupa mucho menos porque el B-Tree
-- deduplica las claves repetidas (cada id_articulo se guarda una vez con la
-- lista de sus filas); en el compuesto cada entrada es distinta.

SELECT c.relname AS indice, pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('precios', 'idx_precios_articulo', 'idx_precios_articulo_fecha')
ORDER BY pg_relation_size(c.oid) DESC;

-- El índice simple queda redundante: el compuesto sirve para cualquier búsqueda
-- por id_articulo porque es su primera columna.

DROP INDEX idx_precios_articulo;

SELECT p.id_articulo, p.precio, p.fecha
FROM precios p
WHERE p.id_articulo = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

-- b.3) Precio actual y descripción del artículo 10. La tabla articulos no tiene
--      clave primaria (CREATE TABLE AS no la crea), así que para encontrar el
--      artículo 10 hay que recorrerla entera.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, p.precio, p.fecha
FROM articulos a
JOIN precios p ON p.id_articulo = a.id
WHERE a.id = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

CALL pr_medir('b.3', 'Sin clave primaria en articulos', $$
    SELECT a.id, a.descripcion, p.precio, p.fecha
    FROM articulos a JOIN precios p ON p.id_articulo = a.id
    WHERE a.id = 10 AND p.fecha <= now()
    ORDER BY p.fecha DESC LIMIT 1
$$, 10);

ALTER TABLE articulos ADD PRIMARY KEY (id);
ANALYZE articulos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, p.precio, p.fecha
FROM articulos a
JOIN precios p ON p.id_articulo = a.id
WHERE a.id = 10
  AND p.fecha <= now()
ORDER BY p.fecha DESC
LIMIT 1;

CALL pr_medir('b.3', 'Con clave primaria en articulos', $$
    SELECT a.id, a.descripcion, p.precio, p.fecha
    FROM articulos a JOIN precios p ON p.id_articulo = a.id
    WHERE a.id = 10 AND p.fecha <= now()
    ORDER BY p.fecha DESC LIMIT 1
$$, 20);

-- La misma consulta con LATERAL. Para un solo artículo rinde igual, pero es la
-- forma que generaliza: el precio actual de muchos artículos a la vez, con una
-- lectura de una entrada del índice por artículo.

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.descripcion, pa.precio, pa.fecha
FROM articulos a
CROSS JOIN LATERAL (
    SELECT p.precio, p.fecha
    FROM precios p
    WHERE p.id_articulo = a.id
      AND p.fecha <= now()
    ORDER BY p.fecha DESC
    LIMIT 1
) pa
WHERE a.id = 10;

CALL pr_medir('b.3', 'LATERAL con clave primaria', $$
    SELECT a.id, a.descripcion, pa.precio, pa.fecha
    FROM articulos a
    CROSS JOIN LATERAL (SELECT p.precio, p.fecha FROM precios p
                        WHERE p.id_articulo = a.id AND p.fecha <= now()
                        ORDER BY p.fecha DESC LIMIT 1) pa
    WHERE a.id = 10
$$, 20);

SELECT a.id, a.descripcion, pa.precio, pa.fecha
FROM articulos a
CROSS JOIN LATERAL (
    SELECT p.precio, p.fecha
    FROM precios p
    WHERE p.id_articulo = a.id
      AND p.fecha <= now()
    ORDER BY p.fecha DESC
    LIMIT 1
) pa
WHERE a.id = 10;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('b.2', 'b.3')
ORDER BY id;
