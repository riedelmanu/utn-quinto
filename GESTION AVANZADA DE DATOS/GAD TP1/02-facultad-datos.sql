-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 3: carga de datos
-- Base: Facultad   |   Esquema: public
-- =============================================================

TRUNCATE ExamenesFinales, Correlativas, Materias, Alumnos, Carreras, Personas
    RESTART IDENTITY CASCADE;

-- -------------------------------------------------------------
-- 3.1 - Integrantes del grupo (idPersona 1 a 3)
--       + personas que completan el padrón de alumnos (4 y 5)
-- -------------------------------------------------------------
INSERT INTO Personas (idPersona, Nombres, Apellidos, Sexo, Documento, Domicilio, FechaNacimiento) VALUES
(1, 'Manuel',   'Riedel',    'masculino',
    ROW('40123456', 'DNI', 'Registro Nacional de las Personas')::TDocumento,
    ROW('Av. Vélez Sarsfield', 1611, '3', 'B')::TDomicilio, '1997-04-18'),

(2, 'Lucía',    'Fernández', 'femenino',
    ROW('39876543', 'DNI', 'Registro Nacional de las Personas')::TDocumento,
    ROW('Bv. Chacabuco', 850, NULL, NULL)::TDomicilio, '1996-11-02'),

(3, 'Tomás',    'Aguirre',   'masculino',
    ROW('41250987', 'DNI', 'Registro Nacional de las Personas')::TDocumento,
    ROW('Rondeau', 245, '1', 'A')::TDomicilio, '1998-07-25'),

(4, 'Sofía',    'Benítez',   'femenino',
    ROW('38445120', 'DNI', 'Registro Nacional de las Personas')::TDocumento,
    ROW('Duarte Quirós', 3300, '7', 'D')::TDomicilio, '1995-02-13'),

(5, 'Ignacio',  'Moretti',   'masculino',
    ROW('AAB123456', 'Pasaporte', 'Ministerio del Interior')::TDocumento,
    NULL, '1994-09-30');

-- -------------------------------------------------------------
-- 3.2 - Carrera de posgrado con 8 materias
-- -------------------------------------------------------------
INSERT INTO Carreras (idCarrera, Nombre, Titulo, Posgrado) VALUES
(1, 'Especialización en Ingeniería de Datos', 'Especialista en Ingeniería de Datos', TRUE),
(2, 'Ingeniería en Sistemas de Información',  'Ingeniero en Sistemas de Información', FALSE);

INSERT INTO Materias (idMateria, idCarrera, Nombre, Anio, Periodo, Costo) VALUES
(1, 1, 'Fundamentos de Bases de Datos Avanzadas', 1, 'Primer Cuatrimestre',  185000.00),
(2, 1, 'Estadística Aplicada a la Ingeniería',    1, 'Primer Cuatrimestre',  160000.00),
(3, 1, 'Modelado y Diseño de Datos',              1, 'Segundo Cuatrimestre', 195000.00),
(4, 1, 'Minería de Datos',                        1, 'Segundo Cuatrimestre', 210000.00),
(5, 1, 'Arquitecturas de Big Data',               2, 'Primer Cuatrimestre',  240000.00),
(6, 1, 'Aprendizaje Automático',                  2, 'Primer Cuatrimestre',  235000.00),
(7, 1, 'Gobierno y Calidad de Datos',             2, 'Segundo Cuatrimestre', 175000.00),
(8, 1, 'Trabajo Final de Especialización',        2, 'Anual',                120000.00);

-- Grafo de correlativas (5 niveles de profundidad):
--
--   1 ──┬──> 3 ──┬──> 5 ──> 7 ──┐
--       │        │              ├──> 8
--   2 ──┴──> 4 ──┴──> 6 ────────┘
--
INSERT INTO Correlativas (idMateriaRequerida, idMateria) VALUES
(1, 3),
(1, 4),
(2, 4),
(3, 5),
(4, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 8);

-- -------------------------------------------------------------
-- 3.3 - Alumnos de la carrera de posgrado
-- -------------------------------------------------------------
INSERT INTO Alumnos (idPersona, Legajo, idCarrera, FechaIngreso, FechaEgreso) VALUES
(1, 'ED-0001', 1, '2024-03-04', NULL),
(2, 'ED-0002', 1, '2024-03-04', NULL),
(3, 'ED-0003', 1, '2024-03-04', NULL),
(4, 'ED-0004', 1, '2023-03-06', '2025-12-19'),
(5, 'ED-0005', 1, '2025-03-03', NULL);

