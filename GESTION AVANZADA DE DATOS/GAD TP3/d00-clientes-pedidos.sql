SET search_path TO public;

-- d.0 / d.1) Tablas clientes y pedidos como las define el enunciado, con 500.000
--            clientes y 5.000.000 de pedidos. Cada pedido se asigna a un cliente
--            al azar, con fecha uniforme entre 2020 y 2025 (seis años, así que 2024
--            tiene alrededor de la sexta parte de los pedidos) y total entre
--            $ 500 y $ 100.000.

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;
DELETE FROM medicion WHERE item LIKE 'd.%';

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    email TEXT UNIQUE
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    fecha DATE,
    total NUMERIC
);

SELECT setseed(0.2026);

INSERT INTO clientes (nombre, email)
SELECT 'Cliente ' || lpad(g::TEXT, 6, '0'),
       'cliente' || g || '@correo.com.ar'
FROM generate_series(1, 500000) AS g;

INSERT INTO pedidos (cliente_id, fecha, total)
SELECT 1 + floor(random() * 500000)::INTEGER,
       DATE '2020-01-01' + floor(random() * (DATE '2026-01-01' - DATE '2020-01-01'))::INTEGER,
       ROUND((500 + random() * 99500)::NUMERIC, 2)
FROM generate_series(1, 5000000);

VACUUM ANALYZE clientes;
VACUUM ANALYZE pedidos;

SELECT c.relname                               AS relacion,
       c.relkind                               AS tipo,
       c.reltuples::BIGINT                     AS filas,
       c.relpages                              AS paginas,
       pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('clientes', 'pedidos', 'clientes_pkey', 'clientes_email_key', 'pedidos_pkey')
ORDER BY c.relkind DESC, c.relname;

SELECT EXTRACT(YEAR FROM fecha)::INTEGER AS anio,
       COUNT(*)                          AS pedidos,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje,
       ROUND(SUM(total), 2)              AS facturacion
FROM pedidos
GROUP BY anio
ORDER BY anio;

SELECT COUNT(DISTINCT cliente_id)                         AS clientes_con_pedidos,
       ROUND(COUNT(*)::NUMERIC / COUNT(DISTINCT cliente_id), 1) AS pedidos_por_cliente
FROM pedidos;
