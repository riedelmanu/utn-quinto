-- =============================================================
-- TP I - SQL Avanzado
-- Ejercicio 12: stored procedures sobre la base Facultad
-- Base: Facultad   |   Esquema: public
-- =============================================================

SET search_path TO public;

-- -------------------------------------------------------------
-- 12.a) Cantidad de alumnos que cursan o cursaban una carrera
--       a una fecha dada.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION alumnos_en_carrera(p_idcarrera INTEGER, p_fecha DATE)
RETURNS INTEGER AS $$
DECLARE
    v_cantidad INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_cantidad
    FROM Alumnos a
    WHERE a.idCarrera = p_idcarrera
      AND a.FechaIngreso <= p_fecha
      AND (a.FechaEgreso IS NULL OR a.FechaEgreso >= p_fecha);

    RETURN v_cantidad;
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.b) Costo total de una carrera.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION costo_de_carrera(p_idcarrera INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    v_nombre VARCHAR(50);
    v_costo  NUMERIC;
BEGIN
    SELECT c.Nombre INTO v_nombre FROM Carreras c WHERE c.idCarrera = p_idcarrera;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No existe la carrera %', p_idcarrera;
    END IF;

    SELECT COALESCE(SUM(m.Costo), 0)
    INTO v_costo
    FROM Materias m
    WHERE m.idCarrera = p_idcarrera;

    RAISE NOTICE 'Carrera "%": costo total %', v_nombre, v_costo;
    RETURN v_costo;
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.c) Promedio de un alumno, SOLO exámenes aprobados.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION promedio_aprobados(p_idpersona INTEGER, p_idcarrera INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    v_promedio NUMERIC;
BEGIN
    SELECT AVG(e.Nota)
    INTO v_promedio
    FROM Alumnos a
    JOIN ExamenesFinales e ON e.Legajo = a.Legajo
    WHERE a.idPersona = p_idpersona
      AND a.idCarrera = p_idcarrera
      AND e.Estado    = 'Aprobado';

    IF v_promedio IS NULL THEN
        RAISE NOTICE 'La persona % no tiene finales aprobados en la carrera %',
                     p_idpersona, p_idcarrera;
        RETURN NULL;
    END IF;

    RETURN ROUND(v_promedio, 2);
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.d) Promedio de un alumno, TODAS las notas.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION promedio_general(p_idpersona INTEGER, p_idcarrera INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    v_promedio NUMERIC;
BEGIN
    SELECT AVG(e.Nota)
    INTO v_promedio
    FROM Alumnos a
    JOIN ExamenesFinales e ON e.Legajo = a.Legajo
    WHERE a.idPersona = p_idpersona
      AND a.idCarrera = p_idcarrera;

    IF v_promedio IS NULL THEN
        RAISE NOTICE 'La persona % no rindió finales en la carrera %',
                     p_idpersona, p_idcarrera;
        RETURN NULL;
    END IF;

    RETURN ROUND(v_promedio, 2);
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.e) Datos del documento de un alumno, a partir del Legajo.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION documento_de_alumno(p_legajo VARCHAR)
RETURNS TABLE (
    legajo        VARCHAR,
    apellidos     VARCHAR,
    nombres       VARCHAR,
    tipo          TipoDeDocumento,
    numero        VARCHAR,
    expedido_por  VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT a.Legajo,
           p.Apellidos,
           p.Nombres,
           (p.Documento).Tipo,
           (p.Documento).Numero,
           (p.Documento).ExpedidoPor
    FROM Alumnos a
    JOIN Personas p ON p.idPersona = a.idPersona
    WHERE a.Legajo = p_legajo;

    IF NOT FOUND THEN
        RAISE NOTICE 'No existe el alumno con legajo %', p_legajo;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.f) Alumnos que aprobaron una materia entre dos fechas.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION aprobados_entre_fechas(
    p_idmateria INTEGER,
    p_desde     DATE,
    p_hasta     DATE
)
RETURNS TABLE (
    apellido_y_nombres TEXT,
    legajo             VARCHAR,
    nota               NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT (p.Apellidos || ', ' || p.Nombres)::TEXT,
           a.Legajo,
           e.Nota
    FROM ExamenesFinales e
    JOIN Alumnos  a ON a.Legajo    = e.Legajo
    JOIN Personas p ON p.idPersona = a.idPersona
    WHERE e.idMateria = p_idmateria
      AND e.Estado    = 'Aprobado'
      AND e.Fecha BETWEEN p_desde AND p_hasta
    ORDER BY p.Apellidos, p.Nombres;
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.g) Materias que hay que aprobar para poder cursar una materia.
--
--       Las correlativas son transitivas: si 5 requiere 3 y 3
--       requiere 1, para cursar 5 hacen falta 3 y 1. Se recorre el
--       grafo con un WHILE y dos arrays (pendientes / encontradas).
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION materias_requeridas(p_idmateria INTEGER)
RETURNS TABLE (
    id_materia INTEGER,
    nombre     VARCHAR,
    anio       INTEGER,
    periodo    TPeriodoMateria
) AS $$
DECLARE
    v_pendientes INTEGER[] := ARRAY[p_idmateria];
    v_requeridas INTEGER[] := ARRAY[]::INTEGER[];
    v_actual     INTEGER;
    v_correlativa INTEGER;
    v_fila       RECORD;
BEGIN
    WHILE array_length(v_pendientes, 1) > 0 LOOP
        v_actual     := v_pendientes[1];
        v_pendientes := v_pendientes[2 : array_length(v_pendientes, 1)];

        FOR v_correlativa IN
            SELECT c.idMateriaRequerida
            FROM Correlativas c
            WHERE c.idMateria = v_actual
        LOOP
            IF NOT (v_correlativa = ANY (v_requeridas)) THEN
                v_requeridas := v_requeridas || v_correlativa;
                v_pendientes := v_pendientes || v_correlativa;
            END IF;
        END LOOP;
    END LOOP;

    FOR v_fila IN
        SELECT m.idMateria, m.Nombre, m.Anio, m.Periodo
        FROM Materias m
        WHERE m.idMateria = ANY (v_requeridas)
        ORDER BY m.Anio, m.idMateria
    LOOP
        id_materia := v_fila.idMateria;
        nombre     := v_fila.Nombre;
        anio       := v_fila.Anio;
        periodo    := v_fila.Periodo;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- -------------------------------------------------------------
-- 12.h) Costo de las materias que al alumno todavía le faltan
--       aprobar para poder cursar una materia determinada.
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION costo_pendiente_para_cursar(
    p_legajo    VARCHAR,
    p_idmateria INTEGER
)
RETURNS NUMERIC AS $$
DECLARE
    v_total NUMERIC := 0;
    v_fila  RECORD;
BEGIN
    FOR v_fila IN SELECT * FROM materias_requeridas(p_idmateria) LOOP
        -- Si ya la aprobó, no la tiene que volver a cursar.
        PERFORM 1
        FROM ExamenesFinales e
        WHERE e.Legajo    = p_legajo
          AND e.idMateria = v_fila.id_materia
          AND e.Estado    = 'Aprobado';

        IF NOT FOUND THEN
            v_total := v_total + (SELECT m.Costo FROM Materias m
                                  WHERE m.idMateria = v_fila.id_materia);
        END IF;
    END LOOP;

    RETURN v_total;
END;
$$ LANGUAGE plpgsql;
