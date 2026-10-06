-- 6. Con funciones de ventana y sin subconsultas: por cada docente, su salario,
--    el salario medio de todos, la diferencia contra esa media y la posición
--    que ocupa ordenando de mayor a menor.

SELECT d.persona_id AS docente_id,
       p.apellidos,
       p.nombres,
       d.salario,
       ROUND(AVG(d.salario) OVER (), 2)              AS salario_medio,
       ROUND(d.salario - AVG(d.salario) OVER (), 2)  AS diferencia_contra_la_media,
       RANK() OVER (ORDER BY d.salario DESC)         AS posicion
FROM docente d
JOIN persona p ON p.persona_id = d.persona_id
ORDER BY posicion;
