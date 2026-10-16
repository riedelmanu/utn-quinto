SET search_path TO public;

DELETE FROM medicion WHERE item IN ('d.2', 'd.3');
DROP INDEX IF EXISTS idx_pedidos_cliente;
DROP INDEX IF EXISTS idx_pedidos_cliente_fecha;
DROP INDEX IF EXISTS idx_pedidos_fecha_cliente;
DROP INDEX IF EXISTS idx_pedidos_fecha_cliente_total;
DROP INDEX IF EXISTS idx_pedidos_cliente_fecha_total;
ANALYZE pedidos;

-- d.2) Los 10 clientes con mayor facturación en 2024, con la consulta del
--      enunciado. pedidos sólo tiene los índices de las restricciones (clave
--      primaria de pedidos, clave primaria y email único de clientes).

SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

-- d.3) Plan de ejecución.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre, SUM(p.total) AS facturacion
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.id
ORDER BY facturacion DESC
LIMIT 10;

CALL pr_medir('d.3', 'Consulta del enunciado, sin índices', $$
    SELECT c.nombre, SUM(p.total) AS facturacion
    FROM clientes c JOIN pedidos p ON c.id = p.cliente_id
    WHERE p.fecha BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.id ORDER BY facturacion DESC LIMIT 10
$$, 5);

SELECT item, variante, mediana_ms, min_ms, max_ms, plan
FROM medicion
WHERE item = 'd.3'
ORDER BY id;
