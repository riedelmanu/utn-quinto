--
-- PostgreSQL database dump
--

\restrict tXvDIrcbqNPPbvdoVdASOsZkaN6vf5MTqAhKhFxPxt79pFNwubz1kBV6FQcJGpO

-- Dumped from database version 17.10 (Homebrew)
-- Dumped by pg_dump version 17.10 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.relacion DROP CONSTRAINT IF EXISTS fk_relacion_tipo;
ALTER TABLE IF EXISTS ONLY public.relacion DROP CONSTRAINT IF EXISTS fk_relacion_persona_b;
ALTER TABLE IF EXISTS ONLY public.relacion DROP CONSTRAINT IF EXISTS fk_relacion_persona_a;
ALTER TABLE IF EXISTS ONLY public.persona DROP CONSTRAINT IF EXISTS fk_persona_tipodocumento_tipodocumento;
ALTER TABLE IF EXISTS ONLY public.partes DROP CONSTRAINT IF EXISTS fk_partes_producto;
ALTER TABLE IF EXISTS ONLY public.partes DROP CONSTRAINT IF EXISTS fk_partes_parte;
ALTER TABLE IF EXISTS ONLY public.inscripto DROP CONSTRAINT IF EXISTS fk_inscripto_curso_curso_id;
ALTER TABLE IF EXISTS ONLY public.inscripto DROP CONSTRAINT IF EXISTS fk_inscripto_alumno_alumno;
ALTER TABLE IF EXISTS ONLY public.historial_precios DROP CONSTRAINT IF EXISTS fk_historial_precios_productos;
ALTER TABLE IF EXISTS ONLY public.docente DROP CONSTRAINT IF EXISTS fk_docente_persona_persona_id;
ALTER TABLE IF EXISTS ONLY public.docente DROP CONSTRAINT IF EXISTS fk_docente_docente_dependede;
ALTER TABLE IF EXISTS ONLY public.asistencia DROP CONSTRAINT IF EXISTS fk_asistencia_inscripto_inscripcion_id;
ALTER TABLE IF EXISTS ONLY public.alumno DROP CONSTRAINT IF EXISTS fk_alumno_persona_persona_id;
ALTER TABLE IF EXISTS ONLY public.alumno DROP CONSTRAINT IF EXISTS fk_alumno_carrera_carrera_id;
DROP TRIGGER IF EXISTS trg_validar_promocion ON public.inscripto;
DROP TRIGGER IF EXISTS trg_inscripto_estado_inicial ON public.inscripto;
DROP TRIGGER IF EXISTS trg_historial_precios ON public.productos;
DROP TRIGGER IF EXISTS trg_controlar_regularidad ON public.asistencia;
DROP TRIGGER IF EXISTS trg_auditar_inscripto ON public.inscripto;
ALTER TABLE IF EXISTS ONLY public.persona DROP CONSTRAINT IF EXISTS uk_persona;
ALTER TABLE IF EXISTS ONLY public.inscripto DROP CONSTRAINT IF EXISTS uk_inscriptio;
ALTER TABLE IF EXISTS ONLY public.docente DROP CONSTRAINT IF EXISTS uk_docente;
ALTER TABLE IF EXISTS ONLY public.alumno DROP CONSTRAINT IF EXISTS uk_alumno;
ALTER TABLE IF EXISTS ONLY public.tipodocumento DROP CONSTRAINT IF EXISTS pk_tipodocumento;
ALTER TABLE IF EXISTS ONLY public.tipo_relacion DROP CONSTRAINT IF EXISTS pk_tipo_relacion;
ALTER TABLE IF EXISTS ONLY public.relacion DROP CONSTRAINT IF EXISTS pk_relacion;
ALTER TABLE IF EXISTS ONLY public.productos DROP CONSTRAINT IF EXISTS pk_productos;
ALTER TABLE IF EXISTS ONLY public.persona DROP CONSTRAINT IF EXISTS pk_persona;
ALTER TABLE IF EXISTS ONLY public.partes DROP CONSTRAINT IF EXISTS pk_partes;
ALTER TABLE IF EXISTS ONLY public.log_inscripto DROP CONSTRAINT IF EXISTS pk_log_inscripto;
ALTER TABLE IF EXISTS ONLY public.inscripto DROP CONSTRAINT IF EXISTS pk_inscripto;
ALTER TABLE IF EXISTS ONLY public.historial_precios DROP CONSTRAINT IF EXISTS pk_historial_precios;
ALTER TABLE IF EXISTS ONLY public.docente DROP CONSTRAINT IF EXISTS pk_docente;
ALTER TABLE IF EXISTS ONLY public.curso DROP CONSTRAINT IF EXISTS pk_curso;
ALTER TABLE IF EXISTS ONLY public.contactos DROP CONSTRAINT IF EXISTS pk_contactos;
ALTER TABLE IF EXISTS ONLY public.carrera DROP CONSTRAINT IF EXISTS pk_carrera;
ALTER TABLE IF EXISTS ONLY public.asistencia DROP CONSTRAINT IF EXISTS pk_asistencia;
ALTER TABLE IF EXISTS ONLY public.alumno DROP CONSTRAINT IF EXISTS pk_alumno;
ALTER TABLE IF EXISTS public.productos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.log_inscripto ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.historial_precios ALTER COLUMN id_historial DROP DEFAULT;
DROP TABLE IF EXISTS public.tipodocumento;
DROP TABLE IF EXISTS public.tipo_relacion;
DROP TABLE IF EXISTS public.relacion;
DROP SEQUENCE IF EXISTS public.productos_id_seq;
DROP TABLE IF EXISTS public.productos;
DROP TABLE IF EXISTS public.persona;
DROP TABLE IF EXISTS public.partes;
DROP SEQUENCE IF EXISTS public.log_inscripto_log_id_seq;
DROP TABLE IF EXISTS public.log_inscripto;
DROP TABLE IF EXISTS public.inscripto;
DROP SEQUENCE IF EXISTS public.historial_precios_id_historial_seq;
DROP TABLE IF EXISTS public.historial_precios;
DROP TABLE IF EXISTS public.docente;
DROP TABLE IF EXISTS public.curso;
DROP TABLE IF EXISTS public.contactos;
DROP TABLE IF EXISTS public.carrera;
DROP TABLE IF EXISTS public.asistencia;
DROP TABLE IF EXISTS public.alumno;
DROP FUNCTION IF EXISTS public.fn_validar_promocion();
DROP FUNCTION IF EXISTS public.fn_registrar_cambio_precio();
DROP FUNCTION IF EXISTS public.fn_partes_explosionadas(p_idproducto integer);
DROP FUNCTION IF EXISTS public.fn_partes_de(p_idproducto integer);
DROP FUNCTION IF EXISTS public.fn_inscripto_estado_inicial();
DROP FUNCTION IF EXISTS public.fn_horas_inasistencia(p_inscripcion_id integer);
DROP FUNCTION IF EXISTS public.fn_grado_parentesco(p_a integer, p_b integer);
DROP FUNCTION IF EXISTS public.fn_distancia_amistad(p_a integer, p_b integer);
DROP FUNCTION IF EXISTS public.fn_depende_de(p_x integer, p_y integer);
DROP FUNCTION IF EXISTS public.fn_controlar_regularidad();
DROP FUNCTION IF EXISTS public.fn_auditar_inscripto();
DROP TYPE IF EXISTS public.estadocursada;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: estadocursada; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.estadocursada AS ENUM (
    'REGULAR',
    'LIBRE',
    'RECURSA',
    'PROMOCION'
);


