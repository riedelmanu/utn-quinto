-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 22: integración de conceptos
--
-- Caso elegido: préstamos de una biblioteca.
-- Integra: ENUM + tipo compuesto, dominio + CHECK, arrays, JSONB,
-- PK/FK, funciones PL/pgSQL con variables y control de flujo,
-- manejo de excepciones y SQL dinámico con EXECUTE/quote_ident/USING.
-- Base: Facultad   |   Esquema: integrador
-- =============================================================

DROP SCHEMA IF EXISTS integrador CASCADE;
CREATE SCHEMA integrador;

SET search_path TO integrador;

-- ---------- Tipos y dominios ----------
CREATE TYPE estado_prestamo AS ENUM ('prestado', 'devuelto', 'vencido');

CREATE TYPE ubicacion AS (
    sala    TEXT,
    estante INT,
    nivel   INT
);

CREATE DOMAIN isbn_valido AS TEXT
    CHECK (VALUE ~ '^[0-9]{3}-[0-9]{10}$');

CREATE DOMAIN email_socio AS TEXT
    CHECK (VALUE ~ '^[^@ ]+@[^@ ]+\.[^@ ]+$');


-- ---------- Tablas ----------
CREATE TABLE libros (
    id         SERIAL PRIMARY KEY,
    titulo     TEXT        NOT NULL,
    isbn       isbn_valido NOT NULL UNIQUE,
    generos    TEXT[]      NOT NULL,
    ficha      JSONB,
    ubicacion  ubicacion,
    ejemplares INT         NOT NULL CHECK (ejemplares >= 0)
);

CREATE TABLE socios (
    id     SERIAL      PRIMARY KEY,
    nombre TEXT        NOT NULL,
    email  email_socio NOT NULL UNIQUE,
    alta   DATE        NOT NULL
);

CREATE TABLE prestamos (
    id               SERIAL          PRIMARY KEY,
    libro_id         INT             NOT NULL REFERENCES libros(id),
    socio_id         INT             NOT NULL REFERENCES socios(id),
    estado           estado_prestamo NOT NULL DEFAULT 'prestado',
    fecha_prestamo   DATE            NOT NULL DEFAULT CURRENT_DATE,
    fecha_devolucion DATE,
    CONSTRAINT ck_devolucion_posterior
        CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo)
);


-- ---------- Datos de prueba ----------
INSERT INTO libros (titulo, isbn, generos, ficha, ubicacion, ejemplares) VALUES
('El Aleph', '978-9500396073', ARRAY['cuento','fantastico'],
 '{"autor": "Jorge Luis Borges", "anio": 1949, "idiomas": ["es","en"]}',
 ROW('Sala A', 3, 2)::ubicacion, 2),

('Rayuela', '978-9500397104', ARRAY['novela','vanguardia','argentina'],
 '{"autor": "Julio Cortázar", "anio": 1963, "idiomas": ["es"]}',
 ROW('Sala A', 4, 1)::ubicacion, 1),

('Fundamentos de Bases de Datos', '978-8448190851',
 ARRAY['tecnico','informatica'],
 '{"autor": "Silberschatz", "anio": 2019, "idiomas": ["es","en"], "edicion": 7}',
 ROW('Sala B', 1, 3)::ubicacion, 0);

INSERT INTO socios (nombre, email, alta) VALUES
('Ana García',  'ana@mail.com',  '2024-03-01'),
('Luis Pérez',  'luis@mail.com', '2025-01-15');


-- =============================================================
-- Función 1: registrar un préstamo.
-- Usa variables, IF, RAISE y manejo de excepciones.
-- =============================================================
CREATE OR REPLACE FUNCTION registrar_prestamo(p_socio_id INT, p_libro_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    v_disponibles INT;
    v_titulo      TEXT;
BEGIN
    SELECT ejemplares, titulo
    INTO v_disponibles, v_titulo
    FROM libros
    WHERE id = p_libro_id;

    IF NOT FOUND THEN
        RAISE NOTICE 'No existe el libro %', p_libro_id;
        RETURN FALSE;
    END IF;

    IF v_disponibles = 0 THEN
        RAISE EXCEPTION 'Sin ejemplares disponibles de "%"', v_titulo
            USING ERRCODE = 'check_violation';
    END IF;

    INSERT INTO prestamos (libro_id, socio_id) VALUES (p_libro_id, p_socio_id);
    UPDATE libros SET ejemplares = ejemplares - 1 WHERE id = p_libro_id;

    RAISE NOTICE 'Préstamo registrado: "%" para el socio %', v_titulo, p_socio_id;
    RETURN TRUE;

EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'Rechazado: %', SQLERRM;
        RETURN FALSE;
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'No existe el socio %', p_socio_id;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Función 2: buscar por género (array) y filtrar por la ficha (JSONB).
-- Devuelve una tabla y recorre con FOR / RETURN NEXT.
-- =============================================================
CREATE OR REPLACE FUNCTION libros_por_genero(p_genero TEXT)
RETURNS TABLE (
    id      INT,
    titulo  TEXT,
    autor   TEXT,
    sala    TEXT,
    generos TEXT[]
) AS $$
DECLARE
    v_fila RECORD;
BEGIN
    FOR v_fila IN
        SELECT l.id, l.titulo, l.ficha ->> 'autor' AS autor,
               (l.ubicacion).sala AS sala, l.generos
        FROM libros l
        WHERE p_genero = ANY (l.generos)
        ORDER BY l.id
    LOOP
        id      := v_fila.id;
        titulo  := v_fila.titulo;
        autor   := v_fila.autor;
        sala    := v_fila.sala;
        generos := v_fila.generos;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Función 3: SQL dinámico con EXECUTE, quote_ident y USING.
-- Cuenta filas de cualquier tabla del esquema filtrando por una columna.
-- =============================================================
CREATE OR REPLACE FUNCTION contar_filas_por(
    nombre_tabla   TEXT,
    nombre_columna TEXT,
    valor          TEXT
)
RETURNS INTEGER AS $$
DECLARE
    v_cantidad INTEGER;
BEGIN
    EXECUTE 'SELECT COUNT(*) FROM ' || quote_ident(nombre_tabla) ||
            ' WHERE ' || quote_ident(nombre_columna) || '::TEXT = $1'
    INTO v_cantidad
    USING valor;

    RETURN v_cantidad;

EXCEPTION
    WHEN undefined_table THEN
        RAISE NOTICE 'La tabla % no existe', nombre_tabla;
        RETURN -1;
    WHEN undefined_column THEN
        RAISE NOTICE 'La columna % no existe en %', nombre_columna, nombre_tabla;
        RETURN -1;
END;
$$ LANGUAGE plpgsql;
