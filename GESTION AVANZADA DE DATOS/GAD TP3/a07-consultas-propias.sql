SET search_path TO public;

DELETE FROM medicion WHERE item LIKE 'a.12%';
DROP INDEX IF EXISTS idx_comercios_clanae_superficie;
DROP INDEX IF EXISTS idx_comercios_clanae;
ANALYZE comercios;

-- a.12.1) Subconsulta correlacionada. Comercios cuya superficie supera el
--         promedio de superficie de su rubro (los NULL no entran al promedio).

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.clanae5, c.superficie
FROM comercios c
WHERE c.superficie > (SELECT AVG(c2.superficie)
                      FROM comercios c2
                      WHERE c2.clanae5 = c.clanae5);

CALL pr_medir('a.12.1', 'Subconsulta correlacionada', $$
    SELECT c.id, c.nombre, c.clanae5, c.superficie
    FROM comercios c
    WHERE c.superficie > (SELECT AVG(c2.superficie) FROM comercios c2
                          WHERE c2.clanae5 = c.clanae5)
$$, 20);

-- Reescritura 1: el promedio de cada rubro se calcula una sola vez en un CTE y
-- se une con comercios.

EXPLAIN (ANALYZE, BUFFERS)
WITH promedio_rubro AS (
    SELECT c2.clanae5, AVG(c2.superficie) AS promedio
    FROM comercios c2
    GROUP BY c2.clanae5
)
SELECT c.id, c.nombre, c.clanae5, c.superficie
FROM comercios c
JOIN promedio_rubro p ON p.clanae5 = c.clanae5
WHERE c.superficie > p.promedio;

CALL pr_medir('a.12.1', 'CTE con GROUP BY y join', $$
    WITH promedio_rubro AS (
        SELECT c2.clanae5, AVG(c2.superficie) AS promedio
        FROM comercios c2 GROUP BY c2.clanae5
    )
    SELECT c.id, c.nombre, c.clanae5, c.superficie
    FROM comercios c
    JOIN promedio_rubro p ON p.clanae5 = c.clanae5
    WHERE c.superficie > p.promedio
$$, 50);

-- Reescritura 2: función de ventana, una sola pasada sobre comercios.

CALL pr_medir('a.12.1', 'Función de ventana', $$
    SELECT id, nombre, clanae5, superficie
    FROM (SELECT c.id, c.nombre, c.clanae5, c.superficie,
                 AVG(c.superficie) OVER (PARTITION BY c.clanae5) AS promedio
          FROM comercios c) t
    WHERE superficie > promedio
$$, 50);

-- Índice sobre (clanae5, superficie): la subconsulta correlacionada pasa a
-- resolverse con un Index Only Scan por fila en lugar de un Seq Scan por fila.

CREATE INDEX idx_comercios_clanae_superficie ON comercios (clanae5, superficie);
VACUUM ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.clanae5, c.superficie
FROM comercios c
WHERE c.superficie > (SELECT AVG(c2.superficie)
                      FROM comercios c2
                      WHERE c2.clanae5 = c.clanae5);

CALL pr_medir('a.12.1', 'Correlacionada con índice', $$
    SELECT c.id, c.nombre, c.clanae5, c.superficie
    FROM comercios c
    WHERE c.superficie > (SELECT AVG(c2.superficie) FROM comercios c2
                          WHERE c2.clanae5 = c.clanae5)
$$, 50);

CALL pr_medir('a.12.1', 'CTE con índice', $$
    WITH promedio_rubro AS (
        SELECT c2.clanae5, AVG(c2.superficie) AS promedio
        FROM comercios c2 GROUP BY c2.clanae5
    )
    SELECT c.id, c.nombre, c.clanae5, c.superficie
    FROM comercios c
    JOIN promedio_rubro p ON p.clanae5 = c.clanae5
    WHERE c.superficie > p.promedio
$$, 50);

DROP INDEX idx_comercios_clanae_superficie;

-- Las tres formas devuelven las mismas filas.

SELECT COUNT(*) AS comercios_sobre_el_promedio
FROM comercios c
WHERE c.superficie > (SELECT AVG(c2.superficie)
                      FROM comercios c2
                      WHERE c2.clanae5 = c.clanae5);

-- a.12.2) Joins y agregación. Las diez combinaciones barrio y rubro con más
--         comercios, con los nombres de ambos.

EXPLAIN (ANALYZE, BUFFERS)
SELECT b.label AS barrio, cl.nombre AS rubro, COUNT(*) AS comercios
FROM comercios c
JOIN barrios b  ON b.type::INTEGER = c.barrio
JOIN clanae  cl ON cl.id = c.clanae5
GROUP BY b.label, cl.nombre
ORDER BY comercios DESC, barrio, rubro
LIMIT 10;

