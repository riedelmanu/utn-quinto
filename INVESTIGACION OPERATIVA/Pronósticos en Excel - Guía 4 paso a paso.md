---
tipo: tp
materia: Investigación Operativa
tags: [investigacion-operativa, pronosticos, excel, guia-4]
---
# Pronósticos en Excel — Guía 4 paso a paso

Volver a [[INVESTIGACION OPERATIVA]] · Teoría en [[Resumen Segundo Parcial - PNL y Pronósticos#Parte II — Modelos de Pronósticos|el resumen]] · Consigna: [[Guía_4-Modelos_de_pronósticos.pdf|Guía 4]] · Modelo de clase: [[Analítica Predictiva.xlsx]]

> [!info] Antes de empezar
> - **Separador de argumentos:** las fórmulas están escritas para Excel en español, con `;` y coma decimal (`0,1`). Si tu Excel usa `,` como separador, cambiá `;` por `,` y la coma decimal por punto.
> - **Parámetros en una celda fija** (α, β, γ, k), referenciados con `$`, como en el Excel de clase. Así cambiás un número y se recalcula todo.
> - **Complementos:** activá **Solver** y **Herramientas para análisis** (*Analysis ToolPak*).
>   - Mac: *Herramientas → Complementos de Excel*.
>   - Windows: *Archivo → Opciones → Complementos → Ir*.
> - **Valores de control ✅:** cada ejercicio trae valores para comparar. Si te dan iguales, las fórmulas están bien. Los verifiqué recalculando las mismas fórmulas en Python.

## 🖱️ Por botones: pestaña Datos

Es la forma en que se hacía en clase. Se usan cuatro herramientas, todas en **Datos**:

| Botón | Para qué sirve | Dónde está |
|---|---|---|
| **Análisis de datos** | Media móvil, Suavización exponencial y Regresión | Datos → grupo *Análisis* (a la derecha) |
| **Hoja de previsión** | Pronóstico automático con tendencia y estacionalidad (ETS) y su intervalo | Datos → grupo *Previsión* |
| **Solver** | Encontrar el mejor α, β, γ o k (mínimo RMSE) | Datos → grupo *Análisis* |
| **Análisis de hipótesis → Tabla de datos** | Comparar varios α o k de una vez | Datos → grupo *Previsión* |

> [!warning] Lo que NO tiene botón
> - Las columnas de **error** y el **RMSE** siempre se calculan con fórmulas: ver [[#Estructura que se repite en todos]].
> - **Holt** y **Winters**, tal como se ven en clase (con α, β, γ dados y la inicialización de las diapositivas), tampoco tienen botón. Los botones sirven para la regresión inicial, para la versión automática de Excel (*Hoja de previsión*) y para Solver. Las actualizaciones se hacen con las fórmulas de los ejercicios 2 y 3.

### 1. Activar los complementos (una sola vez)
- **Windows:** *Archivo → Opciones → Complementos*. Abajo, en *Administrar: Complementos de Excel*, hacé clic en **Ir…**, tildá **Herramientas para análisis** y **Solver** → *Aceptar*.
- **Mac:** menú *Herramientas → Complementos de Excel…* → tildá **Analysis ToolPak** y **Solver Add-in** → *Aceptar*.
- Ahora en **Datos** aparecen los botones **Análisis de datos** y **Solver**.

### 2. Media móvil
1. **Datos → Análisis de datos → Media móvil → Aceptar.**
2. **Rango de entrada:** solo los datos de demanda, sin el encabezado (por ejemplo `B3:B18`). Dejá destildado *Rótulos en la primera fila*.
3. **Intervalo:** el **k** (por ejemplo 4).
4. **Rango de salida:** la celda de la columna de al lado, **una fila más abajo que el primer dato** (si el primer dato está en B3, poné `C4`).
5. Opcional: *Crear gráfico*. Dejá destildado *Error típico*: no es el RMSE.
6. **Aceptar.** Las primeras celdas dan `#N/A` porque no hay datos suficientes. Es normal.

> [!important] ¿Por qué una fila más abajo?
> Excel pone cada promedio en la fila del **último dato que usa**, o sea que incluye la demanda de ese mismo período. Para que sea un **pronóstico** (el promedio de los k anteriores), hay que correrlo una fila. Así, la última celda de la salida es justo el pronóstico del período siguiente.

### 3. Suavización exponencial
1. **Datos → Análisis de datos → Suavización exponencial → Aceptar.**
2. **Rango de entrada:** los datos de demanda, sin encabezado (`B3:B18`).
3. **Factor de amortiguación = 1 − α.** Para α = 0,2 escribís **0,8**; para α = 0,1, **0,9**.
4. **Rango de salida:** la columna de al lado, **en la misma fila** que el primer dato (`C3`).
5. **Aceptar.** Queda:
   - `C3` = `#N/A`;
   - `C4` = `B3`, que es la convención $F_1 = D_0$ de clase;
   - desde ahí, cada celda vale $\alpha D + (1-\alpha)F$ del período anterior.
6. Para el pronóstico del período siguiente, **copiá la última celda una fila más abajo**.

Para probar otro α hay que volver a correr la herramienta, porque el valor queda escrito dentro de las fórmulas. Por eso, para Solver o para la Tabla de datos conviene la versión con fórmulas, con α en una celda.

### 4. Regresión
1. **Datos → Análisis de datos → Regresión → Aceptar.**
2. **Rango Y de entrada:** la demanda. **Rango X de entrada:** la columna t.
3. Si incluiste los encabezados en los rangos, tildá **Rótulos**.
4. **Opciones de salida:** *En una hoja nueva* (más prolijo) o un *Rango de salida*.
5. Opcional: tildá *Residuos* y *Gráfico de residuales*. Sirven para revisar los supuestos (homocedasticidad, cambios de signo).
6. **Aceptar.** Qué leer en la salida:

| En la salida dice… | Es… |
|---|---|
| *Coeficiente de determinación R^2* | $R^2$ |
| *Error típico* (arriba) | $s_e = \sqrt{SSE/(n-2)}$. No es el RMSE: el RMSE divide por $n$ |
| Tabla de abajo, fila *Intercepción*, columna *Coeficientes* | $\beta_0$ (o $A$) |
| Fila *Variable X 1*, columna *Coeficientes* | $\beta_1$ (la pendiente $B$) |
| Fila *Variable X 1*, columna *Probabilidad* | **p-valor**: si es > 0,05, la pendiente no es significativa |

### 5. Hoja de previsión (modelo automático de Excel)
1. Seleccioná **dos columnas**, la de t (o las fechas) y la de demanda, con sus encabezados.
2. **Datos → Hoja de previsión.**
3. En **Fin de la previsión** poné hasta qué período querés pronosticar (por ejemplo 15).
4. Abrí **Opciones**:
   - **Intervalo de confianza:** 90 % o 95 %, según lo que pida el ejercicio.
   - **Estacionalidad:** *Detectar automáticamente*, o *Establecer manualmente* con el largo del ciclo (**4** si es trimestral, 12 si es mensual).
   - Tildá **Incluir estadísticas de previsión**.
5. **Crear.** Se abre una hoja nueva con los pronósticos, los límites inferior y superior del intervalo y un gráfico.
6. La tabla de estadísticas muestra **Alfa, Beta, Gamma, MAE y RMSE**: son los parámetros que eligió Excel y su error.

Es un Holt–Winters **aditivo** con inicialización propia, así que los números no van a coincidir con los del método de clase. Sirve para **comparar**. Si tu versión no tiene este botón (algunas de Mac), usá las funciones `PRONOSTICO.ETS` del ejercicio 2.

### 6. Solver
1. **Datos → Solver.**
2. **Establecer objetivo:** la celda del **RMSE**. **Para:** **Mín**.
3. **Cambiando las celdas de variables:** las celdas de los parámetros (por ejemplo `$H$1`, o `$C$1;$E$1;$G$1` en Winters).
4. **Sujeto a las restricciones → Agregar:** cada parámetro **≥ 0** y **≤ 1** (en Winters, α y β **≤ 0,5**).
5. **Método de resolución:** **GRG Nonlinear** → **Resolver** → *Conservar solución de Solver*.

### 7. Tabla de datos (comparar varios α o k)
1. En una columna escribí los valores a probar (por ejemplo 0,1 a 0,5), y **arriba a la derecha** del primero poné `=` y la celda del RMSE.
2. Seleccioná ese bloque (los valores y la columna de al lado).
3. **Datos → Análisis de hipótesis → Tabla de datos.**
4. **Celda de entrada (columna):** la celda del parámetro (`$H$1`) → **Aceptar**. Aparece el RMSE de cada valor.

### Qué botón usar en cada ejercicio

**Ejercicio 1 — Jolly Donuts**
1. **b)** Seleccioná A2:B18 → *Insertar → Gráfico de líneas*.
2. **c)** *Media móvil* con Intervalo 2, 3, 4, 5 y 6, cada una en una columna nueva y siempre **una fila más abajo**.
3. **c)** *Suavización exponencial* con factor de amortiguación 0,9 · 0,8 · 0,7 · 0,6 · 0,5 (α = 0,1 a 0,5).
4. **c)** Al lado de cada columna, error, error² y RMSE con fórmulas. ✅ k = 4 da RMSE 12,42; α = 0,2 da 13,59.
5. **d)** *Regresión* con Y = ventas y X = semana. ✅ Coeficientes 395,55 y 0,10; Probabilidad de *Variable X 1* = **0,88**. La pendiente no es significativa: conviene el **modelo de nivel**.

