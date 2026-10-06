-- 7. Tabla contactos y carga de un grafo con varios caminos entre A y D
--    y al menos un ciclo (B-C-B y A-C-E-D-A).

DROP TABLE IF EXISTS contactos;

CREATE TABLE contactos (
    nodo_origen  VARCHAR(10) NOT NULL,
    nodo_destino VARCHAR(10) NOT NULL,
    distancia    INTEGER     NOT NULL,
    CONSTRAINT pk_contactos PRIMARY KEY (nodo_origen, nodo_destino),
    CONSTRAINT ck_contactos_distancia CHECK (distancia > 0),
    CONSTRAINT ck_contactos_sin_bucle CHECK (nodo_origen <> nodo_destino)
);

INSERT INTO contactos (nodo_origen, nodo_destino, distancia) VALUES
    ('A', 'B',  5),
    ('A', 'C',  2),
    ('A', 'F', 10),
    ('B', 'C',  1),
    ('B', 'D',  4),
    ('C', 'B',  1),
    ('C', 'D',  7),
    ('C', 'E',  3),
    ('E', 'D',  1),
    ('F', 'D',  1),
    ('D', 'A',  6);

SELECT * FROM contactos ORDER BY nodo_origen, nodo_destino;

-- 7. Con WITH RECURSIVE, todos los caminos posibles de A hasta D indicando la
--    secuencia de nodos, la cantidad de aristas y la distancia total. El arreglo
--    camino guarda los nodos ya visitados y la condición NOT ... = ANY(camino)
--    impide volver a pasar por uno, evitando los ciclos infinitos.

WITH RECURSIVE rutas AS (
    SELECT c.nodo_origen,
           c.nodo_destino,
           ARRAY[c.nodo_origen, c.nodo_destino]::VARCHAR[] AS camino,
           1                                    AS aristas,
           c.distancia                          AS distancia_total
    FROM contactos c
    WHERE c.nodo_origen = 'A'

    UNION ALL

    SELECT r.nodo_origen,
           c.nodo_destino,
           r.camino || c.nodo_destino,
           r.aristas + 1,
           r.distancia_total + c.distancia
    FROM rutas r
    JOIN contactos c ON c.nodo_origen = r.nodo_destino
    WHERE NOT c.nodo_destino = ANY (r.camino)
)
SELECT array_to_string(camino, ' -> ') AS secuencia_de_nodos,
       aristas,
       distancia_total
FROM rutas
WHERE nodo_destino = 'D'
ORDER BY distancia_total, aristas;

-- 7. Camino de menor distancia entre A y D, admitiendo empates.

WITH RECURSIVE rutas AS (
    SELECT c.nodo_origen,
           c.nodo_destino,
           ARRAY[c.nodo_origen, c.nodo_destino]::VARCHAR[] AS camino,
           1                                    AS aristas,
           c.distancia                          AS distancia_total
    FROM contactos c
    WHERE c.nodo_origen = 'A'

    UNION ALL

    SELECT r.nodo_origen,
           c.nodo_destino,
           r.camino || c.nodo_destino,
           r.aristas + 1,
           r.distancia_total + c.distancia
    FROM rutas r
    JOIN contactos c ON c.nodo_origen = r.nodo_destino
    WHERE NOT c.nodo_destino = ANY (r.camino)
),
caminos_a_d AS (
    SELECT camino, aristas, distancia_total
    FROM rutas
    WHERE nodo_destino = 'D'
)
SELECT array_to_string(camino, ' -> ') AS camino_mas_corto,
       aristas,
       distancia_total
FROM caminos_a_d
WHERE distancia_total = (SELECT MIN(distancia_total) FROM caminos_a_d);
