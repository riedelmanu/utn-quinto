-- a. mostrar el listado de todos los clientes ordenados alfabéticamente por nombre
select c.nombre from cliente c
order by c.nombre;

-- b. mostrar el nombre, precio y stock de todos los productos ordenados por precio en forma descendente
select p.nombre, p.precio, p.stock from producto p
order by p.precio desc;

-- c. mostrar los productos cuyo precio sea superior a $300.
select p.nombre, p.precio from producto p
where p.precio > 300;

-- d. mostrar el nombre de los productos pertenecientes a la categoría periférico.
select p.nombre, cat.nombre from producto p
join categoria cat
on p.id_categoria = cat.id_categoria
where cat.nombre = 'Periférico';

-- e. listar todos los pedidos indicando el nombre del cliente que realizó cada uno.
select p.id_pedido,
c.nombre as cliente, p.fecha, p.estado
from pedido p
join cliente c on c.id_cliente = p.id_cliente
order by p.id_pedido;

-- f. mostrar el detalle de cada pedido indicando: número de pedido, nombre del producto, cantidad y precio unitario.
select dp.id_pedido, pr.nombre as producto, dp.cantidad, dp.precio_unitario
from detalle_pedido dp
join producto pr on pr.id_producto = dp.id_producto
order by dp.id_pedido, pr.nombre;

-- g. obtener la cantidad de pedidos realizados por cada cliente.
select c.id_cliente, c.nombre,
count(p.id_pedido) as cantidad_pedidos
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
group by c.id_cliente, c.nombre
order by cantidad_pedidos desc, c.nombre;

-- h. mostrar el importe total correspondiente a cada pedido.
select p.id_pedido, c.nombre as cliente,
sum (dp.cantidad * dp.precio_unitario) as importe_total
from pedido p
join cliente c on c.id_cliente = p.id_cliente
join detalle_pedido dp on dp.id_pedido = p.id_pedido
group by p.id_pedido, c.nombre
order by p.id_pedido;

-- i. obtener el importe total gastado por cada cliente.
select c.id_cliente, c.nombre,
coalesce(sum(dp.cantidad * dp.precio_unitario), 0) as total_gastado
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
left join detalle_pedido dp on dp.id_pedido = p.id_pedido
group by c.id_cliente, c.nombre
order by total_gastado desc;

-- j. mostrar el nombre del cliente que realizó la mayor cantidad de pedidos.
with conteo as (
select p.id_cliente, count(*) as cantidad_pedidos
from pedido p
group by p.id_cliente)
select c.nombre, t.cantidad_pedidos
from conteo t
join cliente c on c.id_cliente = t.id_cliente
where t.cantidad_pedidos = (select max(cantidad_pedidos) from conteo);

-- k. mostrar el producto cuya cantidad total vendida haya sido la mayor.
with vendidos as (
select dp.id_producto, sum(dp.cantidad) as total_vendido
from detalle_pedido dp
group by dp.id_producto)
select pr.nombre, v.total_vendido
from vendidos v
join producto pr on pr.id_producto = v.id_producto
where v.total_vendido = (select max(total_vendido) from vendidos);

-- l. mostrar los clientes que nunca realizaron pedidos.
select c.id_cliente, c.nombre, c.email, c.ciudad
from cliente c
where not exists (
select 1
from pedido p
where p.id_cliente = c.id_cliente);

-- m. mostrar las categorías que no poseen productos vendidos.
select cat.id_categoria, cat.nombre
from categoria cat
where not exists (
select 1
from producto pr
join detalle_pedido dp on dp.id_producto = pr.id_producto
where pr.id_categoria = cat.id_categoria);

-- n. mostrar los productos cuyo precio sea superior al precio promedio de todos los productos.
select p.nombre, p.precio
from producto p
where p.precio > (select avg(precio) from producto)
order by p.precio desc;

-- o. mostrar los clientes cuyo gasto total sea superior al gasto promedio de todos los clientes.

with gasto_cliente as (
select c.id_cliente, c.nombre,
coalesce(sum(dp.cantidad * dp.precio_unitario), 0) as total_gastado
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
left join detalle_pedido dp on dp.id_pedido = p.id_pedido
group by c.id_cliente, c.nombre)
select g.nombre, g.total_gastado
from gasto_cliente g
where g.total_gastado > (select avg(total_gastado) from gasto_cliente)
order by g.total_gastado desc;