**Ejercicio 2 — Cable Com**
1. **b)** Gráfico de líneas: se ve el crecimiento.
2. **c)** *Regresión* solo con los **4 primeros meses** (Y = C4:C7, X = B4:B7). ✅ *Intercepción* = **1700** y *Variable X 1* = **22**. Esos son el nivel y la tendencia iniciales.
3. **c)** Holt **no tiene botón**: armá las columnas con las fórmulas de [[#c) Modelo de tendencia con regresión inicial (4 meses)]]. Podés usar 1700 y 22 en lugar de `INTERSECCION.EJE` y `PENDIENTE`.
4. **d)** *Hoja de previsión* con t y demanda, fin de la previsión 15, intervalo del 90 %, estacionalidad automática y estadísticas tildadas. Compará su **RMSE** con el 14,63 de tu Holt.
   - Esta serie no tiene estacionalidad, así que Excel debería quedarse solo con la tendencia.
   - Si en las estadísticas aparece un Gamma distinto de 0, usá `PRONOSTICO.ETS(...;0)`, que fuerza "sin estacionalidad".
5. **e/f)** Pronósticos e intervalo del 90 % con fórmulas: `D16:D19` y `DISTR.NORM.ESTAND.INV(0,95)`. La Hoja de previsión da su propio intervalo, que sirve para comparar.