--
-- Name: fn_auditar_inscripto(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_auditar_inscripto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: fn_controlar_regularidad(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_controlar_regularidad() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: fn_depende_de(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_depende_de(p_x integer, p_y integer) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
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


--
-- Name: fn_distancia_amistad(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_distancia_amistad(p_a integer, p_b integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $$
    WITH RECURSIVE amistad AS (
        SELECT r.persona_a AS origen, r.persona_b AS destino
        FROM relacion r
        WHERE r.tipo_relacion = 'AMIGO'
        UNION
        SELECT r.persona_b, r.persona_a
        FROM relacion r
        WHERE r.tipo_relacion = 'AMIGO'
    ),
    camino AS (
        SELECT p_a AS nodo, 0 AS distancia, ARRAY[p_a] AS visitados

        UNION ALL

        SELECT a.destino,
               c.distancia + 1,
               c.visitados || a.destino
        FROM camino c
        JOIN amistad a ON a.origen = c.nodo
        WHERE NOT a.destino = ANY (c.visitados)
    )
    SELECT COALESCE(MIN(c.distancia), 0)
    FROM camino c
    WHERE c.nodo = p_b
      AND c.distancia > 0;
$$;


--
-- Name: fn_grado_parentesco(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_grado_parentesco(p_a integer, p_b integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $$
    WITH RECURSIVE familia AS (
        SELECT r.persona_a AS origen, r.persona_b AS destino
        FROM relacion r
        JOIN tipo_relacion t ON t.tipo_relacion = r.tipo_relacion
        WHERE t.es_familiar
        UNION
        SELECT r.persona_b, r.persona_a
        FROM relacion r
        JOIN tipo_relacion t ON t.tipo_relacion = r.tipo_relacion
        WHERE t.es_familiar
    ),
    camino AS (
        SELECT p_a AS nodo, 0 AS grado, ARRAY[p_a] AS visitados

        UNION ALL

        SELECT f.destino,
               c.grado + 1,
               c.visitados || f.destino
        FROM camino c
        JOIN familia f ON f.origen = c.nodo
        WHERE NOT f.destino = ANY (c.visitados)
    )
    SELECT COALESCE(MIN(c.grado), 0)
    FROM camino c
    WHERE c.nodo = p_b
      AND c.grado > 0;
$$;


--
-- Name: fn_horas_inasistencia(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_horas_inasistencia(p_inscripcion_id integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $$
    SELECT COALESCE(SUM(c.horasxclase - a.horas), 0)::INTEGER
    FROM asistencia a
    JOIN inscripto i ON i.inscripcion_id = a.inscripcion_id
    JOIN curso     c ON c.curso_id       = i.curso_id
    WHERE a.inscripcion_id = p_inscripcion_id;
$$;


--
-- Name: fn_inscripto_estado_inicial(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_inscripto_estado_inicial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.estadocursada := 'REGULAR';
    RETURN NEW;
END;
$$;


--
-- Name: fn_partes_de(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_partes_de(p_idproducto integer) RETURNS TABLE(idproducto integer, idparte integer, nivel integer, cantidad integer)
    LANGUAGE sql STABLE
    AS $$
    WITH RECURSIVE explosion AS (
        SELECT p.idproducto,
               p.idparte,
               1 AS nivel,
               p.cantidad,
               ARRAY[p.idproducto, p.idparte] AS visitados
        FROM partes p
        WHERE p.idproducto = p_idproducto

        UNION ALL

        SELECT p.idproducto,
               p.idparte,
               e.nivel + 1,
               p.cantidad,
               e.visitados || p.idparte
        FROM explosion e
        JOIN partes p ON p.idproducto = e.idparte
        WHERE NOT p.idparte = ANY (e.visitados)
    )
    SELECT e.idproducto, e.idparte, e.nivel, e.cantidad
    FROM explosion e
    ORDER BY e.nivel, e.idproducto, e.idparte;
$$;


--
-- Name: fn_partes_explosionadas(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_partes_explosionadas(p_idproducto integer) RETURNS TABLE(idproducto integer, idparte integer, nivel integer, cantidad integer, cantidad_real integer)
    LANGUAGE sql STABLE
    AS $$
    WITH RECURSIVE explosion AS (
        SELECT p.idproducto,
               p.idparte,
               1 AS nivel,
               p.cantidad,
               p.cantidad AS cantidad_real,
               ARRAY[p.idproducto, p.idparte] AS visitados
        FROM partes p
        WHERE p.idproducto = p_idproducto

        UNION ALL

        SELECT p.idproducto,
               p.idparte,
               e.nivel + 1,
               p.cantidad,
               e.cantidad_real * p.cantidad,
               e.visitados || p.idparte
        FROM explosion e
        JOIN partes p ON p.idproducto = e.idparte
        WHERE NOT p.idparte = ANY (e.visitados)
    )
    SELECT e.idproducto, e.idparte, e.nivel, e.cantidad, e.cantidad_real
    FROM explosion e
    ORDER BY e.nivel, e.idproducto, e.idparte;
$$;


--
-- Name: fn_registrar_cambio_precio(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_registrar_cambio_precio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO historial_precios (id_producto, precio_antiguo, precio_nuevo)
    VALUES (NEW.id, OLD.precio, NEW.precio);
    RETURN NULL;
END;
$$;


--
-- Name: fn_validar_promocion(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_validar_promocion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alumno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alumno (
    persona_id integer NOT NULL,
    legajo integer NOT NULL,
    carrera_id character(1)
);


--
-- Name: asistencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.asistencia (
    inscripcion_id integer NOT NULL,
    fecha date DEFAULT (now())::date NOT NULL,
    horas integer NOT NULL
);


--
-- Name: carrera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carrera (
    carrera_id character(1) NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: contactos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contactos (
    nodo_origen character varying(10) NOT NULL,
    nodo_destino character varying(10) NOT NULL,
    distancia integer NOT NULL,
    CONSTRAINT ck_contactos_distancia CHECK ((distancia > 0)),
    CONSTRAINT ck_contactos_sin_bucle CHECK (((nodo_origen)::text <> (nodo_destino)::text))
);


--
-- Name: curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curso (
    curso_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    horaspermregular smallint NOT NULL,
    horaspermpromocion smallint NOT NULL,
    horasxclase smallint NOT NULL
);


--
-- Name: COLUMN curso.horaspermregular; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.curso.horaspermregular IS 'Cantidad de horas de faltas permitidas para regularizar';


--
-- Name: COLUMN curso.horaspermpromocion; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.curso.horaspermpromocion IS 'Cantidad de horas de faltas permitidas para promocionar';


--
-- Name: COLUMN curso.horasxclase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.curso.horasxclase IS 'Cantidad de horas que se dictan por clase.';


--
-- Name: docente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.docente (
    persona_id integer NOT NULL,
    legajo integer NOT NULL,
    dependede integer,
    salario numeric(12,2) NOT NULL
);


--
-- Name: historial_precios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.historial_precios (
    id_historial integer NOT NULL,
    id_producto integer NOT NULL,
    precio_antiguo numeric(12,2) NOT NULL,
    precio_nuevo numeric(12,2) NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    usuario character varying(50) DEFAULT CURRENT_USER NOT NULL
);


--
-- Name: historial_precios_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.historial_precios_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: historial_precios_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.historial_precios_id_historial_seq OWNED BY public.historial_precios.id_historial;


--
-- Name: inscripto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inscripto (
    inscripcion_id integer NOT NULL,
    anio smallint NOT NULL,
    fecha date NOT NULL,
    alumno integer NOT NULL,
    curso_id integer NOT NULL,
    estadocursada public.estadocursada NOT NULL
);


--
-- Name: log_inscripto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.log_inscripto (
    log_id integer NOT NULL,
    operacion character varying(10) NOT NULL,
    fechahora timestamp without time zone DEFAULT now() NOT NULL,
    usuario character varying(50) DEFAULT CURRENT_USER NOT NULL,
    ant_inscripcion_id integer,
    ant_anio smallint,
    ant_fecha date,
    ant_alumno integer,
    ant_curso_id integer,
    ant_estadocursada public.estadocursada,
    nue_inscripcion_id integer,
    nue_anio smallint,
    nue_fecha date,
    nue_alumno integer,
    nue_curso_id integer,
    nue_estadocursada public.estadocursada,
    CONSTRAINT ck_log_inscripto_operacion CHECK (((operacion)::text = ANY ((ARRAY['INSERT'::character varying, 'UPDATE'::character varying, 'DELETE'::character varying])::text[])))
);


--
-- Name: log_inscripto_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.log_inscripto_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: log_inscripto_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.log_inscripto_log_id_seq OWNED BY public.log_inscripto.log_id;


--
-- Name: partes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partes (
    idproducto integer NOT NULL,
    idparte integer NOT NULL,
    cantidad integer NOT NULL,
    CONSTRAINT ck_partes_cantidad CHECK ((cantidad > 0)),
    CONSTRAINT ck_partes_sin_bucle CHECK ((idproducto <> idparte))
);


--
-- Name: persona; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persona (
    persona_id integer NOT NULL,
    tipodocumento character varying(5) NOT NULL,
    documento character varying(25) NOT NULL,
    apellidos character varying(50) NOT NULL,
    nombres character varying(50) NOT NULL
);


--
-- Name: productos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    precio numeric(12,2) NOT NULL,
    CONSTRAINT ck_productos_precio CHECK ((precio >= (0)::numeric))
);


--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: relacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relacion (
    persona_a integer NOT NULL,
    persona_b integer NOT NULL,
    tipo_relacion character varying(15) NOT NULL,
    CONSTRAINT ck_relacion_sin_bucle CHECK ((persona_a <> persona_b))
);


--
-- Name: tipo_relacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_relacion (
    tipo_relacion character varying(15) NOT NULL,
    descripcion character varying(50) NOT NULL,
    es_familiar boolean NOT NULL,
    es_simetrica boolean NOT NULL
);


--
-- Name: tipodocumento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipodocumento (
    tipodocumento character varying(5) NOT NULL,
    descripcion character varying(50) NOT NULL
);


--
-- Name: historial_precios id_historial; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial_precios ALTER COLUMN id_historial SET DEFAULT nextval('public.historial_precios_id_historial_seq'::regclass);


--
-- Name: log_inscripto log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.log_inscripto ALTER COLUMN log_id SET DEFAULT nextval('public.log_inscripto_log_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alumno (persona_id, legajo, carrera_id) FROM stdin;
101	101	K
102	102	K
103	103	K
104	104	K
105	105	K
106	106	K
107	107	K
108	108	K
109	109	K
\.


--
-- Data for Name: asistencia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.asistencia (inscripcion_id, fecha, horas) FROM stdin;
1	2025-04-01	4
2	2025-04-01	4
4	2025-04-01	4
5	2025-04-01	4
6	2025-04-01	4
7	2025-04-01	4
8	2025-04-01	4
9	2025-04-01	4
10	2025-04-01	4
11	2025-04-01	4
12	2025-04-01	4
13	2025-04-01	4
14	2025-04-01	4
15	2025-04-01	4
16	2025-04-01	4
17	2025-04-01	4
18	2025-04-01	4
19	2025-04-01	4
20	2025-04-01	4
1	2025-04-03	4
2	2025-04-03	4
4	2025-04-03	4
5	2025-04-03	4
6	2025-04-03	4
7	2025-04-03	4
8	2025-04-03	4
9	2025-04-03	4
10	2025-04-03	4
11	2025-04-03	0
12	2025-04-03	4
13	2025-04-03	4
14	2025-04-03	4
15	2025-04-03	4
16	2025-04-03	4
17	2025-04-03	0
18	2025-04-03	4
19	2025-04-03	4
20	2025-04-03	4
1	2025-06-01	0
2	2025-06-01	4
4	2025-06-01	4
5	2025-06-01	4
6	2025-06-01	4
7	2025-06-01	4
8	2025-06-01	4
9	2025-06-01	4
10	2025-06-01	0
11	2025-06-01	4
12	2025-06-01	4
13	2025-06-01	4
14	2025-06-01	4
15	2025-06-01	4
16	2025-06-01	4
17	2025-06-01	0
18	2025-06-01	4
19	2025-06-01	4
20	2025-06-01	4
5	2025-06-05	0
5	2025-06-08	0
5	2025-06-12	0
3	2025-04-01	0
3	2025-04-03	0
3	2025-06-01	0
21	2025-04-01	4
21	2025-05-01	4
21	2025-06-01	4
\.


--
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carrera (carrera_id, nombre) FROM stdin;
K	Ingeniería en Sistemas de Información
\.


--
-- Data for Name: contactos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contactos (nodo_origen, nodo_destino, distancia) FROM stdin;
A	B	5
A	C	2
A	F	10
B	C	1
B	D	4
C	B	1
C	D	7
C	E	3
E	D	1
F	D	1
D	A	6
\.


--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.curso (curso_id, nombre, horaspermregular, horaspermpromocion, horasxclase) FROM stdin;
1	Curso 1	8	4	4
2	Curso 2	4	0	4
3	Curso 3	8	4	4
4	Curso 4	4	0	4
5	Curso 5	8	4	4
\.


--
-- Data for Name: docente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.docente (persona_id, legajo, dependede, salario) FROM stdin;
1	1001	\N	2400000.00
2	1002	1	1800000.00
3	1003	1	1750000.00
4	1004	2	1200000.00
5	1005	2	1150000.00
6	1006	3	1100000.00
7	1007	4	900000.00
8	1008	4	850000.00
\.


--
-- Data for Name: historial_precios; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.historial_precios (id_historial, id_producto, precio_antiguo, precio_nuevo, fecha, usuario) FROM stdin;
1	2	320000.00	350000.00	2026-09-21 13:25:09.264348	manuel
2	7	18000.00	19500.00	2026-09-21 13:25:09.265058	manuel
\.


--
-- Data for Name: inscripto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inscripto (inscripcion_id, anio, fecha, alumno, curso_id, estadocursada) FROM stdin;
1	2025	2026-09-16	101	1	REGULAR
4	2025	2026-09-16	104	1	REGULAR
6	2025	2026-09-16	101	2	REGULAR
7	2025	2026-09-16	102	2	REGULAR
8	2025	2026-09-16	103	2	REGULAR
9	2025	2026-09-16	104	2	REGULAR
10	2025	2026-09-16	105	2	REGULAR
11	2025	2026-09-16	101	3	REGULAR
12	2025	2026-09-16	102	3	REGULAR
13	2025	2026-09-16	103	3	REGULAR
14	2025	2026-09-16	104	3	REGULAR
15	2025	2026-09-16	105	3	REGULAR
16	2025	2026-09-16	101	4	REGULAR
18	2025	2026-09-16	103	4	REGULAR
19	2025	2026-09-16	104	4	REGULAR
20	2025	2026-09-16	105	4	REGULAR
21	2025	2026-09-16	106	1	REGULAR
2	2025	2026-09-16	102	1	PROMOCION
5	2025	2026-09-16	105	1	LIBRE
3	2025	2026-09-16	103	1	LIBRE
17	2025	2026-09-16	102	4	LIBRE
\.


--
-- Data for Name: log_inscripto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.log_inscripto (log_id, operacion, fechahora, usuario, ant_inscripcion_id, ant_anio, ant_fecha, ant_alumno, ant_curso_id, ant_estadocursada, nue_inscripcion_id, nue_anio, nue_fecha, nue_alumno, nue_curso_id, nue_estadocursada) FROM stdin;
\.


--
-- Data for Name: partes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.partes (idproducto, idparte, cantidad) FROM stdin;
1	2	4
1	5	1
1	10	1
2	3	1
2	4	1
2	9	5
5	6	4
5	7	4
5	8	8
5	9	2
6	9	3
10	9	20
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.persona (persona_id, tipodocumento, documento, apellidos, nombres) FROM stdin;
1	DNI	1	Gomez	Alan
2	DNI	2	Smith	Micaela
3	DNI	3	Perez	Albert
4	DNI	4	Toma	Alexis
5	DNI	5	Jones	Roberto
6	DNI	6	Sea	Susana
7	DNI	7	Ada	Martinez
8	DNI	8	Keys	Gonzalo
101	DNI	101	Alumno	Alumno 1
102	DNI	102	Alumno	Alumno 2
103	DNI	103	Alumno	Alumno 3
104	DNI	104	Alumno	Alumno 4
105	DNI	105	Alumno	Alumno 5
106	DNI	106	Alumno	Alumno 6
107	DNI	107	Alumno	Alumno 7
108	DNI	108	Alumno	Alumno 8
109	DNI	109	Alumno	Alumno 9
201	DNI	201	Alvarez	Jorge
202	DNI	202	Alvarez	Marta
203	DNI	203	Alvarez	Diego
204	DNI	204	Alvarez	Laura
205	DNI	205	Benitez	Silvia
206	DNI	206	Alvarez	Nicolas
207	DNI	207	Alvarez	Camila
208	DNI	208	Castro	Pablo
209	DNI	209	Diaz	Marina
210	DNI	210	Esquivel	Tomas
211	DNI	211	Ferrer	Ana
212	DNI	212	Gimenez	Luis
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.productos (id, nombre, precio) FROM stdin;
1	Automóvil	38000000.00
3	Llanta	180000.00
4	Neumático	140000.00
5	Motor	9500000.00
6	Pistón	210000.00
8	Válvula	26000.00
9	Tornillo	900.00
10	Chasis	4200000.00
2	Rueda	350000.00
7	Bujía	19500.00
\.


--
-- Data for Name: relacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.relacion (persona_a, persona_b, tipo_relacion) FROM stdin;
201	202	CONYUGE
201	203	PADRE
202	203	PADRE
201	204	PADRE
202	204	PADRE
203	204	HERMANO
203	205	CONYUGE
203	206	PADRE
205	206	PADRE
203	207	PADRE
205	207	PADRE
206	207	HERMANO
206	208	AMIGO
208	209	AMIGO
209	210	AMIGO
210	206	AMIGO
210	211	AMIGO
211	212	CONOCIDO
\.


--
-- Data for Name: tipo_relacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipo_relacion (tipo_relacion, descripcion, es_familiar, es_simetrica) FROM stdin;
PADRE	persona_a es padre o madre de persona_b	t	f
HERMANO	persona_a y persona_b son hermanos	t	t
CONYUGE	persona_a y persona_b son cónyuges	t	t
AMIGO	persona_a y persona_b son amigos	f	t
CONOCIDO	persona_a y persona_b se conocen	f	t
\.


--
-- Data for Name: tipodocumento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipodocumento (tipodocumento, descripcion) FROM stdin;
DNI	Documento Nacional de Identidad
LE	Libreta de Enrolamiento
LC	Libreta Cívica
\.


--
-- Name: historial_precios_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.historial_precios_id_historial_seq', 2, true);


--
-- Name: log_inscripto_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.log_inscripto_log_id_seq', 4, true);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.productos_id_seq', 10, true);


--
-- Name: alumno pk_alumno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (persona_id);


--
-- Name: asistencia pk_asistencia; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT pk_asistencia PRIMARY KEY (inscripcion_id, fecha);


--
-- Name: carrera pk_carrera; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT pk_carrera PRIMARY KEY (carrera_id);


--
-- Name: contactos pk_contactos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contactos
    ADD CONSTRAINT pk_contactos PRIMARY KEY (nodo_origen, nodo_destino);


--
-- Name: curso pk_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT pk_curso PRIMARY KEY (curso_id);


--
-- Name: docente pk_docente; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT pk_docente PRIMARY KEY (persona_id);


--
-- Name: historial_precios pk_historial_precios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial_precios
    ADD CONSTRAINT pk_historial_precios PRIMARY KEY (id_historial);


--
-- Name: inscripto pk_inscripto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inscripto
    ADD CONSTRAINT pk_inscripto PRIMARY KEY (inscripcion_id);


--
-- Name: log_inscripto pk_log_inscripto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.log_inscripto
    ADD CONSTRAINT pk_log_inscripto PRIMARY KEY (log_id);


--
-- Name: partes pk_partes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partes
    ADD CONSTRAINT pk_partes PRIMARY KEY (idproducto, idparte);


--
-- Name: persona pk_persona; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT pk_persona PRIMARY KEY (persona_id);


--
-- Name: productos pk_productos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT pk_productos PRIMARY KEY (id);


--
-- Name: relacion pk_relacion; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relacion
    ADD CONSTRAINT pk_relacion PRIMARY KEY (persona_a, persona_b, tipo_relacion);


--
-- Name: tipo_relacion pk_tipo_relacion; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_relacion
    ADD CONSTRAINT pk_tipo_relacion PRIMARY KEY (tipo_relacion);


--
-- Name: tipodocumento pk_tipodocumento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipodocumento
    ADD CONSTRAINT pk_tipodocumento PRIMARY KEY (tipodocumento);


--
-- Name: alumno uk_alumno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT uk_alumno UNIQUE (legajo);


--
-- Name: docente uk_docente; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT uk_docente UNIQUE (legajo);


--
-- Name: inscripto uk_inscriptio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inscripto
    ADD CONSTRAINT uk_inscriptio UNIQUE (anio, alumno, curso_id);


--
-- Name: persona uk_persona; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT uk_persona UNIQUE (tipodocumento, documento);


--
-- Name: inscripto trg_auditar_inscripto; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_auditar_inscripto AFTER INSERT OR DELETE OR UPDATE ON public.inscripto FOR EACH ROW EXECUTE FUNCTION public.fn_auditar_inscripto();


--
-- Name: asistencia trg_controlar_regularidad; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_controlar_regularidad AFTER INSERT OR DELETE OR UPDATE ON public.asistencia FOR EACH ROW EXECUTE FUNCTION public.fn_controlar_regularidad();


--
-- Name: productos trg_historial_precios; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_historial_precios AFTER UPDATE OF precio ON public.productos FOR EACH ROW WHEN ((old.precio IS DISTINCT FROM new.precio)) EXECUTE FUNCTION public.fn_registrar_cambio_precio();


--
-- Name: inscripto trg_inscripto_estado_inicial; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_inscripto_estado_inicial BEFORE INSERT ON public.inscripto FOR EACH ROW EXECUTE FUNCTION public.fn_inscripto_estado_inicial();


--
-- Name: inscripto trg_validar_promocion; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_validar_promocion BEFORE UPDATE ON public.inscripto FOR EACH ROW WHEN (((new.estadocursada = 'PROMOCION'::public.estadocursada) AND (old.estadocursada IS DISTINCT FROM 'PROMOCION'::public.estadocursada))) EXECUTE FUNCTION public.fn_validar_promocion();


--
-- Name: alumno fk_alumno_carrera_carrera_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fk_alumno_carrera_carrera_id FOREIGN KEY (carrera_id) REFERENCES public.carrera(carrera_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: alumno fk_alumno_persona_persona_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fk_alumno_persona_persona_id FOREIGN KEY (persona_id) REFERENCES public.persona(persona_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: asistencia fk_asistencia_inscripto_inscripcion_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT fk_asistencia_inscripto_inscripcion_id FOREIGN KEY (inscripcion_id) REFERENCES public.inscripto(inscripcion_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: docente fk_docente_docente_dependede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT fk_docente_docente_dependede FOREIGN KEY (dependede) REFERENCES public.docente(persona_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: docente fk_docente_persona_persona_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT fk_docente_persona_persona_id FOREIGN KEY (persona_id) REFERENCES public.persona(persona_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: historial_precios fk_historial_precios_productos; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial_precios
    ADD CONSTRAINT fk_historial_precios_productos FOREIGN KEY (id_producto) REFERENCES public.productos(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: inscripto fk_inscripto_alumno_alumno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inscripto
    ADD CONSTRAINT fk_inscripto_alumno_alumno FOREIGN KEY (alumno) REFERENCES public.alumno(persona_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: inscripto fk_inscripto_curso_curso_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inscripto
    ADD CONSTRAINT fk_inscripto_curso_curso_id FOREIGN KEY (curso_id) REFERENCES public.curso(curso_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: partes fk_partes_parte; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partes
    ADD CONSTRAINT fk_partes_parte FOREIGN KEY (idparte) REFERENCES public.productos(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: partes fk_partes_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partes
    ADD CONSTRAINT fk_partes_producto FOREIGN KEY (idproducto) REFERENCES public.productos(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: persona fk_persona_tipodocumento_tipodocumento; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_persona_tipodocumento_tipodocumento FOREIGN KEY (tipodocumento) REFERENCES public.tipodocumento(tipodocumento) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: relacion fk_relacion_persona_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relacion
    ADD CONSTRAINT fk_relacion_persona_a FOREIGN KEY (persona_a) REFERENCES public.persona(persona_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: relacion fk_relacion_persona_b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relacion
    ADD CONSTRAINT fk_relacion_persona_b FOREIGN KEY (persona_b) REFERENCES public.persona(persona_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: relacion fk_relacion_tipo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relacion
    ADD CONSTRAINT fk_relacion_tipo FOREIGN KEY (tipo_relacion) REFERENCES public.tipo_relacion(tipo_relacion) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict tXvDIrcbqNPPbvdoVdASOsZkaN6vf5MTqAhKhFxPxt79pFNwubz1kBV6FQcJGpO

