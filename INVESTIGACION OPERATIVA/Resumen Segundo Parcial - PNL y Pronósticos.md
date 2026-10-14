---
tipo: resumen
materia: Investigación Operativa
parcial: 2
tags: [resumen, investigacion-operativa, pnl, pronosticos]
---
# Resumen 2° parcial — PNL y Pronósticos

Volver a [[INVESTIGACION OPERATIVA]] · [[Inicio]]

> [!info] Fuentes
> - **Guías:** [[Guía_3-Programación_no_lineal.pdf|Guía 3 – PNL]] · [[Guía_4-Modelos_de_pronósticos.pdf|Guía 4 – Pronósticos]]
> - **Diapositivas:** [[Modelos de Pronósticos.pdf|Modelos de Pronósticos (Casanova–Schab)]] · Excel de clase: [[Analítica Predictiva.xlsx]]
> - **Resúmenes de compañeros:** [[resumen-fmiret.pdf#page=40|fmiret (PNL)]] · [[resumen-iara.pdf#page=59|iara / imartinelli (PNL y Pronósticos)]] · [[resumen-tgrandi.pdf#page=28|tgrandi (métodos numéricos, PNL, regresión y Pronósticos)]]
> - **Libros:** [[hillier_lieberman.pdf#page=526|Hillier–Lieberman, cap. 12 (PNL)]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=713|Taha 9ª ed., caps. 20–21 (PNL)]]. Ninguno de los dos trae el capítulo de pronósticos impreso: en ambos está solo en la web de la editorial.
> - *(complemento)* = no está en el material de la cátedra. ✅ = resultado verificado numéricamente.

> [!todo] Falta integrar el Winston
> El Winston (*Investigación de operaciones*, 4ª ed.) es la base de las diapositivas y de varios ejercicios de las guías. En esa edición, PNL es el cap. 12 y Pronósticos el cap. 24. Quedó en Descargas, a la que macOS no le da acceso a VS Code. Cuando esté en esta carpeta, se suman sus referencias.

**Índice**
- Parte I — PNL: [[#1. PNL vs PL]] · [[#2. Convexidad y concavidad]] · [[#3. Tipos de problemas de PNL]] · [[#4. Una variable sin restricciones]] · [[#5. Varias variables sin restricciones]] · [[#6. Restricciones de igualdad (Lagrange)]] · [[#7. Restricciones de desigualdad (KKT)]] · [[#8. Otros tipos de PNL]] · [[#9. Guía 3 — método y resultados]]
- Parte II — Pronósticos: [[#10. Conceptos]] · [[#11. Medidas de rendimiento]] · [[#12. Modelo de nivel]] · [[#13. Regresión lineal]] · [[#14. Holt (tendencia)]] · [[#15. Winters (tendencia y estacionalidad)]] · [[#16. Cómo elegir el modelo]] · [[#17. Guía 4 — resultados]] · [[#18. Excel]]
- [[#Errores frecuentes y erratas del material]] · [[#Checklist para el parcial]]

---

# Parte I — Programación No Lineal

## 1. PNL vs PL
📎 [[resumen-fmiret.pdf#page=40|fmiret p. 39–40]] · [[resumen-iara.pdf#page=59|iara p. 53]] · [[hillier_lieberman.pdf#page=526|Hillier 12.1–12.2]]

Forma general (si no hay restricciones, es un **PNL irrestricto**):

$$\max\ (\min)\ z = f(x_1,\dots,x_n) \quad \text{s.a.}\quad g_i(x_1,\dots,x_n)\ (\le,\ =,\ \ge)\ b_i,\quad i = 1,\dots,m$$

| | PL | PNL |
|---|---|---|
| Supuestos | Proporcionalidad, aditividad, divisibilidad, certeza | Se relajan proporcionalidad y aditividad |
| Región factible | Siempre convexa | Puede no ser convexa |
| Dónde está el óptimo | En un punto extremo (vértice) | En cualquier lado: vértice, borde o interior |
| Restricciones activas en el óptimo | Tantas como variables | No necesariamente |
| Avanzar en una dirección de mejora | Siempre lleva al óptimo | La función puede empezar a decrecer: hay que recalcular la dirección |
| Óptimos | Local = global | Un óptimo local **puede no ser global** |

- **Máximo local:** $\bar x$ factible tal que $f(\bar x) \ge f(x')$ para todo $x'$ factible cercano ($\lvert x_i - x'_i\rvert < \varepsilon$).
- **Máximo global:** $f(\bar x) \ge f(x')$ para **todo** $x'$ factible.

## 2. Convexidad y concavidad
📎 [[resumen-fmiret.pdf#page=40|fmiret p. 39]] · [[resumen-tgrandi.pdf#page=31|tgrandi 7.1–7.2]] · [[hillier_lieberman.pdf#page=533|Hillier 12.2]]

Es la herramienta que dice **si un óptimo local es global**.

- **Conjunto convexo:** $S$ es convexo si para todo $x_1, x_2 \in S$ y $c \in [0,1]$, el punto $c\,x_1 + (1-c)\,x_2 \in S$. Es decir, el segmento que une dos puntos del conjunto queda adentro.
- **Función convexa (∪):** $f(c\,x_1 + (1-c)\,x_2) \le c\,f(x_1) + (1-c)\,f(x_2)$. La cuerda queda por encima del gráfico.
- **Función cóncava (∩):** la misma desigualdad con $\ge$. Además, $f$ es cóncava si y solo si $-f$ es convexa.

**Cómo probarlo**

| | Convexa (∪) | Cóncava (∩) |
|---|---|---|
| 1 variable | $f''(x) \ge 0$ para todo $x$ | $f''(x) \le 0$ para todo $x$ |
| $n$ variables, con la Hessiana $H$ | Todos los menores principales $\ge 0$ | Cada menor principal **no nulo** de orden $k$ tiene el signo de $(-1)^k$ |
| Versión estricta (menores principales dominantes $\lvert H_k\rvert$) | Todos $> 0$ | Alternan empezando negativo: $\lvert H_1\rvert<0,\ \lvert H_2\rvert>0,\dots$ |
| Caso $2\times2$, con $H = [[a, b], [b, c]]$ | $a \ge 0$, $c \ge 0$, $ac - b^2 \ge 0$ | $a \le 0$, $c \le 0$, $ac - b^2 \ge 0$ |

- Las funciones **lineales** son cóncavas y convexas a la vez.
- La suma de funciones convexas es convexa (lo mismo vale para cóncavas).

> [!warning] Ojo con el resumen de iara
> En la p. 53 tiene invertidas las condiciones: dice "cóncava ⇔ $f'' \ge 0$". Lo correcto es **cóncava ⇔ $f'' \le 0$** y **convexa ⇔ $f'' \ge 0$**.

> [!important] Teorema clave
> Si se **maximiza una función cóncava** (o se **minimiza una convexa**) sobre una **región factible convexa**, todo óptimo local es global. Por eso se define la **programación convexa**: maximizar $f$ cóncava sujeto a $g_i(x) \le b_i$ con todas las $g_i$ convexas.

## 3. Tipos de problemas de PNL
📎 [[hillier_lieberman.pdf#page=535|Hillier 12.3]] · [[resumen-fmiret.pdf#page=41|fmiret p. 40]]

| Tipo | Característica |
|---|---|
| No restringida | Solo $f(x)$, sin restricciones |
| Restringida linealmente | Restricciones lineales y $f$ no lineal |
| Cuadrática | Restricciones lineales y $f$ cuadrática (aparecen términos $x_j^2$ o $x_i x_j$) |
| Convexa | $f$ cóncava (máx) y $g_i$ convexas. Incluye a las anteriores cuando $f$ es cóncava |
| Separable | Caso particular de la convexa: $f(x) = \sum_j f_j(x_j)$ (cada término depende de una sola variable). Se aproxima con PL |
| No convexa | Todo lo que no es convexo. Solo se garantizan óptimos locales |
| Geométrica | $f$ y $g$ son "posinomios" (diseño en ingeniería). Con el cambio $x_j = e^{y_j}$ pasa a ser convexa |
| Fraccional | $f = f_1(x)/f_2(x)$ (productividad, rentabilidad). Se transforma en un problema estándar |

## 4. Una variable sin restricciones

### 4.1 Método analítico (condiciones de óptimo)
📎 [[resumen-tgrandi.pdf#page=39|tgrandi 9.2]] · [[resumen-iara.pdf#page=61|iara p. 55]] · [[resumen-fmiret.pdf#page=42|fmiret p. 41]]

Primero se buscan **candidatos** a óptimo y después se comparan los valores de $f$.

| Dónde buscar candidatos | Cómo clasificarlos |
|---|---|
| Puntos interiores con $f'(x) = 0$ | $f''(x) < 0$ → máx local; $f''(x) > 0$ → mín local. Si $f''(x) = 0$, se sigue derivando: si la primera derivada no nula es de orden **par**, se aplica el mismo criterio; si es **impar**, es un punto de inflexión |
| Puntos donde $f'$ no existe | Se compara con vecinos $x_1 < x < x_2$: si $f(x)$ es mayor o igual que ambos, máx local; si es menor o igual que ambos, mín local; si no, no es extremo |
| Extremos de $[a, b]$ | $f'(a) < 0$ → $a$ es máx local; $f'(a) > 0$ → $a$ es mín local; $f'(b) > 0$ → $b$ es máx local; $f'(b) < 0$ → $b$ es mín local |

El **óptimo global** se obtiene comparando $f$ en todos los candidatos. Si el dominio no está acotado, hay que revisar además los límites.

> [!example] Guía 3, ej. 1 ✅
> $f(x) = 48x - 60x^2 + x^3$. Entonces $f'(x) = 3x^2 - 120x + 48 = 0$, que da $x = 20 \pm 8\sqrt6$.
> - $x \approx 0{,}404$: $f'' = 6x - 120 \approx -117{,}6 < 0$ → **máximo local**, con $f \approx 9{,}66$.
> - $x \approx 39{,}596$: $f'' \approx +117{,}6 > 0$ → **mínimo local**, con $f \approx -30\,089{,}7$.
> - No hay óptimos globales: $f \to +\infty$ cuando $x \to +\infty$ y $f \to -\infty$ cuando $x \to -\infty$ (manda el término $x^3$).

### 4.2 Métodos numéricos
📎 [[resumen-tgrandi.pdf#page=28|tgrandi cap. 6]] · [[hillier_lieberman.pdf#page=540|Hillier 12.4]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=735|Taha 21.1.1]]

Todos necesitan un **punto (o intervalo) inicial**, una **dirección** y una **longitud de paso**, e iteran hasta una tolerancia. Hay dos grandes grupos:
- **Directos:** solo evalúan $f$ (sección áurea, dicotómico). Sirven aunque $f$ no sea derivable.
- **Indirectos:** usan derivadas (bisección, Newton).

#### Sección áurea (método directo)
- **Requisito:** $f$ **unimodal** en $[a, b]$, es decir, con un único máximo: crece hasta $x^*$ y después decrece. No hace falta que sea cóncava.
- Se usa $r = \frac{\sqrt5 - 1}{2} \approx 0{,}618$, la raíz positiva de $r^2 + r - 1 = 0$. Con ese valor, uno de los puntos nuevos **coincide** con uno de la iteración anterior, así que en cada iteración se evalúa $f$ **una sola vez**.
- Puntos de prueba:
$$x_1 = b - r\,(b-a) \qquad x_2 = a + r\,(b-a) \qquad (x_1 < x_2)$$
- **Para maximizar:**
  - Si $f(x_1) < f(x_2)$, el nuevo intervalo es $(x_1, b]$ y el viejo $x_2$ pasa a ser el nuevo $x_1$.
  - Si $f(x_1) \ge f(x_2)$, el nuevo intervalo es $[a, x_2)$ y el viejo $x_1$ pasa a ser el nuevo $x_2$.
- **Para minimizar** se invierte: se conserva el lado donde $f$ es **menor**.
- En cada iteración el intervalo se multiplica por $r$: $L_k = r^k (b - a)$. Las **iteraciones necesarias** para llegar a una longitud $\varepsilon$ son:
$$k \ge \frac{\ln\big(\varepsilon/(b-a)\big)}{\ln r}$$
- Se para cuando $b - a < \varepsilon$. La respuesta es el intervalo final (o su punto medio, o el mejor punto evaluado).
- El **método dicotómico** (Taha) usa $x_{1,2} = \frac{a + b \mp \Delta}{2}$. Necesita dos evaluaciones nuevas por iteración, así que la sección áurea es más eficiente.

> [!example] Guía 3, ej. 6 (Hughesco) ✅
> Maximizar la vida útil $t(p)$ en $[0, 600]$ psi, con precisión 50. Iteraciones necesarias: $k \ge \ln(50/600)/\ln 0{,}618 = 5{,}16$, o sea **6**. Los 7 valores de la tabla del enunciado son justamente los puntos que pide el método.
>
> | It. | Intervalo | $x_1 \to t$ | $x_2 \to t$ | Comparación | Nuevo intervalo (longitud) |
> |---|---|---|---|---|---|
> | 1 | [0, 600] | 229 → 39 | 371 → 81 | $t(x_1) < t(x_2)$ | (229, 600] (371) |
> | 2 | (229, 600] | 371 → 81 *(reusa)* | 458 → 82 | $<$ | (371, 600] (229) |
> | 3 | (371, 600] | 458 → 82 *(reusa)* | 513 → 79 | $\ge$ | (371, 513) (142) |
> | 4 | (371, 513) | 425 → 84 | 458 → 82 *(reusa)* | $\ge$ | (371, 458) (87) |
> | 5 | (371, 458) | 404 → 85 | 425 → 84 *(reusa)* | $\ge$ | (371, 425) (54) |
> | 6 | (371, 425) | 392 → 84 | 404 → 85 *(reusa)* | $<$ | **(392, 425)** (33 < 50) |
>
> **Resultado:** $p^* \in (392, 425)$. El mejor valor observado es $p \approx 404$ psi, con $t = 85$ min.

#### Bisección (método indirecto)
Se aplica cuando $f$ es cóncava: el **signo de $f'$** indica hacia qué lado está el óptimo.
1. Se prueba el punto medio $x' = (\underline{x} + \bar x)/2$.
2. Si $f'(x') \ge 0$, se hace $\underline{x} = x'$; si $f'(x') \le 0$, se hace $\bar x = x'$.
3. Se para cuando $\bar x - \underline{x} \le 2\varepsilon$.

Cada iteración solo divide el intervalo a la mitad, así que es **lento**. En el ejemplo de Hillier, $f = 12x - 3x^4 - 2x^6$ en $[0, 2]$ con $\varepsilon = 0{,}01$, llega a $x^* \approx 0{,}836$ en 7 iteraciones.

#### Newton (1 variable)
Aproxima $f$ con el polinomio de Taylor de 2° orden alrededor de $x_k$ y optimiza esa parábola:

$$x_{k+1} = x_k - \frac{f'(x_k)}{f''(x_k)}$$

- La misma fórmula sirve para máx y mín: en el fondo es Newton-Raphson buscando la raíz de $f'$.
- Se para cuando $\lvert x_{k+1} - x_k\rvert \le \varepsilon$ (o cuando $\lvert f'\rvert$ es muy chico).
- Converge **muy rápido**, pero necesita $f'' \ne 0$, puede no converger si se arranca lejos y puede caer en un mínimo cuando se busca un máximo. Por eso conviene revisar el signo de $f''$.
- Ejemplo de Hillier, con la misma $f$ que en bisección y $x_1 = 1$: $1 \to 0{,}875 \to 0{,}84003 \to 0{,}83763 \to 0{,}83762$ ✅. Son 4 iteraciones, contra unas 20 de la bisección para la misma precisión.

> [!warning] Fórmula de tgrandi
> tgrandi escribe $x_{n+1} = x_n - f(x_n)/f'(x_n)$. Esa es la versión para **encontrar raíces**. Para **optimizar** se aplica a $f'$, lo que da $x_{n+1} = x_n - f'(x_n)/f''(x_n)$.

## 5. Varias variables sin restricciones

### 5.1 Condiciones analíticas
📎 [[resumen-tgrandi.pdf#page=32|tgrandi 7.2–7.3]] · [[resumen-fmiret.pdf#page=43|fmiret p. 42]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=714|Taha 20.1.1]]

- **Condición necesaria (1er orden):** $\nabla f(x^*) = 0$. Los puntos que la cumplen son los puntos estacionarios.
- **Condición suficiente (2° orden):** se miran los menores principales dominantes de la Hessiana en $x^*$:
  - todos $> 0$ → **mínimo local**;
  - alternan empezando negativo ($\lvert H_1\rvert<0,\ \lvert H_2\rvert>0,\ \dots$) → **máximo local**;
  - no nulos pero con otro patrón → **punto silla**;
  - si alguno es $= 0$, el criterio no concluye.
- Si $f$ es **cóncava en todo el dominio**, cualquier punto estacionario es **máximo global**.

> [!example] Guía 3, ej. 10 (monopolio en dos mercados) ✅
> $B(q_1, q_2) = 60q_1 + (100 - q_2)\,q_2 - (q_1 + q_2)^2$.
> - Condiciones: $\partial B/\partial q_1 = 60 - 2(q_1 + q_2) = 0$ y $\partial B/\partial q_2 = 100 - 2q_2 - 2(q_1 + q_2) = 0$.
> - Resultado: $q_1 + q_2 = 30$, de donde $q_2 = 20$ y $q_1 = 10$. Entonces $p_2 = 80$ y **$B = 1300$**.
> - Hessiana: $H = [[-2, -2], [-2, -4]]$, con $\lvert H_1\rvert = -2 < 0$ y $\lvert H_2\rvert = 4 > 0$. $B$ es cóncava, así que es un **máximo global**.

### 5.2 Método del gradiente (ascenso más rápido)
📎 [[hillier_lieberman.pdf#page=545|Hillier 12.5]] · [[resumen-tgrandi.pdf#page=29|tgrandi 6.3]] · [[resumen-fmiret.pdf#page=44|fmiret p. 43]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=739|Taha 21.1.2]]

Recibe varios nombres: "búsqueda del gradiente" (Hillier), "ascenso más pronunciado" o "ascenso acelerado" (Winston y la guía) y "ascenso escalonado" (tgrandi).

**Idea:** $\nabla f(x)$ apunta hacia donde $f$ crece más rápido. Se avanza en esa dirección **hasta que $f$ deja de crecer** y ahí se recalcula el gradiente. Es como subir una montaña sin ver la cima.

1. Se elige un punto inicial $x^0$ y una tolerancia $\varepsilon$.
2. Se calcula $\nabla f(x^k)$. Si $\lvert \partial f/\partial x_j\rvert \le \varepsilon$ para todo $j$, se para.
3. Se escribe $x^k + t\,\nabla f(x^k)$, con cada coordenada en función de $t$, y se reemplaza en $f$. Queda $\varphi(t)$, una función de **una sola variable**.
4. Se busca $t^* = \arg\max_{t \ge 0} \varphi(t)$: con $\varphi'(t) = 0$, o con sección áurea o Newton si es difícil.
5. Se actualiza $x^{k+1} = x^k + t^*\,\nabla f(x^k)$ y se vuelve al paso 2.

- **Para minimizar** se avanza en sentido contrario: $x^{k+1} = x^k - t^*\,\nabla f(x^k)$.
- Dos direcciones consecutivas son perpendiculares, por eso el camino hace **zigzag** hacia el óptimo.

> [!example] Guía 3, ej. 8 ✅
> Maximizar $f = 2x_1x_2 + x_2 - x_1^2 - 2x_2^2$, con $\nabla f = (2x_2 - 2x_1,\ 2x_1 + 1 - 4x_2)$, desde $(1, 1)$ y con $\varepsilon = 0{,}25$.
>
> | $k$ | $x^k$ | $\nabla f(x^k)$ | $x^k + t\nabla f$ | $\varphi(t)$ | $t^*$ | $x^{k+1}$ |
> |---|---|---|---|---|---|---|
> | 0 | (1, 1) | (0, −1) | (1, 1 − t) | $t - 2t^2$ | 1/4 | (1, 3/4) |
> | 1 | (1, 3/4) | (−1/2, 0) | (1 − t/2, 3/4) | $\tfrac18 + \tfrac t4 - \tfrac{t^2}4$ | 1/2 | (3/4, 3/4) |
> | 2 | (3/4, 3/4) | (0, −1/2) | (3/4, 3/4 − t/2) | $\tfrac3{16} + \tfrac t4 - \tfrac{t^2}2$ | 1/4 | (3/4, 5/8) |
> | 3 | (3/4, 5/8) | (−1/4, 0) | — | — | — | **Fin**: $\lvert \partial f/\partial x_j\rvert \le 0{,}25$ |
>
> - **a)** Solución aproximada: $(0{,}75;\ 0{,}625)$, con $f = 7/32$.
> - **b)** Solución exacta: $\nabla f = 0$ da $x_1 = x_2$ y $2x_1 + 1 - 4x_1 = 0$, o sea **$(1/2, 1/2)$**, con $f = 1/4$. La Hessiana $[[-2, 2], [2, -4]]$ es definida negativa, así que es máximo global.
> - **c)** Continuando el zigzag: $(5/8, 5/8) \to (5/8, 9/16) \to (9/16, 9/16) \to \dots \to (1/2, 1/2)$.

### 5.3 Newton-Raphson multivariable
📎 [[hillier_lieberman.pdf#page=549|Hillier 12.5]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=717|Taha 20.1.2]] · [[resumen-iara.pdf#page=64|iara p. 58]]

$$x^{k+1} = x^k - \big[H(x^k)\big]^{-1}\,\nabla f(x^k) \qquad (x \text{ y } \nabla f \text{ como vectores columna})$$

- Sale de la aproximación de Taylor de 2° orden.
- Si $f$ es **cuadrática**, llega al óptimo exacto en **una iteración**.
- Necesita que $H$ sea invertible, e invertirla es costoso. Los métodos **cuasi-Newton** aproximan $H^{-1}$ (Hillier).

> [!example] Guía 3, ej. 7 ✅
> $z = -(x_1 - \sqrt5)^2 - (x_2 - \pi)^2 - 10$, con $\nabla z = (-2(x_1 - \sqrt5),\ -2(x_2 - \pi))$ y $H = -2I$. Desde $(0, 0)$, $\nabla z = (2\sqrt5,\ 2\pi)$.
> - **Gradiente:** $t^* = 1/2$ lleva a $(\sqrt5, \pi)$ en un solo paso. Las curvas de nivel son círculos, así que el gradiente apunta directo al centro.
> - **Newton:** $x^1 = 0 - (-\tfrac12 I)(2\sqrt5, 2\pi) = (\sqrt5, \pi)$, también en un paso (porque $z$ es cuadrática).
> - Máximo: $z^* = -10$ en $(2{,}236;\ 3{,}142)$.

> [!tip] LINGO (iara)
> LINGO resuelve PNL pero **nunca asegura que el óptimo sea global**. Hay que verificarlo con convexidad o con KKT. Los $\lambda$ se leen en la columna de precios duales (precios sombra).

## 6. Restricciones de igualdad (Lagrange)
📎 [[resumen-fmiret.pdf#page=45|fmiret p. 44–49 (con notas de la clase 26/10)]] · [[resumen-tgrandi.pdf#page=33|tgrandi 7.4 y 9.4]] · [[resumen-iara.pdf#page=65|iara p. 59]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=719|Taha 20.2.1]]

Problema: $\max/\min\ f(x)$ s.a. $g_i(x) = b_i$, con $i = 1,\dots,m$ y $m < n$. Se arma la **función de Lagrange**:

$$L(x, \lambda) = f(x) + \sum_{i=1}^{m} \lambda_i\,\big[b_i - g_i(x)\big]$$

**Condiciones de 1er orden:** son $n + m$ ecuaciones con $n + m$ incógnitas.

$$\frac{\partial L}{\partial x_j} = \frac{\partial f}{\partial x_j} - \sum_i \lambda_i \frac{\partial g_i}{\partial x_j} = 0 \qquad\qquad \frac{\partial L}{\partial \lambda_i} = b_i - g_i(x) = 0 \ \text{(devuelve las restricciones)}$$

**Lectura geométrica:** $\nabla f = \sum \lambda_i \nabla g_i$. El gradiente de $f$ es combinación lineal de los gradientes de las restricciones. Con una sola restricción, la curva de nivel de $f$ es tangente a la restricción.

**Condición de 2° orden: hessiano orlado** (clase 26/10; Taha)
- Con $n = 2$ y una restricción:
$$\bar H = \begin{vmatrix} 0 & g_x & g_y \\ g_x & L_{xx} & L_{xy} \\ g_y & L_{yx} & L_{yy} \end{vmatrix} \qquad \lvert\bar H\rvert > 0 \Rightarrow \textbf{máximo},\quad \lvert\bar H\rvert < 0 \Rightarrow \textbf{mínimo},\quad \lvert\bar H\rvert = 0 \Rightarrow \text{no concluye}$$
- Con $n$ variables y una restricción, se miran los menores orlados $\lvert\bar H_2\rvert$ (3×3), $\lvert\bar H_3\rvert$ (4×4), …, $\lvert\bar H_n\rvert$:
  - todos $< 0$ → **mínimo**;
  - alternan empezando positivo ($\lvert\bar H_2\rvert>0,\ \lvert\bar H_3\rvert<0,\dots$, o sea $(-1)^k\lvert\bar H_k\rvert > 0$) → **máximo**.
- **Atajo (Winston):** si $f$ es cóncava (máx) o convexa (mín) y las $g_i$ son **lineales**, cualquier punto que cumpla las condiciones de 1er orden es óptimo.

**Interpretación de $\lambda$ como precio sombra:** $\lambda_i = \dfrac{\partial z^*}{\partial b_i}$. Si $b_i$ aumenta en $\Delta$ (pequeño), $z^*$ cambia aproximadamente $\Delta \cdot \lambda_i$. Para que valga esta lectura hay que escribir $\lambda\,[b - g(x)]$ y **no** $\lambda\,[g(x) - b]$: si no, se invierte el signo (clase).

> [!example] Ejemplo de clase (fmiret, clase 26/10) ✅
> $\max\ U = x_1x_2 + 2x_1$ s.a. $4x_1 + 2x_2 = 60$, con $L = x_1x_2 + 2x_1 + \lambda(60 - 4x_1 - 2x_2)$.
> - Condiciones: $x_2 + 2 - 4\lambda = 0$, $x_1 - 2\lambda = 0$ y $4x_1 + 2x_2 = 60$.
> - Resultado: **$x_1 = 8$, $x_2 = 14$, $\lambda = 4$, $U = 128$**.
> - Hessiano orlado: $\bar H = [[0, 4, 2], [4, 0, 1], [2, 1, 0]]$, con $\lvert\bar H\rvert = 16 > 0$ → **máximo**.
> - Control de $\lambda$: con $b = 61$ queda $U^* = 132{,}03$, o sea $\Delta U \approx 4{,}03 \approx \lambda$.

> [!example] Guía 3, ej. 12 (Quilmes) ✅
> Modelo (descontando la promoción del beneficio): $\max\ z = (9-4)\,6\sqrt{x_1} + (10-5)\,4\sqrt{x_2} - x_1 - x_2$ s.a. $x_1 + x_2 = 100$. La restricción está activa: sin ella, el óptimo sería $x_1 = 225$, $x_2 = 100$.
> - Condiciones: $\frac{15}{\sqrt{x_1}} - 1 = \lambda = \frac{10}{\sqrt{x_2}} - 1$, de donde $x_1 = 2{,}25\,x_2$.
> - Resultado: **$x_1 \approx 69{,}23$, $x_2 \approx 30{,}77$**, beneficio $\approx \$260{,}56$, **$\lambda \approx 0{,}80$**.
> - **c)** Un peso más de promoción sube el beneficio unos **\$0,80**. Si el modelo no descuenta la promoción, $\lambda \approx 1{,}80$. Conviene aclarar el supuesto en el parcial.

## 7. Restricciones de desigualdad (KKT)
📎 [[resumen-tgrandi.pdf#page=42|tgrandi 9.5]] · [[resumen-fmiret.pdf#page=47|fmiret p. 46]] · [[resumen-iara.pdf#page=66|iara p. 60–62]] · [[hillier_lieberman.pdf#page=550|Hillier 12.6]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=729|Taha 20.2.2]]

**Preparación:** todas las restricciones se llevan a la forma $g_i(x) \le b_i$.
- Las de $\ge$ se multiplican por $-1$.
- Las de $=$ se separan en dos desigualdades, o se dejan con Lagrange y $\lambda$ libre.

**Condiciones necesarias de Karush-Kuhn-Tucker**

| | Maximización | Minimización |
|---|---|---|
| Estacionariedad | $\dfrac{\partial f}{\partial x_j} - \sum_i \lambda_i \dfrac{\partial g_i}{\partial x_j} = 0$ | $\dfrac{\partial f}{\partial x_j} + \sum_i \lambda_i \dfrac{\partial g_i}{\partial x_j} = 0$ |
| Holgura complementaria | $\lambda_i\,[b_i - g_i(x)] = 0$ | $\lambda_i\,[b_i - g_i(x)] = 0$ |
| Signo | $\lambda_i \ge 0$ | $\lambda_i \ge 0$ |
| Factibilidad | $g_i(x) \le b_i$ | $g_i(x) \le b_i$ |

- **Con $x_j \ge 0$** (tgrandi, Hillier): en maximización, la estacionariedad pasa a ser $\frac{\partial f}{\partial x_j} - \sum \lambda_i \frac{\partial g_i}{\partial x_j} \le 0$, y además $x_j \cdot \big[\frac{\partial f}{\partial x_j} - \sum \lambda_i \frac{\partial g_i}{\partial x_j}\big] = 0$. En minimización es igual, pero con $+$ y $\ge 0$.
- **Holgura complementaria = multiplicador × sobrante = 0.** Si una restricción **no está activa** (sobra recurso), su precio sombra es $\lambda_i = 0$. Si $\lambda_i > 0$, la restricción está activa.
- **De dónde sale (iara):** se agrega una holgura $s_i^2$, que garantiza no negatividad, y se aplica Lagrange. $\partial L/\partial s_i = -2\lambda_i s_i = 0$ da la holgura complementaria, y $s_i^2 \ge 0$ da $g_i(x) \le b_i$.

**Condiciones suficientes:**
- **máximo:** $f$ cóncava y $g_i$ convexas;
- **mínimo:** $f$ convexa y $g_i$ convexas.

En esos casos, todo punto KKT es **óptimo global**.

> [!warning] Regularidad
> KKT es necesaria solo si se cumplen ciertas **condiciones de regularidad** (Hillier). En el "tercer ejemplo de Charly" (iara), en el óptimo $\nabla f$ **no** se puede escribir como combinación lineal de los gradientes de las restricciones activas, y KKT falla.

**Estrategia práctica para resolver**
1. Resolver **sin restricciones**. Si el punto es factible, es la solución (todos los $\lambda = 0$).
2. Si viola alguna restricción, suponerla **activa** y aplicar Lagrange. Verificar que $\lambda \ge 0$ y que se cumplan las demás restricciones.
3. Si no funciona, probar otras combinaciones de restricciones activas: es el análisis **por casos** (Hillier).

> [!example] Guía 3, ej. 11 (publicidad) ✅
> $x$ = minutos de TV, $y$ = minutos de radio. $\max f = -2x^2 - y^2 + xy + 8x + 3y$ s.a. $3x + y \le 10$ (en miles de \$), $x, y \ge 0$.
> 1. **Sin restricciones:** $\nabla f = (-4x + y + 8,\ x - 2y + 3) = 0$ da $(19/7,\ 20/7) \approx (2{,}71;\ 2{,}86)$. Cuesta $3x + y = 11 > 10$: no es factible.
> 2. **Presupuesto activo:** con $L = f + \lambda(10 - 3x - y)$ se obtiene **$x = 69/28 \approx 2{,}46$ min de TV, $y = 73/28 \approx 2{,}61$ min de radio, $\lambda = 1/4$**. Como $\lambda \ge 0$, se cumple KKT.
> 3. **Suficiencia:** $H = [[-4, 1], [1, -2]]$, con $\lvert H_1\rvert = -4$ y $\lvert H_2\rvert = 7$, así que $f$ es cóncava. La restricción es lineal, por lo que el óptimo es **global**. Ingreso: $f^* = 841/56 \approx 15{,}018$, o sea **≈ \$15.018**.
> 4. **c)** $\lambda = 0{,}25$: cada \$1000 extra suman unos \$250 de ingreso en el margen. En realidad, con \$11.000 ya se alcanza el óptimo sin restricción ($\lambda$ cae a 0) y el ingreso sube solo **\$125**. En los dos casos el ingreso extra es menor que los \$1000 que cuesta: **no conviene gastarlos**.

> [!example] Guía 3, ej. 13 (caja postal) ✅
> $\max V = xyz$ s.a. $z + 2x + 2y \le 108$ (altura más perímetro de la base). Por simetría $x = y$, y la restricción queda activa.
> - Resultado: **$x = y = 18$ cm, $z = 36$ cm, $V = 11.664\ \text{cm}^3$**.
> - $\lambda = 324\ \text{cm}^3$ por cm extra de límite.

## 8. Otros tipos de PNL
📎 [[hillier_lieberman.pdf#page=554|Hillier 12.7–12.10]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=742|Taha 21.2]]

Es material de los libros; no aparece en las guías.
- **Cuadrática:** con $f$ cuadrática cóncava y restricciones lineales, las condiciones KKT quedan lineales y se resuelven con un símplex modificado.
- **Separable:** cada $f_j(x_j)$ se aproxima con tramos lineales y se resuelve con símplex.
- **Convexa:** algoritmo de Frank-Wolfe (linealiza $f$ en cada iteración) y SUMT (función barrera).
- **No convexa:** solo se encuentran óptimos locales. Conviene probar con varios puntos iniciales o usar optimizadores globales (LINGO).

## 9. Guía 3 — método y resultados
Las resoluciones son propias y están verificadas numéricamente. Sirven para chequear lo que hagas vos.

| Ej. | Tema | Método | Resultado ✅ |
|---|---|---|---|
| 1 | 1 variable | $f' = 0$ y $f''$ | Máx local en $x = 20 - 8\sqrt6 \approx 0{,}404$; mín local en $x = 20 + 8\sqrt6 \approx 39{,}6$; sin óptimos globales |
| 2 | Convexidad | $f''$ | a) cóncava ($f'' = -2$); b) convexa ($12(x^2+1)$); c) ninguna: $6(2x-1)$ es cóncava para $x \le 1/2$ y convexa para $x \ge 1/2$; d) convexa ($2(6x^2+1)$); e) ninguna: $6x(2x+1)$ es cóncava en $[-1/2, 0]$ y convexa fuera de ese intervalo |
| 3 | Intervalos | $f'' = 8/x^3$ | Convexa para $x > 0$, cóncava para $x < 0$ |
| 4 | Sección áurea | — | Ojo: en $(0, 2]$, $f' = 1 - 4/x^2 < 0$, así que $f$ es decreciente y no acotada cerca de 0. El método se va al extremo izquierdo. Conviene chequear la unimodalidad antes de aplicarlo |
| 5 | Sección áurea (mín) | Comparaciones invertidas | 7 iteraciones, intervalo final $[-0{,}056;\ 0{,}013]$, así que $x^* = 0$ |
| 6 | Sección áurea con datos | Ver la tabla de §4.2 | $p^* \in (392, 425)$, $p \approx 404$ psi ($t = 85$ min) |
| 7 | Ascenso + Newton | — | Los dos métodos llegan en 1 iteración a $(\sqrt5, \pi)$, con $z = -10$ |
| 8 | Gradiente | Ver la tabla de §5.2 | a) $(0{,}75;\ 0{,}625)$; b) exacta $(0{,}5;\ 0{,}5)$ |
| 9 | Localización del hospital | Minimizar $\sum$ de distancias euclídeas (función convexa), con gradiente | Con D1 = (2, 0), D2 = (8, 3), D3 = (0, 6) leídos de la figura: hospital en ≈ (2,92; 2,28) y $\sum$ ≈ 12,32 km. b) El óptimo queda dentro del triángulo, así que nadie camina más que el lado mayor, $\sqrt{73} \approx 8{,}54$ km (el máximo real es ≈ 5,13 km, desde D2) |
| 10 | 2 variables sin restricciones | $\nabla = 0$ y Hessiana | $q_1 = 10$, $q_2 = 20$, $B = 1300$ |
| 11 | KKT / Lagrange | Ver §7 | TV ≈ 2,46 min, radio ≈ 2,61 min, ingreso ≈ \$15.018. No conviene gastar \$1000 más |
| 12 | Lagrange | Ver §6 | $x_1 \approx 69{,}23$, $x_2 \approx 30{,}77$, $\lambda \approx 0{,}80$ |
| 13 | Lagrange / KKT | Ver §7 | $18 \times 18 \times 36$ cm, $V = 11.664$ cm³ |

---

# Parte II — Modelos de Pronósticos

## 10. Conceptos
📎 [[Modelos de Pronósticos.pdf#page=3|Diapos 3–10]] · [[resumen-iara.pdf#page=69|iara p. 63–65]] · [[resumen-tgrandi.pdf#page=45|tgrandi cap. 10]]

- **Pronosticar** es predecir el futuro (en general, la demanda) para tomar decisiones **operativas** y **estratégicas**. Ejemplos: pacientes de un hospital, alumnos de un sistema escolar, pasajeros por ruta de una aerolínea.
- **Idea:** construir un modelo con **datos del pasado** y usarlo para pronosticar la demanda futura.
- Hay dos tipos de modelos:
  - **Series de tiempo:** usan solo los valores pasados de la misma variable.
  - **Causales:** explican la variable con **otras** variables, mediante regresión.
- Una **serie de tiempo** tiene datos **equiespaciados** y hasta cuatro componentes: **nivel**, **tendencia**, **estacionalidad** y **error aleatorio**. A veces también aparece un componente **cíclico** (por ejemplo, el ciclo económico), que es más difícil de detectar.

| Modelo | Demanda | Pronóstico | Cuándo se usa |
|---|---|---|---|
| Nivel | $D_t = A + \varepsilon_t$ | $F_t = A$ | Demanda estable alrededor de un valor $A$ |
| Tendencia | $D_t = A + Bt + \varepsilon_t$ | $F_t = A + Bt$ | Crece o decrece en el tiempo |
| Estacional | $D_t = A\cdot S_k + \varepsilon_t$ | $F_t = A \cdot S_k$ | Patrón que se repite (por ejemplo, cada año) |
| Estacional con tendencia | $D_t = (A + Bt)\,S_k + \varepsilon_t$ | $F_t = (A + Bt)\,S_k$ | Tendencia y estacionalidad juntas |

$D_t$ es la demanda real, $F_t$ el pronóstico (*forecast*) y $\varepsilon_t$ un error aleatorio de media 0, sin explicación causal. $A$ es el **nivel** (la ordenada al origen), no necesariamente el primer dato.

| Modelo | Métodos |
|---|---|
| Nivel | Promedio, medias móviles, suavizado exponencial |
| Tendencia | Regresión lineal ($x = t$), Holt |
| Tendencia y estacionalidad | Winters |
| Causal | Regresión simple o múltiple |

## 11. Medidas de rendimiento
📎 [[Modelos de Pronósticos.pdf#page=11|Diapos 11–19]] · [[resumen-iara.pdf#page=72|iara p. 66–68]]

Antes de usar un modelo, se mide cómo **habría funcionado sobre los datos históricos**. El error de cada período es $e_t = D_t - F_t$. Su promedio no sirve como medida: los errores $\{1, -1\}$ y $\{5, -5\}$ promedian 0 los dos.

| Medida | Fórmula | Qué mide |
|---|---|---|
| **RMSE** | $\sqrt{\sum (D_t - F_t)^2 / n}$ | Desvío estándar del error. Castiga más los errores grandes y sirve para armar intervalos de confianza |
| **MAE** | $\sum \lvert D_t - F_t\rvert / n$ | Error promedio, en las unidades de la demanda |
| **MAPE** | $\frac{100}{n}\sum \lvert D_t - F_t\rvert / D_t$ | Error promedio en %. Permite comparar series distintas |
| **Sesgo** | $\sum (D_t - F_t) / n$ | $> 0$: el modelo **subestima**; $< 0$: **sobreestima**. Lo ideal es ≈ 0 |

> [!example] Ejemplo de las diapositivas ✅
> | $t$ | 1 | 2 | 3 | 4 | 5 | 6 |
> |---|---|---|---|---|---|---|
> | $D_t$ | 50 | 66 | 75 | 70 | 68 | 72 |
> | $F_t$ | 54 | 61 | 74 | 68 | 73 | 71 |
> | $e_t$ | −4 | 5 | 1 | 2 | −5 | 1 |
>
> - RMSE $= \sqrt{72/6} = 3{,}464$
> - MAE $= 18/6 = 3$
> - MAPE $= 28{,}51/6 = 4{,}75\%$. La diapositiva dice 4,77 porque en la fila 3 pone 1,43 % en lugar de $1/75 = 1{,}33\%$.
> - Sesgo $= 0$

**Intervalo de confianza:** $F_t \pm z \cdot \text{RMSE}$, donde $z$ deja un área $1 - \alpha/2$ a su izquierda en la normal estándar.

| Confianza | 90 % | 95 % | 99 % |
|---|---|---|---|
| $z$ | 1,645 | 1,96 | 2,576 |

Ejemplo: $F_7 = 72$ al 95 % da $72 \pm 1{,}96 \cdot 3{,}464 = [65{,}21;\ 78{,}79]$.

> [!tip] Comparar modelos de forma justa
> Las medidas tienen que calcularse sobre los **mismos períodos**. Medias móviles con $k = 6$ recién pronostica desde $t = 6$, mientras que el suavizado exponencial arranca en $t = 1$.

## 12. Modelo de nivel
📎 [[Modelos de Pronósticos.pdf#page=20|Diapos 20–30]] · [[resumen-iara.pdf#page=74|iara p. 68–70]] · Excel: hojas "Good Tire Media Móvil" y "Good Tire Suavización"

$D_t = A + \varepsilon_t$. El pronóstico para **todos** los períodos futuros es el mismo: la estimación de $A$.

**1. Promedio histórico:** $A = \bar D$. Con las ventas de cubiertas de Good Tire (1980–1992), $F_{13} = 92.677$. Si después llega $D_{13} = 94.400$, $F_{14} = 92.800$. Cambia **muy lentamente**.

**2. Medias móviles (k):**
$$F_{t+1} = \frac{D_t + D_{t-1} + \dots + D_{t-k+1}}{k}$$
- Ejemplo con $k = 5$: $F_{13} = (86.000 + 76.900 + 106.800 + 98.500 + 85.000)/5 = 90.640$. Si $D_{13} = 94.400$, $F_{14} = 92.320$.
- Un $k$ grande da un pronóstico suave pero lento; un $k$ chico reacciona rápido pero sigue el ruido. Todos los datos de la ventana pesan lo mismo.
- $k$ se elige comparando medidas de error ✅:

| $k$ | 3 | 4 | 5 | 6 |
|---|---|---|---|---|
| RMSE | 11.916 | 12.749 | 12.322 | **11.246** |
| MAPE | 11,27 | 11,77 | 11,49 | **10,94** |

**3. Suavizado exponencial (α):** usa el error del último período para corregir el pronóstico.
$$F_t = F_{t-1} + \alpha\,(D_{t-1} - F_{t-1}) = \alpha D_{t-1} + (1-\alpha)\,F_{t-1}$$
- **Por qué se llama exponencial:** al desarrollar la fórmula queda $F_t = \alpha D_{t-1} + \alpha(1-\alpha) D_{t-2} + \alpha(1-\alpha)^2 D_{t-3} + \dots$ Los pesos caen exponencialmente hacia el pasado.
- Un $\alpha$ cercano a 1 reacciona rápido (pero copia el ruido); uno cercano a 0 es suave pero lento. Lo habitual es $\alpha \in [0{,}1;\ 0{,}3]$ (tgrandi).
- **Inicialización** (Excel de clase): $F_1 = D_0$.
- Ejemplo de la diapositiva: si $A = 94.000$ y la demanda real fue 94.400, el error es 400 y el nuevo pronóstico es $94.000 + \alpha \cdot 400$.
- $\alpha$ se elige por error ✅ (se reproduce el valor de la diapositiva usando $F_1 = D_0$):

| α | 0,1 | 0,2 | 0,3 |
|---|---|---|---|
| RMSE | 14.553,7 | 12.838,4 | **12.148,2** |

- **Ventajas:** necesita pocos datos y se adapta a los cambios.
- **Desventaja:** si la serie tiene tendencia, el pronóstico **se queda atrás** de forma sistemática. Para eso está Holt.

## 13. Regresión lineal
📎 [[Modelos de Pronósticos.pdf#page=31|Diapos 31–44]] · [[resumen-iara.pdf#page=80|iara p. 74–81]] · [[resumen-tgrandi.pdf#page=35|tgrandi cap. 8]]

- Es parte de la estadística inferencial y se usa para **explicar** (probar hipótesis) y para **pronosticar**.
- **Regresión vs correlación:** la regresión describe cómo depende $y$ de una o más $x$; la correlación solo mide el grado de asociación lineal.
- Puede ser **simple** (una $x$) o **múltiple** (varias). Las categorías se incorporan con **variables dummy** (0/1).

**Mínimos cuadrados:** el modelo es $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$ y se busca $\min \sum \varepsilon_i^2$. Es un **PNL sin restricciones**: igualando a 0 las derivadas respecto de $\beta_0$ y $\beta_1$ se obtiene

$$\hat\beta_1 = \frac{\sum (x_i - \bar x)(y_i - \bar y)}{\sum (x_i - \bar x)^2} \qquad \hat\beta_0 = \bar y - \hat\beta_1 \bar x$$

En la regresión múltiple ($y = \beta_0 + \beta_1x_1 + \dots + \beta_kx_k + \varepsilon$), $\beta_j \approx \partial y/\partial x_j$: es lo que sube $y$ cuando $x_j$ aumenta 1 y las demás variables quedan fijas.

**¿Es bueno el modelo?**
- $R^2 = \text{SSR}/\text{SST}$, con $\text{SSR} = \sum(\hat y_i - \bar y)^2$ y $\text{SST} = \sum (y_i - \bar y)^2$. Es el % de la variación de $y$ que explican las $x$; en la regresión simple vale $\rho_{xy}^2$.
- **p-valores:** el nivel al que se puede rechazar $H_0: \beta_j = 0$. Un p-valor chico indica que la variable es significativa.
- **Error estándar:** $s_e = \sqrt{\text{SSE}/(n - k - 1)}$ (en la simple, $n - 2$). Alrededor del 68 % de los datos cae a menos de $s_e$ del valor predicho y el 95 % a menos de $2s_e$.

**Supuestos**

| Supuesto | Qué significa | Cómo detectarlo y qué hacer |
|---|---|---|
| Homocedasticidad | La varianza del error no depende de $x$ | Si los residuos se abren en "embudo", hay heterocedasticidad: usar $\ln y$ o $\sqrt y$ como respuesta |
| Normalidad | El error tiene distribución normal | Histograma de los residuos |
| Independencia | Los errores no están autocorrelacionados (aparece sobre todo con datos en el tiempo) | Contar los cambios de signo de los residuos: muchos menos de la mitad indica autocorrelación **positiva**; muchos más, **negativa**; alrededor de la mitad está bien |
| No multicolinealidad | Las $x$ no deben estar muy correlacionadas entre sí | Los coeficientes quedan imprecisos y hasta con el signo cambiado. Sacar o combinar variables. Ej.: en Auto-MPG, *displacement* y *horsepower* no conviene usarlas juntas |

Para el **modelo de tendencia** se usa $x = t$: así se estiman $A$ (ordenada) y $B$ (pendiente). El problema es que todos los datos pesan lo mismo, y si $A$ o $B$ cambian, la regresión tarda mucho en reflejarlo. Por eso existe Holt.

## 14. Holt (tendencia)
📎 [[Modelos de Pronósticos.pdf#page=48|Diapos 47–50]] · [[resumen-iara.pdf#page=76|iara p. 70–71]] · Excel: hoja "Maple Heights Holt"

Después de observar $D_t$, con las constantes $\alpha$ (nivel) y $\beta$ (tendencia):

$$L_t = F_t + \alpha\,(D_t - F_t) \qquad B_t = B_{t-1} + \beta\,\big[(L_t - L_{t-1}) - B_{t-1}\big] \qquad F_{t+1} = L_t + B_t \qquad F_{t+k} = L_t + k\,B_t$$

- **Forma equivalente:** $L_t = \alpha D_t + (1-\alpha)(L_{t-1} + B_{t-1})$ y $B_t = \beta(L_t - L_{t-1}) + (1-\beta)B_{t-1}$. Es la misma estructura que usa Winters.
- $L_t - L_{t-1}$ es la pendiente observada en el último período; se suaviza contra la tendencia anterior $B_{t-1}$.
- **Inicialización** (como en el Excel de clase):
  1. Se hace una regresión con los primeros $m$ datos. La pendiente es $B_{m-1}$.
  2. El valor ajustado en el último de esos datos se corrige con α y da $L_{m-1}$.
  3. Los errores se miden desde $t = m$.

> [!example] Guía 4, ej. 2 (Cable Com), con α = β = 0,1 y regresión con los 4 primeros meses ✅
> La regresión con ENE–ABR ($t = 0..3$) da $D = 1700 + 22t$. El ajuste en ABR es 1766, así que $L_3 = 1766 + 0{,}1(1764 - 1766) = 1765{,}8$ y $B_3 = 22$.
>
> | $t$ | Mes | $D_t$ | $F_t$ | $e_t$ | $L_t$ | $B_t$ |
> |---|---|---|---|---|---|---|
> | 4 | MAY | 1805 | 1787,80 | 17,20 | 1789,52 | 22,172 |
> | 5 | JUN | 1835 | 1811,69 | 23,31 | 1814,02 | 22,405 |
> | 6 | JUL | 1831 | 1836,43 | −5,43 | 1835,89 | 22,351 |
> | 7 | AGO | 1866 | 1858,24 | 7,76 | 1859,01 | 22,428 |
> | 8 | SEP | 1884 | 1881,44 | 2,56 | 1881,70 | 22,454 |
> | 9 | OCT | 1930 | 1904,15 | 25,85 | 1906,74 | 22,713 |
> | 10 | NOV | 1919 | 1929,45 | −10,45 | 1928,40 | 22,608 |
> | 11 | DIC | 1951 | 1951,01 | −0,01 | 1951,01 | 22,608 |
>
> - Medidas: **RMSE ≈ 14,63**, MAE ≈ 11,57, MAPE ≈ 0,62 %, sesgo ≈ +7,6 (subestima un poco).
> - **e)** Pronósticos para los 4 meses siguientes: $F = L_{11} + k \cdot B_{11}$ da **1973,6 · 1996,2 · 2018,8 · 2041,4**.
> - **f)** Intervalo del 90 % para el 4° mes: $2041{,}4 \pm 1{,}645 \cdot 14{,}63 = [2017{,}4;\ 2065{,}5]$.

## 15. Winters (tendencia y estacionalidad)
📎 [[Modelos de Pronósticos.pdf#page=52|Diapos 51–57]] · [[resumen-iara.pdf#page=77|iara p. 71–74]] · [[resumen-tgrandi.pdf#page=49|tgrandi 10.1.4]]

- $c$ es la cantidad de períodos del ciclo estacional: 4 si los datos son trimestrales, 12 si son mensuales.
- $s_t$ es un **factor multiplicativo**. Por ejemplo, $s_7 = 2$ significa que en julio se vende el doble que en un mes promedio.

**Se actualiza en este orden**, con las constantes α, β y γ:

$$L_t = \alpha\frac{D_t}{s_{t-c}} + (1-\alpha)(L_{t-1} + B_{t-1}) \qquad B_t = \beta(L_t - L_{t-1}) + (1-\beta)B_{t-1} \qquad s_t = \gamma\frac{D_t}{L_t} + (1-\gamma)\,s_{t-c}$$

- $D_t / s_{t-c}$ es la demanda **desestacionalizada**.
- $L_{t-1} + B_{t-1}$ es el nivel que se esperaba antes de observar $D_t$.
- $B_t$ se actualiza igual que en Holt.
- $D_t / L_t$ es la estacionalidad observada en $t$, y $s_{t-c}$ es la última estimación para esa misma estación.

**Pronóstico:** $F_{t+k} = (L_t + k\,B_t)\cdot s_{t+k-c}$. Es decir, la base del período $t + k$ multiplicada por el factor más reciente de **esa estación**.

**Estimaciones iniciales** (hacen falta **dos ciclos completos**, los años −2 y −1):
- $B_0 = \dfrac{\text{promedio del año } {-1} - \text{promedio del año } {-2}}{c}$
- $L_0 = \text{promedio del año } {-1} + \dfrac{c}{2}\,B_0$
- Factor de cada estación $= \dfrac{D \text{ de esa estación en el año } {-1}}{\text{promedio del año } {-1}}$. Si hace falta, se normalizan para que sumen $c$.

> [!tip] Consejos de clase (iara, tgrandi)
> - Usar **α y β ≤ 0,5**. Si son más grandes, absorben lo que debería modelar γ, que tiende a 0, y el modelo sobreajusta.
> - Estimar α, β y γ con **una parte** de los datos y **validar con el resto**.
> - Pronosticar un paso adelante cada mes aproxima bien. Pronosticar el año entero solo con las estimaciones iniciales es mucho más impreciso.

> [!example] Guía 4, ej. 3 (South Florida Power), c = 4 ✅
> Inicialización con 2020 (año −2) y 2021 (año −1): los promedios son 7934,75 y 8941,5.
> - $B_0 = 251{,}69$ y $L_0 = 8941{,}5 + 2 \cdot 251{,}69 = 9444{,}9$.
> - Factores estacionales: T1 = 0,672 · T2 = 0,982 · **T3 = 1,410** (pico en el verano boreal) · T4 = 0,936. Suman 4.
>
> Primera actualización, con α = 0,2, β = 0,1 y γ = 0,3 (valores elegidos solo para ilustrar):
> - Pronóstico: $F_1 = (L_0 + B_0)\cdot s_{T1} = 6518{,}6$, contra un real de 6743.
> - Actualización: $L_1 = 9763{,}3$, $B_1 = 258{,}36$, nuevo $s_{T1} = 0{,}678$.
>
> ⚠️ **Dato sospechoso:** 2023 abr–jun = **19.638**, cuando por la tendencia se esperarían ≈ 10.600. Parece un error de tipeo (¿10.638?). Con ese valor, el RMSE de Winters (con los mismos parámetros) da ≈ 3446; corregido, ≈ 303. Por eso el inciso b) pide **graficar la serie antes de modelar**.

## 16. Cómo elegir el modelo
📎 [[resumen-iara.pdf#page=87|iara p. 81 (tabla comparativa)]]

1. **Graficar la serie** (es el inciso b de todos los ejercicios de la guía). Mirar si es estable, si tiene tendencia, si hay un patrón que se repite cada $c$ períodos y si hay datos atípicos.
2. **Elegir el modelo y el método** con la tabla de §10.
3. **Ajustar los parámetros** ($k$, α, β, γ) minimizando el RMSE (por ejemplo, con Solver), siempre sobre los mismos períodos.
4. **Validar:** reservar datos, revisar que el sesgo sea ≈ 0 y que los residuos parezcan aleatorios.
5. **Pronosticar** y dar el intervalo $F \pm z \cdot \text{RMSE}$.

| Método | Modelo | Peso de los datos | Reacción a cambios | Tendencia | Estacionalidad |
|---|---|---|---|---|---|
| Promedio | Nivel | Igual para todos | Muy lenta | No | No |
| Medias móviles | Nivel | Igual para los últimos $k$ | Depende de $k$ | No (se atrasa) | No |
| Suavizado exponencial | Nivel | Decae exponencialmente | Depende de α | No (se atrasa) | No |
| Regresión ($x = t$) | Tendencia / causal | Igual para todos | Lenta | Sí (lineal) | Solo con dummies |
| Holt | Tendencia | Más peso a lo reciente | Rápida | Sí | No |
| Winters | Tendencia y estacionalidad | Más peso a lo reciente | Rápida | Sí | Sí |

## 17. Guía 4 — resultados
Las resoluciones son propias y están verificadas numéricamente; las convenciones son las del Excel de clase.

| Ej. | Modelo | Resultados para autocontrol ✅ |
|---|---|---|
| 1. Jolly Donuts (16 semanas) | **Nivel**: la regresión da una pendiente de 0,10 docenas por semana, con p ≈ 0,88 y $R^2 \approx 0{,}002$, así que no hay tendencia. Media ≈ 396,3 | Medias móviles (RMSE, cada una en su propia ventana): k=2: 16,4 · k=3: 13,3 · **k=4: 12,4** · k=5: 12,8 · k=6: 13,9. Suavizado ($F_1 = D_0$): α=0,1: 13,8 · **α=0,2: 13,6** · α=0,3: 13,8 · α=0,4: 14,1 · α=0,5: 14,5. **d)** Nivel vs tendencia ajustan igual (RMSE 11,59 vs 11,58): conviene el de **nivel**, que es más simple |
| 2. Cable Com (12 meses) | **Tendencia**: Holt | Ver la tabla de §14: RMSE ≈ 14,6; pronósticos 1973,6 / 1996,2 / 2018,8 / 2041,4; IC 90 % = [2017,4; 2065,5] |
| 3. South Florida Power (16 trimestres) | **Tendencia y estacionalidad**: Winters, c = 4 | Valores iniciales y advertencia sobre el dato 19.638 en §15 |

## 18. Excel
📎 [[Analítica Predictiva.xlsx]] (hojas Good Tire Media Móvil, Good Tire Suavización, Maple Heights Suavización y Maple Heights Holt)

- **Medias móviles:** `=PROMEDIO(...)` sobre los $k$ datos anteriores.
- **Suavizado exponencial:** `=F_ant + $H$1*(D_ant - F_ant)`, con α en una celda fija.
- **Holt:**
  - pendiente inicial con `=PENDIENTE()` (en clase está escrita a mano con SUMAPRODUCTO) y ordenada con `=INTERSECCION.EJE()`;
  - después, una fila por período con las fórmulas de §14.
- **Medidas de error:** columnas con el error, el error al cuadrado, el error absoluto y el error porcentual; el RMSE es `=RAIZ(PROMEDIO(errores²))`.
- *(complemento)* **Herramientas para análisis:**
  - **Regresión** da $R^2$, los p-valores y el error típico ($s_e$);
  - **Suavización exponencial** pide un *factor de amortiguación* que es **1 − α**, no α;
  - **Media móvil** también está disponible.
- *(complemento)* **Solver:** minimiza la celda del RMSE cambiando α (y β, γ), con $0 \le \alpha \le 1$ (o ≤ 0,5 en Winters).
- *(complemento)* El inciso 2d ("construir el modelo de tendencia automáticamente") seguramente se refiere a la **Hoja de previsión** o a `PRONOSTICO.ETS`, que hacen suavizado exponencial automático, o a Solver.
- **Valor de z:** `=DISTR.NORM.ESTAND.INV(1 - α/2)` (para el 95 %, 1,96).

---

## Errores frecuentes y erratas del material
- **iara p. 53:** tiene la concavidad y la convexidad al revés. Cóncava ⇔ $f'' \le 0$.
- **tgrandi 6.1:** la fórmula de Newton está en su versión para raíces ($f/f'$). Para optimizar se usa $f'/f''$.
- **iara y tgrandi:** escriben Newton multivariable como $\nabla f \cdot H^{-1}$. Con vectores columna es $H^{-1}\nabla f$.
- **tgrandi 7.4:** dice que para el 2° orden de Lagrange "se puede usar el hessiano de $f$". En general hay que usar el **hessiano orlado** (o el atajo de $f$ cóncava con restricciones lineales).
- **iara p. 58:** en el método del gradiente escribe $\max f(x - \alpha\nabla f)$. Para maximizar es $+$.
- **iara p. 76:** en la fórmula de $\hat\beta_1$ dice $(x_i - \bar x)(x_i - \bar y)$. Es $(x_i - \bar x)(y_i - \bar y)$.
- **iara p. 69:** el desarrollo algebraico del suavizado exponencial tiene errores. El correcto es el de §12.
- **tgrandi 10.1:** dice "A es el primer valor medido". $A$ es el **nivel** (la ordenada al origen).
- **tgrandi 6.2.1:** dice que una función unimodal "es cóncava o convexa". Unimodal no implica cóncava: toda cóncava es unimodal, pero no al revés.
- **Diapositivas (MAPE):** dicen 4,77 %; es 4,75 %.
- **Diapositiva de Winters:** la segunda suma de $B_0$ debería terminar en $-c-1$, no en $-c+1$.
- **Guía 4, ej. 3:** el dato 19.638 es casi seguro un error.

## Checklist para el parcial
- [ ] Probar concavidad y convexidad ($f''$ y Hessiana) y saber qué implica para óptimo local vs global
- [ ] Clasificar candidatos en una variable (interiores, sin derivada, extremos)
- [ ] Sección áurea a mano, reutilizando puntos y calculando la cantidad de iteraciones
- [ ] Newton en una variable y multivariable
- [ ] Gradiente: armar $\varphi(t)$, hallar $t^*$ y aplicar el criterio de parada
- [ ] Lagrange, hessiano orlado e interpretación de λ como precio sombra
- [ ] KKT: plantear las condiciones, resolver por casos y verificar suficiencia
- [ ] RMSE, MAE, MAPE, sesgo e intervalo de confianza
- [ ] Medias móviles y suavizado exponencial a mano, y elección de $k$ y α
- [ ] Regresión: $\beta_0$, $\beta_1$, $R^2$, p-valores, $s_e$ y supuestos
- [ ] Holt: inicialización con regresión, actualización y pronóstico a $k$ períodos
- [ ] Winters: inicialización con dos ciclos, orden de actualización y pronóstico
