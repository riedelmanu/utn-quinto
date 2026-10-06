-- 3. Tablas productos e historial_precios, y trigger que registra cada cambio de precio
--    solamente cuando el precio efectivamente cambió.

DROP TABLE IF EXISTS partes;
DROP TABLE IF EXISTS historial_precios;
DROP TABLE IF EXISTS productos;

CREATE TABLE productos (
    id     SERIAL,
    nombre VARCHAR(100)   NOT NULL,
    precio NUMERIC(12,2)  NOT NULL,
    CONSTRAINT pk_productos PRIMARY KEY (id),
    CONSTRAINT ck_productos_precio CHECK (precio >= 0)
);

CREATE TABLE historial_precios (
    id_historial   SERIAL,
    id_producto    INTEGER       NOT NULL,
    precio_antiguo NUMERIC(12,2) NOT NULL,
    precio_nuevo   NUMERIC(12,2) NOT NULL,
    fecha          TIMESTAMP     NOT NULL DEFAULT NOW(),
    usuario        VARCHAR(50)   NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT pk_historial_precios PRIMARY KEY (id_historial),
    CONSTRAINT fk_historial_precios_productos
        FOREIGN KEY (id_producto) REFERENCES productos (id)
        ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION fn_registrar_cambio_precio()
RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO historial_precios (id_producto, precio_antiguo, precio_nuevo)
    VALUES (NEW.id, OLD.precio, NEW.precio);
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_historial_precios ON productos;

CREATE TRIGGER trg_historial_precios
AFTER UPDATE OF precio ON productos
FOR EACH ROW
WHEN (OLD.precio IS DISTINCT FROM NEW.precio)
EXECUTE FUNCTION fn_registrar_cambio_precio();

-- 3. Carga de productos usada también por los ejercicios 11, 12 y 13.

INSERT INTO productos (id, nombre, precio) VALUES
    ( 1, 'Automóvil',  38000000.00),
    ( 2, 'Rueda',        320000.00),
    ( 3, 'Llanta',       180000.00),
    ( 4, 'Neumático',    140000.00),
    ( 5, 'Motor',       9500000.00),
    ( 6, 'Pistón',       210000.00),
    ( 7, 'Bujía',         18000.00),
    ( 8, 'Válvula',       26000.00),
    ( 9, 'Tornillo',        900.00),
    (10, 'Chasis',      4200000.00);

SELECT setval('productos_id_seq', (SELECT MAX(id) FROM productos));

-- 3. Pruebas

UPDATE productos SET precio = 350000.00 WHERE id = 2;

UPDATE productos SET nombre = 'Rueda' WHERE id = 2;

UPDATE productos SET precio = 350000.00 WHERE id = 2;

UPDATE productos SET precio = 19500.00 WHERE id = 7;

SELECT h.id_historial, h.id_producto, p.nombre,
       h.precio_antiguo, h.precio_nuevo, h.usuario
FROM historial_precios h
JOIN productos p ON p.id = h.id_producto
ORDER BY h.id_historial;

SELECT COUNT(*) AS filas_en_historial FROM historial_precios;
