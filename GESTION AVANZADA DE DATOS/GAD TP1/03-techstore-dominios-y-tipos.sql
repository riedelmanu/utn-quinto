-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 4: dominios, ENUM y tipo compuesto para TechStore
-- Base: Facultad   |   Esquema: techstore
-- =============================================================

DROP SCHEMA IF EXISTS techstore CASCADE;
CREATE SCHEMA techstore;

SET search_path TO techstore;

-- Debe contener @ y al menos un punto DESPUES del @.
CREATE DOMAIN email_valid AS TEXT
    CHECK (VALUE ~ '^[^@ ]+@[^@ ]+\.[^@ ]+$');

-- Formato argentino "+54 351 1234567", o solamente numeros.
CREATE DOMAIN telefono_arg AS TEXT
    CHECK (VALUE ~ '^\+54 [0-9]{2,4} [0-9]{6,8}$' OR VALUE ~ '^[0-9]+$');

CREATE TYPE categoria_producto AS ENUM ('electronica', 'informatica', 'hogar', 'accesorios');

-- El ENUM de estado que pide el Ejercicio 5 para la tabla pedidos.
CREATE TYPE estado_pedido AS ENUM ('pendiente', 'pagado', 'enviado', 'entregado', 'cancelado');

CREATE TYPE direccion_envio AS (
    calle         TEXT,
    numero        INT,
    piso          TEXT,
    departamento  TEXT,
    codigo_postal TEXT,
    localidad     TEXT
);
