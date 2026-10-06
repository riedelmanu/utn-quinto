-- 2. Tabla de auditoría de inscripciones, con el estado anterior y el posterior
--    de cada modificación.
-- 2.a) fechahora TIMESTAMP con la fecha y hora del sistema por defecto.
-- 2.b) usuario, el usuario de base de datos que realizó la modificación.

DROP TABLE IF EXISTS log_inscripto;

CREATE TABLE log_inscripto (
    log_id             SERIAL,
    operacion          VARCHAR(10)   NOT NULL,
    fechahora          TIMESTAMP     NOT NULL DEFAULT NOW(),
    usuario            VARCHAR(50)   NOT NULL DEFAULT CURRENT_USER,
    ant_inscripcion_id INTEGER,
    ant_anio           SMALLINT,
    ant_fecha          DATE,
    ant_alumno         INTEGER,
    ant_curso_id       INTEGER,
    ant_estadocursada  estadocursada,
    nue_inscripcion_id INTEGER,
    nue_anio           SMALLINT,
    nue_fecha          DATE,
    nue_alumno         INTEGER,
    nue_curso_id       INTEGER,
    nue_estadocursada  estadocursada,
    CONSTRAINT pk_log_inscripto PRIMARY KEY (log_id),
    CONSTRAINT ck_log_inscripto_operacion CHECK (operacion IN ('INSERT', 'UPDATE', 'DELETE'))
);

-- 2. Trigger que registra automáticamente las modificaciones sobre inscripto.
--    OLD trae la fila previa al evento y NEW la resultante: en INSERT sólo hay NEW,
--    en DELETE sólo hay OLD y en UPDATE están ambas.

CREATE OR REPLACE FUNCTION fn_auditar_inscripto()
RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_inscripto (operacion,
            nue_inscripcion_id, nue_anio, nue_fecha, nue_alumno, nue_curso_id, nue_estadocursada)
        VALUES (TG_OP,
            NEW.inscripcion_id, NEW.anio, NEW.fecha, NEW.alumno, NEW.curso_id, NEW.estadocursada);

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_inscripto (operacion,
            ant_inscripcion_id, ant_anio, ant_fecha, ant_alumno, ant_curso_id, ant_estadocursada,
            nue_inscripcion_id, nue_anio, nue_fecha, nue_alumno, nue_curso_id, nue_estadocursada)
        VALUES (TG_OP,
            OLD.inscripcion_id, OLD.anio, OLD.fecha, OLD.alumno, OLD.curso_id, OLD.estadocursada,
            NEW.inscripcion_id, NEW.anio, NEW.fecha, NEW.alumno, NEW.curso_id, NEW.estadocursada);

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_inscripto (operacion,
            ant_inscripcion_id, ant_anio, ant_fecha, ant_alumno, ant_curso_id, ant_estadocursada)
        VALUES (TG_OP,
            OLD.inscripcion_id, OLD.anio, OLD.fecha, OLD.alumno, OLD.curso_id, OLD.estadocursada);
    END IF;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_auditar_inscripto ON inscripto;

CREATE TRIGGER trg_auditar_inscripto
AFTER INSERT OR UPDATE OR DELETE ON inscripto
FOR EACH ROW
EXECUTE FUNCTION fn_auditar_inscripto();

-- 2. Pruebas

BEGIN;

INSERT INTO inscripto (inscripcion_id, anio, fecha, alumno, curso_id, estadocursada)
VALUES (902, 2025, DATE '2025-03-11', 108, 5, 'REGULAR');

UPDATE inscripto SET estadocursada = 'PROMOCION' WHERE inscripcion_id = 902;

UPDATE inscripto SET estadocursada = 'RECURSA' WHERE inscripcion_id = 902;

DELETE FROM inscripto WHERE inscripcion_id = 902;

SELECT log_id, operacion, usuario,
       ant_inscripcion_id, ant_estadocursada,
       nue_inscripcion_id, nue_estadocursada
FROM log_inscripto
ORDER BY log_id;

SELECT log_id, operacion, fechahora FROM log_inscripto ORDER BY log_id;

ROLLBACK;
