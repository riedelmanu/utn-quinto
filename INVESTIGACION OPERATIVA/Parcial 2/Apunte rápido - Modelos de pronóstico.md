---
tipo: resumen
materia: Investigación Operativa
tags: [investigacion-operativa, pronosticos, apunte-rapido]
---
# Apunte rápido — Modelos de pronóstico

Volver a [[Parcial 2]] · Más detalle en el [[Resumen Segundo Parcial - PNL y Pronósticos#Parte II — Modelos de Pronósticos|resumen]]

## ¿Qué modelo es? Mirá el gráfico y hacete dos preguntas

| | **No** hay un patrón que se repita | **Sí** se repite un patrón cada $c$ períodos |
|---|---|---|
| **No** sube ni baja | [[#1. Modelo de nivel\|Nivel]] | [[#3. Modelo estacional\|Estacional]] |
| **Sí** sube o baja de forma sostenida | [[#2. Modelo de tendencia\|Tendencia]] | [[#4. Modelo estacional con tendencia\|Estacional con tendencia]] |

1. **¿Sube o baja?** Si los puntos se van corriendo hacia arriba o hacia abajo, hay **tendencia**.
2. **¿Se repiten picos y valles en las mismas estaciones** (mismo trimestre o mismo mes cada año)? Hay **estacionalidad**, con un ciclo de $c$ períodos.
3. Además: **¿hay algún dato que salta muchísimo?** Puede ser un error de carga (dato atípico). Hay que tratarlo antes de modelar.

En los cuatro modelos hay **error aleatorio**: variaciones sin causa, con promedio 0.

---

## 1. Modelo de nivel
![[pron-nivel.png]]

| | |
|---|---|
| **Cómo se ve** | Puntos que suben y bajan **al azar** alrededor de un valor constante. No hay inclinación ni patrón |
| **Componentes** | Nivel + error |
| **Ecuación** | $D_t = A + \varepsilon_t$ |
| **Pronóstico** | $F = A$, **plano**: el mismo valor para todos los períodos futuros |
| **Métodos** | Promedio histórico · medias móviles ($k$) · suavizado exponencial simple (α) |
| **Para elegir los parámetros** | El $k$ o el α de menor RMSE. Lo típico es α entre 0,1 y 0,3 |
| **Cómo confirmarlo** | Con una regresión contra $t$, la pendiente **no es significativa** (p-valor > 0,05) |
| **Ejemplo de la guía** | Ej. 1, Jolly Donuts (≈ 396 docenas por semana) |

## 2. Modelo de tendencia
![[pron-tendencia.png]]

| | |
|---|---|
| **Cómo se ve** | Los puntos **suben (o bajan) de forma sostenida**, alrededor de una recta inclinada |
| **Componentes** | Nivel + tendencia + error |
| **Ecuación** | $D_t = A + Bt + \varepsilon_t$ ($B$ = cuánto sube por período) |
| **Pronóstico** | **Sigue la recta**: $F_{t+k} = L_t + k\,B_t$ |
| **Métodos** | Regresión lineal con $x = t$ · **Holt** (α para el nivel, β para la tendencia) |
| **Cómo se inicializa Holt** | Regresión con los primeros datos: pendiente = $B$, valor ajustado = $L$ |
| **Ojo** | Con suavizado simple o medias móviles, el pronóstico **se atrasa** (ver [[#Cómo se comportan los métodos]]). La regresión pesa igual a todos los datos y tarda en reaccionar |
| **Ejemplo de la guía** | Ej. 2, Cable Com (suscriptores que crecen ≈ 22 por mes) |

## 3. Modelo estacional
![[pron-estacional.png]]

| | |
|---|---|
| **Cómo se ve** | Un **patrón que se repite** cada $c$ períodos (picos y valles en las mismas estaciones) alrededor de un nivel constante |
| **Componentes** | Nivel + estacionalidad + error |
| **Ecuación** | $D_t = A \cdot S_k + \varepsilon_t$ |
| **Factor estacional $S_k$** | Multiplicativo: $S = 1{,}35$ significa que esa estación vende 35 % más que el promedio; $S = 0{,}75$, 25 % menos. Los $c$ factores suman $c$ |
| **Largo del ciclo $c$** | 4 si los datos son trimestrales · 12 si son mensuales · 7 si son diarios con patrón semanal |
| **Pronóstico** | **Repite el patrón**: nivel × factor de esa estación |
| **Métodos** | Winters (con $B = 0$) o índices estacionales |
| **Datos que hacen falta** | Por lo menos **dos ciclos completos** |

## 4. Modelo estacional con tendencia
![[pron-estacional-tendencia.png]]

| | |
|---|---|
| **Cómo se ve** | **Sube** y además **repite picos** cada $c$ períodos. Como es multiplicativo, los picos **se agrandan** a medida que crece el nivel |
| **Componentes** | Las cuatro: nivel + tendencia + estacionalidad + error |
| **Ecuación** | $D_t = (A + Bt)\cdot S_k + \varepsilon_t$ |
| **Pronóstico** | $F_{t+k} = (L_t + k\,B_t)\cdot s_{t+k-c}$: la recta por el factor de la estación |
| **Método** | **Winters** (α nivel, β tendencia, γ estacionalidad). En clase: α, β ≤ 0,5 |
| **Orden de actualización** | Primero $L$ → después $B$ → por último $s$ |
| **Inicialización** | Dos ciclos completos: $B_0$ = (promedio año −1 − promedio año −2)/$c$ · $L_0$ = promedio año −1 + $(c/2)B_0$ · $s$ = dato / promedio del año −1 |
| **Ejemplo de la guía** | Ej. 3, South Florida Power (trimestral, pico en jul–sep). Ojo con el dato atípico de 2023 |

---

## Comparación en una tabla

| Modelo | Sube/baja | Se repite | Forma del pronóstico | Método | Parámetros |
|---|---|---|---|---|---|
| Nivel | No | No | Línea horizontal | Medias móviles / suavizado simple | $k$ o α |
| Tendencia | Sí | No | Recta inclinada | Regresión / Holt | α, β |
| Estacional | No | Sí | Patrón repetido, sin subir | Winters con $B = 0$ | α, γ |
| Estacional con tendencia | Sí | Sí | Patrón repetido que sube y se agranda | Winters | α, β, γ |

---

## Cómo se comportan los métodos

### Rápido vs suave
![[pron-metodos-reaccion.png]]

- **$k$ chico o α grande:** reacciona **rápido** a un cambio, pero sigue el ruido.
- **$k$ grande o α chico:** el pronóstico es **suave**, pero tarda en adaptarse.
- Medias móviles: todos los datos de la ventana pesan igual. Suavizado: los pesos **decaen exponencialmente** hacia el pasado.

### Suavizado simple en una serie con tendencia
![[pron-atraso-tendencia.png]]

- El suavizado simple **queda siempre abajo** de una serie que crece. Los errores son positivos, así que el **sesgo es > 0: subestima**.
- **Holt** estima además la pendiente y **acompaña** la tendencia.
- Si ves un sesgo grande y del mismo signo, probablemente elegiste un modelo sin tendencia para una serie que la tiene.

---

## Práctica: ¿qué modelo es cada serie?
![[pron-practica-guia.png]]

> [!check]- Ver respuesta
> - **Serie A → nivel.** Es el ej. 1 (Jolly Donuts): oscila alrededor de ≈ 396, sin subir ni repetir un patrón.
> - **Serie B → tendencia.** Es el ej. 2 (Cable Com): sube de forma sostenida, sin estacionalidad.
> - **Serie C → estacional con tendencia** ($c = 4$). Es el ej. 3 (South Florida Power): el tercer trimestre es siempre el pico y todo crece año a año. El salto a 19.638 en $t = 13$ (2023 abr–jun) rompe el patrón: es un **dato atípico**, casi seguro un error de carga.
