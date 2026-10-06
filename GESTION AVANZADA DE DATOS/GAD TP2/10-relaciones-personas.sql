-- 10. Esquema de relaciones entre personas. Se reutiliza la tabla persona ya
--     existente y se agregan tipo_relacion y relacion, que forman un grafo general
--     con múltiples caminos y ciclos.

DROP TABLE IF EXISTS relacion;
DROP TABLE IF EXISTS tipo_relacion;

CREATE TABLE tipo_relacion (
    tipo_relacion VARCHAR(15) NOT NULL,
    descripcion   VARCHAR(50) NOT NULL,
    es_familiar   BOOLEAN     NOT NULL,
    es_simetrica  BOOLEAN     NOT NULL,
    CONSTRAINT pk_tipo_relacion PRIMARY KEY (tipo_relacion)
);

CREATE TABLE relacion (
    persona_a     INTEGER     NOT NULL,
    persona_b     INTEGER     NOT NULL,
    tipo_relacion VARCHAR(15) NOT NULL,
    CONSTRAINT pk_relacion PRIMARY KEY (persona_a, persona_b, tipo_relacion),
    CONSTRAINT ck_relacion_sin_bucle CHECK (persona_a <> persona_b),
    CONSTRAINT fk_relacion_persona_a
        FOREIGN KEY (persona_a) REFERENCES persona (persona_id)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT fk_relacion_persona_b
        FOREIGN KEY (persona_b) REFERENCES persona (persona_id)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT fk_relacion_tipo
        FOREIGN KEY (tipo_relacion) REFERENCES tipo_relacion (tipo_relacion)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO tipo_relacion (tipo_relacion, descripcion, es_familiar, es_simetrica) VALUES
    ('PADRE',    'persona_a es padre o madre de persona_b', TRUE,  FALSE),
    ('HERMANO',  'persona_a y persona_b son hermanos',      TRUE,  TRUE),
    ('CONYUGE',  'persona_a y persona_b son cónyuges',      TRUE,  TRUE),
    ('AMIGO',    'persona_a y persona_b son amigos',        FALSE, TRUE),
    ('CONOCIDO', 'persona_a y persona_b se conocen',        FALSE, TRUE);

-- 10. Personas y relaciones de prueba: una familia de tres generaciones y un grupo
--     de amistades que contiene un ciclo y varios caminos alternativos.

DELETE FROM persona WHERE persona_id BETWEEN 201 AND 212;

INSERT INTO persona (persona_id, tipodocumento, documento, apellidos, nombres) VALUES
    (201, 'DNI', '201', 'Alvarez',  'Jorge'),
    (202, 'DNI', '202', 'Alvarez',  'Marta'),
    (203, 'DNI', '203', 'Alvarez',  'Diego'),
    (204, 'DNI', '204', 'Alvarez',  'Laura'),
    (205, 'DNI', '205', 'Benitez',  'Silvia'),
    (206, 'DNI', '206', 'Alvarez',  'Nicolas'),
    (207, 'DNI', '207', 'Alvarez',  'Camila'),
    (208, 'DNI', '208', 'Castro',   'Pablo'),
    (209, 'DNI', '209', 'Diaz',     'Marina'),
    (210, 'DNI', '210', 'Esquivel', 'Tomas'),
    (211, 'DNI', '211', 'Ferrer',   'Ana'),
    (212, 'DNI', '212', 'Gimenez',  'Luis');

INSERT INTO relacion (persona_a, persona_b, tipo_relacion) VALUES
    (201, 202, 'CONYUGE'),
    (201, 203, 'PADRE'),
    (202, 203, 'PADRE'),
    (201, 204, 'PADRE'),
    (202, 204, 'PADRE'),
    (203, 204, 'HERMANO'),
    (203, 205, 'CONYUGE'),
    (203, 206, 'PADRE'),
    (205, 206, 'PADRE'),
    (203, 207, 'PADRE'),
    (205, 207, 'PADRE'),
    (206, 207, 'HERMANO'),
    (206, 208, 'AMIGO'),
    (208, 209, 'AMIGO'),
    (209, 210, 'AMIGO'),
    (210, 206, 'AMIGO'),
    (210, 211, 'AMIGO'),
    (211, 212, 'CONOCIDO');

SELECT r.persona_a, pa.apellidos AS apellido_a,
       r.persona_b, pb.apellidos AS apellido_b,
       r.tipo_relacion
FROM relacion r
JOIN persona pa ON pa.persona_id = r.persona_a
JOIN persona pb ON pb.persona_id = r.persona_b
ORDER BY r.tipo_relacion, r.persona_a, r.persona_b;

-- 10.1. Distancia de amistad entre dos personas: 1 los amigos directos, 2 el amigo
--       de un amigo, y 0 si no existe ningún camino de amistad. Se recorre el grafo
--       en ambos sentidos, se descartan los nodos ya visitados para evitar ciclos y
--       se devuelve la menor distancia cuando hay varios caminos.

CREATE OR REPLACE FUNCTION fn_distancia_amistad(p_a INTEGER, p_b INTEGER)
RETURNS INTEGER
LANGUAGE sql STABLE AS $$
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

-- 10.2. Grado de parentesco entre dos personas: mínima cantidad de relaciones
--       familiares directas (padre/madre-hijo, hermanos y cónyuges) que hay que
--       recorrer, y 0 si no existe ninguna. Contempla ciclos y caminos múltiples.

CREATE OR REPLACE FUNCTION fn_grado_parentesco(p_a INTEGER, p_b INTEGER)
RETURNS INTEGER
LANGUAGE sql STABLE AS $$
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

-- 10. Pruebas de distancia de amistad y grado de parentesco.

SELECT 'amigos directos'                AS caso, 206 AS a, 208 AS b, fn_distancia_amistad(206, 208) AS distancia
UNION ALL
SELECT 'amigo de un amigo',                   206,     209, fn_distancia_amistad(206, 209)
UNION ALL
SELECT 'camino más corto entre varios',       206,     211, fn_distancia_amistad(206, 211)
UNION ALL
SELECT 'sin camino de amistad',               206,     212, fn_distancia_amistad(206, 212)
UNION ALL
SELECT 'la misma persona',                    206,     206, fn_distancia_amistad(206, 206);

SELECT 'padre e hijo'                   AS caso, 203 AS a, 206 AS b, fn_grado_parentesco(203, 206) AS grado
UNION ALL
SELECT 'cónyuges',                            201,     202, fn_grado_parentesco(201, 202)
UNION ALL
SELECT 'hermanos',                            206,     207, fn_grado_parentesco(206, 207)
UNION ALL
SELECT 'abuelo y nieto',                      201,     206, fn_grado_parentesco(201, 206)
UNION ALL
SELECT 'tía y sobrino',                       204,     206, fn_grado_parentesco(204, 206)
UNION ALL
SELECT 'sin relación familiar',               206,     212, fn_grado_parentesco(206, 212);
