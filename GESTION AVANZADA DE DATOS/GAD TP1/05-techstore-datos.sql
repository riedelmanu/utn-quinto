-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 6: insercion de datos y prueba de validaciones
-- Base: Facultad   |   Esquema: techstore
-- =============================================================

SET search_path TO techstore;

-- 6.1 - Tres clientes
INSERT INTO clientes (nombre, email, telefono, fecha_registro) VALUES
('Ana Gómez',      'ana.gomez@gmail.com',      '+54 351 1234567', '2021-05-14'),
('Bruno Salinas',  'bruno.salinas@hotmail.com', '3512345678',     '2023-02-01'),
('Carla Duarte',   'carla.duarte@GMAIL.COM',   '+54 11 43219876', '2024-09-23');

-- 6.2 - Cinco productos (dos con varias etiquetas)
INSERT INTO productos (nombre, precio, stock, categoria, etiquetas, especificaciones) VALUES
('Samsung Galaxy S23', 950000.00, 12, 'electronica',
 ARRAY['ofertas', 'tecnologia', 'nuevo'],
 '{"marca": "Samsung", "modelo": "Galaxy S23", "peso_gr": 168, "colores": ["negro", "blanco"]}'),

('Notebook Lenovo IdeaPad 3', 780000.00, 5, 'informatica',
 ARRAY['ofertas', 'ultima-unidad'],
 '{"marca": "Lenovo", "modelo": "IdeaPad 3", "peso_gr": 1650, "colores": ["gris"]}'),

('Cafetera Express Oster', 210000.00, 20, 'hogar',
 ARRAY['nuevo'],
 '{"marca": "Oster", "modelo": "BVSTEM6603", "peso_gr": 4200, "colores": ["negro", "plata"]}'),

('Auriculares JBL Tune 520', 89000.00, 40, 'accesorios',
 ARRAY['ofertas'],
 '{"marca": "JBL", "modelo": "Tune 520BT", "peso_gr": 160, "colores": ["azul", "negro"]}'),

('Teclado Redragon K552', 65000.00, 0, 'informatica',
 ARRAY['sin-stock'],
 '{"marca": "Redragon", "modelo": "K552", "peso_gr": 980, "colores": ["negro"]}');

-- 6.4 - Tres pedidos usando ROW(...)::direccion_envio
INSERT INTO pedidos (cliente_id, fecha, estado, direccion_entrega, total) VALUES
(1, '2025-03-10 11:20:00', 'entregado',
 ROW('Av. Colón', 1250, '4', 'B', '5000', 'Córdoba')::direccion_envio, 1039000.00),
(2, '2025-06-02 16:45:00', 'pagado',
 ROW('Rondeau', 340, NULL, NULL, '5000', 'Córdoba')::direccion_envio, 780000.00),
(3, '2025-08-19 09:05:00', 'pendiente',
 ROW('Av. Rivadavia', 5600, '2', 'A', '1424', 'Buenos Aires')::direccion_envio, 299000.00);

-- Detalle de cada pedido (Ejercicio 10)
INSERT INTO pedido_productos (pedido_id, producto_id, cantidad) VALUES
(1, 1, 1),
(1, 4, 1),
(2, 2, 1),
(3, 3, 1),
(3, 4, 1);


-- -------------------------------------------------------------
-- 6.1 (segunda parte) - Prueba de que el dominio rechaza un email
-- sin punto despues del @. Se ejecuta dentro de un bloque para
-- mostrar el error sin abortar el script.
-- -------------------------------------------------------------
DO $$
BEGIN
    INSERT INTO clientes (nombre, email, telefono, fecha_registro)
    VALUES ('Pepe Inválido', 'pepe@gmail', '3510000000', '2024-01-01');
    RAISE NOTICE 'ERROR: el dominio email_valid dejó pasar pepe@gmail';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'OK: email_valid rechazó "pepe@gmail" (falta el punto)';
END $$;

DO $$
BEGIN
    INSERT INTO clientes (nombre, email, telefono, fecha_registro)
    VALUES ('Tel Inválido', 'tel@mail.com', 'no-es-un-telefono', '2024-01-01');
    RAISE NOTICE 'ERROR: el dominio telefono_arg dejó pasar texto suelto';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'OK: telefono_arg rechazó "no-es-un-telefono"';
END $$;

DO $$
BEGIN
    INSERT INTO clientes (nombre, email, telefono, fecha_registro)
    VALUES ('Viejo', 'viejo@mail.com', '3510000000', '2019-12-31');
    RAISE NOTICE 'ERROR: el CHECK de fecha_registro dejó pasar 2019';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'OK: fecha_registro rechazó 2019-12-31 (anterior a 2020-01-01)';
END $$;

DO $$
BEGIN
    INSERT INTO productos (nombre, precio, stock, categoria)
    VALUES ('Precio negativo', -100, 5, 'hogar');
    RAISE NOTICE 'ERROR: el CHECK de precio dejó pasar un valor negativo';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'OK: precio rechazó -100 (debe ser > 0)';
END $$;
