-- 5. Con WITH, salario medio y desviación estándar de los docentes, y listado de
--    los docentes cuyo salario cae en el intervalo media ± desviación estándar.

WITH estadisticas AS (
    SELECT AVG(d.salario)             AS salario_medio,
           STDDEV_SAMP(d.salario)     AS desvio_estandar
    FROM docente d
    WHERE d.salario IS NOT NULL
)
SELECT d.persona_id      AS docente_id,
       d.legajo,
       p.apellidos,
       p.nombres,
       d.salario,
       ROUND(e.salario_medio, 2)                        AS salario_medio,
       ROUND(e.desvio_estandar, 2)                      AS desvio_estandar,
       ROUND(e.salario_medio - e.desvio_estandar, 2)    AS limite_inferior,
       ROUND(e.salario_medio + e.desvio_estandar, 2)    AS limite_superior
FROM docente d
JOIN persona p ON p.persona_id = d.persona_id
CROSS JOIN estadisticas e
WHERE d.salario IS NOT NULL
  AND d.salario BETWEEN e.salario_medio - e.desvio_estandar
                    AND e.salario_medio + e.desvio_estandar
ORDER BY d.salario DESC;

-- 5. Detalle de control: todos los docentes indicando si quedan dentro del intervalo.

WITH estadisticas AS (
    SELECT AVG(d.salario)         AS salario_medio,
           STDDEV_SAMP(d.salario) AS desvio_estandar
    FROM docente d
    WHERE d.salario IS NOT NULL
)
SELECT d.persona_id AS docente_id,
       p.apellidos,
       p.nombres,
       d.salario,
       d.salario BETWEEN e.salario_medio - e.desvio_estandar
                     AND e.salario_medio + e.desvio_estandar AS dentro_del_intervalo
FROM docente d
JOIN persona p ON p.persona_id = d.persona_id
CROSS JOIN estadisticas e
ORDER BY d.salario DESC;
