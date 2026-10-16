SET search_path TO public;

-- c.0 Tabla personas con un millón de filas y cuatro columnas con valores
--     repetidos: nombre, apellido, edad y ciudad. Las ciudades se reparten con
--     pesos distintos para que no todas tengan la misma frecuencia, como pasaría
--     con datos reales: Paraná es la más grande y Colón tiene el 3 % de las filas.
--     La edad es uniforme entre 0 y 99 años.

DROP TABLE IF EXISTS personas;
DELETE FROM medicion WHERE item LIKE 'c.%';

CREATE TABLE personas (
    id        BIGINT PRIMARY KEY,
    nombre    VARCHAR(30) NOT NULL,
    apellido  VARCHAR(30) NOT NULL,
    edad      SMALLINT    NOT NULL,
    ciudad    VARCHAR(40) NOT NULL
);

SELECT setseed(0.2026);

WITH ciudades (ciudad, peso) AS (
    VALUES ('Paraná', 25), ('Concordia', 16), ('Gualeguaychú', 11),
           ('Concepción del Uruguay', 10), ('Gualeguay', 5), ('Villaguay', 5),
           ('Chajarí', 5), ('Victoria', 4), ('Colón', 3), ('La Paz', 3),
           ('Nogoyá', 3), ('San José', 2), ('Federación', 2), ('Crespo', 2),
           ('Villa Elisa', 2), ('Basavilbaso', 2)
),
urna AS (
    -- Cada ciudad aparece tantas veces como su peso: sortear una posición de este
    -- arreglo de 100 elementos es sortear una ciudad con esa probabilidad.
    SELECT array_agg(ciudad) AS ciudades
    FROM ciudades, generate_series(1, peso)
),
nombres AS (
    SELECT ARRAY['Juan','María','José','Ana','Carlos','Laura','Luis','Sofía','Jorge',
                 'Lucía','Miguel','Valentina','Pedro','Camila','Diego','Martina',
                 'Pablo','Julieta','Andrés','Florencia','Ricardo','Paula','Sergio',
                 'Carolina','Martín','Gabriela','Fernando','Natalia','Leandro',
                 'Agustina','Manuel','Victoria','Nicolás','Micaela','Federico',
                 'Rocío','Gustavo','Daniela','Alejandro','Romina'] AS v
),
apellidos AS (
    SELECT ARRAY['González','Rodríguez','Gómez','Fernández','López','Díaz',
                 'Martínez','Pérez','García','Sánchez','Romero','Sosa','Álvarez',
                 'Torres','Ruiz','Ramírez','Flores','Acosta','Benítez','Medina',
                 'Suárez','Herrera','Aguirre','Pereyra','Gutiérrez','Giménez',
                 'Molina','Silva','Castro','Rojas','Ortiz','Núñez','Luna','Juárez',
                 'Cabrera','Ríos','Morales','Godoy','Moreno','Ferreyra','Domínguez',
                 'Carrizo','Peralta','Castillo','Ledesma','Quiroga','Vega','Vera',
                 'Muñoz','Ojeda'] AS v
)
INSERT INTO personas (id, nombre, apellido, edad, ciudad)
SELECT g,
       n.v[1 + floor(random() * cardinality(n.v))::INTEGER],
       a.v[1 + floor(random() * cardinality(a.v))::INTEGER],
       floor(random() * 100)::SMALLINT,
       u.ciudades[1 + floor(random() * 100)::INTEGER]
FROM generate_series(1, 1000000) AS g
CROSS JOIN nombres n
CROSS JOIN apellidos a
CROSS JOIN urna u;

VACUUM ANALYZE personas;

SELECT c.relname                               AS tabla,
       c.reltuples::BIGINT                     AS filas,
       c.relpages                              AS paginas,
       pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname = 'personas';

SELECT ciudad, COUNT(*) AS personas,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM personas
GROUP BY ciudad
ORDER BY personas DESC;

SELECT COUNT(DISTINCT nombre)   AS nombres,
       COUNT(DISTINCT apellido) AS apellidos,
       COUNT(DISTINCT edad)     AS edades,
       COUNT(DISTINCT ciudad)   AS ciudades
FROM personas;
