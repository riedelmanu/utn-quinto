SET search_path TO public;

DELETE FROM medicion WHERE item IN ('a.10', 'a.11');
DROP INDEX IF EXISTS idx_comercios_calle_clanae;
ANALYZE comercios;

-- a.10) Comercios de la calle 8 de junio con CLANAE 47119 (kioscos y polirrubros).
--       Sigue existiendo el índice hash sobre calle creado en el a.2.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle = '8 de junio'
  AND c.clanae5 = '47119';

CALL pr_medir('a.10', 'Hash sobre calle', $$
    SELECT * FROM comercios c WHERE c.calle = '8 de junio' AND c.clanae5 = '47119'
$$, 50);

-- a.11) B-Tree compuesto sobre (calle, clanae5) y la misma consulta.

CREATE INDEX idx_comercios_calle_clanae ON comercios USING btree (calle, clanae5);
ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle = '8 de junio'
  AND c.clanae5 = '47119';

CALL pr_medir('a.11', 'B-Tree (calle, clanae5)', $$
    SELECT * FROM comercios c WHERE c.calle = '8 de junio' AND c.clanae5 = '47119'
$$, 50);

-- a.11) El índice compuesto sirve también si se filtra sólo por calle (prefijo
--       izquierdo), pero no si se filtra sólo por clanae5, la segunda columna.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.calle = '8 de junio';

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM comercios c
WHERE c.clanae5 = '47119';

-- a.11) La consulta del a.8 (versión con códigos literales) también lo aprovecha.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.calle, c.numero
FROM comercios c
WHERE c.barrio  = 0
  AND c.calle   = 'Galarza'
  AND c.clanae5 = '47119'
ORDER BY c.numero;

CALL pr_medir('a.11', 'Consulta del a.8 (V3) con el B-Tree', $$
    SELECT c.id, c.nombre, c.calle, c.numero
    FROM comercios c
    WHERE c.barrio = 0 AND c.calle = 'Galarza' AND c.clanae5 = '47119'
    ORDER BY c.numero
$$, 50);

-- Resultado.

SELECT c.id, c.nombre, c.calle, c.numero, c.clanae5, c.productoprincipal
FROM comercios c
WHERE c.calle = '8 de junio'
  AND c.clanae5 = '47119'
ORDER BY c.numero;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('a.8', 'a.10', 'a.11')
ORDER BY id;