-- -------------------------------------------------------------
-- 3.4 - Exámenes finales (24 registros, aprobados y desaprobados)
--       Incluye recursadas: misma materia desaprobada y luego aprobada.
-- -------------------------------------------------------------
INSERT INTO ExamenesFinales (idExamen, idMateria, Legajo, Fecha, Nota, Estado, NumeroActa) VALUES
-- ED-0001: aprobó 1, 2, 3, 4; desaprobó 5 y después la aprobó
( 1, 1, 'ED-0001', '2024-07-25',  8.00, 'Aprobado',    'ACTA-2024-0101'),
( 2, 2, 'ED-0001', '2024-08-01',  6.50, 'Aprobado',    'ACTA-2024-0102'),
( 3, 3, 'ED-0001', '2024-12-12',  9.00, 'Aprobado',    'ACTA-2024-0233'),
( 4, 4, 'ED-0001', '2024-12-19',  7.00, 'Aprobado',    'ACTA-2024-0241'),
( 5, 5, 'ED-0001', '2025-07-24',  3.00, 'Desaprobado', 'ACTA-2025-0118'),
( 6, 5, 'ED-0001', '2025-08-14',  6.00, 'Aprobado',    'ACTA-2025-0155'),

-- ED-0002: buen promedio, va por la última
( 7, 1, 'ED-0002', '2024-07-25', 10.00, 'Aprobado',    'ACTA-2024-0101'),
( 8, 2, 'ED-0002', '2024-08-01',  9.50, 'Aprobado',    'ACTA-2024-0102'),
( 9, 3, 'ED-0002', '2024-12-12',  8.50, 'Aprobado',    'ACTA-2024-0233'),
(10, 4, 'ED-0002', '2024-12-19',  9.00, 'Aprobado',    'ACTA-2024-0241'),
(11, 5, 'ED-0002', '2025-07-24',  8.00, 'Aprobado',    'ACTA-2025-0118'),
(12, 6, 'ED-0002', '2025-07-31',  9.00, 'Aprobado',    'ACTA-2025-0126'),
(13, 7, 'ED-0002', '2025-12-11',  7.50, 'Aprobado',    'ACTA-2025-0290'),

-- ED-0003: arrancó flojo, sólo tiene las de primer año
(14, 1, 'ED-0003', '2024-07-25',  2.00, 'Desaprobado', 'ACTA-2024-0101'),
(15, 1, 'ED-0003', '2024-08-15',  5.00, 'Aprobado',    'ACTA-2024-0117'),
(16, 2, 'ED-0003', '2024-08-01',  4.00, 'Aprobado',    'ACTA-2024-0102'),
(17, 3, 'ED-0003', '2024-12-12',  3.50, 'Desaprobado', 'ACTA-2024-0233'),
(18, 3, 'ED-0003', '2025-03-13',  6.00, 'Aprobado',    'ACTA-2025-0031'),
(19, 4, 'ED-0003', '2025-03-20',  1.50, 'Desaprobado', 'ACTA-2025-0038'),

-- ED-0004: egresada, cursó la carrera completa
(20, 1, 'ED-0004', '2023-07-27',  7.00, 'Aprobado',    'ACTA-2023-0099'),
(21, 3, 'ED-0004', '2023-12-14',  8.00, 'Aprobado',    'ACTA-2023-0210'),
(22, 5, 'ED-0004', '2024-07-25',  6.50, 'Aprobado',    'ACTA-2024-0105'),
(23, 7, 'ED-0004', '2025-07-24',  9.50, 'Aprobado',    'ACTA-2025-0121'),
(24, 8, 'ED-0004', '2025-12-05', 10.00, 'Aprobado',    'ACTA-2025-0281'),

-- ED-0005: recién ingresado, un único final desaprobado
(25, 1, 'ED-0005', '2025-07-25',  3.75, 'Desaprobado', 'ACTA-2025-0119');

-- Reposicionar las secuencias, porque los id se insertaron a mano.
SELECT setval('personas_idpersona_seq',              5);
SELECT setval('carreras_idcarrera_seq',              2);
SELECT setval('materias_idmateria_seq',              8);
SELECT setval('examenesfinales_idexamen_seq',       25);
