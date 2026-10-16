SET search_path TO public;

DELETE FROM medicion WHERE item = 'b.1';
DROP INDEX IF EXISTS idx_articulos_rubro;
ANALYZE articulos;

-- b.1) Artículos correspondientes al rubro 5, sin índices.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM articulos a
WHERE a.rubro = 5;

CALL pr_medir('b.1', 'Sin índice', $$
    SELECT * FROM articulos a WHERE a.rubro = 5
$$, 10);

-- Índice B-Tree sobre rubro. El rubro 5 tiene el 3,3 % de los artículos.

CREATE INDEX idx_articulos_rubro ON articulos (rubro);
ANALYZE articulos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM articulos a
WHERE a.rubro = 5;

CALL pr_medir('b.1', 'Índice B-Tree sobre rubro', $$
    SELECT * FROM articulos a WHERE a.rubro = 5
$$, 10);

-- Aun con el índice se leen casi todas las páginas de la tabla: los artículos de
-- cada rubro están desparramados (correlación de rubro cercana a 0). CLUSTER
-- reescribe la tabla en el orden del índice y deja juntos los del mismo rubro.

\timing on
CLUSTER articulos USING idx_articulos_rubro;
\timing off
ANALYZE articulos;

SELECT attname, ROUND(correlation::NUMERIC, 3) AS correlacion
FROM pg_stats
WHERE tablename = 'articulos' AND attname IN ('id', 'rubro')
ORDER BY attname;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM articulos a
WHERE a.rubro = 5;

CALL pr_medir('b.1', 'Índice B-Tree + CLUSTER', $$
    SELECT * FROM articulos a WHERE a.rubro = 5
$$, 10);

SELECT COUNT(*) AS articulos_rubro_5
FROM articulos a
WHERE a.rubro = 5;

SELECT a.id, LEFT(a.descripcion, 40) AS descripcion, a.rubro
FROM articulos a
WHERE a.rubro = 5
ORDER BY a.id
LIMIT 5;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'b.1'
ORDER BY id;
