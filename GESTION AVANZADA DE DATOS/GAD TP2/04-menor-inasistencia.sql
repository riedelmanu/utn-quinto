-- 4. Con WITH, alumno o alumnos que acumularon la menor cantidad total de horas
--    de inasistencia durante 2025, contemplando que varios compartan el mínimo.

WITH inasistencias_por_inscripcion AS (
    SELECT i.inscripcion_id,
           i.alumno,
           COALESCE(SUM(c.horasxclase - a.horas), 0) AS horas_ausente
    FROM inscripto i
    JOIN curso      c ON c.curso_id = i.curso_id
    LEFT JOIN asistencia a
           ON a.inscripcion_id = i.inscripcion_id
          AND EXTRACT(YEAR FROM a.fecha) = 2025
    WHERE i.anio = 2025
    GROUP BY i.inscripcion_id, i.alumno
),
inasistencias_por_alumno AS (
    SELECT ii.alumno,
           SUM(ii.horas_ausente) AS total_horas_ausente
    FROM inasistencias_por_inscripcion ii
    GROUP BY ii.alumno
),
minimo AS (
    SELECT MIN(total_horas_ausente) AS horas_minimas
    FROM inasistencias_por_alumno
)
SELECT ia.alumno AS alumno_id,
       p.apellidos,
       p.nombres,
       ia.total_horas_ausente AS horas_de_inasistencia
FROM inasistencias_por_alumno ia
JOIN alumno  al ON al.persona_id = ia.alumno
JOIN persona p  ON p.persona_id  = al.persona_id
CROSS JOIN minimo m
WHERE ia.total_horas_ausente = m.horas_minimas
ORDER BY ia.alumno;

-- 4. Detalle de control: totales de todos los alumnos con cursada en 2025.

WITH inasistencias_por_inscripcion AS (
    SELECT i.inscripcion_id,
           i.alumno,
           COALESCE(SUM(c.horasxclase - a.horas), 0) AS horas_ausente
    FROM inscripto i
    JOIN curso      c ON c.curso_id = i.curso_id
    LEFT JOIN asistencia a
           ON a.inscripcion_id = i.inscripcion_id
          AND EXTRACT(YEAR FROM a.fecha) = 2025
    WHERE i.anio = 2025
    GROUP BY i.inscripcion_id, i.alumno
)
SELECT ii.alumno AS alumno_id,
       p.apellidos,
       p.nombres,
       COUNT(*)                  AS cursos_inscriptos,
       SUM(ii.horas_ausente)     AS horas_de_inasistencia
FROM inasistencias_por_inscripcion ii
JOIN persona p ON p.persona_id = ii.alumno
GROUP BY ii.alumno, p.apellidos, p.nombres
ORDER BY horas_de_inasistencia, alumno_id;
