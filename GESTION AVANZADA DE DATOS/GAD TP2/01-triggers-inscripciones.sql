-- 1. Horas de inasistencia acumuladas por una inscripción, usadas por los controles b) y c).

CREATE OR REPLACE FUNCTION fn_horas_inasistencia(p_inscripcion_id INTEGER)
RETURNS INTEGER
LANGUAGE sql STABLE AS $$
    SELECT COALESCE(SUM(c.horasxclase - a.horas), 0)::INTEGER
    FROM asistencia a
    JOIN inscripto i ON i.inscripcion_id = a.inscripcion_id
    JOIN curso     c ON c.curso_id       = i.curso_id
    WHERE a.inscripcion_id = p_inscripcion_id;
$$;

-- 1.a) Al dar de alta una inscripción, estadocursada debe quedar siempre en REGULAR,
--      cualquiera sea el valor indicado en el INSERT.

CREATE OR REPLACE FUNCTION fn_inscripto_estado_inicial()
RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    NEW.estadocursada := 'REGULAR';
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_inscripto_estado_inicial ON inscripto;

CREATE TRIGGER trg_inscripto_estado_inicial
BEFORE INSERT ON inscripto
FOR EACH ROW
EXECUTE FUNCTION fn_inscripto_estado_inicial();

-- 1.b) Sólo se acepta el paso a PROMOCION si las inasistencias no superan
--      horaspermpromocion del curso; en caso contrario se rechaza la modificación.

CREATE OR REPLACE FUNCTION fn_validar_promocion()
RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
    v_inasistencias INTEGER;
    v_permitidas    SMALLINT;
BEGIN
    SELECT c.horaspermpromocion
      INTO v_permitidas
    FROM curso c
    WHERE c.curso_id = NEW.curso_id;

    v_inasistencias := fn_horas_inasistencia(NEW.inscripcion_id);

    IF v_inasistencias > v_permitidas THEN
        RAISE EXCEPTION
            'Inscripción %: no puede promocionar, acumula % horas de inasistencia y el curso permite %',
            NEW.inscripcion_id, v_inasistencias, v_permitidas;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_validar_promocion ON inscripto;

CREATE TRIGGER trg_validar_promocion
BEFORE UPDATE ON inscripto
FOR EACH ROW
WHEN (NEW.estadocursada = 'PROMOCION'
      AND OLD.estadocursada IS DISTINCT FROM 'PROMOCION')
EXECUTE FUNCTION fn_validar_promocion();

-- 1.c) Cuando las inasistencias superan horaspermregular del curso,
--      la inscripción pasa automáticamente a LIBRE.

CREATE OR REPLACE FUNCTION fn_controlar_regularidad()
RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
    v_inscripcion   INTEGER;
    v_inasistencias INTEGER;
    v_permitidas    SMALLINT;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_inscripcion := OLD.inscripcion_id;
    ELSE
        v_inscripcion := NEW.inscripcion_id;
    END IF;

    SELECT c.horaspermregular
      INTO v_permitidas
    FROM inscripto i
    JOIN curso     c ON c.curso_id = i.curso_id
    WHERE i.inscripcion_id = v_inscripcion;

    v_inasistencias := fn_horas_inasistencia(v_inscripcion);

    IF v_inasistencias > v_permitidas THEN
        UPDATE inscripto
           SET estadocursada = 'LIBRE'
         WHERE inscripcion_id = v_inscripcion
           AND estadocursada <> 'LIBRE';
    END IF;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_controlar_regularidad ON asistencia;

CREATE TRIGGER trg_controlar_regularidad
AFTER INSERT OR UPDATE OR DELETE ON asistencia
FOR EACH ROW
EXECUTE FUNCTION fn_controlar_regularidad();

-- 1. Normalización de las inscripciones que ya estaban cargadas antes de existir
--    los triggers, para que la base arranque cumpliendo la regla c).

UPDATE inscripto i
   SET estadocursada = 'LIBRE'
  FROM curso c
 WHERE c.curso_id = i.curso_id
   AND i.estadocursada <> 'LIBRE'
   AND fn_horas_inasistencia(i.inscripcion_id) > c.horaspermregular;

-- 1. Pruebas

BEGIN;

INSERT INTO inscripto (inscripcion_id, anio, fecha, alumno, curso_id, estadocursada)
VALUES (901, 2025, DATE '2025-03-10', 107, 3, 'PROMOCION');

SELECT inscripcion_id, alumno, curso_id, estadocursada AS estado_tras_el_alta
FROM inscripto WHERE inscripcion_id = 901;

INSERT INTO asistencia (inscripcion_id, fecha, horas) VALUES (901, DATE '2025-04-07', 0);

SELECT fn_horas_inasistencia(901) AS inasistencias,
       c.horaspermpromocion, c.horaspermregular
FROM inscripto i JOIN curso c ON c.curso_id = i.curso_id
WHERE i.inscripcion_id = 901;

DO $$
BEGIN
    UPDATE inscripto SET estadocursada = 'PROMOCION' WHERE inscripcion_id = 901;
    RAISE NOTICE 'Promoción aceptada con % horas de inasistencia', fn_horas_inasistencia(901);
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Promoción rechazada: %', SQLERRM;
END;
$$;

SELECT inscripcion_id, estadocursada AS estado FROM inscripto WHERE inscripcion_id = 901;

UPDATE inscripto SET estadocursada = 'REGULAR' WHERE inscripcion_id = 901;
INSERT INTO asistencia (inscripcion_id, fecha, horas) VALUES (901, DATE '2025-04-14', 0);

DO $$
BEGIN
    UPDATE inscripto SET estadocursada = 'PROMOCION' WHERE inscripcion_id = 901;
    RAISE NOTICE 'Promoción aceptada con % horas de inasistencia', fn_horas_inasistencia(901);
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Promoción rechazada: %', SQLERRM;
END;
$$;

SELECT inscripcion_id, estadocursada AS estado FROM inscripto WHERE inscripcion_id = 901;

INSERT INTO asistencia (inscripcion_id, fecha, horas) VALUES (901, DATE '2025-04-21', 0);

SELECT fn_horas_inasistencia(901) AS inasistencias,
       i.estadocursada AS estado_automatico
FROM inscripto i WHERE i.inscripcion_id = 901;

ROLLBACK;

SELECT i.inscripcion_id, i.alumno, i.curso_id, i.estadocursada,
       fn_horas_inasistencia(i.inscripcion_id) AS inasistencias,
       c.horaspermregular, c.horaspermpromocion
FROM inscripto i
JOIN curso c ON c.curso_id = i.curso_id
ORDER BY i.inscripcion_id;
