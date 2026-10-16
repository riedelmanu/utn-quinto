SET search_path TO public;

DELETE FROM medicion WHERE item IN ('a.3', 'a.4', 'a.5');
DROP INDEX IF EXISTS idx_comercios_pp_btree;
DROP INDEX IF EXISTS idx_comercios_pp_hash;
ANALYZE comercios;

-- a.3) Cantidad de comercios agrupados por producto principal, sin índices.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.productoprincipal, COUNT(*) AS cantidad
FROM comercios c
GROUP BY c.productoprincipal;

CALL pr_medir('a.3', 'Sin índice', $$
    SELECT c.productoprincipal, COUNT(*) FROM comercios c GROUP BY c.productoprincipal
$$, 50);

-- a.4) Índice B-Tree sobre productoprincipal y la misma consulta. VACUUM marca
--      las páginas como visibles para todos, requisito del Index Only Scan.

CREATE INDEX idx_comercios_pp_btree ON comercios USING btree (productoprincipal);
VACUUM ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.productoprincipal, COUNT(*) AS cantidad
FROM comercios c
GROUP BY c.productoprincipal;

CALL pr_medir('a.4', 'Índice B-Tree', $$
    SELECT c.productoprincipal, COUNT(*) FROM comercios c GROUP BY c.productoprincipal
$$, 50);

-- a.5) Índice hash sobre productoprincipal. Se borra antes el B-Tree: si los dos
--      existen, el planificador sigue usando el B-Tree y no se ve el efecto del hash.

DROP INDEX idx_comercios_pp_btree;
CREATE INDEX idx_comercios_pp_hash ON comercios USING hash (productoprincipal);
ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.productoprincipal, COUNT(*) AS cantidad
FROM comercios c
GROUP BY c.productoprincipal;

CALL pr_medir('a.5', 'Índice hash', $$
    SELECT c.productoprincipal, COUNT(*) FROM comercios c GROUP BY c.productoprincipal
$$, 50);

-- a.5) El hash no se usa para agrupar, pero sí para buscar un producto puntual.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.productoprincipal, COUNT(*) AS cantidad
FROM comercios c
WHERE c.productoprincipal = 'kiosco'
GROUP BY c.productoprincipal;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('a.3', 'a.4', 'a.5')
ORDER BY id;
