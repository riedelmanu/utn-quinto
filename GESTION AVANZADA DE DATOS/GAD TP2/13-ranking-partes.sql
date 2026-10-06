-- 13. Con funciones de ventana, por cada producto: parte, cantidad, porcentaje sobre
--     el total del producto y posición según la cantidad de mayor a menor, de modo
--     que dos partes con la misma cantidad compartan posición.

SELECT pa.idproducto,
       pr.nombre AS producto,
       pa.idparte,
       pp.nombre AS parte,
       pa.cantidad,
       ROUND(100.0 * pa.cantidad
             / SUM(pa.cantidad) OVER (PARTITION BY pa.idproducto), 2) AS porcentaje,
       DENSE_RANK() OVER (PARTITION BY pa.idproducto ORDER BY pa.cantidad DESC) AS posicion
FROM partes pa
JOIN productos pr ON pr.id = pa.idproducto
JOIN productos pp ON pp.id = pa.idparte
ORDER BY pa.idproducto, posicion, pa.idparte;

-- 13. Comparación de las tres funciones sobre los mismos datos: ROW_NUMBER numera
--     sin repetir y rompe los empates arbitrariamente, RANK los respeta pero deja
--     huecos y DENSE_RANK los respeta sin dejarlos, que es lo que pide el enunciado.

SELECT pa.idproducto,
       pa.idparte,
       pp.nombre AS parte,
       pa.cantidad,
       ROW_NUMBER() OVER (PARTITION BY pa.idproducto ORDER BY pa.cantidad DESC) AS row_number,
       RANK()       OVER (PARTITION BY pa.idproducto ORDER BY pa.cantidad DESC) AS rank,
       DENSE_RANK() OVER (PARTITION BY pa.idproducto ORDER BY pa.cantidad DESC) AS dense_rank
FROM partes pa
JOIN productos pp ON pp.id = pa.idparte
ORDER BY pa.idproducto, rank, pa.idparte;
