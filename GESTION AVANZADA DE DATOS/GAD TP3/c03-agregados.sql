SET search_path TO public;

DELETE FROM medicion WHERE item = 'c.6';
DROP INDEX IF EXISTS idx_personas_edad;
DROP INDEX IF EXISTS idx_personas_ciudad_edad;
ANALYZE personas;

-- c.6) Funciones agregadas sobre la columna edad, sin y con índices sobre ella.
--      Consulta 1: totales de toda la tabla. Consulta 2: los mismos agregados por
--      ciudad.

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS personas, SUM(edad) AS suma_edades, ROUND(AVG(edad), 2) AS edad_promedio
FROM personas;

CALL pr_medir('c.6', 'Totales, sin índice', $$
    SELECT COUNT(*), SUM(edad), AVG(edad) FROM personas
$$, 10);

EXPLAIN (ANALYZE, BUFFERS)
SELECT ciudad, COUNT(*) AS personas, SUM(edad) AS suma_edades,
       ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
GROUP BY ciudad
ORDER BY ciudad;

CALL pr_medir('c.6', 'Por ciudad, sin índice', $$
    SELECT ciudad, COUNT(*), SUM(edad), AVG(edad) FROM personas
    GROUP BY ciudad ORDER BY ciudad
$$, 10);

-- Índice B-Tree sobre edad: los totales se pueden calcular leyendo sólo el
-- índice (Index Only Scan), que es más chico que la tabla.

CREATE INDEX idx_personas_edad ON personas USING btree (edad);
VACUUM ANALYZE personas;

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS personas, SUM(edad) AS suma_edades, ROUND(AVG(edad), 2) AS edad_promedio
FROM personas;

CALL pr_medir('c.6', 'Totales, índice (edad)', $$
    SELECT COUNT(*), SUM(edad), AVG(edad) FROM personas
$$, 10);

-- Por ciudad, el índice sobre edad sola no alcanza: falta la ciudad.

EXPLAIN (ANALYZE, BUFFERS)
SELECT ciudad, COUNT(*) AS personas, SUM(edad) AS suma_edades,
       ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
GROUP BY ciudad
ORDER BY ciudad;

CALL pr_medir('c.6', 'Por ciudad, índice (edad)', $$
    SELECT ciudad, COUNT(*), SUM(edad), AVG(edad) FROM personas
    GROUP BY ciudad ORDER BY ciudad
$$, 10);

-- Índice compuesto (ciudad, edad): tiene las dos columnas y además entrega las
-- filas ordenadas por ciudad, así que el agrupamiento no necesita hash ni sort.

CREATE INDEX idx_personas_ciudad_edad ON personas USING btree (ciudad, edad);
VACUUM ANALYZE personas;

EXPLAIN (ANALYZE, BUFFERS)
SELECT ciudad, COUNT(*) AS personas, SUM(edad) AS suma_edades,
       ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
GROUP BY ciudad
ORDER BY ciudad;

CALL pr_medir('c.6', 'Por ciudad, índice (ciudad, edad)', $$
    SELECT ciudad, COUNT(*), SUM(edad), AVG(edad) FROM personas
    GROUP BY ciudad ORDER BY ciudad
$$, 10);

-- Ni con el índice sobre edad ni con el compuesto cambia el plan de las dos
-- consultas que recorren toda la tabla. Con random_page_cost = 1.1 (SSD, o datos en
-- memoria, que es el caso) el planificador pasa a leer sólo los índices.

SET random_page_cost = 1.1;

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS personas, SUM(edad) AS suma_edades, ROUND(AVG(edad), 2) AS edad_promedio
FROM personas;

CALL pr_medir('c.6', 'Totales, índices, random_page_cost 1.1', $$
    SELECT COUNT(*), SUM(edad), AVG(edad) FROM personas
$$, 10);

EXPLAIN (ANALYZE, BUFFERS)
SELECT ciudad, COUNT(*) AS personas, SUM(edad) AS suma_edades,
       ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
GROUP BY ciudad
ORDER BY ciudad;

CALL pr_medir('c.6', 'Por ciudad, índices, random_page_cost 1.1', $$
    SELECT ciudad, COUNT(*), SUM(edad), AVG(edad) FROM personas
    GROUP BY ciudad ORDER BY ciudad
$$, 10);

RESET random_page_cost;

-- Con el filtro por ciudad, el índice compuesto da los agregados de una sola
-- ciudad leyendo únicamente su tramo del índice.

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS personas, SUM(edad) AS suma_edades, ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
WHERE ciudad = 'Colón';

CALL pr_medir('c.6', 'Colón, índice (ciudad, edad)', $$
    SELECT COUNT(*), SUM(edad), AVG(edad) FROM personas WHERE ciudad = 'Colón'
$$, 10);

SELECT pg_size_pretty(pg_relation_size('personas'))                 AS tabla,
       pg_size_pretty(pg_relation_size('idx_personas_edad'))        AS indice_edad,
       pg_size_pretty(pg_relation_size('idx_personas_ciudad_edad')) AS indice_ciudad_edad;

SELECT ciudad, COUNT(*) AS personas, SUM(edad) AS suma_edades,
       ROUND(AVG(edad), 2) AS edad_promedio
FROM personas
GROUP BY ciudad
ORDER BY ciudad;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'c.6'
ORDER BY id;
