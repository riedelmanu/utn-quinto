SET search_path TO public;

DELETE FROM medicion WHERE item IN ('a.1', 'a.2');
DROP INDEX IF EXISTS idx_comercios_calle_hash;

-- a.1) Comercios que se encuentran en la calle Mitre, sin índices sobre calle.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle = 'Mitre';

CALL pr_medir('a.1', 'Sin índice', $$
    SELECT * FROM comercios c WHERE c.calle = 'Mitre'
$$, 50);

-- a.2) Índice hash sobre calle y la misma consulta.

CREATE INDEX idx_comercios_calle_hash ON comercios USING hash (calle);
ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle = 'Mitre';

CALL pr_medir('a.2', 'Índice hash sobre calle', $$
    SELECT * FROM comercios c WHERE c.calle = 'Mitre'
$$, 50);

-- a.2) El índice hash sólo sirve para igualdad: con LIKE por prefijo el
--      planificador no lo puede usar y vuelve al Seq Scan.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle LIKE 'Mit%';

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('a.1', 'a.2')
ORDER BY id;
