-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 13: escenario base para funciones y procedimientos
-- Base: Facultad   |   Esquema: universidad
--
-- Va en su propio esquema porque las tablas "alumnos" y "materias"
-- de este ejercicio tienen otra estructura que las de la Parte A.
-- =============================================================

DROP SCHEMA IF EXISTS universidad CASCADE;
CREATE SCHEMA universidad;

SET search_path TO universidad;

CREATE TABLE alumnos (
    id            SERIAL PRIMARY KEY,
    nombre        TEXT NOT NULL,
    email         TEXT UNIQUE NOT NULL,
    fecha_ingreso DATE NOT NULL
);

CREATE TABLE materias (
    id       SERIAL PRIMARY KEY,
    nombre   TEXT NOT NULL,
    creditos INT NOT NULL CHECK (creditos > 0)
);

CREATE TABLE inscripciones (
    alumno_id         INT REFERENCES alumnos(id) ON DELETE CASCADE,
    materia_id        INT REFERENCES materias(id) ON DELETE CASCADE,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nota              NUMERIC(4,2) CHECK (nota >= 0 AND nota <= 10),
    PRIMARY KEY (alumno_id, materia_id)
);

-- Datos de prueba del enunciado
INSERT INTO alumnos VALUES (1, 'Ana García', 'ana@mail.com', '2023-03-01');
INSERT INTO alumnos VALUES (2, 'Luis Pérez', 'luis@mail.com', '2024-01-15');

INSERT INTO materias VALUES (1, 'Matemática', 4);
INSERT INTO materias VALUES (2, 'Física', 5);

INSERT INTO inscripciones VALUES (1, 1, '2023-03-10', 8.5);
INSERT INTO inscripciones VALUES (1, 2, '2023-04-01', 6.0);

-- Un par de filas más, para que las funciones tengan qué mostrar.
INSERT INTO alumnos  VALUES (3, 'Marta Ruiz', 'marta@mail.com', '2022-08-10');
INSERT INTO materias VALUES (3, 'Química General', 3);
INSERT INTO materias VALUES (4, 'Matemática Discreta', 6);
INSERT INTO inscripciones VALUES (3, 1, '2022-08-20', 9.5);
INSERT INTO inscripciones VALUES (3, 3, '2022-09-05', 3.5);

-- Los id se insertaron a mano: hay que reposicionar las secuencias.
SELECT setval('universidad.alumnos_id_seq',  3);
SELECT setval('universidad.materias_id_seq', 4);
