-- 8. Con WITH RECURSIVE sobre persona y docente.dependede, nivel de cada persona
--    dentro del árbol: 0 la raíz, 1 quienes dependen de la raíz, y así sucesivamente.

WITH RECURSIVE jerarquia AS (
    SELECT d.persona_id,
           d.dependede,
           0                      AS nivel,
           ARRAY[d.persona_id]    AS visitados
    FROM docente d
    WHERE d.dependede IS NULL

    UNION ALL

    SELECT h.persona_id,
           h.dependede,
           j.nivel + 1,
           j.visitados || h.persona_id
    FROM jerarquia j
    JOIN docente h ON h.dependede = j.persona_id
    WHERE NOT h.persona_id = ANY (j.visitados)
)
SELECT persona_id AS idpersona,
       dependede,
       nivel
FROM jerarquia
ORDER BY nivel, idpersona;

-- 8. Misma jerarquía mostrando apellido y nombre de la persona y de aquella de la
--    que depende. La raíz aparece igual, con los datos del superior en nulo.

WITH RECURSIVE jerarquia AS (
    SELECT d.persona_id,
           d.dependede,
           0                      AS nivel,
           ARRAY[d.persona_id]    AS visitados
    FROM docente d
    WHERE d.dependede IS NULL

    UNION ALL

    SELECT h.persona_id,
           h.dependede,
           j.nivel + 1,
           j.visitados || h.persona_id
    FROM jerarquia j
    JOIN docente h ON h.dependede = j.persona_id
    WHERE NOT h.persona_id = ANY (j.visitados)
)
SELECT j.persona_id  AS idpersona,
       pe.apellidos  AS apellidos,
       pe.nombres    AS nombres,
       j.dependede   AS iddependede,
       ps.apellidos  AS apellidos_superior,
       ps.nombres    AS nombres_superior,
       j.nivel
FROM jerarquia j
JOIN persona pe      ON pe.persona_id = j.persona_id
LEFT JOIN persona ps ON ps.persona_id = j.dependede
ORDER BY j.nivel, j.persona_id;
