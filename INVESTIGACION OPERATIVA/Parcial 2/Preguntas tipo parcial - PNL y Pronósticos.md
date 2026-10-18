---
tipo: tp
materia: Investigación Operativa
tags: [investigacion-operativa, pnl, pronosticos, parcial, preguntas]
---
# Preguntas tipo parcial — PNL y Pronósticos

Volver a [[Parcial 2]] · Teoría: [[Resumen Segundo Parcial - PNL y Pronósticos|resumen]] · Modelo real: [[Parcial 2 2025 - Teoría PNL resuelto|parcial 2025 resuelto]]

> [!info] Cómo usarlo
> - Las preguntas siguen el estilo del parcial 2025: **verdadero/falso con justificación**, **preguntas de desarrollo** y algunos **ejercicios cortos**.
> - Cada respuesta está **cerrada debajo de la pregunta**. Respondé primero y después hacé clic en **"Ver respuesta"** para desplegarla.
> - Las respuestas son mías, no de la cátedra. Las cuentas de los ejercicios están verificadas.
> - Al final hay tres [[#Simulacros]] armados con estas preguntas.

---

# Parte A — Programación No Lineal

## A.1 Verdadero o falso (justifique)

**A1.** Si la función objetivo de un PNL de maximización es cóncava, todo máximo local es un máximo global.

> [!check]- Ver respuesta
> **Falso.** Además, la **región factible tiene que ser convexa** (en restricciones ≤, todas las $g_i$ convexas). Recién ahí es un problema de programación convexa y local = global.
> Contraejemplo (Hillier): la Wyndor con la restricción $8x_1 - x_1^2 + 14x_2 - x_2^2 \le 49$ tiene función objetivo lineal (cóncava), pero la región no es convexa y hay dos máximos locales, $(0, 7)$ y $(4, 3)$; solo el primero es global.
> Si el problema es **irrestricto** sí es verdadero, porque $\mathbb{R}^n$ es convexo.

**A2.** Si $\nabla f(x_0) = 0$, entonces $x_0$ es un óptimo local de $f$.

> [!check]- Ver respuesta
> **Falso.** $\nabla f = 0$ es una condición **necesaria**, no suficiente.
> - $x_0$ puede ser un **punto silla**: $f = x_1^2 - x_2^2$ en $(0, 0)$.
> - En una variable, puede ser un **punto de inflexión**: $f = x^3$ en $x = 0$.
>
> Para clasificarlo hace falta la condición de 2° orden (Hessiana) o saber que $f$ es cóncava o convexa.

**A3.** En el método de la sección áurea, la longitud del intervalo de incertidumbre se reduce a la mitad en cada iteración.

> [!check]- Ver respuesta
> **Falso.** Se multiplica por $r = (\sqrt5 - 1)/2 \approx 0{,}618$: $L_k = r^k(b - a)$. La reducción a la mitad corresponde al método de **bisección**, que además usa el signo de la derivada.
> La ventaja de la sección áurea es que reutiliza un punto, así que evalúa $f$ una sola vez por iteración.

**A4.** El método de la sección áurea solo puede aplicarse si la función es cóncava en el intervalo.

> [!check]- Ver respuesta
> **Falso.** Solo necesita que $f$ sea **unimodal** en $[a, b]$: un único máximo, creciente antes y decreciente después. No hace falta que sea cóncava ni derivable.
> Por ejemplo, $f(x) = -\lvert x - 1\rvert$ en $[0, 3]$ es unimodal y no es derivable en $x = 1$. Toda función cóncava es unimodal, pero no al revés.

**A5.** Una función lineal no es cóncava ni convexa.

> [!check]- Ver respuesta
> **Falso.** Es **cóncava y convexa a la vez**: la desigualdad de la definición se cumple con igualdad ($f'' = 0$, Hessiana nula).
> Por eso las restricciones lineales nunca rompen la convexidad de la región factible.

**A6.** En el método del gradiente con búsqueda lineal exacta, dos direcciones de movimiento consecutivas son perpendiculares.

> [!check]- Ver respuesta
> **Verdadero.** $t^*$ maximiza $\varphi(t) = f(x^k + t\,\nabla f(x^k))$, así que $\varphi'(t^*) = \nabla f(x^{k+1}) \cdot \nabla f(x^k) = 0$. El gradiente nuevo es ortogonal al anterior.
> Por eso la trayectoria hace **zigzag** hacia el óptimo (Guía 3, ej. 8).

**A7.** El método de Newton siempre converge a un máximo de la función.

> [!check]- Ver respuesta
> **Falso.** Newton busca los ceros de $f'$ (o de $\nabla f$). Puede converger a un **mínimo** o a un **punto silla**, **no converger** si el punto inicial está lejos, o fallar si $f'' = 0$ (o si $H$ no es invertible).
> Converge muy rápido cerca del óptimo, y en una sola iteración si $f$ es cuadrática.

**A8.** Si en el óptimo de un PNL con restricciones ≤ una restricción no está activa, su multiplicador vale cero.

> [!check]- Ver respuesta
> **Verdadero.** Por **holgura complementaria**: $\lambda_i\,[b_i - g_i(x^*)] = 0$. Si sobra recurso ($b_i - g_i > 0$), entonces $\lambda_i = 0$: una unidad adicional de ese recurso no mejora el óptimo.

**A9.** Las condiciones de Karush-Kuhn-Tucker son suficientes para que un punto sea óptimo.

> [!check]- Ver respuesta
> **Falso.** En general son **necesarias**, y solo bajo condiciones de regularidad. Son **suficientes** cuando el problema es convexo:
> - **máx:** $f$ cóncava y $g_i$ convexas;
> - **mín:** $f$ convexa y $g_i$ convexas.

**A10.** Para interpretar el multiplicador como precio sombra, es indistinto escribir el lagrangiano con $\lambda\,(b - g(x))$ o con $\lambda\,(g(x) - b)$.

> [!check]- Ver respuesta
> **Falso.** Con $L = f + \lambda(b - g)$ se obtiene $\lambda = \partial z^*/\partial b$. Con $\lambda(g - b)$ el multiplicador cambia de **signo**, y la interpretación se invierte.

**A11.** En un PNL de una variable con dominio $[a, b]$, el máximo global siempre satisface $f'(x^*) = 0$.

> [!check]- Ver respuesta
> **Falso.** El máximo puede estar en un **extremo** del intervalo con $f' \ne 0$.
> Ejemplo: $\max x^2$ en $[-1, 2]$ da $x^* = 2$, con $f'(2) = 4 > 0$. Regla: $f'(b) > 0$ → $b$ es máx local; $f'(a) < 0$ → $a$ es máx local.

**A12.** Si en un punto estacionario de $f(x_1, x_2)$ la Hessiana cumple $\lvert H_1\rvert < 0$ y $\lvert H_2\rvert > 0$, el punto es un máximo local.

> [!check]- Ver respuesta
> **Verdadero.** Los menores principales dominantes alternan empezando negativo, así que la Hessiana es definida negativa y el punto es un **máximo local** (estricto).
> Si $\lvert H_2\rvert < 0$ sería un punto silla.

**A13.** En un problema de 2 variables con 1 restricción de igualdad, si el hessiano orlado en el punto estacionario tiene determinante positivo, el punto es un mínimo.

> [!check]- Ver respuesta
> **Falso.** Con $n = 2$ y $m = 1$: $\lvert\bar H\rvert > 0$ es **máximo** y $\lvert\bar H\rvert < 0$ es **mínimo**.
> En el ejemplo de clase, $\max x_1x_2 + 2x_1$ s.a. $4x_1 + 2x_2 = 60$, da $\lvert\bar H\rvert = 16 > 0$: máximo.

**A14.** LINGO garantiza que la solución que encuentra para cualquier PNL es el óptimo global.

> [!check]- Ver respuesta
> **Falso.** El solver estándar encuentra óptimos **locales**. La solución es global si el problema es **convexo** (máx de cóncava, o mín de convexa, sobre región convexa).
> Si no, hay que verificarlo: analizar convexidad, comprobar KKT con los precios duales que informa LINGO, probar distintos puntos iniciales o usar el *Global Solver*.

## A.2 Desarrollo

**A15.** Explique por qué el método de la sección áurea usa $r \approx 0{,}618$. Deduzca la ecuación que lo define y cómo se calcula la cantidad de iteraciones necesarias.

> [!check]- Ver respuesta
> Se busca que uno de los dos puntos nuevos **coincida** con uno de la iteración anterior, así se evalúa $f$ una sola vez por iteración.
>
> Con $x_1 = b - r(b - a)$ y $x_2 = a + r(b - a)$, si el nuevo intervalo es $[a, x_2]$ se pide que el nuevo $x_2$ sea el viejo $x_1$:
> $$a + r\,[x_2 - a] = b - r(b - a) \;\Rightarrow\; a + r^2(b - a) = b - r(b - a) \;\Rightarrow\; r^2 + r - 1 = 0$$
> La raíz positiva es $r = \frac{\sqrt5 - 1}{2} \approx 0{,}618$.
>
> En cada iteración el intervalo se multiplica por $r$: $L_k = r^k(b - a)$. Para que $L_k \le \varepsilon$:
> $$k \ge \frac{\ln(\varepsilon/(b - a))}{\ln r}$$
> Hay que dividir por $\ln r < 0$, por eso la desigualdad queda $\ge$.

**A16.** Describa el método del gradiente (ascenso acelerado) para maximizar una función de varias variables. ¿Qué cambia si se quiere minimizar? ¿Qué criterio de detención se usa?

> [!check]- Ver respuesta
> 1. Se parte de $x^0$ y una tolerancia $\varepsilon$.
> 2. Se calcula $\nabla f(x^k)$. Es la dirección de máximo crecimiento local.
> 3. Se arma $\varphi(t) = f(x^k + t\,\nabla f(x^k))$, una función de una sola variable.
> 4. Se halla $t^* \ge 0$ que maximiza $\varphi$ (con $\varphi' = 0$ o con un método de una variable, como la sección áurea).
> 5. Se actualiza $x^{k+1} = x^k + t^*\nabla f(x^k)$ y se repite.
>
> - **Detención:** cuando $\lvert \partial f/\partial x_j\rvert \le \varepsilon$ para todo $j$ (o cuando los puntos o los valores de $f$ casi no cambian).
> - **Para minimizar:** se avanza en $-\nabla f$, o sea $x^{k+1} = x^k - t^*\nabla f$.
> - **Requisitos:** $f$ diferenciable y problema sin restricciones. Para asegurar el óptimo global, $f$ cóncava (máx) o convexa (mín).
> - **Comportamiento:** las direcciones consecutivas son perpendiculares, así que avanza en zigzag y puede ser lento.

**A17.** Compare los métodos de Newton y de la sección áurea para una variable: requisitos, información que usan y velocidad de convergencia.

> [!check]- Ver respuesta
> | | Sección áurea | Newton |
> |---|---|---|
> | Tipo | Directo (solo evalúa $f$) | Indirecto (usa $f'$ y $f''$) |
> | Requisitos | $f$ unimodal en $[a, b]$ | $f$ dos veces derivable, $f'' \ne 0$, punto inicial cercano |
> | Qué devuelve | Un intervalo que contiene el óptimo | Un punto |
> | Convergencia | Lineal (el intervalo se multiplica por 0,618) | Muy rápida (cuadrática) cerca del óptimo |
> | Garantía | Siempre converge si $f$ es unimodal | Puede diverger o ir a un mínimo |
>
> Fórmula de Newton: $x_{k+1} = x_k - f'(x_k)/f''(x_k)$. Sale de optimizar la aproximación de Taylor de 2° orden.

**A18.** Enuncie las condiciones de Karush-Kuhn-Tucker para un problema de maximización con restricciones ≤ e interprete cada una.

> [!check]- Ver respuesta
> Para $\max f(x)$ s.a. $g_i(x) \le b_i$:
> 1. **Estacionariedad:** $\dfrac{\partial f}{\partial x_j} - \sum_i \lambda_i \dfrac{\partial g_i}{\partial x_j} = 0$. En el óptimo, $\nabla f$ es una combinación de los gradientes de las restricciones activas: no hay una dirección factible que mejore.
> 2. **Holgura complementaria:** $\lambda_i\,[b_i - g_i(x)] = 0$. O la restricción está activa, o su precio sombra es 0.
> 3. **Signo:** $\lambda_i \ge 0$. Relajar una restricción ≤ no puede empeorar el máximo.
> 4. **Factibilidad:** $g_i(x) \le b_i$.
>
> Son **necesarias** (con regularidad) y **suficientes** si $f$ es cóncava y las $g_i$ convexas. Para minimizar, la condición 1 se escribe con $+$.

**A19.** ¿Qué es un problema de programación convexa y por qué es importante en PNL?

> [!check]- Ver respuesta
> Es un problema de **maximizar una función cóncava** (o minimizar una convexa) sujeto a $g_i(x) \le b_i$ con todas las $g_i$ **convexas**. Así, la región factible es un conjunto convexo.
>
> Es importante porque:
> - **todo óptimo local es global**;
> - las condiciones **KKT pasan a ser suficientes**;
> - los métodos numéricos (gradiente, LINGO) que encuentran óptimos locales encuentran **el** óptimo.
>
> En problemas no convexos solo se aseguran óptimos locales.

**A20.** Explique cómo se determina si un punto estacionario de un problema con una restricción de igualdad es máximo o mínimo.

> [!check]- Ver respuesta
> 1. Se arma $L = f + \lambda(b - g)$ y se resuelve el sistema $\partial L/\partial x_j = 0$, $\partial L/\partial \lambda = 0$.
> 2. Se evalúa el **hessiano orlado** en ese punto. Con 2 variables:
> $$\bar H = \begin{vmatrix} 0 & g_x & g_y \\ g_x & L_{xx} & L_{xy} \\ g_y & L_{yx} & L_{yy}\end{vmatrix}$$
>    - $\lvert\bar H\rvert > 0$ → máximo;
>    - $\lvert\bar H\rvert < 0$ → mínimo;
>    - $= 0$ → el criterio no concluye.
> 3. Con $n$ variables, se miran los menores $\lvert\bar H_2\rvert, \dots, \lvert\bar H_n\rvert$: todos negativos → mínimo; alternando empezando positivo → máximo.
>
> Atajo: si $f$ es cóncava (máx) o convexa (mín) y $g$ es lineal, el punto estacionario ya es óptimo.

**A21.** LINGO devolvió una solución para un PNL con restricciones. ¿Puede asegurar que es el óptimo global? ¿Cómo lo verificaría?

> [!check]- Ver respuesta
> No en general: LINGO informa un óptimo **local**. Para asegurar que es global:
> 1. **Convexidad:** si es máx de $f$ cóncava con $g_i$ convexas (o mín de convexa), local = global.
> 2. **KKT:** con los precios duales que informa LINGO como $\lambda$, verificar estacionariedad, $\lambda \ge 0$ y holgura complementaria. Si además el problema es convexo, KKT es suficiente.
> 3. Si no es convexo: probar **varios puntos iniciales**, usar el **solver global**, o comparar con otros candidatos (puntos en la frontera).

**A22.** Describa una estrategia para resolver a mano un PNL con restricciones de desigualdad.

> [!check]- Ver respuesta
> 1. Pasar todas las restricciones a la forma $g_i \le b_i$.
> 2. Resolver el problema **sin restricciones**. Si el óptimo es factible, es la solución (todos los $\lambda = 0$).
> 3. Si viola alguna restricción, suponerla **activa** (igualdad) y resolver con **Lagrange**. Verificar $\lambda \ge 0$ y que se cumplan las demás restricciones.
> 4. Si falla, probar otras combinaciones de restricciones activas (análisis **por casos**).
> 5. Verificar la **suficiencia**: concavidad o convexidad (KKT suficiente), o comparar los candidatos.
> 6. Interpretar $\lambda$ como precio sombra.

---

# Parte B — Modelos de Pronósticos

## B.1 Verdadero o falso (justifique)

**B1.** Si el sesgo de un modelo de pronóstico es cero, el modelo es preciso.

> [!check]- Ver respuesta
> **Falso.** El sesgo es el promedio de los errores con signo, y errores grandes positivos y negativos se **compensan**. Errores de $+5$ y $-5$ dan sesgo 0, pero RMSE 5.
> La precisión se mide con RMSE, MAE o MAPE. El sesgo solo indica si el modelo sub- o sobreestima sistemáticamente.

**B2.** Un RMSE bajo garantiza que el modelo no tiene sesgo.

> [!check]- Ver respuesta
> **Falso.** El RMSE mide la **magnitud** del error, no su dirección. Si todos los errores valen $+1$, el RMSE es 1 (bajo), pero el sesgo es $+1$: el modelo **subestima** siempre.
> Hay que mirar las dos medidas.

**B3.** En el suavizado exponencial, un valor de α cercano a 1 da más peso a los datos históricos.

> [!check]- Ver respuesta
> **Falso.** $F_t = \alpha D_{t-1} + (1 - \alpha)F_{t-1}$. Con α cercano a 1, el pronóstico casi copia **el último dato**: es reactivo, pero sigue el ruido. Con α cercano a 0 pesa más la historia y el pronóstico es suave pero lento.

**B4.** En el método de medias móviles, un $k$ grande permite reaccionar más rápido a un cambio de nivel en la demanda.

> [!check]- Ver respuesta
> **Falso.** Con $k$ grande, el promedio incluye muchos datos viejos: el pronóstico es **más suave y más lento**. Un $k$ chico reacciona rápido, pero es más sensible al ruido.

**B5.** En un modelo de nivel, el pronóstico para los próximos 5 períodos es el mismo valor.

> [!check]- Ver respuesta
> **Verdadero.** $D_t = A + \varepsilon_t$ y el pronóstico para cualquier período futuro es la estimación actual de $A$: $F_{t+k} = A$ para todo $k$. Solo cambia cuando llegan datos nuevos.

**B6.** Si una serie tiene tendencia creciente, el suavizado exponencial simple tiende a subestimar la demanda.

> [!check]- Ver respuesta
> **Verdadero.** El suavizado simple estima un nivel constante y siempre "llega tarde" a una serie que crece. Los errores $D_t - F_t$ son mayormente positivos (**sesgo > 0**, subestima). Para eso se usa **Holt**.

**B7.** El método de Holt da el mismo peso a todas las observaciones pasadas, igual que la regresión lineal.

> [!check]- Ver respuesta
> **Falso.** La regresión lineal pondera igual a todos los datos, por eso tarda en reflejar un cambio de nivel o de pendiente. Holt es un **suavizado exponencial**: el nivel y la tendencia se actualizan dando más peso a lo reciente, según α y β.

**B8.** En el método de Winters, un factor estacional $s = 0{,}8$ para el primer trimestre indica que la demanda en ese trimestre es aproximadamente el 80 % de la de un trimestre promedio.

> [!check]- Ver respuesta
> **Verdadero.** Los factores son **multiplicativos**: $F = (L + kB)\cdot s$. Un factor menor que 1 indica una estación por debajo del promedio. Normalizados, los $c$ factores suman $c$.

**B9.** Para inicializar el método de Winters con datos mensuales alcanza con un año de datos.

> [!check]- Ver respuesta
> **Falso.** Se necesitan **dos ciclos completos** (24 meses). $B_0$ se estima como la diferencia entre el promedio del año −1 y el del año −2, dividida por $c$. Con un solo año no se puede separar la tendencia de la estacionalidad.

**B10.** Un $R^2$ cercano a 1 garantiza que el modelo de regresión cumple sus supuestos.

> [!check]- Ver respuesta
> **Falso.** $R^2 = SSR/SST$ solo mide qué porcentaje de la variabilidad de $y$ explica el modelo. Los supuestos (homocedasticidad, normalidad, independencia de los errores, no multicolinealidad) se verifican **analizando los residuos** y las correlaciones entre variables explicativas.

**B11.** Si los residuos de una regresión cambian de signo muy pocas veces, es probable que exista autocorrelación positiva.

> [!check]- Ver respuesta
> **Verdadero.** Muchos menos cambios de signo que la mitad indican que los errores vienen en rachas (un error positivo tiende a seguir a otro positivo): **autocorrelación positiva**. Si cambian muchas más veces que la mitad, es autocorrelación negativa. Alrededor de la mitad es lo esperable con errores independientes.

**B12.** La multicolinealidad se presenta cuando la varianza del error depende del valor de la variable independiente.

> [!check]- Ver respuesta
> **Falso.** Eso es **heterocedasticidad**, que se corrige usando $\ln y$ o $\sqrt y$. La **multicolinealidad** ocurre cuando las variables explicativas están muy correlacionadas **entre sí**. Los coeficientes quedan imprecisos e incluso con el signo cambiado (por ejemplo, *displacement* y *horsepower* en Auto-MPG).

**B13.** Para elegir entre dos métodos de pronóstico alcanza con comparar sus RMSE, sin importar sobre qué períodos se calcularon.

> [!check]- Ver respuesta
> **Falso.** Hay que compararlos sobre **los mismos períodos**. Por ejemplo, medias móviles con $k = 6$ recién pronostica desde $t = 6$ y el suavizado desde $t = 1$. Si no, se comparan errores de tramos distintos de la serie.
> Además, conviene validar con datos que no se usaron para ajustar los parámetros.

**B14.** El intervalo $F_t \pm z\cdot\text{RMSE}$ supone que los errores de pronóstico se distribuyen normalmente.

> [!check]- Ver respuesta
> **Verdadero.** El RMSE se usa como estimación del desvío estándar del error, y $z$ sale de la normal estándar (1,645 para el 90 %, 1,96 para el 95 %). También supone errores con media cero (sin sesgo) y varianza constante.

**B15.** El MAPE permite comparar la precisión de modelos aplicados a series con unidades o escalas distintas.

> [!check]- Ver respuesta
> **Verdadero.** Es un error **porcentual**, no depende de las unidades. Limitación: no está definido si algún $D_t = 0$, y se distorsiona con demandas muy chicas.

**B16.** En la herramienta *Suavización exponencial* de Excel (Datos → Análisis de datos), el *factor de amortiguación* que se ingresa es α.

> [!check]- Ver respuesta
> **Falso.** El factor de amortiguación es **$1 - \alpha$**: para α = 0,2 se ingresa 0,8.

## B.2 Desarrollo

**B17.** Compare los modelos de pronóstico de series de tiempo con los causales. Dé un ejemplo de cada uno.

> [!check]- Ver respuesta
> - **Series de tiempo:** pronostican una variable usando **solo sus propios valores pasados**, registrados a intervalos iguales. Suponen que el patrón (nivel, tendencia, estacionalidad) se mantiene. Métodos: medias móviles, suavizado exponencial, Holt, Winters. Ejemplo: pronosticar la demanda de donas de la próxima semana con las ventas de las últimas 16.
> - **Causales:** explican la variable a partir de **otras variables**. Usan regresión simple o múltiple. Ejemplo: ventas en función del gasto en publicidad y del precio.
> - **Diferencias:** los causales permiten analizar el "por qué" e hipotetizar escenarios, pero exigen pronosticar también las variables explicativas y cumplir los supuestos de la regresión. Las series de tiempo son más simples, pero no detectan cambios causados por factores externos.

**B18.** Explique las componentes de una serie de tiempo y qué modelo de pronóstico corresponde a cada combinación de componentes.

> [!check]- Ver respuesta
> **Componentes:**
> - **nivel:** el valor alrededor del cual fluctúa la serie;
> - **tendencia:** crecimiento o decrecimiento sistemático;
> - **estacionalidad:** un patrón que se repite cada $c$ períodos;
> - **error aleatorio:** variaciones sin causa, con media 0.
>
> A veces aparece también un componente cíclico.
>
> | Componentes | Modelo | Método |
> |---|---|---|
> | Nivel + error | $F_t = A$ | Promedio, medias móviles, suavizado exponencial |
> | + tendencia | $F_t = A + Bt$ | Regresión con $x = t$, Holt |
> | Nivel + estacionalidad | $F_t = A\cdot S_k$ | Winters sin tendencia |
> | + tendencia + estacionalidad | $F_t = (A + Bt)S_k$ | Winters |

**B19.** ¿Por qué el suavizado exponencial se llama "exponencial"? Desarrolle la fórmula.

> [!check]- Ver respuesta
> Partiendo de $F_t = \alpha D_{t-1} + (1 - \alpha)F_{t-1}$ y reemplazando $F_{t-1}$, $F_{t-2}$, …:
> $$F_t = \alpha D_{t-1} + \alpha(1-\alpha)D_{t-2} + \alpha(1-\alpha)^2 D_{t-3} + \dots + (1-\alpha)^{t-1}F_1$$
> El peso de cada observación es $\alpha(1-\alpha)^{j}$: decae **exponencialmente** a medida que el dato es más viejo. Todos los datos influyen, pero los recientes pesan más.
> A diferencia de las medias móviles (peso $1/k$ a los últimos $k$ y 0 al resto), solo hay que guardar el último pronóstico.

**B20.** Explique el método de Holt: qué estima, cómo se actualiza y cómo se inicializa. ¿Por qué puede preferirse a la regresión lineal para series con tendencia?

> [!check]- Ver respuesta
> Estima un **nivel** $L_t$ y una **tendencia** $B_t$ (pendiente por período), con dos constantes de suavizado α y β:
> $$L_t = F_t + \alpha(D_t - F_t), \qquad B_t = B_{t-1} + \beta\,[(L_t - L_{t-1}) - B_{t-1}], \qquad F_{t+k} = L_t + k\,B_t$$
> - **Inicialización:** con una regresión lineal sobre los primeros datos. La pendiente da $B$ y el valor ajustado en el último de esos datos da $L$.
> - **Frente a la regresión:** la regresión da el mismo peso a todos los datos, así que si cambian el nivel o la pendiente tarda mucho en reflejarlo. Holt pondera más lo reciente y se adapta.

**B21.** Explique el método de Winters: orden de actualización, significado de cada término e inicialización.

> [!check]- Ver respuesta
> Con $c$ = largo del ciclo y constantes α, β, γ, después de observar $D_t$ se actualiza en este orden:
> 1. $L_t = \alpha\dfrac{D_t}{s_{t-c}} + (1-\alpha)(L_{t-1} + B_{t-1})$. Combina la demanda **desestacionalizada** con el nivel esperado antes de verla.
> 2. $B_t = \beta(L_t - L_{t-1}) + (1-\beta)B_{t-1}$. Igual que en Holt.
> 3. $s_t = \gamma\dfrac{D_t}{L_t} + (1-\gamma)s_{t-c}$. Combina la estacionalidad observada con la última estimación de esa misma estación.
>
> - **Pronóstico:** $F_{t+k} = (L_t + kB_t)\,s_{t+k-c}$.
> - **Inicialización** (dos ciclos): $B_0$ = (promedio del año −1 − promedio del año −2)/$c$; $L_0$ = promedio del año −1 + $(c/2)B_0$; cada factor = demanda de esa estación en el año −1 / promedio del año −1.
> - **Consejo de clase:** α, β ≤ 0,5, para que no absorban lo que debe modelar γ.

**B22.** Compare RMSE, MAE, MAPE y sesgo. ¿Qué mide cada uno y cuándo conviene usarlo?

> [!check]- Ver respuesta
> | Medida | Fórmula | Qué mide | Cuándo conviene |
> |---|---|---|---|
> | RMSE | $\sqrt{\sum e_t^2/n}$ | Desvío del error; castiga los errores grandes | Cuando los errores grandes son graves; para armar intervalos de confianza |
> | MAE | $\sum \lvert e_t\rvert/n$ | Error promedio en unidades | Interpretación directa ("me equivoco ±x unidades") |
> | MAPE | $\frac{100}{n}\sum \lvert e_t\rvert/D_t$ | Error promedio en % | Comparar series con escalas distintas |
> | Sesgo | $\sum e_t/n$ | Dirección sistemática del error | Detectar si el modelo sub- (>0) o sobreestima (<0) |
>
> El promedio simple de los errores no sirve como precisión, porque los errores positivos y negativos se cancelan.

**B23.** ¿Cómo construiría un intervalo de confianza para un pronóstico? ¿Qué supuestos utiliza?

> [!check]- Ver respuesta
> 1. Se calcula el **RMSE** del modelo sobre los datos históricos. Estima el desvío estándar del error.
> 2. Se elige el nivel de confianza y se busca $z$ tal que el área a su izquierda en la normal estándar sea $1 - \alpha/2$ (90 %: 1,645; 95 %: 1,96).
> 3. El intervalo es $F_t \pm z \cdot \text{RMSE}$.
>
> **Supuestos:** errores con distribución **normal**, media 0 (sin sesgo), varianza constante, y que el modelo siga siendo válido en el futuro. Para horizontes largos, el intervalo real es más ancho.

**B24.** Enumere los supuestos de un modelo de regresión lineal. Para cada uno, indique cómo detectar su incumplimiento y qué hacer.

> [!check]- Ver respuesta
> | Supuesto | Cómo se detecta que no se cumple | Qué hacer |
> |---|---|---|
> | **Homocedasticidad** | En el gráfico de residuos vs $x$, el error crece (forma de embudo) | Transformar: $\ln y$ o $\sqrt y$ |
> | **Normalidad** del error | Histograma o gráfico de probabilidad normal de los residuos | Transformar, revisar datos atípicos |
> | **Independencia** (sin autocorrelación) | Contar los cambios de signo de los residuos en el tiempo | Agregar variables (por ejemplo, el valor rezagado) o usar modelos de series de tiempo |
> | **No multicolinealidad** | Correlación alta entre $x$; coeficientes con signo absurdo o p-valores altos | Eliminar o combinar variables |

**B25.** Se eligieron α, β y γ de Winters minimizando el RMSE con Solver, usando todos los datos. ¿Qué riesgos tiene? ¿Cómo los evitaría?

> [!check]- Ver respuesta
> - **Riesgo: sobreajuste.** Los parámetros se adaptan al ruido de esos datos en particular y el modelo pronostica peor a futuro.
>   - Con pocos datos, Solver suele devolver valores extremos (0 o 1). En la Guía 4, ej. 3, da α ≈ 0,04, β = 0 y γ = 1.
>   - Además, si α y β son grandes, absorben lo que debería capturar γ.
> - **Cómo evitarlo:**
>   - separar los datos: estimar los parámetros con una parte y **validar** con el resto;
>   - limitar α y β (≤ 0,5, como se recomendó en clase);
>   - revisar que los valores tengan sentido;
>   - controlar el sesgo y los residuos;
>   - antes de ajustar, revisar si hay datos atípicos que distorsionan el RMSE.

**B26.** Describa los pasos para elegir, ajustar y validar un modelo de pronóstico ante una serie nueva.

> [!check]- Ver respuesta
> 1. **Graficar la serie.** ¿Es estable? ¿Tiene tendencia? ¿Hay un patrón que se repite cada $c$ períodos? ¿Hay datos atípicos o errores de carga?
> 2. **Elegir el modelo:** nivel, tendencia, estacional o estacional con tendencia, usando el conocimiento del negocio.
> 3. **Elegir el método** y **ajustar sus parámetros** ($k$, α, β, γ) minimizando el RMSE, comparando sobre los mismos períodos.
> 4. **Validar:** con datos reservados; sesgo ≈ 0; residuos aleatorios.
> 5. **Pronosticar** y dar el **intervalo de confianza** $F \pm z\cdot\text{RMSE}$.
> 6. **Monitorear:** recalcular a medida que llegan datos nuevos.

---

# Parte C — Integradoras

**C1.** Muestre que estimar los coeficientes de una regresión lineal simple por mínimos cuadrados es un problema de PNL sin restricciones. ¿Es convexo? ¿Qué implica?

> [!check]- Ver respuesta
> Se busca $\min_{\beta_0, \beta_1} \text{SSE} = \sum_i (y_i - \beta_0 - \beta_1 x_i)^2$. La función objetivo es **cuadrática** y no tiene restricciones: es un PNL irrestricto.
> - **Condiciones de 1er orden:** $\partial/\partial\beta_0 = 0$ da $\beta_0 = \bar y - \beta_1\bar x$, y $\partial/\partial\beta_1 = 0$ da $\beta_1 = \frac{\sum(x_i - \bar x)(y_i - \bar y)}{\sum(x_i - \bar x)^2}$.
> - **Convexidad:** la Hessiana es $2\begin{pmatrix} n & \sum x_i \\ \sum x_i & \sum x_i^2\end{pmatrix}$, con $\lvert H_1\rvert = 2n > 0$ y $\lvert H_2\rvert = 4\,[n\sum x_i^2 - (\sum x_i)^2] = 4n\sum(x_i - \bar x)^2 > 0$ si no todos los $x_i$ son iguales. Es **definida positiva**, así que SSE es convexa.
> - **Implicación:** el único punto estacionario es el **mínimo global**. Por eso las fórmulas de mínimos cuadrados dan siempre la mejor recta.

**C2.** Elegir el α del suavizado exponencial que minimiza el RMSE es un problema de PNL. Formúlelo, clasifíquelo e indique qué método aplicaría y qué cuidado tendría.

> [!check]- Ver respuesta
> **Formulación:** $\min_{\alpha}\ \text{RMSE}(\alpha) = \sqrt{\frac1n\sum_t (D_t - F_t(\alpha))^2}$ s.a. $0 \le \alpha \le 1$.
> - Es un PNL de **una variable, restringido a un intervalo**. $F_t(\alpha)$ es un polinomio en α, así que el RMSE es no lineal y no necesariamente convexo.
> - **Métodos:** si $\text{RMSE}(\alpha)$ es unimodal en $[0, 1]$, la **sección áurea** es ideal (no necesita derivadas). En Excel, **Solver (GRG no lineal)** o una tabla de datos con varios α.
> - **Cuidados:**
>   - el óptimo puede estar en un **extremo** (α = 0 o α = 1), donde la derivada no tiene por qué ser 0: hay que analizar la frontera;
>   - si no es unimodal, Solver puede quedarse en un óptimo local;
>   - comparar sobre los mismos períodos y validar para no sobreajustar.

**C3.** En Winters, Solver devolvió γ = 1 con la restricción $0 \le \gamma \le 1$. ¿Es necesariamente un error? ¿Qué se puede decir de la condición de óptimo en ese punto?

> [!check]- Ver respuesta
> No es un error matemático. El óptimo está en la **frontera** de la región factible: la restricción $\gamma \le 1$ está **activa**.
> - Por KKT (minimización), en ese punto no hace falta que $\partial\,\text{RMSE}/\partial\gamma = 0$. Alcanza con que la derivada sea **≤ 0**: el RMSE seguiría bajando si se pudiera aumentar γ. El multiplicador de esa restricción es $\lambda = -\partial\,\text{RMSE}/\partial\gamma \ge 0$.
> - **En la práctica:** γ = 1 significa que el factor estacional se reemplaza siempre por la última observación. Con pocos datos es señal de **sobreajuste**. Conviene validar con datos reservados o elegir un γ razonable.

---

# Parte D — Ejercicios cortos

**D1.** Aplique dos iteraciones del método de la sección áurea para maximizar $f(x) = -x^2 + 4x$ en $[0, 5]$. ¿Cuántas iteraciones harían falta para un intervalo final de longitud 0,1?

> [!check]- Ver respuesta
> | It. | Intervalo | $x_1$ / $f(x_1)$ | $x_2$ / $f(x_2)$ | Decisión | Nuevo intervalo |
> |---|---|---|---|---|---|
> | 1 | [0; 5] | 1,910 / 3,992 | 3,090 / 2,812 | $f(x_1) \ge f(x_2)$ | [0; 3,090] |
> | 2 | [0; 3,090] | 1,180 / 3,328 | 1,910 / 3,992 *(reusa)* | $f(x_1) < f(x_2)$ | [1,180; 3,090] |
>
> Después de dos iteraciones, la longitud es 1,910 ($= 0{,}618^2 \cdot 5$). El máximo real, $x^* = 2$, está adentro.
> Iteraciones necesarias: $k \ge \ln(0{,}1/5)/\ln 0{,}618 = 8{,}13$, o sea **9**.

**D2.** Resuelva $\min z = x^2 + y^2$ s.a. $x + y = 10$. Verifique con el hessiano orlado e interprete λ.

> [!check]- Ver respuesta
> - Lagrangiano: $L = x^2 + y^2 + \lambda(10 - x - y)$.
> - Condiciones: $2x - \lambda = 0$, $2y - \lambda = 0$ y $x + y = 10$, de donde **$x = y = 5$**, **$\lambda = 10$** y **$z^* = 50$**.
> - Hessiano orlado: $\bar H = \begin{vmatrix} 0 & 1 & 1 \\ 1 & 2 & 0 \\ 1 & 0 & 2\end{vmatrix} = -4 < 0$, así que es un **mínimo** ✅. Además $f$ es convexa y la restricción lineal: mínimo global.
> - $\lambda = \partial z^*/\partial b = 10$: si la restricción pasa a $x + y = 11$, $z^*$ sube unas 10 unidades (el valor exacto es $60{,}5$, o sea $+10{,}5$; λ es una aproximación marginal).

**D3.** Resuelva $\max f = -(x-3)^2 - (y-2)^2$ s.a. $x + y \le 4$. Verifique las condiciones KKT.

> [!check]- Ver respuesta
> 1. **Sin restricciones:** el óptimo es $(3, 2)$, pero $3 + 2 = 5 > 4$: no es factible, así que la restricción está **activa**.
> 2. Con $L = f + \lambda(4 - x - y)$: $-2(x - 3) - \lambda = 0$, $-2(y - 2) - \lambda = 0$ y $x + y = 4$. Resulta **$x = 2{,}5$**, **$y = 1{,}5$**, **$\lambda = 1$**.
> 3. **KKT:** $\lambda = 1 \ge 0$ ✅, restricción activa ✅ (holgura complementaria), factible ✅.
> 4. **Suficiencia:** $f$ es cóncava (Hessiana $-2I$) y la restricción lineal, así que es el **máximo global**: $f^* = -0{,}5$.

**D4.** Ventas: $D_1, \dots, D_5$ = 20, 24, 22, 26, 25.
a) Pronóstico para $t = 6$ con medias móviles, $k = 3$.
b) Suavizado exponencial con α = 0,3 y $F_2 = D_1$: pronósticos, RMSE y sesgo (sobre $t = 2 \dots 5$). Interprete el sesgo.

> [!check]- Ver respuesta
> a) $F_6 = (22 + 26 + 25)/3 = $ **24,33**.
>
> b)
> | $t$ | $D_t$ | $F_t$ | $e_t$ |
> |---|---|---|---|
> | 2 | 24 | 20 | 4 |
> | 3 | 22 | 21,2 | 0,8 |
> | 4 | 26 | 21,44 | 4,56 |
> | 5 | 25 | 22,808 | 2,192 |
> | 6 | — | **23,466** | |
>
> - RMSE $= \sqrt{(16 + 0{,}64 + 20{,}79 + 4{,}80)/4} = \sqrt{10{,}56} = $ **3,25**.
> - Sesgo = **+2,89**: el modelo **subestima**, porque la serie crece y el suavizado simple se atrasa. Convendría un modelo de tendencia (Holt).

