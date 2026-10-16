SET search_path TO public;

DELETE FROM medicion WHERE item IN ('c.1', 'c.2', 'c.3');
DROP INDEX IF EXISTS idx_personas_ciudad_btree;
DROP INDEX IF EXISTS idx_personas_ciudad_hash;
DROP INDEX IF EXISTS idx_personas_edad;
DROP INDEX IF EXISTS idx_personas_ciudad_edad;
ANALYZE personas;

-- c.1) Personas de Colón, sin índices sobre ciudad.

EXPLAIN ANALYZE SELECT * FROM personas WHERE ciudad = 'Colón';

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM personas WHERE ciudad = 'Colón';

CALL pr_medir('c.1', 'Sin índice', $$
    SELECT * FROM personas WHERE ciudad = 'Colón'
$$, 10);

-- c.2) Índice B-Tree sobre ciudad.

CREATE INDEX idx_personas_ciudad_btree ON personas USING btree (ciudad);
ANALYZE personas;

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM personas WHERE ciudad = 'Colón';

CALL pr_medir('c.2', 'Índice B-Tree', $$
    SELECT * FROM personas WHERE ciudad = 'Colón'
$$, 10);

-- c.2) Paraná tiene el 25 % de las filas. El planificador sigue eligiendo el
--      Bitmap Heap Scan; se compara con el Seq Scan deshabilitando el bitmap.

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM personas WHERE ciudad = 'Paraná';

CALL pr_medir('c.2', 'Paraná, índice B-Tree', $$
    SELECT * FROM personas WHERE ciudad = 'Paraná'
$$, 10);

SET enable_bitmapscan = off;
SET enable_indexscan = off;
CALL pr_medir('c.2', 'Paraná, sin usar el índice', $$
    SELECT * FROM personas WHERE ciudad = 'Paraná'
$$, 10);
RESET enable_bitmapscan;
RESET enable_indexscan;

-- c.3) Se elimina el B-Tree y se crea un índice hash sobre ciudad.

DROP INDEX idx_personas_ciudad_btree;
CREATE INDEX idx_personas_ciudad_hash ON personas USING hash (ciudad);
ANALYZE personas;

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM personas WHERE ciudad = 'Colón';

CALL pr_medir('c.3', 'Índice hash', $$
    SELECT * FROM personas WHERE ciudad = 'Colón'
$$, 10);

-- Tamaño de cada índice sobre la misma columna. El B-Tree se recrea sólo para
-- medirlo y se vuelve a borrar.

CREATE INDEX idx_personas_ciudad_btree ON personas USING btree (ciudad);

SELECT c.relname AS relacion, am.amname AS metodo,
       pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
LEFT JOIN pg_am am ON am.oid = c.relam
WHERE c.relname IN ('personas', 'idx_personas_ciudad_btree', 'idx_personas_ciudad_hash')
ORDER BY pg_relation_size(c.oid) DESC;

DROP INDEX idx_personas_ciudad_btree;

SELECT COUNT(*) AS personas_de_colon FROM personas WHERE ciudad = 'Colón';

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('c.1', 'c.2', 'c.3')
ORDER BY id;
