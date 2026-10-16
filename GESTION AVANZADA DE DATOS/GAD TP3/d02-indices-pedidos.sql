SET search_path TO public;

DELETE FROM medicion WHERE item IN ('d.4', 'd.5');
DROP INDEX IF EXISTS idx_pedidos_cliente;
DROP INDEX IF EXISTS idx_pedidos_cliente_fecha;
DROP INDEX IF EXISTS idx_pedidos_fecha_cliente;
DROP INDEX IF EXISTS idx_pedidos_fecha_cliente_total;
DROP INDEX IF EXISTS idx_pedidos_cliente_fecha_total;

-- d.4) Se prueban los tres índices del enunciado de a uno por vez. Para cada uno:
--      el plan que elige el planificador y, si no lo usa, el plan y el tiempo que
--      se obtienen obligándolo (enable_seqscan = off encarece artificialmente el
--      Seq Scan y fuerza a buscar un camino por índice).

-- 1. INDEX(cliente_id)

CREATE INDEX idx_pedidos_cliente ON pedidos (cliente_id);
VACUUM ANALYZE pedidos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.4', '(cliente_id), plan elegido', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

SET enable_seqscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.4', '(cliente_id), forzado', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 3);

RESET enable_seqscan;
DROP INDEX idx_pedidos_cliente;

-- 2. INDEX(cliente_id, fecha)

CREATE INDEX idx_pedidos_cliente_fecha ON pedidos (cliente_id, fecha);
VACUUM ANALYZE pedidos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.4', '(cliente_id, fecha), plan elegido', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

SET enable_seqscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.4', '(cliente_id, fecha), forzado', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

RESET enable_seqscan;
DROP INDEX idx_pedidos_cliente_fecha;

-- 3. INDEX(fecha, cliente_id)

CREATE INDEX idx_pedidos_fecha_cliente ON pedidos (fecha, cliente_id);
VACUUM ANALYZE pedidos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.4', '(fecha, cliente_id), plan elegido', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

SELECT c.relname AS indice, pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('pedidos', 'idx_pedidos_fecha_cliente');

DROP INDEX idx_pedidos_fecha_cliente;

-- d.5) Ninguno de los tres mejora la consulta tal como están. Les falta la columna
--      total, así que cualquier plan por índice tiene que visitar la tabla por cada
--      pedido de 2024. Se repiten los dos índices compuestos agregando total con
--      INCLUDE, para que el índice cubra la consulta (Index Only Scan).

-- Antes, la reescritura que se usa más abajo, todavía sin índices sobre pedidos,
-- para separar lo que aporta cada cambio.

CALL pr_medir('d.5', 'Reescrita, sin índices', $$
    WITH ranking AS (
        SELECT p.cliente_id, SUM(p.total) AS facturacion
        FROM pedidos p
        WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
        GROUP BY p.cliente_id ORDER BY facturacion DESC LIMIT 10
    )
    SELECT c.nombre, r.facturacion
    FROM ranking r JOIN clientes c ON c.id = r.cliente_id
    ORDER BY r.facturacion DESC
$$, 5);

CREATE INDEX idx_pedidos_fecha_cliente_total ON pedidos (fecha, cliente_id) INCLUDE (total);
VACUUM ANALYZE pedidos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.5', '(fecha, cliente_id) INCLUDE (total)', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

DROP INDEX idx_pedidos_fecha_cliente_total;

CREATE INDEX idx_pedidos_cliente_fecha_total ON pedidos (cliente_id, fecha) INCLUDE (total);
VACUUM ANALYZE pedidos;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.5', '(cliente_id, fecha) INCLUDE (total)', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

-- d.5) Reescritura con el índice anterior: el nombre del cliente sólo hace falta
--      para los diez primeros. Se calcula el ranking sobre pedidos solo y después
--      se buscan esos diez clientes por clave primaria, en lugar de unir los
--      835.000 pedidos de 2024 con los 500.000 clientes.

EXPLAIN (ANALYZE, BUFFERS)
WITH ranking AS (
    SELECT p.cliente_id, SUM(p.total) AS facturacion
    FROM pedidos p
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY p.cliente_id
    ORDER BY facturacion DESC
    LIMIT 10
)
SELECT c.nombre, r.facturacion
FROM ranking r
JOIN clientes c ON c.id = r.cliente_id
ORDER BY r.facturacion DESC;

CALL pr_medir('d.5', 'Reescrita + (cliente_id, fecha) INCLUDE (total)', $$
    WITH ranking AS (
        SELECT p.cliente_id, SUM(p.total) AS facturacion
        FROM pedidos p
        WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
        GROUP BY p.cliente_id ORDER BY facturacion DESC LIMIT 10
    )
    SELECT c.nombre, r.facturacion
    FROM ranking r JOIN clientes c ON c.id = r.cliente_id
    ORDER BY r.facturacion DESC
$$, 5);

SELECT c.relname AS indice, pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('pedidos', 'idx_pedidos_cliente_fecha_total');

WITH ranking AS (
    SELECT p.cliente_id, SUM(p.total) AS facturacion
    FROM pedidos p
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY p.cliente_id
    ORDER BY facturacion DESC
    LIMIT 10
)
SELECT c.nombre, r.facturacion
FROM ranking r
JOIN clientes c ON c.id = r.cliente_id
ORDER BY r.facturacion DESC;

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item IN ('d.3', 'd.4', 'd.5')
ORDER BY id;