CALL pr_medir('a.12.2', 'Join y después agrupar', $$
    SELECT b.label AS barrio, cl.nombre AS rubro, COUNT(*) AS comercios
    FROM comercios c
    JOIN barrios b  ON b.type::INTEGER = c.barrio
    JOIN clanae  cl ON cl.id = c.clanae5
    GROUP BY b.label, cl.nombre
    ORDER BY comercios DESC, barrio, rubro
    LIMIT 10
$$, 50);

-- Reescritura: se agrupa primero por los códigos, en la propia tabla comercios, y
-- recién después se buscan los nombres. El join recibe una fila por combinación
-- (unas 550) en lugar de una por comercio (unas 1900), y se agrupa por claves
-- cortas en lugar de por textos largos.

EXPLAIN (ANALYZE, BUFFERS)
SELECT b.label AS barrio, cl.nombre AS rubro, t.comercios
FROM (SELECT c.barrio, c.clanae5, COUNT(*) AS comercios
      FROM comercios c
      GROUP BY c.barrio, c.clanae5) t
JOIN barrios b  ON b.type::INTEGER = t.barrio
JOIN clanae  cl ON cl.id = t.clanae5
ORDER BY t.comercios DESC, barrio, rubro
LIMIT 10;

CALL pr_medir('a.12.2', 'Agrupar y después join', $$
    SELECT b.label AS barrio, cl.nombre AS rubro, t.comercios
    FROM (SELECT c.barrio, c.clanae5, COUNT(*) AS comercios
          FROM comercios c GROUP BY c.barrio, c.clanae5) t
    JOIN barrios b  ON b.type::INTEGER = t.barrio
    JOIN clanae  cl ON cl.id = t.clanae5
    ORDER BY t.comercios DESC, barrio, rubro
    LIMIT 10
$$, 50);

SELECT b.label AS barrio, cl.nombre AS rubro, t.comercios
FROM (SELECT c.barrio, c.clanae5, COUNT(*) AS comercios
      FROM comercios c
      GROUP BY c.barrio, c.clanae5) t
JOIN barrios b  ON b.type::INTEGER = t.barrio
JOIN clanae  cl ON cl.id = t.clanae5
ORDER BY t.comercios DESC, barrio, rubro
LIMIT 10;

-- a.12.3) Subconsulta de anti-join. Rubros del nomenclador CLANAE que no tienen
--         ningún comercio cargado, con NOT IN y con NOT EXISTS.

EXPLAIN (ANALYZE, BUFFERS)
SELECT cl.id, cl.nombre
FROM clanae cl
WHERE cl.id NOT IN (SELECT c.clanae5 FROM comercios c);

CALL pr_medir('a.12.3', 'NOT IN', $$
    SELECT cl.id, cl.nombre FROM clanae cl
    WHERE cl.id NOT IN (SELECT c.clanae5 FROM comercios c)
$$, 50);

EXPLAIN (ANALYZE, BUFFERS)
SELECT cl.id, cl.nombre
FROM clanae cl
WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id);

CALL pr_medir('a.12.3', 'NOT EXISTS', $$
    SELECT cl.id, cl.nombre FROM clanae cl
    WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id)
$$, 50);

-- Con un índice sobre comercios.clanae5 el anti-join pasa a Nested Loop: por cada
-- rubro busca en el índice y corta en la primera coincidencia.

CREATE INDEX idx_comercios_clanae ON comercios (clanae5);
VACUUM ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT cl.id, cl.nombre
FROM clanae cl
WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id);

CALL pr_medir('a.12.3', 'NOT EXISTS con índice', $$
    SELECT cl.id, cl.nombre FROM clanae cl
    WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id)
$$, 50);

DROP INDEX idx_comercios_clanae;

-- NOT IN y NOT EXISTS sólo son equivalentes si la subconsulta no devuelve NULL.
-- Con un solo comercio sin rubro, NOT IN deja de devolver filas (x NOT IN (..., NULL)
-- nunca es verdadero), mientras que NOT EXISTS no cambia. Se prueba dentro de una
-- transacción que se deshace.

BEGIN;
UPDATE comercios SET clanae5 = NULL WHERE id = 1;

SELECT 'NOT IN' AS forma, COUNT(*) AS rubros_sin_comercios
FROM clanae cl
WHERE cl.id NOT IN (SELECT c.clanae5 FROM comercios c)
UNION ALL
SELECT 'NOT EXISTS', COUNT(*)
FROM clanae cl
WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id);
ROLLBACK;

SELECT cl.id, cl.nombre
FROM clanae cl
WHERE NOT EXISTS (SELECT 1 FROM comercios c WHERE c.clanae5 = cl.id)
ORDER BY cl.id;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item LIKE 'a.12%'
ORDER BY id;
