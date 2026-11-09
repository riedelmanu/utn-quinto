---
tipo: resumen
materia: Investigación Operativa
parcial: 3
tags: [resumen, investigacion-operativa, stock, inventarios]
---
# Resumen 3° parcial — Modelos de Stock (Inventarios)

Volver a [[Parcial 3]] · [[INVESTIGACION OPERATIVA]] · [[Inicio]] · Práctica: [[Preguntas tipo parcial - Modelos de Stock|preguntas tipo parcial]]

> [!info] Fuentes
> - **Diapositivas:** [[Modelos de Inventarios.pdf|Introducción a los Modelos de Inventarios (Lauritto–Casanova–Schab)]]. Es el PDF que estaba guardado como "PDF.js viewer": se imprimió desde Firefox y algunas figuras salieron en blanco. Por eso los gráficos de este resumen son propios.
> - **Guía:** [[Guía_5-Modelos_de_inventario.pdf|Guía 5 — Modelos de inventario]]
> - **GeoGebra:** `GeoGebra/stock-descuentos-por-cantidad.ggb` (ejemplo de descuentos por cantidad, ver [[#6. Descuentos por cantidad]])
> - **Apuntes de clase:** [[apuntes stock]]
> - **Resúmenes de compañeros** (carpeta del Parcial 2): [[resumen-fmiret.pdf#page=52|fmiret p. 51–61]] · [[resumen-iara.pdf#page=88|iara p. 82–99]] · [[resumen-tgrandi.pdf#page=52|tgrandi cap. 11]]
> - **Libros:** [[hillier_lieberman.pdf#page=802|Hillier–Lieberman, cap. 18 (Teoría de inventarios)]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=493|Taha 9ª ed., cap. 13 (determinísticos)]] y [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=589|cap. 16 (probabilísticos)]]
> - *(complemento)* = no está en las diapositivas. ✅ = resultado verificado numéricamente.

**Índice**
- Base: [[#1. Para qué sirven los stocks]] · [[#2. Componentes de los modelos]]
- Determinísticos: [[#3. EOQ básico (lote económico)]] · [[#4. Análisis de sensibilidad]] · [[#5. Restricciones]] · [[#6. Descuentos por cantidad]] · [[#7. EOQ con faltantes admitidas]] · [[#8. Stock de protección]]
- Demanda: [[#9. Caracterización de la demanda]]
- Estocásticos: [[#10. Revisión continua con demanda aleatoria (q, SR)]] · [[#11. Método del nivel de servicio]]
- Otros: [[#12. Análisis ABC y XYZ]] · [[#13. Guía 5 — resultados]] · [[#Errores frecuentes y erratas del material]] · [[#Checklist para el parcial]]

---

## 1. Para qué sirven los stocks
📎 [[Modelos de Inventarios.pdf#page=3|p. 3–5]] · [[resumen-fmiret.pdf#page=52|fmiret p. 51]] · [[resumen-iara.pdf#page=88|iara p. 82]]

- **Stock, existencias e inventario** son sinónimos.
- El control de existencias es una de las funciones más importantes de la administración, tanto en empresas productivas como comerciales.
- Hay **oposición de intereses** entre sectores:
  - **Producción** quiere lotes grandes (menos preparaciones de máquina).
  - **Marketing** quiere mucho stock para no perder ventas.
  - **Finanzas** quiere poco stock, porque es capital inmovilizado.
- Los stocks son un **"mal necesario"**: cuestan, pero actúan como **amortiguador** de los procesos y permiten absorber desfasajes estacionales.

> [!important] Función principal de los stocks (definición de las diapos)
> Absorber las fluctuaciones de demanda, fabricación y distribución que se verifican como consecuencia de la **aleatoriedad de los procesos** y de las **diferencias en el tiempo y en la distribución física entre la oferta y la demanda**.

> [!important] Política de inventarios = **cuándo** y **cuánto** pedir
> La administración del stock empieza por definir la política. Según los apuntes de clase, es **pregunta de coloquio**.
> - EOQ básico: pedir $q^*$ cuando el stock llega a $SR$.
> - Modelo estocástico: pedir $q$ cuando el stock llega a $SR$, con $q$ y $SR$ calculados juntos.

**Administración científica de inventarios** (4 pasos):
1. Formular un **modelo matemático** del sistema de inventarios.
2. Elaborar una **política óptima** a partir del modelo.
3. Usar un **sistema computarizado** para registrar los niveles de inventario.
4. Con esos registros, aplicar la política para señalar **cuándo y cuánto** reabastecer.

*(complemento, fmiret)* Motivos para tener stock: protegerse de la incertidumbre (oferta, demanda, tiempos), comprar o producir en lotes económicos (descuentos, fletes), cubrir cambios anticipados (subas de precio, promociones), stock en tránsito y aprovechar al máximo equipos muy caros.

## 2. Componentes de los modelos
📎 [[Modelos de Inventarios.pdf#page=14|p. 14–18]] · [[resumen-iara.pdf#page=89|iara p. 83–86]] · [[hillier_lieberman.pdf#page=805|Hillier 18.2]]

| Componente | Símbolo | Detalle | Unidades |
|---|---|---|---|
| Demanda | $d$ (tasa), $D$ (en el período $T$) | Independiente o dependiente · constante o variable · conocida o incierta | u/tiempo |
| Costo de la orden | $K$ | Fijo por pedido, **no depende de $q$**: administración, recepción, control, *setup* si se fabrica | $/pedido |
| Costo de adquisición | $b$ | Precio unitario (puede tener descuentos) | $/u |
| Costo de almacenamiento | $c_1$ | Mantener una unidad durante una unidad de tiempo | $/(u·tiempo) |
| Costo de agotamiento | $c_2$ | Faltante: pérdida de imagen, interés perdido, costos administrativos | $/(u·tiempo) |
| Tiempo de reaprovisionamiento | $LT$ | *Lead time* o plazo de entrega: desde que se pide hasta que llega | tiempo |
| Política | $(q, SR)$ | Cuánto y cuándo pedir | — |

> [!tip] El costo de almacenamiento tiene dos partes (apuntes de clase)
> $$c_1 = c_1' + i \cdot b$$
> - $c_1'$: **costo operativo** (depósito, energía, seguros, roturas, robo, obsolescencia, personal).
> - $i \cdot b$: **costo financiero** o de oportunidad del capital inmovilizado. $i$ es la **tasa de inmovilización del capital**.
>
> Si el enunciado dice "el costo de mantener es el 20% del precio", entonces $c_1 = 0{,}2\,b$. **Si cambia $b$ (descuentos), cambia $c_1$.**

- **Demanda dependiente** = depende de otro producto (las piezas de un lavarropas dependen de cuántos lavarropas se fabrican). Se maneja con planificación de requerimientos de materiales, no con estos modelos.
- **Faltantes:** si el cliente espera, hay **pedidos pendientes** (*backorders*). Si no espera, hay **ventas perdidas**.
- La cantidad en stock tiene un **comportamiento cíclico** (diente de sierra).
- $T$ es el **período estratégico** (en general un año) al que se refieren los costos.
- *(complemento, iara)* **Revisión continua (tipo Q):** se pide siempre la misma cantidad cuando el stock llega al punto de reorden, y el intervalo entre pedidos varía. **Revisión periódica (tipo P):** se revisa cada cierto tiempo fijo y la cantidad pedida varía.

**Ejemplos disparadores de las diapos**

| Ejemplo | Datos | Tipo de modelo |
|---|---|---|
| Bocinas para televisores | $d = 8000$/mes, $K = 12\,000$, $b = 10$, $c_1 = 0{,}30$/mes, $c_2 = 1{,}10$/mes | Determinístico. EOQ: $q^* = 25\,298$. Con faltantes: $q^* = 28\,540$, $S^* = 22\,424$ ✅ |
| Distribuidor de bicicletas | $K = 2000$, $b = 350$, $c_1 = 10$/mes, $c_2 = 150$/mes, **demanda incierta**, pedido mensual | Estocástico de revisión periódica |

## 3. EOQ básico (lote económico)
📎 [[Modelos de Inventarios.pdf#page=21|p. 21–31]] · [[resumen-fmiret.pdf#page=54|fmiret p. 53–55]] · [[hillier_lieberman.pdf#page=807|Hillier 18.3]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=496|Taha 13.3]]

También se llama **modelo de Wilson**.

**Hipótesis** (las 12 de las diapos):
1. Se administra un **único ítem**.
2. El producto es de **demanda independiente**.
3. La demanda es **conocida** y a **tasa constante**.
4. El plazo de entrega es **conocido y constante**.
5. La reposición se hace exactamente cuando el stock llega a **cero** (no hay stock de protección).
6. El reaprovisionamiento es **instantáneo**: el lote llega todo junto. Ojo: esto **no** significa que $LT = 0$.
7. El horizonte de planeamiento es de **largo plazo**.
8. $c_2 \to \infty$: **no se admiten faltantes**.
9. Los demás costos son **independientes de la cantidad** a ordenar.
10. **No hay restricciones** sobre el tamaño del lote.
11. Todos los parámetros monetarios están en **moneda constante**.
12. El producto se mide en una **unidad continua**.

![[stock-eoq-diente-de-sierra.png]]

**Variables:** $q$ = cantidad a ordenar · $t$ = duración de un ciclo · $CTE$ = costo total esperado en el período $T$ · $SR$ = stock de reorden (punto de pedido).

**Costo de un ciclo** (el stock promedio es $q/2$ durante un tiempo $t$):
$$CTE_i(q) = b\,q + \tfrac12\,q\,c_1\,t + K$$

**Costo del período:** hay $n = \dfrac{D}{q} = \dfrac{T}{t}$ ciclos, entonces
$$\boxed{CTE(q) = b\,D + \tfrac12\,q\,c_1\,T + K\,\frac{D}{q}}$$

**Optimización:** se deriva e iguala a cero.
$$\frac{dCTE}{dq} = \tfrac12\,c_1 T - \frac{K D}{q^2} = 0 \quad\Rightarrow\quad \boxed{q^* = \sqrt{\frac{2\,K\,D}{c_1\,T}}}$$

*(complemento)* $\dfrac{d^2CTE}{dq^2} = \dfrac{2KD}{q^3} > 0$: la función es **convexa** para $q > 0$, así que el punto crítico es el **mínimo global**. Es un PNL irrestricto de una variable, como en el Parcial 2.

**Resultados en el óptimo**

| Magnitud | Fórmula |
|---|---|
| Costo total | $CTE^* = b\,D + \sqrt{2\,K\,D\,c_1\,T}$ |
| Costo variable (sin compra) | $CVT^* = \sqrt{2\,K\,D\,c_1\,T}$ |
| Duración del ciclo | $t^* = \dfrac{q^*}{d} = \dfrac{T\,q^*}{D}$ |
| Número de pedidos | $n^* = D / q^*$ |
| Stock de reorden | $SR = LT \cdot d$ (con las unidades homogeneizadas) |

![[stock-eoq-costos.png]]

> [!important] Tres propiedades que se preguntan mucho
> 1. **$b\,D$ no depende de $q$**, así que el precio no cambia $q^*$, **salvo** que $c_1$ dependa de $b$ ($c_1 = c_1' + i\,b$) o que haya descuentos.
> 2. **En el óptimo, costo de ordenar = costo de almacenar** $= \tfrac12\sqrt{2KDc_1T}$. Es el punto donde se cortan la recta y la hipérbola.
> 3. **$q^*$ crece con la raíz cuadrada**: si $D$ se cuadruplica, $q^*$ solo se duplica. Si $K$ sube, $q^*$ y $t^*$ suben (menos pedidos). Si $c_1$ sube, $q^*$ y $t^*$ bajan.

*(complemento, Hillier)* Si $LT > t^*$ (el plazo de entrega es más largo que un ciclo), $LT \cdot d > q^*$: hay pedidos en tránsito. El pedido se coloca cuando el **stock físico** llega a $LT \cdot d - k\,q^*$, donde $k$ es la cantidad de pedidos en camino.

**Ejemplo de las diapos** ✅ — Ventas de 10 kg/semana, $K = 10$, $i = 25\%$ anual, $c_1' \approx 0$, $b = 100$ \$/kg, 50 semanas/año, $LT = 0{,}5$ semanas.
- $D = 500$ kg/año y $c_1 = 0{,}25 \cdot 100 = 25$ \$/(kg·año).
- $q^* = \sqrt{2 \cdot 10 \cdot 500 / 25} = 20$ kg.
- $t^* = 20/10 = 2$ semanas.
- $CTE^* = 100 \cdot 500 + \sqrt{2 \cdot 10 \cdot 500 \cdot 25} = 50\,000 + 500 = 50\,500$ \$/año.
- $SR = 0{,}5 \cdot 10 = 5$ kg.

## 4. Análisis de sensibilidad
📎 [[Modelos de Inventarios.pdf#page=32|p. 32–43]] · [[resumen-fmiret.pdf#page=56|fmiret p. 55]] · [[resumen-tgrandi.pdf#page=56|tgrandi 11.2.1]]

**¿Cuánto cuesta pedir una cantidad distinta de la óptima?** Se escribe $q' = \alpha \cdot q^*$ y se compara solo la parte variable:
$$CVTE(q) = CTE(q) - b\,D \qquad\qquad \lambda = \frac{CVTE(q')}{CVTE(q^*)} = \frac12\left(\alpha + \frac1\alpha\right)$$

![[stock-sensibilidad.png]]

| $\alpha$ | 0,5 | 0,75 | 0,8 | 1 | 1,25 | 1,3 | 1,5 | 2 |
|---|---|---|---|---|---|---|---|---|
| $\lambda$ | 1,250 | 1,042 | 1,025 | 1 | 1,025 | 1,035 | 1,083 | 1,250 |

**Conclusiones de las diapos:**
1. El modelo es **poco sensible**: grandes cambios en $q$ producen poca variación del costo. Por ejemplo, pedir 25% de más cuesta solo 2,5% más.
2. Hay **mayor sensibilidad a izquierda que a derecha**: pedir 25% de menos (+4,17%) cuesta más que pedir 25% de más (+2,5%).

> [!tip] Simetría útil
> $\lambda(\alpha) = \lambda(1/\alpha)$: pedir **el doble** cuesta lo mismo que pedir **la mitad** (+25% en los dos casos).

**Errores en los parámetros.** Si los valores reales son $c_1' = \beta\,c_1$, $K' = \gamma\,K$ y $D' = \delta\,D$:
$$q'^* = q^* \sqrt{\frac{\gamma\,\delta}{\beta}} \quad\Rightarrow\quad \alpha = \sqrt{\frac{\gamma\,\delta}{\beta}}$$
y con ese $\alpha$ se usa la misma fórmula de $\lambda$. Por la simetría, no importa de qué lado se tome el cociente.

Como el error entra con **raíz cuadrada** y $\lambda$ es plano cerca de 1, una estimación imprecisa de $K$, $c_1$ o $D$ casi no encarece la política. Por ejemplo, si $D$ era 30% más grande: $\alpha = \sqrt{1{,}3} = 1{,}14$ y $\lambda = 1{,}0086$ (menos del 1%).

**Ejemplo de las diapos (fotocopiadoras, Miranda 2006)** ✅ — $D = 200$/año, $K = 1200$, $c_1 = 40$ (real entre 35 y 55), reaprovisionamiento instantáneo.
1. $q^* = \sqrt{2 \cdot 1200 \cdot 200 / 40} = 109{,}5$ unidades. $CVT^* = 4381{,}8$.
2. $n = 200 / 109{,}5 = 1{,}83$ órdenes por año.
3. Para que al cabo de un año el stock remanente sea nulo, $n$ tiene que ser entero: $n = 2 \Rightarrow q = 100$ ($CVT = 4400$) o $n = 1 \Rightarrow q = 200$ ($CVT = 5200$). Se elige **$q = 100$**.
4. Pedir 30% más: $\lambda(1{,}3) = 1{,}0346$, es decir **+3,46%**.
5. Si el $c_1$ real fuera 35: $\alpha = \sqrt{35/40}$, $\lambda = 1{,}0022$ (**+0,22%**). Si fuera 55: $\alpha = \sqrt{55/40}$, $\lambda = 1{,}0127$ (**+1,27%**).

## 5. Restricciones
📎 [[Modelos de Inventarios.pdf#page=44|p. 44]]

Se pueden agregar al modelo básico restricciones de:
1. **Superficie** disponible en el almacén.
2. **Monto máximo** a inmovilizar.
3. **Cantidad máxima (o mínima) de órdenes** a emitir.
4. **Variable entera** (por ejemplo, $q$ o $n$ enteros).

**Cómo incorporarlas.** Como $CTE(q)$ es **convexa**:
- Si $q^*$ cumple la restricción, sigue siendo el óptimo.
- Si no la cumple, el óptimo está **en el borde** de la restricción, el valor permitido más cercano a $q^*$.

| Restricción | Se traduce en | Si $q^*$ no la cumple |
|---|---|---|
| Superficie: cada unidad ocupa $s$, hay $A$ disponible | $s \cdot q \le A$ | $q = A/s$ |
| Monto máximo $M$ (stock máximo valorizado) | $b \cdot q \le M$ | $q = M/b$ |
| Como máximo $N$ órdenes por año | $D/q \le N$ | $q = D/N$ |
| $q$ o $n$ entero | — | Evaluar el costo en los dos enteros vecinos y elegir el menor |

- El monto máximo puede referirse al stock **máximo** ($b\,q$) o al **promedio** ($b\,q/2$). Hay que leer bien el enunciado.
- Con **varios productos** que comparten una restricción (por ejemplo, la superficie total), el problema es un **PNL con restricciones**. Se resuelve con **Lagrange** o **KKT**, como en el Parcial 2 *(complemento)*.
- Según los apuntes de clase, los problemas **no lineales y enteros** son los más difíciles de resolver.

## 6. Descuentos por cantidad
📎 [[Modelos de Inventarios.pdf#page=45|p. 45–47]] · [[resumen-fmiret.pdf#page=59|fmiret p. 58]] · [[resumen-iara.pdf#page=97|iara p. 91]] · [[hillier_lieberman.pdf#page=811|Hillier 18.3]]

El precio depende del tamaño del lote: $b_1 > b_2 > \dots > b_k$ en los rangos $[Q_0, Q_1), [Q_1, Q_2), \dots, [Q_{k-1}, Q_k)$, con $Q_0 = 0$ y $Q_k = M$ (un valor muy grande).

Para cada precio hay una curva de costo distinta, porque también cambia $c_1$:
$$CTE_i(q) = b_i\,D + \tfrac12\,q\,(c_1' + i\,b_i)\,T + K\,\frac{D}{q}$$

- Para un mismo $q$, la curva con **menor precio está siempre más abajo**.
- Los $q_i^*$ de cada curva son parecidos, pero el de un tramo puede **caer fuera de su rango**. Cada curva vale **solo dentro de su tramo**.
- Por eso el óptimo está en un **$q_i^*$ factible** o en un **punto de corte** $Q_{i-1}$ (el inicio de un tramo más barato).

> [!example] Algoritmo de las diapos (empieza por el precio más bajo)
> 1. Hacer $i = k$, $CTE^* = \infty$ y $q^* = 0$.
> 2. Calcular $q_i^*$, el lote óptimo para el precio $b_i$.
> 3. Si $Q_{i-1} \le q_i^* < Q_i$ (es factible):
>    - 3.1. Si $CTE_i(q_i^*) < CTE^*$, hacer $CTE^* = CTE_i(q_i^*)$ y $q^* = q_i^*$.
>    - Ir al paso 5.
> 4. Si no es factible:
>    - 4.1. Si $CTE_i(Q_{i-1}) < CTE^*$, hacer $CTE^* = CTE_i(Q_{i-1})$ y $q^* = Q_{i-1}$.
>    - 4.2. Hacer $i = i - 1$ y volver al paso 2.
> 5. Devolver $q^*$.
>
> **Por qué se puede parar** cuando $q_i^*$ es factible: los tramos que quedan tienen precios más altos y su mínimo está en lotes más chicos, así que no pueden ser mejores.

**Ejemplo de las diapos: Compañía Química La Plata** ✅ — $D = 1000$ m³/mes, $K = 800$, $c_1' = 10$ \$/(m³·mes), $i = 10\%$ mensual.

| $i$ | Rango (m³) | $b_i$ | $c_{1i} = 10 + 0{,}1\,b_i$ | $q_i^*$ | ¿Factible? | Costo evaluado | $CTE^*$ acumulado |
|---|---|---|---|---|---|---|---|
| 4 | $q \ge 650$ | 6,75 | 10,675 | 387,1 | No | $CTE_4(650) = 11\,450{,}1$ | 11 450,1 ($q = 650$) |
| 3 | $[500, 650)$ | 7 | 10,7 | 386,7 | No | $CTE_3(500) = 11\,275{,}0$ | **11 275,0 ($q = 500$)** |
| 2 | $[250, 500)$ | 7,5 | 10,75 | 385,8 | **Sí** | $CTE_2(385{,}8) = 11\,647{,}3$ | No mejora → **fin** |

**Política:** pedir **500 m³** por vez, con un costo de **\$11 275 por mes**. Aunque $q_2^* = 385{,}8$ es el único óptimo "propio" factible, conviene subir al corte de 500 para obtener el precio de \$7.

![[stock-descuentos.png]]

> [!tip] El archivo de GeoGebra
> `GeoGebra/stock-descuentos-por-cantidad.ggb` tiene este mismo ejemplo: los parámetros ($K = 800$, $c_1' = 10$, $i = 0{,}1$, $D = 1000$ y los cuatro precios), las curvas $CTE_1$ a $CTE_4$ y sus mínimos con el comando `Extremo`.
> Para armar otro ejercicio:
> 1. Definir los parámetros como números (deslizadores).
> 2. `CTE_1(x) = b_1*D + x/2*c_11 + K*D/x` (una función por precio).
> 3. `Extremo(CTE_1)` para ver $q_1^*$.
> 4. `Si(250 <= x < 500, CTE_2(x))` para dibujar cada curva **solo en su tramo**.

**Variante de la Guía 5 (ejercicios 3 y 5):** el descuento puede estar en el **costo de almacenamiento** ($c_1$ por tramo) o en el **costo de producción**. Se usa el mismo razonamiento: una curva por tramo y se comparan los $q_i^*$ factibles y los bordes.

## 7. EOQ con faltantes admitidas
📎 [[Modelos de Inventarios.pdf#page=48|p. 48–57]] · [[resumen-fmiret.pdf#page=58|fmiret p. 57]] · [[resumen-tgrandi.pdf#page=61|tgrandi 11.2.3]] · [[hillier_lieberman.pdf#page=809|Hillier 18.3]]

**Cuándo conviene:** si los clientes aceptan un **retraso razonable** y el costo de mantener es **alto en relación con el costo de faltante**, bajar el stock y permitir faltantes breves y ocasionales puede ser buena decisión.

Se reemplaza la hipótesis $c_2 \to \infty$ por: *cuando hay faltante, los clientes esperan y sus pedidos pendientes se satisfacen apenas llega el lote*.

![[stock-faltantes.png]]

**Variables nuevas:** $S$ = stock máximo (stock al recibir el lote) · $q - S$ = faltante máximo · $t_1 = S/d$ = tiempo con stock · $t_2 = (q - S)/d$ = tiempo con faltantes.

**Costos de un ciclo:**
- Mantener: $c_1 \cdot \dfrac{S}{2} \cdot \dfrac{S}{d} = \dfrac12\,c_1\,\dfrac{S^2}{d}$
- Faltantes: $c_2 \cdot \dfrac{q-S}{2} \cdot \dfrac{q-S}{d} = \dfrac12\,c_2\,\dfrac{(q-S)^2}{d}$

**Costo del período** (multiplicando por $n = D/q$ y usando $D = d\,T$):
$$CTE(q, S) = b\,D + c_1\,\frac{S^2}{2q}\,T + c_2\,\frac{(q-S)^2}{2q}\,T + K\,\frac{D}{q}$$

**Óptimo** (derivadas parciales iguales a cero). De $\partial CTE / \partial S = 0$ sale $S = q\,\dfrac{c_2}{c_1 + c_2}$, y reemplazando:
$$\boxed{q^* = \sqrt{\frac{2KD}{c_1 T}}\,\sqrt{\frac{c_1 + c_2}{c_2}}} \qquad \boxed{S^* = \sqrt{\frac{2KD}{c_1 T}}\,\sqrt{\frac{c_2}{c_1 + c_2}}}$$
$$CTE^* = b\,D + \sqrt{2KDc_1T}\,\sqrt{\frac{c_2}{c_1+c_2}} \qquad t^* = \frac{q^*}{d} \qquad \text{faltante máximo} = q^* - S^*$$

> [!important] Lo que hay que saber interpretar
> - $\rho = \dfrac{c_2}{c_1 + c_2} = \dfrac{S^*}{q^*}$ es la **tasa de deficiencia**: la **fracción del tiempo sin faltantes**.
> - Respecto del EOQ básico: **$q^*$ sube** (se multiplica por $1/\sqrt\rho$), **el stock máximo baja** y el **costo variable baja** (se multiplica por $\sqrt\rho < 1$).
> - Si $c_2 \to \infty$, entonces $\rho \to 1$ y se vuelve al **EOQ básico**.
> - Si $c_2$ es chico respecto de $c_1$, conviene tener mucho faltante.

*(complemento)* **Punto de reorden con faltantes:** el lote llega cuando el faltante es $q - S$. Entonces se pide cuando el stock neto vale $LT \cdot d - (q - S)$.

**Ejemplo de las diapos (válvulas)** ✅ — $D = 200$/año, $b = 50$, $K = 5$, $c_1 = 0{,}10$ \$/(u·año), $c_2 = 10$ \$/(u·año), $LT = 4$ meses.
1. $q^* = \sqrt{2 \cdot 5 \cdot 200 / 0{,}1}\,\sqrt{10{,}1/10} = 141{,}42 \cdot 1{,}005 = 142{,}1$ válvulas.
2. $S^* = 141{,}42 \cdot \sqrt{10/10{,}1} = 140{,}7$ (stock máximo). Faltante máximo = 1,4 válvulas. Como $LT \cdot d = 66{,}7$, se pide cuando el stock baja a $66{,}7 - 1{,}4 = 65{,}3$ válvulas.
3. Período con stock: $t_1 = 140{,}7/200 = 0{,}70$ años (8,4 meses). Período de déficit: $t_2 = 1{,}4/200 = 0{,}007$ años (unos 2,6 días).

Como $c_2$ es 100 veces $c_1$, casi no conviene tener faltantes.

## 8. Stock de protección
*(complemento: aparece en [[resumen-fmiret.pdf#page=57|fmiret p. 56]] y [[resumen-tgrandi.pdf#page=57|tgrandi 11.2.2]], de cursadas anteriores. No está en las diapos 2023.)*

Se cambia la hipótesis 5: se mantiene un **stock de protección** $S_p$ que no se usa en la operación normal. Sirve frente a imprevistos como huelgas, demoras o picos de demanda.
$$CTE(q) = b\,D + \tfrac12\,q\,c_1\,T + K\,\frac{D}{q} + S_p\,c_1\,T$$
- $q^*$ y $t^*$ **no cambian**, porque $S_p$ no depende de $q$.
- $CTE^* = b\,D + \sqrt{2KDc_1T} + S_p\,c_1\,T$.
- $SR = LT \cdot d + S_p$.

## 9. Caracterización de la demanda
📎 [[Modelos de Inventarios.pdf#page=59|p. 59–67]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=494|Taha 13.1]]

Según Taha, la demanda puede ser de **cuatro tipos**:
1. Determinística y **constante** (estática).
2. Determinística y **variable** (dinámica).
3. Probabilística y **estacionaria**.
4. Probabilística y **no estacionaria**.

Esta clasificación supone que hay datos confiables para pronosticar (conexión con el Parcial 2).

**Coeficiente de variación:** $V = \dfrac{\text{desviación estándar}}{\text{media}} \cdot 100$, calculado mes a mes con datos de varios años.

| Medias mensuales | $V$ | Tipo de demanda |
|---|---|---|
| Aproximadamente constantes | Chico ($< 20\%$) | Determinística y constante |
| Varían apreciablemente entre meses | Chico en todos los meses | Determinística pero variable |
| Aproximadamente constantes | Alto ($> 20\%$), pero aproximadamente constante | Probabilística y estacionaria |
| Varían | Varía apreciablemente mes a mes | Probabilística no estacionaria |

**Ejemplo (consumo de gas natural, Taha):** las medias van de 42,2 (agosto) a 111,7 (enero), así que varían mucho por el invierno. Pero $V$ está entre 6,1% y 13,9%, siempre menor al 20%. **Conclusión: demanda determinística pero variable.**

## 10. Revisión continua con demanda aleatoria (q, SR)
📎 [[Modelos de Inventarios.pdf#page=69|p. 69–88]] · [[resumen-iara.pdf#page=99|iara p. 93–95]] · [[resumen-tgrandi.pdf#page=71|tgrandi 11.4]] · [[investigacic3b3n-de-operaciones-9na-edicic3b3n-hamdy-a-taha-fl.pdf#page=592|Taha 16.1.2]]

Se parte del **modelo con faltantes admitidas** y se agrega:
- **Revisión continua** del stock.
- **Demanda aleatoria.**
- **Tiempo de entrega distinto de 0.**

**Política:** pedir la cantidad $q$ cada vez que el stock disponible baja a $SR$.

![[stock-estocastico.png]]

**Notación (Taha):**
- $f(x)$: densidad de la **demanda durante el tiempo de entrega**.
- $D$: demanda esperada por unidad de tiempo.
- $c_1$: costo de retención por unidad y por unidad de tiempo.
- $c_2$: costo por faltante **por unidad faltante**, sin multiplicar por tiempo (distinto del modelo determinístico).
- $K$: costo de la orden.

**Costo total esperado por unidad de tiempo** = preparación + retención + faltantes.
- **Preparación:** hay $D/q$ pedidos por unidad de tiempo, entonces el costo es $\dfrac{KD}{q}$.
- **Retención:** el stock promedio es $I = \dfrac{q}{2} + SR - E[x]$, entonces el costo es $c_1 \left(\dfrac{q}{2} + SR - E[x]\right)$.
- **Faltantes:** el faltante esperado por ciclo es $S = \displaystyle\int_{SR}^{\infty} (x - SR)\,f(x)\,dx$, entonces el costo es $\dfrac{c_2\,D\,S}{q}$.

$$CTE(q, SR) = \frac{KD}{q} + c_1\left(\frac q2 + SR - E[x]\right) + \frac{c_2\,D}{q}\int_{SR}^{\infty}(x - SR)\,f(x)\,dx$$

> [!warning] Ojo con la letra $S$
> En este modelo, $S$ es el **faltante esperado por ciclo**. En el modelo de faltantes admitidas, $S$ era el **stock máximo**.

**Condiciones de óptimo** (derivadas parciales iguales a cero):
$$q^* = \sqrt{\frac{2D\,(K + c_2\,S)}{c_1}} \quad (1) \qquad\qquad \int_{SR}^{\infty} f(x)\,dx = P(x \ge SR) = \frac{c_1\,q^*}{c_2\,D} \quad (2)$$

- $q^*$ y $SR^*$ **no tienen forma cerrada**: (1) depende de $SR$ a través de $S$, y (2) depende de $q$. Se resuelven juntos.
- **Interpretación de (2):** la probabilidad de faltante en un ciclo es $\dfrac{c_1 q}{c_2 D}$. Si los faltantes son caros (sube $c_2$), esa probabilidad baja, sube $SR$ y aumenta el stock de seguridad.
- La ecuación (1) es el EOQ con el costo de pedido "inflado" por el costo esperado de faltante de cada ciclo ($K + c_2 S$).

> [!example] Algoritmo de Hadley y Whitin
> **¿Hay solución única?** Se calculan
> $$\hat q = \sqrt{\frac{2D\,(K + c_2\,E[x])}{c_1}} \qquad \tilde q = \frac{c_2\,D}{c_1}$$
> Si $\tilde q \ge \hat q$, existe solución única.
>
> **Paso 0:** usar la solución inicial $q_1 = \sqrt{2KD/c_1}$ (EOQ clásico, con $S = 0$). Sea $SR_0 = 0$ e $i = 1$.
> **Paso $i$:**
> 1. Con $q_i$, calcular $SR_i$ usando (2).
> 2. Si $SR_i \approx SR_{i-1}$, parar: la solución es $q_i$ y $SR_i$.
> 3. Si no, calcular $S$ con $SR_i$, usar (1) para obtener $q_{i+1}$, hacer $i = i + 1$ y repetir.

**Cuentas según la distribución**

| | Uniforme en $[a, b]$ | Normal $N(\mu, \sigma)$ |
|---|---|---|
| $P(x \ge SR)$ | $\dfrac{b - SR}{b - a}$ | $1 - \Phi\!\left(\dfrac{SR - \mu}{\sigma}\right)$ |
| $SR$ a partir de (2) | $SR = b - (b - a)\,\dfrac{c_1 q}{c_2 D}$ | $SR = \mu + z\,\sigma$, con $P(Z \ge z) = \dfrac{c_1 q}{c_2 D}$ |
| $S$ (faltante esperado) | $\dfrac{(b - SR)^2}{2\,(b - a)}$ | $\sigma\,[\varphi(z) - z\,(1 - \Phi(z))]$ *(complemento)* |

**Demanda durante el LT a partir de la demanda por período:** si $d$ tiene media $E[d]$ y desvío $\sigma_d$, y $LT$ está en esa misma unidad de tiempo,
$$E[x] = LT \cdot E[d] \qquad \sigma_x = \sigma_d \sqrt{LT}$$
Las varianzas se suman, los desvíos no (se supone independencia entre períodos).

**Ejemplo Electro (Taha), demanda uniforme** ✅ — $D = 1000$ gal/mes, $K = 100$, $c_1 = 2$ \$/(gal·mes), $c_2 = 10$ \$/gal, $x \sim U(0, 100)$, $E[x] = 50$.
- Chequeo: $\hat q = \sqrt{2 \cdot 1000\,(100 + 10 \cdot 50)/2} = 774{,}6$ y $\tilde q = 10 \cdot 1000 / 2 = 5000$. Como $\tilde q \ge \hat q$, hay solución única.

| Iteración | $q_i$ | $P(x \ge SR) = c_1 q_i / (c_2 D)$ | $SR_i = 100\,(1 - P)$ | $S = (100 - SR)^2/200$ |
|---|---|---|---|---|
| 1 | 316,23 | 0,063246 | 93,675 | 0,2 |
| 2 | 319,37 | 0,063875 | 93,613 | 0,204 |
| 3 | 319,44 | 0,063887 | 93,611 | Converge |

**Política:** pedir **319,4 galones** cuando el stock baja a **93,6 galones**. $CTE = \$726{,}10$ por mes (la diapo dice 626,10, ver [[#Errores frecuentes y erratas del material|erratas]]).

**Ejemplo modificado, demanda normal** ✅ — $d \sim N(400, 4)$ por mes, $LT = 1$ semana $= 0{,}25$ meses, $c_1 = 2$, $c_2 = 4$, $K = 20$.
- $E[x] = 0{,}25 \cdot 400 = 100$ y $\sigma_x = 4\sqrt{0{,}25} = 2$, así que $x \sim N(100, 2)$.
- $\hat q = 409{,}9$ y $\tilde q = 800$: hay solución única.
- Iteraciones: $q_1 = 89{,}44 \to SR_1 = 102{,}434$ ($S = 0{,}1083$) $\to q_2 = 90{,}41 \to SR_2 = 102{,}421$ ($S = 0{,}1098$) $\to q_3 = 90{,}42 \to SR_3 = 102{,}421$ (converge).
- **Política:** pedir **90,42 galones** cuando el stock baja a **102,42**. $CTE = \$185{,}68$ por mes. Stock de seguridad $= 102{,}42 - 100 = 2{,}42$ galones.

## 11. Método del nivel de servicio
📎 [[Modelos de Inventarios.pdf#page=89|p. 89–95 y 115–118]] · [[resumen-iara.pdf#page=102|iara p. 96]] · [[resumen-tgrandi.pdf#page=74|tgrandi 11.4]] · [[hillier_lieberman.pdf#page=838|Hillier 18.6]]

Suele ser **difícil estimar el costo de un faltante** ($c_2$). Entonces la gerencia fija un **nivel de servicio** y controla los faltantes con él.

**Medidas posibles del nivel de servicio:**
1. **Probabilidad de que ocurra un faltante** entre que se coloca la orden y se recibe el pedido.
2. **Número promedio de faltantes por año.**
3. **Porcentaje promedio de la demanda anual** que se satisface de inmediato.
4. **Retraso promedio** para satisfacer los pedidos pendientes cuando hay faltante.
5. **Retraso promedio global** (si no hay faltante, el retraso es 0).

**Cómo se calcula (medida 1).** $\alpha$ es la probabilidad máxima de faltante admitida, y el nivel de servicio es $1 - \alpha$.
- **Cantidad:** se usa el **EOQ clásico**, $q = \sqrt{2KD/c_1}$ (el inicial de Hadley–Whitin).
- **Stock de reorden:** se busca $SR$ tal que $P(x \ge SR) \le \alpha$.
  - Uniforme en $[a, b]$: $SR = a + (1 - \alpha)(b - a)$.
  - Normal: $SR = \mu + z_{1-\alpha}\,\sigma$.
- **Stock de seguridad** = $SR - E[x]$: el stock esperado justo antes de que llegue el pedido.

| Nivel de servicio $1 - \alpha$ | 0,75 | 0,80 | 0,85 | 0,90 | 0,95 | 0,975 | 0,99 |
|---|---|---|---|---|---|---|---|
| $z$ | 0,674 | 0,842 | 1,036 | 1,282 | 1,645 | 1,960 | 2,326 |

*(complemento)* **De la medida 1 a la 2:** hay $D/q$ ciclos por año, y en cada uno la probabilidad de faltante es $\alpha$. Entonces el número esperado de ciclos con faltante por año es $\dfrac{D}{q} \cdot \alpha$.

> [!warning] Diapos vs. Hillier
> Las **diapos** usan el **EOQ clásico** para $q$. **Hillier** (de donde salen los ejercicios 8 y 9 de la guía) usa el **EOQ con faltantes planeados**, $q = \sqrt{\frac{2DK}{c_1}}\sqrt{\frac{c_1 + c_2}{c_2}}$. El $SR$ se calcula igual en los dos casos. En el parcial conviene usar el de las diapos y aclarar el criterio.

**Ejemplos de las diapos** ✅

| Caso | $\alpha$ | $q$ (EOQ) | $SR$ | Stock de seguridad | $CTE$ | $CTE$ óptimo (Hadley–Whitin) |
|---|---|---|---|---|---|---|
| Electro uniforme $U(0, 100)$ | 0,05 | 316,23 | 95 | 45 | 726,41 | 726,10 |
| Electro normal $N(100, 2)$ | 0,05 | 89,44 | 103,29 | 3,29 | 186,21 | 185,68 |

El costo del nivel de servicio queda **casi igual al óptimo**: es una buena aproximación sin necesidad de estimar $c_2$.

Hay un **compromiso**: más nivel de servicio implica más $SR$, más stock de seguridad y más costo de mantener. En la normal, pasar del 95% al 99% aumenta el stock de seguridad un 41% ($2{,}326/1{,}645$).

## 12. Análisis ABC y XYZ
*(complemento: está en [[resumen-iara.pdf#page=103|iara p. 97–99]], [[resumen-tgrandi.pdf#page=75|tgrandi 11.5]] y [[resumen-fmiret.pdf#page=61|fmiret p. 60]]. No está en las diapos 2023, pero se dio en clase otros años.)*

Sirve cuando hay **muchos productos**: no todos merecen el mismo control.

**ABC (principio de Pareto, según la demanda valorizada):**
1. Calcular la **demanda valorizada** de cada ítem ($b \cdot D$) y su porcentaje sobre el total.
2. Ordenar de mayor a menor y **acumular** los porcentajes.
3. Clasificar:
   - **A:** hasta el 80% acumulado. Cerca del 20% de los ítems. Control estricto y revisión frecuente.
   - **B:** del 80% al 95%. Cerca del 30% de los ítems. Control intermedio.
   - **C:** del 95% al 100%. Cerca del 50% de los ítems. Control de rutina.

**XYZ (según la variabilidad de la demanda, con el coeficiente de variación $V$):**
- **X:** $V \le 10\%$, demanda estable.
- **Y:** $10\% < V \le 25\%$, demanda moderada o de temporada.
- **Z:** $V > 25\%$, demanda errática. Conviene vender bajo pedido.

**ABC–XYZ:** se combinan y quedan 9 categorías.
- AX, AY y BX: siempre disponibles.
- AZ, BY y CX: requieren atención.
- BZ, CY y CZ: consumo caótico, candidatos a eliminar o vender bajo pedido.

## 13. Guía 5 — resultados
📎 [[Guía_5-Modelos_de_inventario.pdf|Guía 5]] · Resolución completa en [[Preguntas tipo parcial - Modelos de Stock#Parte D — Guía 5 resuelta|Preguntas tipo parcial, parte D]]

| Ej. | Modelo | Resultado principal ✅ |
|---|---|---|
| 1 | EOQ básico, sensibilidad | $q^* = 24\,495$ kg (cabe en el camión de 30 t), un pedido cada 4,9 días. Flete = almacenamiento = \$89 406/año, total \$178 813/año. Con demanda +30%: $q^* = 27\,928$ kg y \$203 878/año. Si se sigue pidiendo 24 495: \$205 635/año, +0,86% |
| 2 | EOQ básico, comparación de alternativas | Envasar ellos: $q^* = 31\,623$ cajas cada 77 días, $CTE = \$159\,487$. Comprar envasadas: $q^* = 6325$ cada 15,4 días, $CTE = \$189\,872$. **Conviene envasar** |
| 3 | Descuentos en $c_1$ por tanques | Costo mínimo con 1 tanque \$251 850, con 2 tanques \$203 878 ($q^* = 27\,928$ kg), con 3 tanques \$180 675 ($q = 40\,000$ kg). Si un pedido de 40 t necesita **2 viajes**, con 3 tanques sube a \$249 698 y **conviene 2 tanques** |
| 4 | EOQ, despejar $K$, descuento | $D = 1000$ plaquetas/año, $c_1 = 32$, $K = 250$, $q^* = 125$, 8 pedidos/año. Con el descuento (4 pedidos de 250 a \$94): $CTE = \$98\,917 < \$100\,000$. **Conviene aceptar** |
| 5 | Descuentos en el costo de producción | $q^* = 4839$ parlantes a \$11, $CTE = \$63\,839$/mes. El corte de 10 000 cuesta \$64 800 y el de 80 000, \$196 600 |
| 6 | EOQ y EOQ con faltantes | Sin faltantes: $q^* = 346$, $CVT = \$34\,641$. Con faltantes: $q^* = 447$, $S^* = 268$, faltante máximo 179, $CVT = \$26\,833$ |
| 7 | EOQ, sensibilidad, faltantes | Pedir 5: $CVT = \$11\,640$. $q^* = 13$, una vez por semana, $SR = 6{,}5$, $CVT^* = \$7800$ (−33%). Con faltantes: $CVT = \$3900$ (otro −50%) |
| 8 | Nivel de servicio, normal | $q = 30$ (EOQ clásico; con Hillier, 60). $SR = 50 + 0{,}674 \cdot 15 = 60{,}1 \approx 60$. Stock de seguridad = 10 |
| 9 | Nivel de servicio, uniforme | $SR = 10 + 0{,}8 \cdot 20 = 26$. Stock de seguridad = 6. $q = 32{,}7$ (EOQ clásico; con Hillier, 80). Ciclos con faltante: 5,9 por año (2,4 con $q = 80$) |

---

## Errores frecuentes y erratas del material

> [!warning] Errores típicos
> - **Unidades:** $D$, $c_1$, $c_2$ y $T$ tienen que estar en la **misma unidad de tiempo**. Si $c_1$ está por día y $D$ por año, hay que pasar todo a días o todo a años antes de aplicar la fórmula.
> - Si $c_1$ se da como **porcentaje del precio**, entonces $c_1 = i \cdot b$, y con descuentos **cambia en cada tramo**.
> - Para comparar alternativas con **precios distintos** (Guía ejercicios 2, 4 y 5) se usa el **$CTE$ con $b\,D$**, no el $CVT$.
> - En descuentos, olvidarse de evaluar los **puntos de corte**. El óptimo muchas veces está en un corte.
> - $\lambda$ compara **costos variables**, no el $CTE$ con la compra incluida.
> - **Reaprovisionamiento instantáneo no es $LT = 0$:** significa que el lote llega todo junto.
> - En el modelo estocástico, $c_2$ es **por unidad faltante**. En el determinístico con faltantes, es **por unidad y por tiempo**.

> [!bug] Erratas del material
> - **Diapositivas, p. 88 y 95 del PDF (Electro):** el código de Octave calcula la retención como `2*(q/2+SR-100)`, pero $E[x] = 50$, no 100. Los costos correctos son **\$726,10** (Hadley–Whitin) y **\$726,41** (nivel de servicio), no 626,10 y 626,41. La comparación entre los dos métodos no cambia.
> - **Diapositivas, p. 117–118 del PDF:** dice $SR = 103{,}28$ y stock de seguridad 3,28. El valor exacto es 103,29 (redondeo).
> - **Guía 5, ejercicio 8:** dice "ganancia cercana a 33 000 dólares". En el Hillier es **3 000**: $\frac13 \cdot 3000 = 1000$, que es el $c_2$ del enunciado. No se usa en el método del nivel de servicio.
> - **Guía 5, ejercicio 1:** no dice la unidad de tiempo de $c_1 = 0{,}02$ \$/kg. Se toma **por día**, como en el ejercicio 3, y 365 días por año.

## Checklist para el parcial
- [ ] Definir política de inventarios (cuándo y cuánto pedir) y explicar la función de los stocks.
- [ ] Nombrar los componentes de un modelo con sus unidades. Saber que $c_1 = c_1' + i\,b$.
- [ ] Enunciar las hipótesis del EOQ básico.
- [ ] Deducir $q^*$ derivando el $CTE$. Calcular $CTE^*$, $t^*$, $n^*$ y $SR$.
- [ ] Graficar el diente de sierra y las curvas de costo.
- [ ] Usar $\lambda = \frac12(\alpha + 1/\alpha)$ y $\alpha = \sqrt{\gamma\delta/\beta}$, y explicar las dos conclusiones.
- [ ] Incorporar restricciones (borde más cercano, enteros vecinos).
- [ ] Aplicar el algoritmo de descuentos con una tabla por tramo.
- [ ] EOQ con faltantes: $q^*$, $S^*$, faltante máximo, $t_1$, $t_2$ e interpretar $c_2/(c_1 + c_2)$.
- [ ] Clasificar la demanda con el coeficiente de variación.
- [ ] Escribir el $CTE(q, SR)$ estocástico y las condiciones (1) y (2).
- [ ] Iterar Hadley–Whitin con demanda uniforme y normal (chequear $\tilde q \ge \hat q$).
- [ ] Nivel de servicio: $SR$, stock de seguridad, $E[x] = LT \cdot E[d]$ y $\sigma_x = \sigma_d\sqrt{LT}$.
- [ ] Llevar la tabla normal o la calculadora con $\Phi^{-1}$.
