-- 9. Función que, dados los identificadores de dos personas X e Y, devuelve si X
--    depende directa o indirectamente de Y, resolviéndolo con una CTE recursiva.

CREATE OR REPLACE FUNCTION fn_depende_de(p_x INTEGER, p_y INTEGER)
RETURNS BOOLEAN
LANGUAGE sql STABLE AS $$
    WITH RECURSIVE cadena AS (
        SELECT d.persona_id,
               d.dependede,
               ARRAY[d.persona_id] AS visitados
        FROM docente d
        WHERE d.persona_id = p_x

        UNION ALL

        SELECT s.persona_id,
               s.dependede,
               c.visitados || s.persona_id
        FROM cadena c
        JOIN docente s ON s.persona_id = c.dependede
        WHERE NOT s.persona_id = ANY (c.visitados)
    )
    SELECT EXISTS (SELECT 1 FROM cadena c WHERE c.dependede = p_y);
$$;

-- 9. Pruebas de los cuatro casos pedidos.

SELECT 'X depende directamente de Y'   AS caso, 4 AS x, 2 AS y, fn_depende_de(4, 2) AS resultado
UNION ALL
SELECT 'X depende indirectamente de Y',      7,      1, fn_depende_de(7, 1)
UNION ALL
SELECT 'X no depende de Y',                  3,      2, fn_depende_de(3, 2)
UNION ALL
SELECT 'X e Y son la misma persona',         1,      1, fn_depende_de(1, 1);

-- 9. Matriz completa de dependencias entre todos los docentes.

SELECT x.persona_id AS x,
       y.persona_id AS y,
       fn_depende_de(x.persona_id, y.persona_id) AS x_depende_de_y
FROM docente x
CROSS JOIN docente y
WHERE x.persona_id <> y.persona_id
  AND fn_depende_de(x.persona_id, y.persona_id)
ORDER BY x.persona_id, y.persona_id;
