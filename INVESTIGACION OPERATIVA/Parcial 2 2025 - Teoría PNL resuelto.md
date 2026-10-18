---
tipo: tp
materia: Investigación Operativa
tags: [investigacion-operativa, pnl, parcial, examen-resuelto]
---
# 2° parcial 2025 — Teoría de PNL (resuelto)

Volver a [[INVESTIGACION OPERATIVA]] · Consigna original: [[parcial2-consigna.pdf|2° parcial del 03/09/2025]] · Teoría: [[Resumen Segundo Parcial - PNL y Pronósticos|resumen]] · [[Mapa mental - PNL y Pronósticos.canvas|mapa mental]]

> [!info] Cómo está armado
> Cada respuesta tiene primero la **respuesta para el parcial** (lo que escribirías en la hoja) y después un **desarrollo** para entender el porqué. Las respuestas son mías, no de la cátedra.

---

## 1) Verdadero o falso

### (a) "El método de secciones áureas y el de ascenso/descenso acelerado se pueden aplicar en la misma clase de problemas de manera intercambiable."

> [!success] Respuesta para el parcial: **FALSO**
> Resuelven clases de problemas distintas:
> - **Sección áurea:** problemas de **una variable**, sobre un **intervalo cerrado** $[a, b]$, con $f$ **unimodal**. Es un método **directo**: solo evalúa $f$, así que sirve aunque $f$ no sea derivable.
> - **Ascenso/descenso acelerado:** problemas **multivariables sin restricciones**, con $f$ **diferenciable**, porque necesita el gradiente $\nabla f$. Es un método **indirecto**.
>
> No son intercambiables. Sí son **complementarios**: en cada iteración del ascenso acelerado hay que resolver un problema de una variable, $\max_{t \ge 0} f(x^k + t\,\nabla f(x^k))$, y para eso se puede usar la sección áurea.

**Desarrollo**

| | Sección áurea | Ascenso/descenso acelerado |
|---|---|---|
| Variables | Una | Varias ($n \ge 2$) |
| Región | Intervalo $[a, b]$ (restringido) | Todo $\mathbb{R}^n$ (irrestricto) |
| Requisito sobre $f$ | Unimodal en $[a, b]$ (no hace falta que sea derivable) | Diferenciable; cóncava (máx) o convexa (mín) para asegurar el óptimo global |
| Información que usa | Solo valores de $f$ (directo) | Gradiente (indirecto) |
| Cómo avanza | Achica el intervalo por $r = 0{,}618$ en cada iteración | Se mueve en la dirección de $\nabla f$ (o $-\nabla f$) con el paso óptimo $t^*$ |
| Resultado | Un intervalo que contiene $x^*$ | Una sucesión de puntos (zigzag) hasta que $\lvert \partial f/\partial x_j\rvert \le \varepsilon$ |

Contraejemplos:
- Para maximizar $f(x) = -\lvert x - 1\rvert$ en $[0, 3]$, la sección áurea funciona (es unimodal), pero el ascenso no se puede aplicar: $f$ no es derivable en $x = 1$.
- Para maximizar $f(x_1, x_2) = 2x_1x_2 + x_2 - x_1^2 - 2x_2^2$ (Guía 3, ej. 8), sirve el ascenso, pero la sección áurea no se puede aplicar directamente: tiene dos variables y no hay un intervalo.

