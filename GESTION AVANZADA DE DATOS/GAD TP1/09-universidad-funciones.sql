-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicios 14 a 21: funciones y procedimientos en PL/pgSQL
-- Base: Facultad   |   Esquema: universidad
-- =============================================================

SET search_path TO universidad;

-- =============================================================
-- Ejercicio 14 - RETURNS TABLE y parámetros
-- =============================================================
CREATE OR REPLACE FUNCTION listar_alumnos_por_nota(nota_minima NUMERIC)
RETURNS TABLE (
    alumno TEXT,
    materia TEXT,
    nota   NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT a.nombre, m.nombre, i.nota
    FROM inscripciones i
    JOIN alumnos  a ON a.id = i.alumno_id
    JOIN materias m ON m.id = i.materia_id
    WHERE i.nota >= nota_minima
    ORDER BY i.nota DESC;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 15 - Variables y FOUND
-- =============================================================
CREATE OR REPLACE FUNCTION obtener_promedio(p_alumno_id INT)
RETURNS NUMERIC AS $$
DECLARE
    v_promedio NUMERIC;
BEGIN
    -- Con PERFORM, FOUND queda en TRUE si la consulta devolvió filas.
    -- No sirve preguntar FOUND después del AVG: una función de agregado
    -- siempre devuelve una fila, aunque sea NULL.
    PERFORM 1 FROM inscripciones WHERE alumno_id = p_alumno_id AND nota IS NOT NULL;

    IF NOT FOUND THEN
        RAISE NOTICE 'El alumno % no tiene notas cargadas', p_alumno_id;
        RETURN NULL;
    END IF;

    SELECT AVG(nota) INTO v_promedio
    FROM inscripciones
    WHERE alumno_id = p_alumno_id;

    RETURN ROUND(v_promedio, 2);
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 16 - CASE con parámetros IN / OUT
-- =============================================================
CREATE OR REPLACE FUNCTION clasificar_nota(
    p_nota           IN  NUMERIC,
    p_clasificacion  OUT TEXT
) AS $$
BEGIN
    CASE
        WHEN p_nota >= 9 THEN p_clasificacion := 'Excelente';
        WHEN p_nota >= 7 THEN p_clasificacion := 'Aprobado';
        WHEN p_nota >= 4 THEN p_clasificacion := 'Regular';
        ELSE                  p_clasificacion := 'Reprobado';
    END CASE;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 17 - Procedimiento con FOR y RAISE NOTICE
-- =============================================================
CREATE OR REPLACE PROCEDURE generar_reporte_inscripciones()
AS $$
DECLARE
    v_fila RECORD;
BEGIN
    FOR v_fila IN
        SELECT a.nombre AS alumno, m.nombre AS materia, i.nota
        FROM inscripciones i
        JOIN alumnos  a ON a.id = i.alumno_id
        JOIN materias m ON m.id = i.materia_id
        ORDER BY a.nombre, m.nombre
    LOOP
        RAISE NOTICE 'Alumno % se inscribió en % con nota %',
                     v_fila.alumno, v_fila.materia, v_fila.nota;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 18 - Manejo de excepciones
-- =============================================================
CREATE OR REPLACE FUNCTION inscribir_alumno(
    p_alumno_id  INT,
    p_materia_id INT,
    p_nota       NUMERIC DEFAULT NULL
)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO inscripciones (alumno_id, materia_id, nota)
    VALUES (p_alumno_id, p_materia_id, p_nota);

    RETURN TRUE;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'No existe el alumno % o la materia %', p_alumno_id, p_materia_id;
        RETURN FALSE;
    WHEN unique_violation THEN
        RAISE NOTICE 'El alumno % ya está inscripto en la materia %',
                     p_alumno_id, p_materia_id;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 19 - SQL dinámico y EXECUTE
-- =============================================================
CREATE OR REPLACE FUNCTION actualizar_columna_segura(
    nombre_tabla   TEXT,
    nombre_columna TEXT,
    valor_nuevo    TEXT,
    id_busqueda    INT
)
RETURNS INTEGER AS $$
DECLARE
    v_filas INTEGER;
BEGIN
    EXECUTE 'UPDATE ' || quote_ident(nombre_tabla) ||
            ' SET '   || quote_ident(nombre_columna) || ' = $1' ||
            ' WHERE id = $2'
    USING valor_nuevo, id_busqueda;

    -- EXECUTE no actualiza FOUND, así que la cantidad de filas
    -- se pide con GET DIAGNOSTICS.
    GET DIAGNOSTICS v_filas = ROW_COUNT;

    IF v_filas = 1 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

EXCEPTION
    WHEN undefined_table THEN
        RAISE NOTICE 'La tabla % no existe', nombre_tabla;
        RETURN -1;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 20 - RETURNS SETOF y RETURN NEXT
-- =============================================================
CREATE OR REPLACE FUNCTION buscar_por_texto(palabra TEXT)
RETURNS SETOF materias AS $$
DECLARE
    v_materia materias%ROWTYPE;
BEGIN
    FOR v_materia IN
        SELECT * FROM materias
        WHERE nombre ~* palabra
        ORDER BY id
    LOOP
        RETURN NEXT v_materia;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- =============================================================
-- Ejercicio 21 - Procedimiento con transacción y COMMIT
-- =============================================================
CREATE TABLE IF NOT EXISTS alumnos_historicos (
    id           INT PRIMARY KEY,
    nombre       TEXT NOT NULL,
    email        TEXT NOT NULL,
    fecha_egreso DATE
);

CREATE OR REPLACE PROCEDURE migrar_alumnos_antiguos(fecha_corte DATE)
AS $$
DECLARE
    v_migrados INTEGER;
BEGIN
    INSERT INTO alumnos_historicos (id, nombre, email, fecha_egreso)
    SELECT id, nombre, email, CURRENT_DATE
    FROM alumnos
    WHERE fecha_ingreso < fecha_corte;

    GET DIAGNOSTICS v_migrados = ROW_COUNT;

    DELETE FROM alumnos WHERE fecha_ingreso < fecha_corte;

    COMMIT;

    RAISE NOTICE 'Se migraron % alumnos ingresados antes del %',
                 v_migrados, fecha_corte;
END;
$$ LANGUAGE plpgsql;