**D5.** Con el método de Holt: $L_{t-1} = 100$, $B_{t-1} = 5$, α = 0,2, β = 0,1. Se observa $D_t = 110$. Calcule $F_t$, $L_t$, $B_t$, el pronóstico para el período siguiente y para 3 períodos adelante.

> [!check]- Ver respuesta
> - $F_t = L_{t-1} + B_{t-1} = 105$
> - $L_t = 105 + 0{,}2(110 - 105) = $ **106**
> - $B_t = 5 + 0{,}1\,[(106 - 100) - 5] = $ **5,1**
> - $F_{t+1} = 106 + 5{,}1 = $ **111,1**
> - $F_{t+3} = 106 + 3 \cdot 5{,}1 = $ **121,3**

**D6.** Con el método de Winters: $L_{t-1} = 200$, $B_{t-1} = 4$, $s_{t-c} = 1{,}2$, α = 0,3, β = 0,2, γ = 0,4. Se observa $D_t = 252$. Calcule $F_t$, $L_t$, $B_t$ y $s_t$.

> [!check]- Ver respuesta
> - $F_t = (200 + 4)\cdot 1{,}2 = $ **244,8**
> - $L_t = 0{,}3 \cdot \frac{252}{1{,}2} + 0{,}7 \cdot 204 = 63 + 142{,}8 = $ **205,8**
> - $B_t = 0{,}2\,(205{,}8 - 200) + 0{,}8 \cdot 4 = $ **4,36**
> - $s_t = 0{,}4 \cdot \frac{252}{205{,}8} + 0{,}6 \cdot 1{,}2 = $ **1,210**: la estación sigue estando ≈ 21 % por encima del promedio.

**D7.** Un modelo pronostica $F = 500$ unidades con RMSE = 20. Dé un intervalo del 95 % para la demanda. ¿Qué pasa con el ancho si se pide un 99 %?

> [!check]- Ver respuesta
> - 95 %: $500 \pm 1{,}96 \cdot 20 = 500 \pm 39{,}2$, o sea **[460,8; 539,2]**.
> - 99 %: $z = 2{,}576$, así que $500 \pm 51{,}5$. **Más confianza, intervalo más ancho.**

---

# Simulacros
Armados como el parcial de 2025: tres V/F, dos de desarrollo y un ejercicio corto. Tomate unos 40 minutos.

| | V/F | Desarrollo | Ejercicio |
|---|---|---|---|
| **Simulacro 1** | A4, A8, B6 | A16, B21 | D3 |
| **Simulacro 2** | A11, B1, B9 | A19, B20 | D4 |
| **Simulacro 3** | A6, A14, B12 | B25, C1 | D6 |

- [ ] Simulacro 1
- [ ] Simulacro 2
- [ ] Simulacro 3
