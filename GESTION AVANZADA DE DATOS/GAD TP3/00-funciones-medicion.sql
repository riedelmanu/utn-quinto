SET search_path TO public;

-- 0. Funciones auxiliares para comparar planes. Se crean en las dos bases del
--    práctico (cdelu y optimizacion). Un solo EXPLAIN ANALYZE no alcanza para
--    comparar tiempos: la primera corrida puede leer de disco y las siguientes
--    de caché, y en tablas chicas la diferencia entre dos planes es menor que el
--    ruido de una corrida a otra. fn_medir ejecuta la consulta varias veces y
--    devuelve el resumen del plan y la mediana del tiempo de ejecución.

-- 0.a) Resumen de una línea del árbol del plan, a partir del EXPLAIN en JSON:
--      cada nodo con sus hijos entre corchetes, el índice usado entre paréntesis
--      y las subconsultas marcadas como InitPlan (se evalúan una vez) o SubPlan
--      (se evalúan por cada fila del nodo padre).

CREATE OR REPLACE FUNCTION fn_resumen_plan(p_nodo jsonb)
RETURNS text
LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE
    v_texto TEXT;
    v_hijos TEXT[] := '{}';
    v_hijo  JSONB;
BEGIN
    v_texto := p_nodo->>'Node Type';

    IF v_texto = 'Aggregate' THEN
        v_texto := CASE p_nodo->>'Strategy'
                       WHEN 'Hashed' THEN 'HashAggregate'
                       WHEN 'Sorted' THEN 'GroupAggregate'
                       WHEN 'Mixed'  THEN 'MixedAggregate'
                       ELSE 'Aggregate'
                   END;
    END IF;

    IF COALESCE(p_nodo->>'Join Type', 'Inner') <> 'Inner' THEN
        IF v_texto = 'Nested Loop' THEN
            v_texto := 'Nested Loop ' || (p_nodo->>'Join Type') || ' Join';
        ELSE
            v_texto := replace(v_texto, ' Join', ' ' || (p_nodo->>'Join Type') || ' Join');
        END IF;
    END IF;

    IF p_nodo->>'Partial Mode' = 'Partial' THEN
        v_texto := 'Partial ' || v_texto;
    ELSIF p_nodo->>'Partial Mode' = 'Finalize' THEN
        v_texto := 'Finalize ' || v_texto;
    END IF;

    IF p_nodo->>'Scan Direction' = 'Backward' THEN
        v_texto := v_texto || ' Backward';
    END IF;

    IF (p_nodo->>'Parallel Aware')::boolean THEN
        v_texto := 'Parallel ' || v_texto;
    END IF;

    IF p_nodo ? 'Index Name' THEN
        v_texto := v_texto || ' (' || (p_nodo->>'Index Name') || ')';
    END IF;

    FOR v_hijo IN SELECT jsonb_array_elements(p_nodo->'Plans') LOOP
        IF v_hijo->>'Parent Relationship' IN ('InitPlan', 'SubPlan') THEN
            v_hijos := v_hijos || ((v_hijo->>'Parent Relationship') || ' ' || fn_resumen_plan(v_hijo));
        ELSE
            v_hijos := v_hijos || fn_resumen_plan(v_hijo);
        END IF;
    END LOOP;

    IF cardinality(v_hijos) > 0 THEN
        v_texto := v_texto || ' [' || array_to_string(v_hijos, ', ') || ']';
    END IF;

    RETURN v_texto;
END;
$$;

-- 0.b) Ejecuta la consulta una vez para calentar la caché (esa corrida se descarta)
--      y después p_repeticiones veces con EXPLAIN (ANALYZE, TIMING OFF). Devuelve el
--      plan elegido y el mínimo, la mediana y el máximo del tiempo de ejecución en
--      milisegundos. TIMING OFF evita medir cada nodo, que es lo que más distorsiona
--      el tiempo total en consultas que procesan muchas filas.

CREATE OR REPLACE FUNCTION fn_medir(p_consulta TEXT, p_repeticiones INTEGER DEFAULT 20)
RETURNS TABLE (plan TEXT, min_ms NUMERIC, mediana_ms NUMERIC, max_ms NUMERIC)
LANGUAGE plpgsql AS $$
DECLARE
    v_explain JSONB;
    v_tiempos NUMERIC[] := '{}';
BEGIN
    EXECUTE 'EXPLAIN (ANALYZE, TIMING OFF, FORMAT JSON) ' || p_consulta;

    FOR i IN 1..p_repeticiones LOOP
        EXECUTE 'EXPLAIN (ANALYZE, TIMING OFF, FORMAT JSON) ' || p_consulta
           INTO v_explain;
        v_tiempos := v_tiempos || (v_explain->0->>'Execution Time')::NUMERIC;
    END LOOP;

    plan := fn_resumen_plan(v_explain->0->'Plan');

    SELECT ROUND(MIN(t), 3),
           ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY t))::NUMERIC, 3),
           ROUND(MAX(t), 3)
      INTO min_ms, mediana_ms, max_ms
    FROM unnest(v_tiempos) AS t;

    RETURN NEXT;
END;
$$;

-- 0.c) Registro de las mediciones, para poder mostrar al final de cada script
--      la comparación entre las variantes de una misma consulta.

CREATE TABLE IF NOT EXISTS medicion (
    id          SERIAL PRIMARY KEY,
    item        TEXT    NOT NULL,
    variante    TEXT    NOT NULL,
    plan        TEXT,
    min_ms      NUMERIC,
    mediana_ms  NUMERIC,
    max_ms      NUMERIC
);

CREATE OR REPLACE PROCEDURE pr_medir(p_item TEXT, p_variante TEXT,
                                     p_consulta TEXT, p_repeticiones INTEGER DEFAULT 20)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO medicion (item, variante, plan, min_ms, mediana_ms, max_ms)
    SELECT p_item, p_variante, m.plan, m.min_ms, m.mediana_ms, m.max_ms
    FROM fn_medir(p_consulta, p_repeticiones) m;
END;
$$;
