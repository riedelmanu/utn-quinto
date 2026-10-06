-- 12. Con una función de ventana, porcentaje que representa la cantidad de cada
--     parte sobre el total de partes directas requeridas por su producto, sin
--     consultar aparte el total de cada producto.

SELECT pa.idproducto,
       pr.nombre AS producto,
       pa.idparte,
       pp.nombre AS parte,
       pa.cantidad,
       SUM(pa.cantidad) OVER (PARTITION BY pa.idproducto) AS total_del_producto,
       ROUND(100.0 * pa.cantidad
             / SUM(pa.cantidad) OVER (PARTITION BY pa.idproducto), 2) AS porcentaje
FROM partes pa
JOIN productos pr ON pr.id = pa.idproducto
JOIN productos pp ON pp.id = pa.idparte
ORDER BY pa.idproducto, porcentaje DESC, pa.idparte;
