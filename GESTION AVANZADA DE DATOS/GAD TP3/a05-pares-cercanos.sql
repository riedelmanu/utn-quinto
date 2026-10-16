SET search_path TO public;

DELETE FROM medicion WHERE item = 'a.9';
DROP INDEX IF EXISTS idx_comercios_rubro_calle_numero;
ANALYZE comercios;

-- a.9) Pares de comercios del mismo rubro (clanae5) que están cerca uno del otro:
--      misma calle y número a no más de 50 de distancia. La condición c2.id > c1.id
--      hace que cada par salga una sola vez y que un comercio no se empareje consigo.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c1.clanae5, c1.calle,
       c1.id AS id_1, c1.nombre AS comercio_1, c1.numero AS numero_1,
       c2.id AS id_2, c2.nombre AS comercio_2, c2.numero AS numero_2
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5
                 AND c2.calle   = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;

CALL pr_medir('a.9', 'Sin índice (plan elegido)', $$
    SELECT c1.id, c1.nombre, c2.id, c2.nombre
    FROM comercios c1
    JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                     AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                     AND c2.id > c1.id
$$, 50);

-- El Merge Join gasta casi todo su tiempo en los dos Sort. Prohibiéndolo, el
-- planificador cae en el Hash Join, que no ordena nada. Se muestra primero el
-- costo estimado de cada alternativa sin ejecutarlas.

EXPLAIN
SELECT c1.id, c1.nombre, c2.id, c2.nombre
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;


SET enable_mergejoin = off;

EXPLAIN
SELECT c1.id, c1.nombre, c2.id, c2.nombre
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;

CALL pr_medir('a.9', 'Sin índice, forzando Hash Join', $$
    SELECT c1.id, c1.nombre, c2.id, c2.nombre
    FROM comercios c1
    JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                     AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                     AND c2.id > c1.id
$$, 50);
RESET enable_mergejoin;

-- Los Sort son caros porque comparan texto con la collation de la base
-- (en_US.UTF-8). La misma ordenación con la collation "C" (comparación byte a byte):

SELECT datcollate FROM pg_database WHERE datname = current_database();

CALL pr_medir('a.9', 'Sólo el Sort, collation en_US', $$
    SELECT calle, clanae5 FROM comercios ORDER BY calle, clanae5
$$, 50);

CALL pr_medir('a.9', 'Sólo el Sort, collation C', $$
    SELECT calle, clanae5 FROM comercios ORDER BY calle COLLATE "C", clanae5 COLLATE "C"
$$, 50);

-- Índice B-Tree compuesto que cubre las tres condiciones del join: las dos
-- igualdades primero y el rango sobre numero al final.

CREATE INDEX idx_comercios_rubro_calle_numero ON comercios (clanae5, calle, numero);
VACUUM ANALYZE comercios;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c1.clanae5, c1.calle,
       c1.id AS id_1, c1.nombre AS comercio_1, c1.numero AS numero_1,
       c2.id AS id_2, c2.nombre AS comercio_2, c2.numero AS numero_2
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5
                 AND c2.calle   = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;

CALL pr_medir('a.9', 'Con índice (plan elegido)', $$
    SELECT c1.id, c1.nombre, c2.id, c2.nombre
    FROM comercios c1
    JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                     AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                     AND c2.id > c1.id
$$, 50);

-- Con random_page_cost = 1.1 (valor recomendado para SSD, y acá todo está en
-- memoria) el planificador deja de penalizar el acceso por índice y lo elige.

SET random_page_cost = 1.1;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c1.clanae5, c1.calle,
       c1.id AS id_1, c1.nombre AS comercio_1, c1.numero AS numero_1,
       c2.id AS id_2, c2.nombre AS comercio_2, c2.numero AS numero_2
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5
                 AND c2.calle   = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;

CALL pr_medir('a.9', 'Con índice, random_page_cost 1.1', $$
    SELECT c1.id, c1.nombre, c2.id, c2.nombre
    FROM comercios c1
    JOIN comercios c2 ON c2.clanae5 = c1.clanae5 AND c2.calle = c1.calle
                     AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                     AND c2.id > c1.id
$$, 50);

RESET random_page_cost;

-- Resultado: cantidad de pares y los primeros diez.

SELECT COUNT(*) AS pares
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5
                 AND c2.calle   = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id;

SELECT c1.clanae5, c1.calle,
       c1.nombre AS comercio_1, c1.numero AS numero_1,
       c2.nombre AS comercio_2, c2.numero AS numero_2
FROM comercios c1
JOIN comercios c2 ON c2.clanae5 = c1.clanae5
                 AND c2.calle   = c1.calle
                 AND c2.numero BETWEEN c1.numero - 50 AND c1.numero + 50
                 AND c2.id > c1.id
ORDER BY c1.calle, c1.numero, c2.numero
LIMIT 10;

-- El índice de este punto se borra: también cubre la consulta del a.10 (clanae5 y
-- calle por igualdad) y no dejaría ver el efecto del índice que pide el a.11.

DROP INDEX idx_comercios_rubro_calle_numero;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'a.9'
ORDER BY id;
