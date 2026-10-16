SET search_path TO public;

DELETE FROM medicion WHERE item IN ('a.6', 'a.7');
DROP INDEX IF EXISTS idx_comercios_barrio_hash;
ANALYZE comercios;

-- a.6) Comercios que se encuentran en el barrio 1. El código 1 corresponde a
--      barrios.type = '1', "Cantera 25/ san jose" (ver a00-preparacion.sql).

SELECT b.type AS codigo, b.label AS barrio
FROM barrios b
WHERE b.type::INTEGER = 1;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.barrio = 1;

CALL pr_medir('a.6', 'Sin índice', $$
    SELECT * FROM comercios c WHERE c.barrio = 1
$$, 50);

-- a.7) Índice hash sobre barrio y la misma consulta.

CREATE INDEX idx_comercios_barrio_hash ON comercios USING hash (barrio);
ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.barrio = 1;

CALL pr_medir('a.7', 'Índice hash, barrio 1', $$
    SELECT * FROM comercios c WHERE c.barrio = 1
$$, 50);

-- a.7) El mismo índice no se usa para el barrio 0 (Centro): las estadísticas dicen
--      que tiene más de la mitad de los comercios, y para traer la mitad de la tabla
--      conviene leerla entera en orden.

SELECT v.valor AS barrio, ROUND(v.frecuencia::NUMERIC * 100, 2) AS porcentaje
FROM pg_stats s
CROSS JOIN LATERAL unnest(s.most_common_vals::TEXT::INTEGER[], s.most_common_freqs)
     AS v(valor, frecuencia)
WHERE s.tablename = 'comercios'
  AND s.attname = 'barrio'
ORDER BY v.frecuencia DESC
LIMIT 5;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.barrio = 0;

CALL pr_medir('a.7', 'Índice hash, barrio 0', $$
    SELECT * FROM comercios c WHERE c.barrio = 0
$$, 50);

SET enable_seqscan = off;
CALL pr_medir('a.7', 'Barrio 0 forzando el índice', $$
    SELECT * FROM comercios c WHERE c.barrio = 0
$$, 50);
RESET enable_seqscan;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('a.6', 'a.7')
ORDER BY id;
