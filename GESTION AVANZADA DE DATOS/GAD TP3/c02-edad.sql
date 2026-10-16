SET search_path TO public;

DELETE FROM medicion WHERE item IN ('c.4', 'c.5');
DROP INDEX IF EXISTS idx_personas_edad;
DROP INDEX IF EXISTS idx_personas_ciudad_edad;
ANALYZE personas;

-- c.4) Personas de entre 30 y 34 años (5 de las 100 edades, un 5 % de la tabla).
--      El índice hash del c.3 no sirve para rangos: sólo resuelve igualdades.

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM personas
WHERE edad BETWEEN 30 AND 34;

CALL pr_medir('c.4', 'Rango 30-34, sin índice', $$
    SELECT * FROM personas WHERE edad BETWEEN 30 AND 34
$$, 10);

CALL pr_medir('c.4', 'Edad = 30, sin índice', $$
    SELECT * FROM personas WHERE edad = 30
$$, 10);

-- c.5) Índice B-Tree sobre edad.

CREATE INDEX idx_personas_edad ON personas USING btree (edad);
ANALYZE personas;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM personas
WHERE edad BETWEEN 30 AND 34;

CALL pr_medir('c.5', 'Rango 30-34, B-Tree', $$
    SELECT * FROM personas WHERE edad BETWEEN 30 AND 34
$$, 10);

-- Una sola edad (1 %) y un rango amplio (de 18 a 64, casi la mitad de la tabla).

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM personas
WHERE edad = 30;

CALL pr_medir('c.5', 'Edad = 30, B-Tree', $$
    SELECT * FROM personas WHERE edad = 30
$$, 10);

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM personas
WHERE edad BETWEEN 18 AND 64;

-- Si la consulta sólo necesita columnas que están en el índice, se resuelve sin
-- leer la tabla: cuántas personas hay en el rango.

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*)
FROM personas
WHERE edad BETWEEN 30 AND 34;

CALL pr_medir('c.5', 'COUNT(*) rango 30-34, B-Tree', $$
    SELECT COUNT(*) FROM personas WHERE edad BETWEEN 30 AND 34
$$, 10);

SELECT edad, COUNT(*) AS personas
FROM personas
WHERE edad BETWEEN 30 AND 34
GROUP BY edad
ORDER BY edad;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('c.4', 'c.5')
ORDER BY id;
