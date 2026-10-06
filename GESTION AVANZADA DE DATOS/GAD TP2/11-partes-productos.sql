-- 11. Estructura de composición de productos en partes, con una cantidad arbitraria
--     de niveles: cada parte puede a su vez estar compuesta por otras partes.

DROP TABLE IF EXISTS partes;

CREATE TABLE partes (
    idproducto INTEGER NOT NULL,
    idparte    INTEGER NOT NULL,
    cantidad   INTEGER NOT NULL,
    CONSTRAINT pk_partes PRIMARY KEY (idproducto, idparte),
    CONSTRAINT ck_partes_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_partes_sin_bucle CHECK (idproducto <> idparte),
    CONSTRAINT fk_partes_producto
        FOREIGN KEY (idproducto) REFERENCES productos (id)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_partes_parte
        FOREIGN KEY (idparte) REFERENCES productos (id)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO partes (idproducto, idparte, cantidad) VALUES
    ( 1,  2,  4),
    ( 1,  5,  1),
    ( 1, 10,  1),
    ( 2,  3,  1),
    ( 2,  4,  1),
    ( 2,  9,  5),
    ( 5,  6,  4),
    ( 5,  7,  4),
    ( 5,  8,  8),
    ( 5,  9,  2),
    ( 6,  9,  3),
    (10,  9, 20);

SELECT pr.id AS idproducto, pr.nombre AS producto,
       pa.idparte, pp.nombre AS parte, pa.cantidad
FROM partes pa
JOIN productos pr ON pr.id = pa.idproducto
JOIN productos pp ON pp.id = pa.idparte
ORDER BY pa.idproducto, pa.idparte;

-- 11. Función SQL que, dado un idProducto, devuelve todas sus partes y subpartes
--     con el nivel en el que se encuentran y la cantidad requerida, usando
--     WITH RECURSIVE. El arreglo de visitados corta cualquier ciclo.

CREATE OR REPLACE FUNCTION fn_partes_de(p_idproducto INTEGER)
RETURNS TABLE (idproducto INTEGER, idparte INTEGER, nivel INTEGER, cantidad INTEGER)
LANGUAGE sql STABLE AS $$
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

-- 11. Extensión que calcula la cantidad real de cada componente necesaria para
--     fabricar una unidad del producto original, multiplicando la cantidad de cada
--     nivel por la acumulada de los niveles anteriores.

CREATE OR REPLACE FUNCTION fn_partes_explosionadas(p_idproducto INTEGER)
RETURNS TABLE (idproducto INTEGER, idparte INTEGER, nivel INTEGER,
               cantidad INTEGER, cantidad_real INTEGER)
LANGUAGE sql STABLE AS $$
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

-- 11. Pruebas

SELECT f.idproducto, pr.nombre AS producto,
       f.idparte, pp.nombre AS parte,
       f.nivel, f.cantidad
FROM fn_partes_de(1) f
JOIN productos pr ON pr.id = f.idproducto
JOIN productos pp ON pp.id = f.idparte
ORDER BY f.nivel, f.idproducto, f.idparte;

SELECT f.idproducto, f.idparte, pp.nombre AS parte,
       f.nivel, f.cantidad, f.cantidad_real
FROM fn_partes_explosionadas(1) f
JOIN productos pp ON pp.id = f.idparte
ORDER BY f.nivel, f.idproducto, f.idparte;

SELECT f.idparte, pp.nombre AS parte,
       SUM(f.cantidad_real) AS unidades_por_automovil
FROM fn_partes_explosionadas(1) f
JOIN productos pp ON pp.id = f.idparte
GROUP BY f.idparte, pp.nombre
ORDER BY unidades_por_automovil DESC, f.idparte;

SELECT f.idproducto, f.idparte, pp.nombre AS parte, f.nivel, f.cantidad_real
FROM fn_partes_explosionadas(5) f
JOIN productos pp ON pp.id = f.idparte
ORDER BY f.nivel, f.idparte;
