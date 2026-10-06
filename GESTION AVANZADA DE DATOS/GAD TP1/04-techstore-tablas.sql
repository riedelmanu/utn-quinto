-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 5: tablas de TechStore con tipos, dominios y CHECK
-- Base: Facultad   |   Esquema: techstore
-- =============================================================

SET search_path TO techstore;

CREATE TABLE clientes (
    id             SERIAL       PRIMARY KEY,
    nombre         TEXT         NOT NULL,
    email          email_valid  NOT NULL UNIQUE,
    telefono       telefono_arg,
    fecha_registro DATE         NOT NULL CHECK (fecha_registro >= DATE '2020-01-01')
);

CREATE TABLE productos (
    id               SERIAL             PRIMARY KEY,
    nombre           TEXT               NOT NULL,
    precio           NUMERIC(12,2)      NOT NULL CHECK (precio > 0),
    stock            INTEGER            NOT NULL CHECK (stock >= 0),
    categoria        categoria_producto NOT NULL,
    etiquetas        TEXT[],
    especificaciones JSONB
);

CREATE TABLE pedidos (
    id                SERIAL          PRIMARY KEY,
    cliente_id        INTEGER         NOT NULL REFERENCES clientes(id),
    fecha             TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado            estado_pedido   NOT NULL DEFAULT 'pendiente',
    direccion_entrega direccion_envio NOT NULL,
    total             NUMERIC(12,2)   NOT NULL CHECK (total > 0)
);

-- Tabla intermedia que pide el Ejercicio 10 para poder hacer el JOIN.
CREATE TABLE pedido_productos (
    pedido_id   INTEGER NOT NULL REFERENCES pedidos(id),
    producto_id INTEGER NOT NULL REFERENCES productos(id),
    cantidad    INTEGER NOT NULL CHECK (cantidad > 0),
    PRIMARY KEY (pedido_id, producto_id)
);