**Ejercicio 3 — South Florida Power**
1. **b)** Gráfico de líneas: se ven la tendencia, el pico en jul–sep y el **dato atípico de 2023 abr–jun**.
2. **c/d)** El Winters de clase **no tiene botón**: usá las fórmulas de [[#Ejercicio 3 — South Florida Power (Winters, c = 4)]].
3. **Solver** para elegir α, β y γ, con α, β ≤ 0,5.
4. Para comparar: *Hoja de previsión* con **Estacionalidad manual = 4** e intervalo del 90 %.

---

> [!note] Con fórmulas
> Lo que sigue es la versión con fórmulas, igual a la del Excel de clase. Hace falta para Holt, Winters, el cálculo de los errores y para usar Solver.

## Estructura que se repite en todos

Una fila por período y estas columnas:

| Columna | Contenido | Fórmula (fila $n$) |
|---|---|---|
| t | número de período (0, 1, 2…) | se tipea |
| D | demanda real | se tipea |
| F | pronóstico | depende del método |
| Error | $D - F$ | `=D_n-F_n` |
| Error² | | `=Error_n^2` |
| \|Error\| | | `=ABS(Error_n)` |
| Error % | | `=100*ABS_n/D_n` |

Abajo o al costado van las medidas:

| Medida | Fórmula |
|---|---|
| RMSE | `=RAIZ(PROMEDIO(rango Error²))` |
| MAE | `=PROMEDIO(rango Error absoluto)` |
| MAPE | `=PROMEDIO(rango Error %)` |
| Sesgo | `=PROMEDIO(rango Error)` |

> [!tip] Atajo
> `=RAIZ(SUMAXMENOSY2(rango_D;rango_F)/CONTAR(rango_D))` calcula el RMSE sin columnas auxiliares.

**Gráfico (inciso b de todos los ejercicios):** seleccioná t y D → *Insertar → Gráfico de líneas*. Después agregá la columna F como segunda serie: *clic derecho → Seleccionar datos → Agregar*.

---

## Ejercicio 1 — Jolly Donuts (modelo de nivel)

Cargá **A3:A18** = semanas 0…15 y **B3:B18** = ventas.

### a/b) ¿Qué modelo?
El gráfico oscila alrededor de ≈ 396, sin crecer ni bajar. Es un **modelo de nivel**.

### c) Medias móviles
Hoja nueva, con el **k en H1** (por ejemplo 4).

| Celda | Fórmula | Copiar hasta |
|---|---|---|
| C7 (primer pronóstico, t = 4) | `=PROMEDIO(B3:B6)` | C19 (C19 es el pronóstico de la semana 16) |
| D7 | `=B7-C7` | D18 |
| E7 | `=D7^2` | E18 |
| F7 | `=ABS(D7)` | F18 |
| G7 | `=100*F7/B7` | G18 |
| RMSE | `=RAIZ(PROMEDIO(E7:E18))` | — |

Con la fórmula fija, para probar otro **k** hay que rehacer la columna.

> [!tip] Para cambiar k desde una sola celda
> En C3 poné `=SI(A3>=$H$1;PROMEDIO(DESREF(B3;-$H$1;0;$H$1;1));"")` y copiala hasta C19. En los errores usá `=SI(C3="";"";B3-C3)`: `PROMEDIO` ignora las celdas vacías, así que el RMSE se ajusta solo cuando cambiás H1.

✅ **Control:**

| k | 2 | 3 | **4** | 5 | 6 |
|---|---|---|---|---|---|
| RMSE | 16,41 | 13,29 | **12,42** | 12,84 | 13,89 |
| Pronóstico semana 16 | 399,00 | 399,00 | 393,75 | 393,60 | 396,33 |

### c) Suavizado exponencial
Hoja nueva, con **α en H1** (por ejemplo 0,2).

| Celda | Fórmula | Copiar hasta |
|---|---|---|
| C4 ($F_1$) | `=B3` (convención de clase: $F_1 = D_0$) | — |
| C5 | `=C4+$H$1*(B4-C4)` | C19 |
| D4…G4 | errores, igual que antes | fila 18 |
| RMSE | `=RAIZ(PROMEDIO(E4:E18))` | — |

**Comparar varios α de una vez con una tabla de datos:**
1. En J3:J7 escribí 0,1 · 0,2 · 0,3 · 0,4 · 0,5.
2. En K2 poné `=` y la celda del RMSE.
3. Seleccioná J2:K7 → *Datos → Análisis de hipótesis → Tabla de datos* → **Celda de entrada (columna): `$H$1`**.

**α óptimo con Solver:** *Datos → Solver*.
- Objetivo: la celda del RMSE, en **Mín**.
- Celda que cambia: **$H$1**.
- Restricciones: $H$1 ≥ 0 y $H$1 ≤ 1.
- Método: **GRG no lineal**.

✅ **Control:**

| α | 0,1 | **0,2** | 0,3 | 0,4 | 0,5 |
|---|---|---|---|---|---|
| RMSE | 13,81 | **13,59** | 13,77 | 14,10 | 14,52 |

Solver da α ≈ 0,18 y RMSE ≈ 13,58.

> [!warning] Comparación justa
> Las medias móviles con k = 4 se evalúan desde la semana 4 y el suavizado desde la semana 1. Para comparar bien, calculá el RMSE de todos los métodos **sobre las mismas filas** (por ejemplo, de la semana 6 en adelante).

### d) Nivel vs tendencia

| Celda | Fórmula |
|---|---|
| Nivel, C3 (copiar a C18) | `=PROMEDIO($B$3:$B$18)` |
| Tendencia, D3 (copiar a D18) | `=INTERSECCION.EJE($B$3:$B$18;$A$3:$A$18)+PENDIENTE($B$3:$B$18;$A$3:$A$18)*A3` |
| RMSE de cada uno | `=RAIZ(SUMAXMENOSY2($B$3:$B$18;C3:C18)/16)` (y lo mismo con D) |

Para decidir, mirá si la pendiente es **significativa**: *Datos → Análisis de datos → Regresión*, con Y = B3:B18 y X = A3:A18. Fijate el **p-valor** de la variable t.

✅ **Control:**
- Pendiente = 0,10 docenas por semana, con p-valor ≈ 0,88 y $R^2 \approx 0{,}002$: **no hay tendencia**.
- RMSE nivel = 11,59 y RMSE tendencia = 11,58: prácticamente iguales.
- Conclusión: **modelo de nivel**, que es el más simple.

---

## Ejercicio 2 — Cable Com (Holt)

Parámetros: **C1 = α = 0,1** y **E1 = β = 0,1**. Encabezados en la fila 3. Los datos van de **A4:C15**: A = mes, B = t (0…11), C = demanda.

Columnas: D = pronóstico F · E = nivel L · F = tendencia B · G = error · H = error² · I = |error| · J = error %.

### c) Modelo de tendencia con regresión inicial (4 meses)

| Celda | Fórmula | Qué es |
|---|---|---|
| F7 | `=PENDIENTE(C4:C7;B4:B7)` | $B_3$: pendiente de la regresión de ENE–ABR |
| D7 | `=INTERSECCION.EJE(C4:C7;B4:B7)+F7*B7` | valor ajustado en ABR |
| E7 | `=D7+$C$1*(C7-D7)` | $L_3$ |
| D8 | `=E7+F7` | $F_t = L_{t-1} + B_{t-1}$ |
| E8 | `=D8+$C$1*(C8-D8)` | $L_t = F_t + \alpha(D_t - F_t)$ |
| F8 | `=F7+$E$1*((E8-E7)-F7)` | $B_t = B_{t-1} + \beta[(L_t - L_{t-1}) - B_{t-1}]$ |
| G8…J8 | errores, igual que antes | |

Copiá **D8:J8** hasta la **fila 15**. RMSE: `=RAIZ(PROMEDIO(H8:H15))`.

✅ **Control:**
- Regresión inicial: $1700 + 22t$, o sea F7 = 22, D7 = 1766 y E7 = 1765,8.
- Mayo: F = 1787,80; L = 1789,52; B = 22,172.
- **RMSE = 14,63**, MAE = 11,57, MAPE = 0,62 %, sesgo = +7,60.

### e) Pronóstico de los 4 meses siguientes
En A16:A19 van ENE…ABR y en B16:B19 van 12…15.

| Celda | Fórmula | Copiar hasta |
|---|---|---|
| D16 | `=$E$15+(B16-$B$15)*$F$15` | D19 |

Es $F_{t+k} = L_t + k\,B_t$, con $k$ = cuántos meses después de diciembre.

✅ **Control:** 1973,62 · 1996,23 · 2018,83 · 2041,44.

### f) Intervalo de confianza del 90 % para el 4° mes

| | Fórmula |
|---|---|
| z | `=DISTR.NORM.ESTAND.INV(0,95)` (en Excel nuevo también `=INV.NORM.ESTAND(0,95)`), da 1,645 |
| Límite inferior | `=D19-z*RMSE` |
| Límite superior | `=D19+z*RMSE` |

Para el 95 % se usa `0,975` y da 1,96. ✅ **Control:** **[2017,4; 2065,5]**.

### d) Modelo de tendencia "automático" de Excel
Excel tiene su propio suavizado exponencial (ETS), que elige α y β solo.

| Qué | Fórmula |
|---|---|
| Pronóstico (en K16, copiar a K19) | `=PRONOSTICO.ETS(B16;$C$4:$C$15;$B$4:$B$15;0)` |
| RMSE de Excel | `=PRONOSTICO.ETS.STAT($C$4:$C$15;$B$4:$B$15;7;0)` |
| α y β que eligió | lo mismo, con 1 o 2 en lugar de 7 |

- El último argumento, `0`, significa **sin estacionalidad**: solo nivel y tendencia.
- Otra opción: *Datos → Hoja de previsión*, con *Opciones → Incluir estadísticas de previsión* (si tu versión la tiene).
- Compará ese RMSE con el 14,63 de tu Holt. No va a coincidir exactamente, porque Excel inicializa distinto y optimiza los parámetros.
- *(otra opción)* Usar **Solver** sobre tu propia hoja: minimizar el RMSE cambiando **$C$1** y **$E$1**, con valores entre 0 y 1.

---

## Ejercicio 3 — South Florida Power (Winters, c = 4)

Parámetros: **C1 = α**, **E1 = β**, **G1 = γ**. Encabezados en la fila 3. Columnas: A = año · B = trimestre · C = t · D = demanda · E = pronóstico · F = nivel L · G = tendencia B · H = estacionalidad s · I…L = errores.

| Filas | Contenido |
|---|---|
| 4–7 | 2020 (año −2, solo para inicializar) |
| 8–11 | 2021 (año −1, solo para inicializar) |
| 12–15 | 2022, con t = 1…4 |
| 16–19 | 2023, con t = 5…8 |
| 20–23 | 2024, con t = 9…12: los pronósticos |

### a/b) Mirá el gráfico primero
Hay **tendencia creciente** y un **pico cada julio–septiembre**, así que corresponde **Winters**.

⚠️ El dato **2023 abr–jun = 19.638** salta muchísimo; lo esperable es ≈ 10.600. Casi seguro es un error de tipeo (¿10.638?). Mencionalo y probá el modelo con los dos valores.

### c) Estimaciones iniciales (con 2020 y 2021)

| Celda | Fórmula | Qué es |
|---|---|---|
| H8 (copiar a H11) | `=D8/PROMEDIO($D$8:$D$11)` | factor estacional de cada trimestre |
| G11 | `=(PROMEDIO(D8:D11)-PROMEDIO(D4:D7))/4` | $B_0$ |
| F11 | `=PROMEDIO(D8:D11)+(4/2)*G11` | $L_0$ |

✅ **Control:** $B_0$ = 251,69; $L_0$ = 9444,88; factores 0,672 · 0,982 · 1,410 · 0,936.

### c) Actualización (fila 12, copiar hasta la 19)

| Celda | Fórmula | Qué es |
|---|---|---|
| E12 | `=(F11+G11)*H8` | $F_t = (L_{t-1} + B_{t-1})\,s_{t-c}$ |
| F12 | `=$C$1*D12/H8+(1-$C$1)*(F11+G11)` | $L_t$ |
| G12 | `=$E$1*(F12-F11)+(1-$E$1)*G11` | $B_t$ |
| H12 | `=$G$1*D12/F12+(1-$G$1)*H8` | $s_t$ |
| I12…L12 | errores, igual que antes | |

> [!tip] El truco de la estacionalidad
> `H8` está **4 filas arriba**: es el factor del mismo trimestre del año anterior ($s_{t-c}$). Al copiar la fórmula hacia abajo, eso se mantiene solo.

✅ **Control** con α = 0,2, β = 0,1 y γ = 0,3 (valores para probar, no los de la guía):
- Fila 12: E12 = **6518,6**; F12 = 9763,3; G12 = 258,36; H12 = 0,678.
- Con 19.638: **RMSE ≈ 3446**. Con 10.638: **RMSE ≈ 303**.

### d) Pronóstico de los 4 trimestres de 2024

| Celda | Fórmula | Copiar hasta |
|---|---|---|
| E20 | `=($F$19+(C20-$C$19)*$G$19)*H16` | E23 |

Es $F_{t+k} = (L_t + k\,B_t)\,s_{t+k-c}$: `H16` es el factor del mismo trimestre de 2023.

✅ **Control** (α = 0,2, β = 0,1, γ = 0,3):

| | 2024 T1 | T2 | T3 | T4 |
|---|---|---|---|---|
| Con 19.638 | 8864 | 15.318 | 18.366 | 12.417 |
| Con 10.638 | 7828 | 11.460 | 16.669 | 11.151 |

### e) Intervalo de confianza del 90 % para el 4° trimestre
`=E23 ± DISTR.NORM.ESTAND.INV(0,95)*RMSE`.

✅ **Control** (con los mismos parámetros):
- Corregido: **[10.652; 11.649]**.
- Con 19.638: [6.748; 18.085]. Es enorme por el dato atípico.

### Elegir α, β y γ con Solver
- Objetivo: la celda del RMSE, en **Mín**.
- Celdas que cambian: **$C$1;$E$1;$G$1**.
- Restricciones: todas ≥ 0; **α y β ≤ 0,5** (consejo de clase); γ ≤ 1.
- Método: **GRG no lineal**.

> [!warning] Ojo con lo que devuelve Solver
> Con solo 8 trimestres para evaluar, Solver tiende a irse a los bordes:
> - con 19.638 devuelve α = β = γ = 0 (el modelo ignora los datos), con RMSE ≈ 3162;
> - corregido devuelve α ≈ 0,04, β = 0 y γ = 1, con RMSE ≈ 249.
>
> Es el **sobreajuste** del que se habló en clase. Comentalo en el ejercicio y, si los valores no tienen sentido, usá parámetros razonables (por ejemplo 0,1–0,3).

---

## Errores típicos en la planilla
- Olvidarse el `$` en los parámetros: al copiar hacia abajo, α "se corre" de celda.
- Calcular el RMSE incluyendo filas sin pronóstico (las de inicialización).
- En Holt, empezar los errores en la misma fila de la regresión inicial. Se cuentan **desde el período siguiente**.
- En Winters, usar el factor estacional de la fila de arriba en lugar del de **4 filas arriba**.
- Pronosticar varios períodos con el suavizado simple como si subiera. En el modelo de nivel, el pronóstico es **el mismo** para todos los períodos futuros.
