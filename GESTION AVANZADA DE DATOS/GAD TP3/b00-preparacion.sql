SET search_path TO public;

-- b.0 Tablas articulos y precios, tal como las define el enunciado, en la base
--     optimizacion (compartida con las partes c y d):
--
--       createdb optimizacion
--       psql -d optimizacion -f 00-funciones-medicion.sql
--
--     setseed fija la semilla de random() para que los datos generados sean
--     siempre los mismos y las salidas de este documento se puedan reproducir.

DROP TABLE IF EXISTS precios;
DROP TABLE IF EXISTS articulos;
DELETE FROM medicion WHERE item LIKE 'b.%';

CREATE OR REPLACE FUNCTION public.random_string(length integer)
RETURNS text
LANGUAGE plpgsql AS $BODY$
declare
    chars text[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
    result text := '';
    i integer := 0;
begin
    if length < 0 then
        raise exception 'Given length cannot be less than 0';
    end if;
    for i in 1..length loop
        result := result || chars[1+random()*(array_length(chars, 1)-1)];
    end loop;
    return result;
end;
$BODY$;

SELECT setseed(0.2026);

create table articulos as
    select id::int8, random_string(100) as descripcion, round(random() * 30)::int8 as rubro
    from generate_series(1, 500000) as id;

create table precios as
    select id::int8,
           round(random() * 99000)::int8+1 as id_articulo,
           timestamp '2022-01-01 00:00:00' + (random() * (interval '1000 days')) as fecha,
           100.00+round(random() * 5000)::numeric(11,2) as precio
    from generate_series(1, 8000000) as id;

VACUUM ANALYZE articulos;
VACUUM ANALYZE precios;

-- Tamaño de las tablas. Ninguna de las dos tiene clave primaria ni índices:
-- CREATE TABLE AS sólo copia los datos.

SELECT c.relname                               AS tabla,
       c.reltuples::BIGINT                     AS filas,
       c.relpages                              AS paginas,
       pg_size_pretty(pg_relation_size(c.oid)) AS tamanio
FROM pg_class c
WHERE c.relname IN ('articulos', 'precios')
ORDER BY c.relname;

-- Características de los datos que condicionan los planes: id_articulo va de 1 a
-- 99.001, así que sólo uno de cada cinco artículos tiene precios; cada uno tiene
-- en promedio unos 80. Los rubros van de 0 a 30.

SELECT MIN(id_articulo)                         AS min_articulo,
       MAX(id_articulo)                         AS max_articulo,
       COUNT(DISTINCT id_articulo)              AS articulos_con_precio,
       ROUND(COUNT(*)::NUMERIC / COUNT(DISTINCT id_articulo), 1) AS precios_por_articulo,
       MIN(fecha)::DATE                         AS primera_fecha,
       MAX(fecha)::DATE                         AS ultima_fecha,
       MIN(precio)                              AS precio_min,
       MAX(precio)                              AS precio_max
FROM precios;

SELECT rubro, COUNT(*) AS articulos
FROM articulos
WHERE rubro IN (0, 5, 15, 30)
GROUP BY rubro
ORDER BY rubro;

-- Correlación entre el orden físico y el valor de cada columna, según las
-- estadísticas del planificador (1 = misma secuencia, 0 = sin relación).

SELECT tablename, attname, n_distinct, ROUND(correlation::NUMERIC, 3) AS correlacion
FROM pg_stats
WHERE tablename IN ('articulos', 'precios')
ORDER BY tablename, attname;
