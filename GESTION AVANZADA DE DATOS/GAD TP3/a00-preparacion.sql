SET search_path TO public;

-- a.0 Preparación de la base cdelu. La base se crea y se carga desde la terminal
--     con el dump de la cátedra, que necesita PostGIS porque las tablas de
--     barrios, calles y puntos de interés tienen columnas de tipo geometry:
--
--       createdb cdelu
--       psql -d cdelu -c "CREATE EXTENSION postgis"
--       psql -d cdelu -f "CdelU - Comercios.sql"
--       psql -d cdelu -f 00-funciones-medicion.sql
--
--     Si el servidor no tiene el rol postgres, los ALTER ... OWNER TO postgres del
--     dump fallan sin consecuencias: las tablas quedan a nombre de quien las carga.
--
--     Este script deja la tabla comercios como vino en el dump: borra los índices
--     que crean los scripts siguientes y actualiza las estadísticas.

DROP INDEX IF EXISTS idx_comercios_calle_hash;
DROP INDEX IF EXISTS idx_comercios_pp_btree;
DROP INDEX IF EXISTS idx_comercios_pp_hash;
DROP INDEX IF EXISTS idx_comercios_barrio_hash;
DROP INDEX IF EXISTS idx_comercios_rubro_calle_numero;
DROP INDEX IF EXISTS idx_comercios_calle_clanae;
DROP INDEX IF EXISTS idx_comercios_clanae_superficie;
DROP INDEX IF EXISTS idx_comercios_clanae;

TRUNCATE TABLE medicion;

VACUUM ANALYZE comercios;
VACUUM ANALYZE clanae;
VACUUM ANALYZE barrios;

-- Tamaño de las tablas que usa la parte a: comercios entra entera en 58 páginas
-- de 8 kB, así que después de la primera lectura queda toda en shared_buffers.

SELECT c.relname                              AS tabla,
       c.reltuples::BIGINT                    AS filas,
       c.relpages                             AS paginas,
       pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('comercios', 'clanae', 'barrios')
ORDER BY c.relname;

-- Índices de partida: sólo las claves primarias (y el GiST geográfico de barrios).

SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename IN ('comercios', 'clanae', 'barrios')
ORDER BY tablename, indexname;

-- comercios.barrio no referencia a barrios.gid sino a barrios.type (guardado como
-- texto). Se comprueba ubicando geográficamente los comercios que tienen punto en
-- poiscomercios: el barrio que contiene al punto coincide con el que se obtiene
-- uniendo por type, nunca con el que se obtendría uniendo por gid.

SELECT pc.barrio,
       bt.label                                    AS barrio_por_type,
       bg.label                                    AS barrio_por_gid,
       MODE() WITHIN GROUP (ORDER BY geo.label)    AS barrio_por_ubicacion,
       COUNT(geo.gid)                              AS comercios_ubicados
FROM poiscomercios pc
JOIN barrios geo ON ST_Contains(geo.the_geom, pc.geom)
LEFT JOIN barrios bt ON bt.type::INTEGER = pc.barrio
LEFT JOIN barrios bg ON bg.gid = pc.barrio
GROUP BY pc.barrio, bt.label, bg.label
ORDER BY pc.barrio NULLS LAST;
