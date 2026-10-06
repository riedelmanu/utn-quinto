-- 0. Datos complementarios que el trabajo práctico necesita y la base no trae:
--    columna salario en docente, alta de los ocho docentes con su jerarquía de
--    dependencia, y asistencias de la inscripción 21, cargada sin registros.

ALTER TABLE docente ADD COLUMN IF NOT EXISTS salario NUMERIC(12,2);

TRUNCATE TABLE docente;

INSERT INTO docente (persona_id, legajo, dependede, salario) VALUES
    (1, 1001, NULL, 2400000.00),
    (2, 1002,    1, 1800000.00),
    (3, 1003,    1, 1750000.00),
    (4, 1004,    2, 1200000.00),
    (5, 1005,    2, 1150000.00),
    (6, 1006,    3, 1100000.00),
    (7, 1007,    4,  900000.00),
    (8, 1008,    4,  850000.00);

ALTER TABLE docente ALTER COLUMN salario SET NOT NULL;

INSERT INTO asistencia (inscripcion_id, fecha, horas) VALUES
    (21, DATE '2025-04-01', 4),
    (21, DATE '2025-05-01', 4),
    (21, DATE '2025-06-01', 4)
ON CONFLICT (inscripcion_id, fecha) DO NOTHING;

SELECT d.persona_id, p.apellidos, p.nombres, d.legajo, d.dependede, d.salario
FROM docente d
JOIN persona p ON p.persona_id = d.persona_id
ORDER BY d.persona_id;
