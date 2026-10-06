-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicios 1 y 2: tipos enumerados, tipos compuestos y tablas
-- Base: Facultad   |   Esquema: public
-- =============================================================

-- Limpieza para poder reejecutar el script de punta a punta.
DROP TABLE IF EXISTS ExamenesFinales CASCADE;
DROP TABLE IF EXISTS Correlativas    CASCADE;
DROP TABLE IF EXISTS Materias        CASCADE;
DROP TABLE IF EXISTS Alumnos         CASCADE;
DROP TABLE IF EXISTS Carreras        CASCADE;
DROP TABLE IF EXISTS Personas        CASCADE;

DROP TYPE IF EXISTS TDomicilio      CASCADE;
DROP TYPE IF EXISTS TDocumento      CASCADE;
DROP TYPE IF EXISTS TEstadoExamen   CASCADE;
DROP TYPE IF EXISTS TPeriodoMateria CASCADE;
DROP TYPE IF EXISTS TipoDeDocumento CASCADE;
DROP TYPE IF EXISTS TSexo           CASCADE;


-- -------------------------------------------------------------
-- Ejercicio 1.2 - Tipos enumerados
-- -------------------------------------------------------------
CREATE TYPE TSexo           AS ENUM ('masculino', 'femenino', 'otro');
CREATE TYPE TipoDeDocumento AS ENUM ('DNI', 'Pasaporte', 'Cédula');
CREATE TYPE TPeriodoMateria AS ENUM ('Anual', 'Primer Cuatrimestre', 'Segundo Cuatrimestre');

-- El enunciado no lo pide entre los enums del Ej.1, pero la tabla
-- ExamenesFinales exige el estado (Desaprobado, Aprobado): va como enum.
CREATE TYPE TEstadoExamen   AS ENUM ('Desaprobado', 'Aprobado');


-- -------------------------------------------------------------
-- Ejercicio 1.3 - Tipos compuestos
-- -------------------------------------------------------------
CREATE TYPE TDocumento AS (
    Numero      VARCHAR(20),
    Tipo        TipoDeDocumento,
    ExpedidoPor VARCHAR(100)
);

CREATE TYPE TDomicilio AS (
    Calle        VARCHAR(100),
    Numero       INTEGER,
    Piso         VARCHAR(10),
    Departamento VARCHAR(10)
);


-- -------------------------------------------------------------
-- Ejercicio 2 - Tablas
-- -------------------------------------------------------------

CREATE TABLE Personas (
    idPersona       SERIAL       PRIMARY KEY,
    Nombres         VARCHAR(100) NOT NULL,
    Apellidos       VARCHAR(100) NOT NULL,
    Sexo            TSexo        NOT NULL,
    Documento       TDocumento   NOT NULL,
    Domicilio       TDomicilio,
    FechaNacimiento DATE         NOT NULL,
    Foto            BYTEA,
    Huella          BYTEA,
    Firma           BYTEA
);

CREATE TABLE Carreras (
    idCarrera SERIAL      PRIMARY KEY,
    Nombre    VARCHAR(50) NOT NULL,
    Titulo    VARCHAR(50) NOT NULL,
    Posgrado  BOOLEAN     NOT NULL
);

-- Las columnas que son clave foránea van INTEGER, no SERIAL:
-- SERIAL crearía una secuencia propia y un DEFAULT nextval() sobre una
-- columna cuyo valor tiene que venir de la tabla padre.
CREATE TABLE Alumnos (
    idPersona    INTEGER     NOT NULL REFERENCES Personas(idPersona),
    Legajo       VARCHAR(10) PRIMARY KEY,
    idCarrera    INTEGER     NOT NULL REFERENCES Carreras(idCarrera),
    FechaIngreso DATE        NOT NULL,
    FechaEgreso  DATE
);

CREATE TABLE Materias (
    idMateria SERIAL          PRIMARY KEY,
    idCarrera INTEGER         NOT NULL REFERENCES Carreras(idCarrera),
    Nombre    VARCHAR(100)    NOT NULL,
    Anio      INTEGER         NOT NULL CHECK (Anio BETWEEN 1 AND 5),
    Periodo   TPeriodoMateria NOT NULL,
    Costo     NUMERIC(10,2)   NOT NULL
);

CREATE TABLE Correlativas (
    idMateriaRequerida INTEGER NOT NULL REFERENCES Materias(idMateria),
    idMateria          INTEGER NOT NULL REFERENCES Materias(idMateria),
    PRIMARY KEY (idMateriaRequerida, idMateria)
);

CREATE TABLE ExamenesFinales (
    idExamen   SERIAL        PRIMARY KEY,
    idMateria  INTEGER       NOT NULL REFERENCES Materias(idMateria),
    Legajo     VARCHAR(10)   NOT NULL REFERENCES Alumnos(Legajo),
    Fecha      DATE          NOT NULL,
    Nota       NUMERIC(4,2)  NOT NULL CHECK (Nota BETWEEN 1 AND 10),
    Estado     TEstadoExamen NOT NULL,
    NumeroActa VARCHAR(20)   NOT NULL
);
