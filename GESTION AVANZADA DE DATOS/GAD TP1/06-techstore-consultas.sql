-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicios 7 a 11: consultas sobre TechStore
-- Base: Facultad   |   Esquema: techstore
-- =============================================================

SET search_path TO techstore;

-- =============================================================
-- Ejercicio 7 - Consultas con Arrays y ENUM
-- =============================================================

\echo '@@ 7.1 Productos con la etiqueta ofertas'
-- 7.1 - Productos con la etiqueta 'ofertas'
SELECT id, nombre, etiquetas
FROM productos
WHERE 'ofertas' = ANY (etiquetas);

\echo '@@ 7.2 Productos con mas de 2 etiquetas'
-- 7.2 - Productos con mas de 2 etiquetas
SELECT id, nombre, etiquetas, array_length(etiquetas, 1) AS cantidad_etiquetas
FROM productos
WHERE array_length(etiquetas, 1) > 2;

\echo '@@ 7.3 Pedidos pendientes o pagados'
-- 7.3 - Pedidos en estado pendiente o pagado
SELECT id, cliente_id, estado, total
FROM pedidos
WHERE estado IN ('pendiente', 'pagado');


-- =============================================================
-- Ejercicio 8 - Consultas con expresiones regulares
-- =============================================================

\echo '@@ 8.1 Clientes con email de gmail.com'
-- 8.1 - Clientes con email de gmail.com, sin distinguir mayusculas (~*)
SELECT id, nombre, email
FROM clientes
WHERE email ~* '@gmail\.com$';

\echo '@@ 8.2 Productos sin numeros en el nombre'
-- 8.2 - Productos cuyo nombre NO contiene numeros
SELECT id, nombre
FROM productos
WHERE nombre !~ '[0-9]';

\echo '@@ 8.3 Telefonos con solo digitos'
-- 8.3 - Desafio: telefono dejando unicamente los digitos
SELECT id,
       nombre,
       telefono,
       regexp_replace(telefono, '[^0-9]', '', 'g') AS solo_digitos
FROM clientes;


-- =============================================================
-- Ejercicio 9 - Consultas y actualizaciones con JSONB
-- =============================================================

\echo '@@ 9.1 Producto y marca'
-- 9.1 - Nombre del producto y la marca como texto (->> devuelve text)
SELECT nombre,
       especificaciones ->> 'marca' AS marca
FROM productos;

\echo '@@ 9.2 Productos con color negro'
-- 9.2 - Productos con el color negro dentro del array colores
SELECT id, nombre, especificaciones -> 'colores' AS colores
FROM productos
WHERE especificaciones -> 'colores' @> '"negro"';

\echo '@@ 9.3 Agregar garantia_meses'
-- 9.3 - Agregar garantia_meses = 12 a todos los productos
UPDATE productos
SET especificaciones = jsonb_set(especificaciones, '{garantia_meses}', '12', TRUE)
WHERE especificaciones IS NOT NULL;

SELECT id, nombre, especificaciones ->> 'garantia_meses' AS garantia_meses
FROM productos;

\echo '@@ 9.4 Pedido, cliente y localidad'
-- 9.4 - Pedido, nombre del cliente y localidad del tipo compuesto
SELECT p.id AS id_pedido,
       c.nombre AS cliente,
       (p.direccion_entrega).localidad AS localidad
FROM pedidos p
JOIN clientes c ON c.id = p.cliente_id;


-- =============================================================
-- Ejercicio 10 - Consulta integradora
-- =============================================================
\echo '@@ 10 Consulta integradora'
SELECT c.nombre                        AS cliente,
       c.email                         AS email,
       p.total                         AS total_pedido,
       p.estado                        AS estado_pedido,
       (p.direccion_entrega).calle     AS calle,
       (p.direccion_entrega).numero    AS numero,
       pr.especificaciones             AS especificaciones_primer_producto
FROM pedidos p
JOIN clientes c ON c.id = p.cliente_id
JOIN pedido_productos pp ON pp.pedido_id = p.id
JOIN productos pr ON pr.id = pp.producto_id
-- "El primer producto que contiene el pedido": el de menor producto_id.
WHERE pp.producto_id = (
    SELECT MIN(pp2.producto_id)
    FROM pedido_productos pp2
    WHERE pp2.pedido_id = p.id
)
ORDER BY p.id;


-- =============================================================
-- Ejercicio 11 - Bonus: restriccion avanzada
-- =============================================================

-- Un CHECK no puede consultar otra tabla, asi que la consulta va
-- encapsulada en una funcion y el CHECK la invoca.
CREATE OR REPLACE FUNCTION fecha_registro_cliente(p_cliente_id INT)
RETURNS DATE AS $$
    SELECT fecha_registro FROM clientes WHERE id = p_cliente_id;
$$ LANGUAGE SQL STABLE;

ALTER TABLE pedidos
    ADD CONSTRAINT ck_entregado_despues_del_registro CHECK (
        estado <> 'entregado'
        OR fecha >= fecha_registro_cliente(cliente_id)
    );

\echo '@@ 11 Prueba del CHECK de entrega'
-- Prueba: el cliente 3 se registro el 2024-09-23, este pedido es anterior.
DO $$
BEGIN
    INSERT INTO pedidos (cliente_id, fecha, estado, direccion_entrega, total)
    VALUES (3, '2024-01-05 10:00:00', 'entregado',
            ROW('Falsa', 123, NULL, NULL, '1424', 'Buenos Aires')::direccion_envio, 5000);
    RAISE NOTICE 'ERROR: se permitió entregar antes de registrar al cliente';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'OK: rechazó un pedido entregado anterior al registro del cliente';
END $$;
