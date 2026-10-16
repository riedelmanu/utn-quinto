SET search_path TO public;

DELETE FROM medicion WHERE item = 'a.8';

-- a.8) Comercios del barrio Centro, en calle Galarza, con el código CLANAE del
--      rubro kioscos. El barrio y el rubro llegan por nombre, así que la consulta
--      natural resuelve los códigos con joins a barrios y clanae. Al llegar a este
--      punto existen los índices hash sobre calle (a.2) y sobre barrio (a.7).

SELECT cl.id, cl.nombre
FROM clanae cl
WHERE cl.nombre ILIKE 'kiosco%';

-- Versión 1: joins con barrios y clanae.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.calle, c.numero, b.label AS barrio, cl.nombre AS rubro
FROM comercios c
JOIN barrios b  ON b.type::INTEGER = c.barrio
JOIN clanae  cl ON cl.id = c.clanae5
WHERE b.label = 'Centro'
  AND c.calle = 'Galarza'
  AND cl.nombre ILIKE 'kiosco%'
ORDER BY c.numero;

CALL pr_medir('a.8', 'V1: joins con barrios y clanae', $$
    SELECT c.id, c.nombre, c.calle, c.numero, b.label AS barrio, cl.nombre AS rubro
    FROM comercios c
    JOIN barrios b  ON b.type::INTEGER = c.barrio
    JOIN clanae  cl ON cl.id = c.clanae5
    WHERE b.label = 'Centro' AND c.calle = 'Galarza' AND cl.nombre ILIKE 'kiosco%'
    ORDER BY c.numero
$$, 50);

-- Versión 2: los códigos se resuelven en subconsultas no correlacionadas.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.calle, c.numero
FROM comercios c
WHERE c.barrio  = (SELECT b.type::INTEGER FROM barrios b WHERE b.label = 'Centro')
  AND c.calle   = 'Galarza'
  AND c.clanae5 IN (SELECT cl.id FROM clanae cl WHERE cl.nombre ILIKE 'kiosco%')
ORDER BY c.numero;

CALL pr_medir('a.8', 'V2: subconsultas', $$
    SELECT c.id, c.nombre, c.calle, c.numero
    FROM comercios c
    WHERE c.barrio  = (SELECT b.type::INTEGER FROM barrios b WHERE b.label = 'Centro')
      AND c.calle   = 'Galarza'
      AND c.clanae5 IN (SELECT cl.id FROM clanae cl WHERE cl.nombre ILIKE 'kiosco%')
    ORDER BY c.numero
$$, 50);

-- Versión 3: códigos literales (barrio 0, CLANAE 47119), como si la aplicación
-- ya los tuviera resueltos.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id, c.nombre, c.calle, c.numero
FROM comercios c
WHERE c.barrio  = 0
  AND c.calle   = 'Galarza'
  AND c.clanae5 = '47119'
ORDER BY c.numero;

CALL pr_medir('a.8', 'V3: códigos literales', $$
    SELECT c.id, c.nombre, c.calle, c.numero
    FROM comercios c
    WHERE c.barrio = 0 AND c.calle = 'Galarza' AND c.clanae5 = '47119'
    ORDER BY c.numero
$$, 50);

-- Resultado (igual en las tres versiones).

SELECT c.id, c.nombre, c.calle, c.numero, c.productoprincipal
FROM comercios c
WHERE c.barrio = 0 AND c.calle = 'Galarza' AND c.clanae5 = '47119'
ORDER BY c.numero;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'a.8'
ORDER BY id;