📎 [[Resumen Segundo Parcial - PNL y Pronósticos#4.2 Métodos numéricos|Sección áurea]] · [[Resumen Segundo Parcial - PNL y Pronósticos#5.2 Método del gradiente (ascenso más rápido)|Gradiente]]

---

### (b) "Los multiplicadores de Lagrange son un artificio matemático que no tiene interpretación física ni económica."

> [!success] Respuesta para el parcial: **FALSO**
> - **Interpretación económica:** $\lambda_i$ es el **precio sombra** de la restricción $i$. Mide cuánto cambia el valor óptimo de la función objetivo si el recurso $b_i$ aumenta una unidad (en el margen):
> $$\lambda_i = \frac{\partial z^*}{\partial b_i} \qquad\Rightarrow\qquad \Delta z^* \approx \lambda_i\,\Delta b_i$$
>   Es lo máximo que convendría pagar por una unidad adicional del recurso. Es la misma idea que las variables duales en PL.
> - **Interpretación geométrica:** en el óptimo, $\nabla f = \sum_i \lambda_i \nabla g_i$. El gradiente de la función objetivo es una combinación lineal de los gradientes de las restricciones, y $\lambda_i$ es el peso de cada una. Con una restricción, la curva de nivel de $f$ es tangente a la restricción.
> - **Interpretación física:** en mecánica, $\lambda$ es la **fuerza de reacción** que ejerce un vínculo para que se cumpla la restricción.
>
> Para que $\lambda$ se lea así, el lagrangiano debe escribirse $L = f + \lambda\,(b - g(x))$.

**Desarrollo y ejemplo**

En el ejemplo de clase, $\max U = x_1x_2 + 2x_1$ s.a. $4x_1 + 2x_2 = 60$:
- da $x_1 = 8$, $x_2 = 14$, $U^* = 128$ y $\lambda = 4$;
- si el presupuesto sube de 60 a 61, el nuevo óptimo es $U^* = 132{,}03$, o sea $\Delta U \approx 4 = \lambda$ ✅.

Con desigualdades (KKT), la interpretación se mantiene y explica la holgura complementaria:
- si sobra recurso (la restricción no está activa), una unidad más no sirve, así que $\lambda_i = 0$;
- si $\lambda_i > 0$, el recurso es escaso y la restricción está activa.

Matiz: es una tasa **marginal**, válida para cambios pequeños. En la Guía 3, ej. 11, $\lambda = 0{,}25$, pero al agregar \$1000 al presupuesto el ingreso sube solo 0,125 (miles de \$), porque $\lambda$ va bajando hasta 0.

📎 [[Resumen Segundo Parcial - PNL y Pronósticos#6. Restricciones de igualdad (Lagrange)|Lagrange en el resumen]]

---

### (c) "Si $x_0$ es la solución óptima de un programa lineal multivariable con 2 restricciones lineales de ≤, y se verifica que $\lambda_1 > \lambda_2 > 0$, entonces $x_0$ es un punto interior de la región factible."

> [!success] Respuesta para el parcial: **FALSO**
> Por la condición de **holgura complementaria** (KKT, o dualidad en PL):
> $$\lambda_i\,[\,b_i - g_i(x_0)\,] = 0, \qquad i = 1, 2$$
> Como $\lambda_1 > 0$ y $\lambda_2 > 0$, tiene que valer $g_1(x_0) = b_1$ y $g_2(x_0) = b_2$: **las dos restricciones están activas**. Entonces $x_0$ está sobre el **borde** de la región factible, en la intersección de las dos restricciones. Con dos variables, es un **vértice**.
>
> Un punto interior tiene todas las restricciones inactivas, lo que obliga a que $\lambda_1 = \lambda_2 = 0$ (y $\nabla f(x_0) = 0$). Eso contradice el enunciado.
>
> Que $\lambda_1 > \lambda_2$ solo dice que el recurso 1 es más valioso en el margen que el 2. No tiene nada que ver con que el punto sea interior.

**Desarrollo**
- El enunciado dice "programa **lineal**", pero la conclusión vale igual para un programa no lineal. En PL hay un argumento más: el óptimo de una función objetivo lineal (no constante) **nunca** está en el interior, siempre está en un punto extremo.
- Recordá la regla: **$\lambda > 0$ ⇒ restricción activa** y **restricción inactiva ⇒ $\lambda = 0$**. Lo que no vale es la inversa: puede pasar que $\lambda = 0$ con la restricción activa (caso degenerado).

📎 [[Resumen Segundo Parcial - PNL y Pronósticos#7. Restricciones de desigualdad (KKT)|KKT en el resumen]]

---

## 2) Supuestos de PNL vs PL: diferencias e implicaciones

> [!success] Respuesta para el parcial
> **Supuestos de PL:**
> 1. **Proporcionalidad:** el aporte de cada variable a la función objetivo y a las restricciones es proporcional a su valor ($c_j x_j$, $a_{ij} x_j$).
> 2. **Aditividad:** el efecto total es la suma de los efectos individuales, sin interacciones (no hay términos $x_i x_j$).
> 3. **Divisibilidad:** las variables pueden tomar valores no enteros.
> 4. **Certeza:** todos los parámetros se conocen y son constantes.
>
> **En PNL se relajan la proporcionalidad y/o la aditividad:** la función objetivo o alguna restricción es no lineal. Divisibilidad y certeza **se mantienen**.
>
> Esto permite modelar situaciones reales que la PL no captura:
> - rendimientos decrecientes (como $6\sqrt{x_1}$ cajas vendidas en el ej. 12 de la guía);
> - precios que dependen de la cantidad ($p_2 = 100 - q_2$ en el ej. 10);
> - costos con economías o deseconomías de escala ($(q_1 + q_2)^2$);
> - interacciones entre variables ($x\,y$ en el ej. 11);
> - riesgo de una cartera (cuadrático).

**Implicaciones de relajar esos supuestos**

| Aspecto | PL | PNL |
|---|---|---|
| Región factible | Siempre **convexa** (poliedro) | Puede **no ser convexa** (si alguna $g_i$ de una restricción ≤ no es convexa) |
| Dónde está el óptimo | En un **punto extremo** (vértice) | En cualquier lugar: vértice, **borde** o **interior** ($\nabla f = 0$). Se amplía el dominio de búsqueda |
| Restricciones activas en el óptimo | Tantas como variables (en el vértice) | Su número **no tiene por qué coincidir** con el de variables (hasta puede no haber ninguna) |
| Óptimo local vs global | Todo local es **global** | Puede haber varios óptimos locales. Solo se asegura el global con **convexidad** (máx $f$ cóncava y $g_i$ convexas) |
| Dirección de mejora | El gradiente es constante ($c$): avanzar en una dirección mejora siempre, hasta chocar una restricción | El gradiente **cambia en cada punto**: siguiendo una dirección fija, $f$ puede empezar a empeorar, y hay que recalcularla (métodos iterativos) |
| Método de resolución | Un algoritmo general y finito (**símplex**) que encuentra el óptimo exacto | **No hay un método general**: analíticos (derivadas, Lagrange, KKT) o numéricos iterativos que **aproximan** con una tolerancia. LINGO no asegura el óptimo global |
| Condiciones de óptimo | Factibilidad primal y dual + holgura complementaria | Condiciones de 1er y 2° orden, Lagrange, KKT. Son **necesarias** con regularidad y **suficientes** solo con convexidad |
| Sensibilidad | Los precios sombra son constantes dentro de un rango | Los $\lambda$ son **marginales** (locales): valen para cambios pequeños |

📎 [[Resumen Segundo Parcial - PNL y Pronósticos#1. PNL vs PL|PNL vs PL en el resumen]]

---

## 3) Condiciones de 1er orden: una variable restringido vs irrestricto

> [!success] Respuesta para el parcial
> **Irrestricto** ($x \in \mathbb{R}$): la condición necesaria de primer orden es $f'(x^*) = 0$. Los candidatos son los **puntos estacionarios** y los puntos donde **$f'$ no existe**. Puede no haber óptimo global, si $f$ no está acotada.
>
> **Restringido** ($a \le x \le b$). Además:
> 1. Los puntos estacionarios solo son candidatos si están **dentro** del intervalo, en $(a, b)$.
> 2. Hay que analizar los **extremos $a$ y $b$**. El óptimo puede estar en la frontera **aunque la derivada no sea cero ahí**: $f'(x^*) = 0$ deja de ser condición necesaria en la frontera. El criterio es el signo de la derivada:
>
> | | $f'(\cdot) > 0$ | $f'(\cdot) < 0$ |
> |---|---|---|
> | En $a$ | mínimo local | **máximo local** |
> | En $b$ | **máximo local** | mínimo local |
>
> 3. También hay que revisar los puntos de $[a, b]$ donde $f'$ no existe.
> 4. El **óptimo global** se obtiene comparando $f$ en **todos** los candidatos. Si $f$ es continua y el intervalo es cerrado y acotado, el máximo y el mínimo globales **existen siempre** (teorema de Weierstrass). En el caso irrestricto, en cambio, pueden no existir.

**Desarrollo y ejemplo**

$\max f(x) = x^2$:
- **Irrestricto:** $f'(x) = 2x = 0$ da $x = 0$, que es un **mínimo** ($f'' = 2 > 0$). No hay máximo: $f \to \infty$.
- **Restringido a $[-1, 2]$:** el punto estacionario $x = 0$ sigue siendo un mínimo. Pero aparecen los extremos:
  - $f'(-1) = -2 < 0$ → $x = -1$ es máximo local, con $f = 1$;
  - $f'(2) = 4 > 0$ → $x = 2$ es máximo local, con $f = 4$.
- Comparando, el **máximo global es $x = 2$**, un punto donde $f' \ne 0$. Si solo se hubiera mirado $f'(x) = 0$, no se encontraba.

**Relación con KKT.** Si $\max f(x)$ s.a. $x \le b$ y $-x \le -a$, las condiciones KKT son $f'(x) - \lambda_1 + \lambda_2 = 0$, con $\lambda_1(b - x) = 0$, $\lambda_2(x - a) = 0$ y $\lambda_1, \lambda_2 \ge 0$. De ahí sale:
- en el **interior**, los dos $\lambda$ valen 0, así que $f'(x) = 0$;
- en **$x = b$**, $\lambda_1 = f'(b) \ge 0$, así que $f'(b) \ge 0$;
- en **$x = a$**, $\lambda_2 = -f'(a) \ge 0$, así que $f'(a) \le 0$.

Son exactamente las reglas de la tabla. Es el mismo caso que Hillier muestra con $x \ge 0$: el óptimo puede ser $x = 0$ con $f'(0) < 0$.

Ojo con los **intervalos abiertos**: si el intervalo es $(0, 2]$, el extremo 0 no es candidato, y el supremo puede no alcanzarse. Pasa en la Guía 3, ej. 4, con $f = x + 4/x$.

📎 [[Resumen Segundo Parcial - PNL y Pronósticos#4.1 Método analítico (condiciones de óptimo)|Método analítico en el resumen]]