-- p. obtener el segundo producto más caro de la tienda (no el más caro, sino el inmediatamente inferior considerando precios distintos).
select p.nombre, p.precio
from producto p
order by p.precio desc
limit 1 offset 1;

-- q. obtener el cliente que realizó el segundo mayor gasto acumulado en compras.
with gasto_cliente as (
select c.id_cliente, c.nombre,
coalesce(sum(dp.cantidad * dp.precio_unitario), 0) as total_gastado
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
left join detalle_pedido dp on dp.id_pedido = p.id_pedido
group by c.id_cliente, c.nombre)
select g.nombre, g.total_gastado
from gasto_cliente g
order by g.total_gastado desc
limit 1 offset 1;


-- r. mostrar los tres clientes que más dinero gastaron en la tienda, indicando el importe total de cada uno.
with gasto_cliente as (
select c.id_cliente, c.nombre,
coalesce(sum(dp.cantidad * dp.precio_unitario), 0) as total_gastado
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
left join detalle_pedido dp on dp.id_pedido = p.id_pedido
group by c.id_cliente, c.nombre)
select g.nombre, g.total_gastado
from gasto_cliente g
order by g.total_gastado desc
limit 3;

-- s. mostrar la categoría cuyos productos generaron el mayor importe total de ventas.
select ca.nombre from categoria ca
join producto p on ca.id_categoria = p.id_categoria
join detalle_pedido dp on dp.id_producto = p.id_producto
group by ca.nombre
order by sum(dp.cantidad * dp.precio_unitario)
limit 1;

-- t. obtener los productos que nunca fueron vendidos.
select p.nombre from producto p
where not exists (
select 1 
from detalle_pedido dp
where dp.id_producto = p.id_producto)

-- u. mostrar los clientes que compraron productos de más de una categoría diferente.
select c.id_cliente, c.nombre,
count(distinct pr.id_categoria) as categorias_distintas
from cliente c
join pedido p on p.id_cliente = c.id_cliente
join detalle_pedido dp on dp.id_pedido = p.id_pedido
join producto pr on pr.id_producto = dp.id_producto
group by c.id_cliente, c.nombre
having count(distinct pr.id_categoria) > 1
order by categorias_distintas desc, c.nombre;

-- v. obtener el pedido cuyo importe total sea el mayor.
with importes as (
select dp.id_pedido,
sum(dp.cantidad * dp.precio_unitario) as importe_total
from detalle_pedido dp
group by dp.id_pedido)
select i.id_pedido, c.nombre as cliente, p.fecha, i.importe_total
from importes i
join pedido p  on p.id_pedido = i.id_pedido
join cliente c on c.id_cliente = p.id_cliente
where i.importe_total = (select max(importe_total) from importes);

-- w. mostrar todos los pedidos cuyo importe sea superior al importe promedio de todos los pedidos.
with importes as (
select dp.id_pedido,
sum(dp.cantidad * dp.precio_unitario) as importe_total
from detalle_pedido dp
group by dp.id_pedido)
select i.id_pedido, c.nombre as cliente, i.importe_total
from importes i
join pedido p on p.id_pedido = i.id_pedido
join cliente c on c.id_cliente = p.id_cliente
where i.importe_total > (select avg(importe_total) from importes)
order by i.importe_total desc;

-- x. para cada categoría, mostrar el producto de mayor precio perteneciente a esa categoría.
with ranking as (
select cat.id_categoria,
cat.nombre as categoria,
pr.nombre  as producto,
pr.precio,
rank() over (partition by cat.id_categoria order by pr.precio desc) as puesto
from categoria cat
join producto pr on pr.id_categoria = cat.id_categoria)
select categoria, producto, precio
from   ranking
where  puesto = 1
order  by id_categoria;

-- y. mostrar el nombre del cliente junto con la fecha de su último pedido
select c.id_cliente, c.nombre,
max(p.fecha) as ultimo_pedido
from cliente c
left join pedido p on p.id_cliente = c.id_cliente
group by c.id_cliente, c.nombre
order by ultimo_pedido desc nulls last;
