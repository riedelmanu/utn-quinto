---
materia: GESTION AVANZADA DE DATOS
entrega: 
estado: resuelto
tipo: tp
tags: [tp, postgresql, optimizacion]
---
# TP3 - Optimización de consultas

Volver a [[GESTION AVANZADA DE DATOS]]

## Consigna
Resolver consultas con `EXPLAIN ANALYZE`, describir los planes y mejorarlas con índices (B-Tree, hash) y reescritura:
- **a.** Base de comercios de Concepción del Uruguay (dump `CdelU - Comercios.sql`): 12 ítems.
- **b.** Tablas `articulos` (500k) y `precios` (8M) generadas con `random_string`: 9 consultas.
- **c.** Tabla propia de personas (1M filas): índices B-Tree y hash sobre ciudad y edad, agregados.
- **d.** Clientes (500k) y pedidos (5M): top 10 de facturación 2024 y comparación de índices.

Grupo: Juan Brun, Leandro Guiffrey, Manuel Ángel Riedel.

## Archivos
- `TP3-Optimizacion-de-consultas-resuelto.pdf`: resolución completa (explicación, scripts y salidas).
- Scripts `00-funciones-medicion.sql`, `a00` a `a07` (base `cdelu`), `b00` a `b06`, `c00` a `c03`, `d00` a `d02` (base `optimizacion`). Hay que correrlos en orden dentro de cada parte.
- Enunciado 2025 y borrador del grupo (`Trabajo practico 3 - Optimización de Consultas.pdf`, ítems a.1 a a.7).
- Teoría: `2026 - Optimizacion-de-Consultas-en-PostgreSQL.pdf` y `2026 - Metodos de Acceso B-Tree, Hash, Bitmap(1).ppt`.

## Ideas clave
- Comparar medianas de varias ejecuciones (`fn_medir`), no una sola corrida: la primera lectura de un índice desde disco hacía parecer más lento al B-Tree en el borrador (a.4).
- `comercios.barrio` se relaciona con `barrios.type`, no con `gid`: Centro es el código 0.
- Hash: sólo igualdad; no sirve para `GROUP BY` (a.5) ni rangos (c.4). B-Tree: igualdad, rango, orden, Index Only Scan y deduplicación (6,9 MB contra 47 MB del hash en c.3).
- Con filas dispersas, un índice sobre el 3 % de la tabla igual lee casi todas las páginas (b.1, c.2); `CLUSTER` lo arregla.
- Índices cubrientes con `INCLUDE`: b.2 (66 ms a 0,003 ms) y d.5.
- Reescribir: subconsulta correlacionada a CTE (a.12.1, 142 ms a 0,36 ms), `EXISTS` en vez de `DISTINCT` (b.4), `ORDER BY ... LIMIT 1` en vez de `MAX` (b.7).
- Vista materializada para promedios sobre toda la tabla (b.5, b.6, b.8, b.9).
- En d, ninguno de los tres índices pedidos mejora la consulta; `(cliente_id, fecha) INCLUDE (total)` y calcular el ranking antes del join la bajan de 359 a 165 ms.
- `random_page_cost = 4` (pensado para disco) hace que el planificador elija planes peores con datos en memoria (a.9, c.6).

## Avance
- [x] Parte a (incluye correcciones al borrador del grupo)
- [x] Parte b
- [x] Parte c
- [x] Parte d
- [ ] Revisar el PDF con Juan y Leandro
- [ ] Entregar
