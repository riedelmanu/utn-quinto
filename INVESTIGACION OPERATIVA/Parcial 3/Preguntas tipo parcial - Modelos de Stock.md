---
tipo: resumen
materia: Investigación Operativa
parcial: 3
tags: [investigacion-operativa, stock, inventarios, parcial, preguntas]
---
# Preguntas tipo parcial — Modelos de Stock

Volver a [[Parcial 3]] · Teoría: [[Resumen Tercer Parcial - Modelos de Stock|resumen]]

> [!info] Cómo usarlo
> - Hay **verdadero/falso con justificación**, **preguntas de desarrollo** (estilo coloquio), **ejercicios cortos**, la **Guía 5 resuelta** y preguntas **integradoras** con el Parcial 2.
> - Cada respuesta está **cerrada debajo de la pregunta**. Respondé primero y después hacé clic en **"Ver respuesta"** para desplegarla.
> - Las respuestas se basan en las diapositivas y la Guía 5. Lo que no está en las diapos está marcado *(complemento)*. Todas las cuentas están verificadas.
> - Al final hay dos [[#Simulacros]].

---

# Parte A — Verdadero o falso (justifique)

**A1.** Si la demanda anual se duplica, el lote económico también se duplica.

> [!check]- Ver respuesta
> **Falso.** $q^* = \sqrt{2KD/(c_1T)}$ crece con la **raíz** de $D$. Si $D$ se duplica, $q^*$ se multiplica por $\sqrt2 \approx 1{,}41$. Lo mismo pasa con el costo variable óptimo $\sqrt{2KDc_1T}$.

**A2.** En el EOQ básico, el precio unitario $b$ no influye en el tamaño óptimo del lote.

> [!check]- Ver respuesta
> **Depende de cómo esté dado $c_1$, así que en general es falso.**
> - El término $b\,D$ del $CTE$ no depende de $q$, así que desaparece al derivar.
> - Pero si $c_1 = c_1' + i\,b$ (incluye el costo del capital inmovilizado), $b$ entra en $q^*$ a través de $c_1$: a mayor precio, mayor $c_1$ y menor lote.
> - Solo si $c_1$ es un valor fijo, independiente de $b$, el precio no influye.

**A3.** En el lote óptimo del EOQ básico, el costo anual de ordenar es igual al costo anual de mantener el inventario.

> [!check]- Ver respuesta
> **Verdadero.** Con $q^*$:
> $$K\frac{D}{q^*} = \tfrac12\,q^*\,c_1\,T = \tfrac12\sqrt{2KDc_1T}$$
> Gráficamente, $q^*$ está donde se cortan la hipérbola $KD/q$ y la recta $\frac12 q c_1 T$. En la Guía 5, ejercicio 1, flete = almacenamiento = \$89 406.

**A4.** Pedir un 25% más que el lote óptimo cuesta lo mismo que pedir un 25% menos.

> [!check]- Ver respuesta
> **Falso.** Con $\lambda = \frac12(\alpha + 1/\alpha)$:
> - $\alpha = 1{,}25$ da $\lambda = 1{,}025$ (+2,5%).
> - $\alpha = 0{,}75$ da $\lambda = 1{,}0417$ (+4,17%).
>
> Hay **mayor sensibilidad a izquierda**: quedarse corto cuesta más. Lo que sí es igual es pedir el **doble** y la **mitad** ($\lambda = 1{,}25$ en los dos casos), porque $\lambda(\alpha) = \lambda(1/\alpha)$.

**A5.** El modelo EOQ es muy sensible a los errores de estimación de $K$, $c_1$ y $D$.

> [!check]- Ver respuesta
> **Falso.** Un error en los parámetros cambia el lote en $\alpha = \sqrt{\gamma\delta/\beta}$ (con raíz cuadrada), y $\lambda$ es muy plano cerca de $\alpha = 1$.
> Por ejemplo, si $D$ era en realidad un 30% mayor, $\alpha = \sqrt{1{,}3} = 1{,}14$ y el costo variable sube solo un **0,86%**. Por eso el modelo sirve aunque los costos sean estimaciones.

**A6.** La hipótesis de reaprovisionamiento instantáneo significa que el plazo de entrega es cero.

> [!check]- Ver respuesta
> **Falso.** Significa que **el lote llega todo junto**, no de forma gradual (como pasaría con una producción a ritmo finito). El plazo de entrega $LT$ puede ser positivo, conocido y constante (hipótesis 4). Por eso existe el stock de reorden $SR = LT \cdot d$.

**A7.** En el EOQ básico, el stock de reorden depende del tamaño del lote.

> [!check]- Ver respuesta
> **Falso** en el EOQ básico: $SR = LT \cdot d$ depende solo de la demanda y del plazo de entrega.
> *(complemento)* La excepción es $LT > t$: hay pedidos en tránsito y el pedido se coloca cuando el stock físico llega a $LT \cdot d - k\,q$.
> En el **modelo estocástico** sí dependen uno del otro: la ecuación $P(x \ge SR) = c_1 q/(c_2 D)$ liga $SR$ con $q$.

**A8.** Admitir faltantes siempre empeora el costo, porque se agrega el costo $c_2$.

> [!check]- Ver respuesta
> **Falso.** Si $c_2$ es finito, el costo variable óptimo es
> $$\sqrt{2KDc_1T}\cdot\sqrt{\frac{c_2}{c_1 + c_2}}$$
> y el segundo factor es menor que 1. Se ahorra en mantenimiento más de lo que se paga en faltantes. En la Guía 5, ejercicio 7, el costo baja de \$7800 a \$3900. Solo si $c_2 \to \infty$ el costo queda igual al del EOQ básico.

**A9.** En el modelo con faltantes admitidas, si $c_2 \to \infty$ se recupera el EOQ básico.

> [!check]- Ver respuesta
> **Verdadero.** $\dfrac{c_2}{c_1 + c_2} \to 1$, entonces $q^* \to \sqrt{2KD/(c_1T)}$, $S^* \to q^*$ y el faltante máximo $q^* - S^* \to 0$. Es la hipótesis 8 del modelo básico.

**A10.** En un problema de descuentos por cantidad, el lote óptimo siempre es el $q_i^*$ de alguna de las curvas de costo.

> [!check]- Ver respuesta
> **Falso.** El óptimo puede estar en un **punto de corte** $Q_{i-1}$, el mínimo necesario para acceder a un precio más bajo. En el ejemplo de Química La Plata, el único $q_i^*$ factible es 385,8 (\$11 647), pero el óptimo es el corte $q = 500$ (\$11 275).

**A11.** En descuentos por cantidad conviene siempre comprar en el tramo de menor precio.

> [!check]- Ver respuesta
> **Falso.** Para entrar al tramo más barato puede haber que pedir un lote tan grande que el costo de mantenerlo supere el ahorro en el precio. En la Guía 5, ejercicio 5, pedir 80 000 parlantes a \$9,5 cuesta \$196 600 por mes, contra \$63 839 pidiendo 4839 a \$11.

**A12.** Una demanda mensual con media aproximadamente constante y coeficiente de variación del 30% puede tratarse como determinística.

> [!check]- Ver respuesta
> **Falso.** Con el criterio de Taha, $V > 20\%$ indica demanda **probabilística**. Si $V$ además es aproximadamente constante, es probabilística **estacionaria**.

**A13.** Para aplicar el método del nivel de servicio hay que conocer el costo de faltante $c_2$.

> [!check]- Ver respuesta
> **Falso.** Justamente se usa cuando **$c_2$ es difícil de estimar**. En lugar de minimizar un costo con $c_2$, se fija una probabilidad máxima de faltante $\alpha$ y se busca $SR$ con $P(x \ge SR) \le \alpha$. Para $q$ se usa el EOQ clásico, que no usa $c_2$.

**A14.** Con demanda normal, pasar de un nivel de servicio del 95% al 99% duplica el stock de seguridad.

> [!check]- Ver respuesta
> **Falso.** El stock de seguridad es $z\,\sigma_x$. $z$ pasa de 1,645 a 2,326, es decir, aumenta un **41%**, no el doble. Igual es un aumento grande para 4 puntos de servicio: cada punto extra cuesta más que el anterior.

**A15.** El algoritmo de Hadley y Whitin siempre converge a una solución única.

> [!check]- Ver respuesta
> **Falso.** Primero hay que verificar la condición $\tilde q \ge \hat q$, con $\tilde q = c_2D/c_1$ y $\hat q = \sqrt{2D(K + c_2E[x])/c_1}$. Si no se cumple, no está garantizada la solución única.

**A16.** Si la demanda mensual tiene desvío $\sigma_d$ y el plazo de entrega es de 4 meses, el desvío de la demanda durante el plazo de entrega es $4\,\sigma_d$.

> [!check]- Ver respuesta
> **Falso.** Se suman las **varianzas** de los 4 meses (suponiendo independencia), no los desvíos: $\sigma_x^2 = 4\sigma_d^2$, entonces $\sigma_x = \sigma_d\sqrt4 = 2\,\sigma_d$. La media sí se multiplica: $E[x] = 4\,E[d]$.

**A17.** El costo de mantener inventario incluye solo el alquiler del depósito.

> [!check]- Ver respuesta
> **Falso.** $c_1 = c_1' + i\,b$.
> - La parte **operativa** $c_1'$ incluye depósito, energía, seguros, impuestos, roturas, robo, obsolescencia y personal.
> - La parte **financiera** $i\,b$ es el costo de oportunidad del capital inmovilizado. En muchos ejercicios es la parte principal.

---

# Parte B — Desarrollo

**B1.** ¿Qué es una política de inventarios? ¿Cómo queda definida en el EOQ básico y en el modelo estocástico de revisión continua? *(pregunta de coloquio según los apuntes de clase)*

> [!check]- Ver respuesta
> Una política de inventarios es la regla que dice **cuándo** y **cuánto** pedir.
> - **EOQ básico:** cuánto = $q^* = \sqrt{2KD/(c_1T)}$. Cuándo = cuando el stock llega a $SR = LT \cdot d$ (o cada $t^* = q^*/d$, porque la demanda es constante).
> - **Estocástico de revisión continua:** se pide $q$ cada vez que el stock baja a $SR$. Los dos se calculan **juntos** (Hadley–Whitin) o con el método del nivel de servicio (EOQ para $q$ y el percentil de la demanda en el $LT$ para $SR$).
> - *(complemento)* En **revisión periódica**, la política dice cada cuánto revisar y hasta qué nivel reponer.
>
> La administración científica de inventarios formula un modelo, saca de él la política óptima, registra los niveles de stock y aplica la política para decidir cuándo y cuánto reabastecer.

**B2.** ¿Por qué se dice que los stocks son un "mal necesario"? ¿Qué intereses se oponen en una empresa respecto del nivel de stock?

> [!check]- Ver respuesta
> **Son un mal** porque inmovilizan capital y generan costos de almacenamiento, seguros, obsolescencia y control.
> **Son necesarios** porque **amortiguan** los procesos: absorben las fluctuaciones de demanda, fabricación y distribución que vienen de la aleatoriedad y de los desfasajes de tiempo y lugar entre oferta y demanda (por ejemplo, la estacionalidad).
>
> **Oposición de intereses:**
> - **Producción** quiere lotes grandes (menos preparaciones).
> - **Marketing** quiere mucho stock para no perder ventas.
> - **Finanzas** quiere poco stock para no inmovilizar capital.
>
> El modelo busca el equilibrio de costos entre esas posiciones.

**B3.** Enumere los componentes de un modelo de inventarios y explique cada costo con sus unidades.

> [!check]- Ver respuesta
> - **Demanda** $d$, $D$: independiente o dependiente, constante o variable, conocida o incierta.
> - **Costos:**
>   - **De la orden** $K$ [\$/pedido]: fijo por pedido. Administración, recepción, control de calidad, *setup* si se fabrica.
>   - **De adquisición** $b$ [\$/u]: precio unitario. Puede ser constante o tener descuentos.
>   - **De almacenamiento** $c_1$ [\$/(u·tiempo)]: $c_1 = c_1' + i\,b$ (operativo más financiero).
>   - **De agotamiento** $c_2$ [\$/(u·tiempo)]: costo de no tener el producto cuando se lo pide. Si el cliente espera, son pedidos pendientes. Si no, ventas perdidas.
> - **Tiempo de reaprovisionamiento** $LT$: desde que se pide hasta que llega.
> - **Política:** cuándo y cuánto pedir.
>
> Además, el stock tiene un **comportamiento cíclico** (diente de sierra).

**B4.** Enuncie las hipótesis del modelo EOQ básico.

> [!check]- Ver respuesta
> 1. Un único ítem.
> 2. Demanda independiente.
> 3. Demanda conocida y a tasa constante.
> 4. Plazo de entrega conocido y constante.
> 5. Se repone exactamente cuando el stock llega a cero.
> 6. Reaprovisionamiento instantáneo (el lote llega completo).
> 7. Horizonte de planeamiento de largo plazo.
> 8. $c_2 \to \infty$ (no se admiten faltantes).
> 9. Los demás costos no dependen de la cantidad a ordenar.
> 10. No hay restricciones sobre el tamaño del lote.
> 11. Parámetros monetarios en moneda constante.
> 12. El producto se mide en una unidad continua.

**B5.** Deduzca la fórmula del lote económico a partir del costo total esperado. Justifique que es un mínimo.

> [!check]- Ver respuesta
> **Un ciclo:** se compran $q$ unidades (costo $b\,q$), se paga una orden ($K$) y se mantiene un stock promedio de $q/2$ durante $t$ (costo $\frac12 q c_1 t$).
> $$CTE_i = b\,q + \tfrac12\,q\,c_1\,t + K$$
> **Período:** hay $n = D/q = T/t$ ciclos.
> $$CTE(q) = n \cdot CTE_i = b\,D + \tfrac12\,q\,c_1\,T + K\frac{D}{q}$$
> **Condición de primer orden:**
> $$CTE'(q) = \tfrac12\,c_1T - \frac{KD}{q^2} = 0 \Rightarrow q^* = \sqrt{\frac{2KD}{c_1T}}$$
> **Es mínimo:** $CTE''(q) = 2KD/q^3 > 0$ para $q > 0$. La función es convexa, así que el punto crítico es el mínimo global.
> Reemplazando: $CTE^* = b\,D + \sqrt{2KDc_1T}$.

**B6.** Grafique esquemáticamente los costos en función del tamaño del pedido y explique el compromiso que resuelve el modelo.

> [!check]- Ver respuesta
> ![[stock-eoq-costos.png]]
> - El **costo de mantener** $\frac12 q c_1 T$ es una **recta creciente**: pedir mucho genera mucho stock.
> - El **costo de ordenar** $KD/q$ es una **hipérbola decreciente**: pedir mucho implica pocos pedidos.
> - La **suma** tiene forma de U. Su mínimo está en $q^*$, donde las dos componentes son iguales.
> - $b\,D$ es una constante que solo desplaza la curva hacia arriba.
>
> El modelo resuelve el compromiso entre **pocos pedidos grandes** (mucho stock) y **muchos pedidos chicos** (muchos costos de orden).

**B7.** Explique el análisis de sensibilidad del EOQ: qué es $\alpha$, qué es $\lambda$, a qué conclusiones se llega y qué pasa si se estiman mal los parámetros.

> [!check]- Ver respuesta
> - $\alpha = q'/q^*$ mide cuánto se aparta el lote pedido del óptimo.
> - $\lambda = CVTE(q')/CVTE(q^*)$ compara los **costos variables**, sin $b\,D$.
> - Reemplazando $q' = \alpha q^*$:
> $$\lambda = \tfrac12\left(\alpha + \frac1\alpha\right) \ge 1$$
>
> **Conclusiones:**
> 1. El modelo es **poco sensible**: $\alpha = 1{,}25$ da $\lambda = 1{,}025$.
> 2. Hay **más sensibilidad a izquierda**: $\alpha = 0{,}75$ da $\lambda = 1{,}042$.
>
> **Error en parámetros:** con $c_1' = \beta c_1$, $K' = \gamma K$ y $D' = \delta D$, el óptimo verdadero es $q'^* = q^*\sqrt{\gamma\delta/\beta}$. Ese factor es el $\alpha$ que se usa en la misma fórmula.
>
> **Consecuencias prácticas:** se puede redondear el lote a cantidades cómodas (camiones, cajas) y trabajar con costos estimados sin perder mucho.

**B8.** ¿Cómo se incorporan restricciones al modelo básico? Dé ejemplos.

> [!check]- Ver respuesta
> Restricciones típicas:
> - Superficie: $s\,q \le A$.
> - Monto máximo inmovilizado: $b\,q \le M$, o $b\,q/2 \le M$ si es sobre el promedio.
> - Máximo de órdenes: $D/q \le N$, es decir, $q \ge D/N$.
> - Variable entera ($q$ o $n$).
>
> Como $CTE(q)$ es **convexa**:
> - Si $q^*$ cumple la restricción, sigue siendo óptimo.
> - Si no la cumple, el óptimo es el **borde** más cercano a $q^*$.
> - Si hay que usar enteros, se evalúan los dos enteros vecinos y se elige el de menor costo (como en el ejemplo de las fotocopiadoras: $n = 2$, $q = 100$).
>
> *(complemento)* Con varios productos que comparten la restricción, hay que resolver un PNL con restricciones por **Lagrange o KKT**. Ver E2.

**B9.** Explique el procedimiento para resolver un problema con descuentos por cantidad. ¿Por qué el algoritmo empieza por el precio más bajo y por qué puede detenerse?

> [!check]- Ver respuesta
> **Planteo:** para cada precio $b_i$ hay una curva $CTE_i(q) = b_iD + \frac12 q(c_1' + i\,b_i)T + KD/q$, válida solo en su tramo $[Q_{i-1}, Q_i)$.
>
> **Algoritmo:**
> 1. Empezar por el precio más bajo ($i = k$) con $CTE^* = \infty$.
> 2. Calcular $q_i^*$.
> 3. Si es factible, compararlo con el mejor hasta ahora y **terminar**.
> 4. Si no es factible, evaluar el **corte inferior** $CTE_i(Q_{i-1})$, guardarlo si mejora, bajar a $i - 1$ y repetir.
>
> **Por qué empieza por el más barato:** para un mismo $q$, esa curva está siempre por debajo. Si su $q^*$ fuera factible, ya sería el óptimo.
>
> **Por qué puede detenerse:** cuando un $q_i^*$ es factible, los tramos restantes tienen precios más altos y lotes más chicos. Sus curvas están por encima, así que no pueden mejorar.
>
> El óptimo es siempre un $q_i^*$ factible o un punto de corte.

**B10.** ¿Cuándo tiene sentido admitir faltantes planeados? Explique el significado de $S$, $q - S$ y $\dfrac{c_2}{c_1 + c_2}$.

> [!check]- Ver respuesta
> **Cuándo:** cuando los clientes aceptan un retraso razonable (los pedidos quedan pendientes y no se pierden) y el costo de mantener es **alto en relación con el costo de faltante**. Conviene bajar el stock y tolerar faltantes breves y ocasionales.
> - $S$: **stock máximo**, el nivel al recibir el lote, después de cubrir los pedidos pendientes.
> - $q - S$: **faltante máximo**, los pedidos pendientes acumulados justo antes de que llegue el lote.
> - $\rho = \dfrac{c_2}{c_1 + c_2} = \dfrac{S^*}{q^*} = \dfrac{t_1}{t}$: **fracción del tiempo sin faltantes**.
>
> Fórmulas: $q^* = \sqrt{\frac{2KD}{c_1T}}\sqrt{\frac{c_1 + c_2}{c_2}}$ y $S^* = \sqrt{\frac{2KD}{c_1T}}\sqrt{\frac{c_2}{c_1 + c_2}}$.

**B11.** ¿Cómo se decide si la demanda puede tratarse como determinística? Explique los cuatro tipos de demanda.

> [!check]- Ver respuesta
> Con el **coeficiente de variación** $V = \sigma/\text{media} \cdot 100$, calculado mes a mes con datos de varios años (Taha).
>
> | Medias mensuales | $V$ | Tipo |
> |---|---|---|
> | Aproximadamente constantes | $< 20\%$ | Determinística y constante (estática) |
> | Varían entre meses | Chico en todos | Determinística pero variable (dinámica) |
> | Aproximadamente constantes | $> 20\%$, aproximadamente constante | Probabilística estacionaria |
> | Varían | Varía mucho | Probabilística no estacionaria |
>
> En el ejemplo del gas natural, las medias van de 42,2 a 111,7 y $V$ siempre es menor a 14%: es una demanda **determinística pero variable**.

**B12.** En el modelo estocástico de revisión continua, escriba el costo total esperado y explique cada término.

> [!check]- Ver respuesta
> $$CTE(q, SR) = \frac{KD}{q} + c_1\left(\frac q2 + SR - E[x]\right) + \frac{c_2 D}{q}\int_{SR}^{\infty}(x - SR)\,f(x)\,dx$$
> - **Preparación:** hay $D/q$ pedidos por unidad de tiempo, cada uno cuesta $K$.
> - **Retención:** el stock promedio es $q/2 + SR - E[x]$. $SR - E[x]$ es lo que queda en promedio al llegar el pedido (stock de seguridad).
> - **Faltantes:** $S = \int_{SR}^\infty (x - SR) f(x)\,dx$ es el faltante esperado en un ciclo (la demanda del $LT$ que supera a $SR$). Cada unidad faltante cuesta $c_2$ y hay $D/q$ ciclos.
>
> $f(x)$ es la densidad de la **demanda durante el plazo de entrega**.

**B13.** Interprete la condición de óptimo $\displaystyle\int_{SR}^{\infty} f(x)\,dx = \frac{c_1\,q}{c_2\,D}$.

> [!check]- Ver respuesta
> El lado izquierdo es $P(x \ge SR)$: la **probabilidad de quedarse sin stock** en un ciclo.
> - Si los faltantes son caros ($c_2$ grande), conviene una probabilidad de faltante baja, es decir, un $SR$ alto.
> - Si mantener es caro ($c_1$ grande), conviene aceptar más riesgo, es decir, un $SR$ más bajo.
> - Si $q$ es grande, hay menos ciclos por año ($D/q$), menos oportunidades de faltante, y se tolera más probabilidad por ciclo.
>
> Es el equilibrio marginal: subir $SR$ una unidad cuesta $c_1$ por tiempo y ahorra $c_2 \cdot \frac{D}{q} \cdot P(x \ge SR)$.

**B14.** Describa el algoritmo de Hadley y Whitin.

> [!check]- Ver respuesta
> Resuelve de manera iterativa las dos condiciones de óptimo:
> $$q = \sqrt{\frac{2D(K + c_2S)}{c_1}} \quad (1) \qquad P(x \ge SR) = \frac{c_1 q}{c_2 D} \quad (2)$$
> 0. **Verificar solución única:** $\tilde q = c_2D/c_1 \ge \hat q = \sqrt{2D(K + c_2E[x])/c_1}$.
> 1. **Inicio:** $q_1 = \sqrt{2KD/c_1}$ (EOQ con $S = 0$) y $SR_0 = 0$.
> 2. Con $q_i$, calcular $SR_i$ usando (2).
> 3. Si $SR_i \approx SR_{i-1}$, terminar.
> 4. Si no, calcular $S = \int_{SR_i}^\infty (x - SR_i)f(x)\,dx$, obtener $q_{i+1}$ con (1) y volver al paso 2.
>
> Converge en pocas iteraciones (tres en los ejemplos de Electro).

**B15.** ¿En qué consiste el método del nivel de servicio? ¿Qué medidas de nivel de servicio existen? ¿Qué es el stock de seguridad?

> [!check]- Ver respuesta
> **Idea:** como suele ser difícil estimar $c_2$, en vez de minimizar un costo con faltantes se **fija un nivel de servicio** y se controlan los faltantes con él.
>
> **Medidas:**
> 1. Probabilidad de faltante entre que se pide y se recibe.
> 2. Número promedio de faltantes por año.
> 3. Porcentaje de la demanda anual satisfecha de inmediato.
> 4. Retraso promedio de los pedidos pendientes cuando hay faltante.
> 5. Retraso promedio global.
>
> **Cálculo (medida 1):**
> - $q$ = EOQ clásico.
> - $SR$ tal que $P(x \ge SR) \le \alpha$. En la normal, $SR = \mu + z_{1-\alpha}\sigma$. En la uniforme $[a, b]$, $SR = a + (1 - \alpha)(b - a)$.
>
> **Stock de seguridad** = $SR - E[x]$: el stock esperado justo antes de recibir el pedido. Es la protección contra una demanda en el $LT$ mayor que la esperada.

**B16.** ¿Cómo se obtiene la distribución de la demanda durante el plazo de entrega a partir de la demanda mensual?

> [!check]- Ver respuesta
> Si la demanda mensual $d$ tiene media $E[d]$ y desvío $\sigma_d$, y el $LT$ se expresa **en meses**:
> $$E[x] = LT \cdot E[d] \qquad \sigma_x = \sigma_d\,\sqrt{LT}$$
> Se supone que la demanda de distintos períodos es independiente: se suman las varianzas, no los desvíos. Si $d$ es normal, $x$ también.
> Ejemplo de las diapos: $N(400, 4)$ por mes con $LT = 1$ semana $= 0{,}25$ meses da $x \sim N(100, 2)$.

**B17.** *(complemento)* Explique el análisis ABC–XYZ y para qué sirve.

> [!check]- Ver respuesta
> Sirve para decidir **cuánto esfuerzo de control** dedicar a cada producto cuando hay muchos.
> - **ABC** (Pareto, por demanda valorizada $b \cdot D$ acumulada):
>   - **A:** hasta el 80% del valor, cerca del 20% de los ítems. Control estricto.
>   - **B:** del 80% al 95%, cerca del 30% de los ítems.
>   - **C:** el 5% restante del valor, cerca del 50% de los ítems. Control de rutina.
> - **XYZ** (por coeficiente de variación):
>   - **X:** $V \le 10\%$, estable.
>   - **Y:** hasta 25%.
>   - **Z:** más de 25%, errática.
> - **Combinados** dan 9 categorías. AX, AY y BX siempre tienen que estar disponibles. BZ, CY y CZ son candidatos a eliminar o vender bajo pedido.

---

# Parte C — Ejercicios cortos

**C1.** Demanda de 2400 u/año, $K = \$50$ por pedido, $c_1 = \$6$ por unidad y por año. Calcule $q^*$, la cantidad de pedidos por año, la duración del ciclo y el costo variable anual.

> [!check]- Ver respuesta
> - $q^* = \sqrt{2 \cdot 50 \cdot 2400/6} = \sqrt{40\,000} = \mathbf{200}$ unidades.
> - $n = 2400/200 = \mathbf{12}$ pedidos por año, es decir, $t = 1$ mes.
> - $CVT^* = \sqrt{2 \cdot 50 \cdot 2400 \cdot 6} = \mathbf{\$1200}$ por año: \$600 de órdenes y \$600 de mantenimiento.

**C2.** Con los datos de C1, ¿cuánto cuesta pedir 300 unidades por vez? ¿Y 100? Resuelva con $\lambda$ y verifique con la fórmula.

> [!check]- Ver respuesta
> - $q = 300$: $\alpha = 1{,}5$ y $\lambda = \frac12(1{,}5 + 0{,}667) = 1{,}0833$, así que $CVT = 1200 \cdot 1{,}0833 = \mathbf{\$1300}$. Verificación: $50 \cdot 2400/300 + \frac12 \cdot 300 \cdot 6 = 400 + 900 = 1300$.
> - $q = 100$: $\alpha = 0{,}5$ y $\lambda = 1{,}25$, así que $CVT = \mathbf{\$1500}$. Verificación: $1200 + 300 = 1500$.

**C3.** Con los datos de C1, cada unidad ocupa 0,5 m² y el depósito tiene 80 m². ¿Cuál es el lote óptimo y cuánto cuesta la restricción?

> [!check]- Ver respuesta
> - La restricción es $0{,}5\,q \le 80$, es decir, $q \le 160$. Como $q^* = 200$ no la cumple y el costo es convexo, el óptimo es el borde: **$q = 160$**.
> - $CVT(160) = 50 \cdot 2400/160 + \frac12 \cdot 160 \cdot 6 = 750 + 480 = \mathbf{\$1230}$.
> - La restricción cuesta **\$30 por año** (+2,5%, que coincide con $\lambda(0{,}8) = 1{,}025$).

**C4.** Con los datos de C1, la demanda se cuadruplica. ¿Qué pasa con $q^*$ y con el costo variable?

> [!check]- Ver respuesta
> Los dos se multiplican por $\sqrt4 = 2$: $q^* = 400$ y $CVT^* = \$2400$. El costo por unidad vendida **baja a la mitad** (de \$0,50 a \$0,25): hay economías de escala.

**C5.** $K = \$100$, $D = 1200$ u/año, $c_1 = \$4$/(u·año), $c_2 = \$12$/(u·año). Calcule la política con faltantes admitidas.

> [!check]- Ver respuesta
> - EOQ básico: $\sqrt{2 \cdot 100 \cdot 1200/4} = 244{,}9$.
> - $q^* = 244{,}9 \cdot \sqrt{16/12} = \mathbf{282{,}8}$.
> - $S^* = 244{,}9 \cdot \sqrt{12/16} = \mathbf{212{,}1}$.
> - Faltante máximo: $282{,}8 - 212{,}1 = \mathbf{70{,}7}$.
> - $CVT^* = \sqrt{2 \cdot 100 \cdot 1200 \cdot 4} \cdot \sqrt{0{,}75} = 979{,}8 \cdot 0{,}866 = \mathbf{\$848{,}5}$ (sin faltantes era \$979,8).
> - El 75% del tiempo hay stock.

**C6.** La demanda durante el plazo de entrega es normal, con media 200 y desvío 30. Se quiere un nivel de servicio del 95% (medida 1). Calcule $SR$ y el stock de seguridad.

> [!check]- Ver respuesta
> $SR = 200 + 1{,}645 \cdot 30 = \mathbf{249{,}3}$ unidades. Stock de seguridad $= 249{,}3 - 200 = \mathbf{49{,}3}$ unidades.

**C7.** La demanda durante el plazo de entrega es uniforme entre 40 y 80. Se admite una probabilidad de faltante de 0,10. Calcule $SR$ y el stock de seguridad.

> [!check]- Ver respuesta
> $P(x \ge SR) = (80 - SR)/40 \le 0{,}1$, así que $SR \ge 76$. Entonces **$SR = 76$**. $E[x] = 60$, así que el stock de seguridad es **16**.

**C8.** La demanda semanal es normal con media 100 y desvío 20. El plazo de entrega es de 4 semanas. ¿Qué $SR$ da un 90% de nivel de servicio?

> [!check]- Ver respuesta
> - $E[x] = 4 \cdot 100 = 400$ y $\sigma_x = 20\sqrt4 = 40$ (no 80).
> - $SR = 400 + 1{,}282 \cdot 40 = \mathbf{451{,}3}$. Stock de seguridad $= \mathbf{51{,}3}$.

**C9.** La demanda mensual de un producto tiene media 500 y desvío 150, y es parecida todos los meses. ¿Qué modelo usaría?

> [!check]- Ver respuesta
> $V = 150/500 = 30\% > 20\%$, con medias aproximadamente constantes: es una demanda **probabilística estacionaria**. Corresponde un modelo estocástico, como el $(q, SR)$ de revisión continua o el método del nivel de servicio. Usar un EOQ determinístico sin stock de seguridad generaría faltantes frecuentes.

**C10.** Verifique si el algoritmo de Hadley–Whitin garantiza solución única con $D = 500$, $K = 50$, $c_1 = 1$ y $E[x] = 300$, para (a) $c_2 = 2$ y (b) $c_2 = 1{,}2$.

> [!check]- Ver respuesta
> - (a) $\tilde q = 2 \cdot 500/1 = 1000$ y $\hat q = \sqrt{2 \cdot 500\,(50 + 600)} = 806{,}2$. Como $\tilde q \ge \hat q$, **hay solución única**.
> - (b) $\tilde q = 600$ y $\hat q = \sqrt{1000\,(50 + 360)} = 640{,}3$. Como $\tilde q < \hat q$, **no está garantizada**: el faltante es tan barato que el modelo no tiene un equilibrio único.

**C11.** *(complemento)* La demanda es de 40 u/día, el plazo de entrega es de 5 días y $q^* = 150$. ¿Cuándo se pide?

> [!check]- Ver respuesta
> - $LT \cdot d = 200 > q^* = 150$. El ciclo dura $t = 150/40 = 3{,}75$ días, menos que el $LT$: siempre hay **un pedido en camino**.
> - El pedido se coloca cuando el **stock físico** llega a $200 - 150 = \mathbf{50}$ unidades. Visto como **posición de inventario** (stock más pedidos en tránsito), el punto de reorden sigue siendo 200.

**C12.** *(complemento)* Con los datos de C1, se decide mantener un stock de protección de 50 unidades. ¿Cambia el lote? ¿Cuánto cuesta?

> [!check]- Ver respuesta
> - **El lote no cambia** ($q^* = 200$), porque $S_p\,c_1\,T$ no depende de $q$.
> - El costo variable sube en $50 \cdot 6 = \$300$: queda $CVT = \$1500$.
> - El punto de pedido pasa a ser $SR = LT \cdot d + 50$.

---

# Parte D — Guía 5 resuelta

📎 [[Guía_5-Modelos_de_inventario.pdf|Guía 5]]. Se toman 365 días por año salvo que se indique otra cosa.

**D1. Ejercicio 1 (Jarabe de Sorbitol).** Camión de 30 t, \$1200 por viaje, $c_1 = \$0{,}02$/kg (por día), $d = 5000$ kg/día. Calcule (a) cantidad por viaje, (b) frecuencia, (c) gasto anual, (e) cómo bajar costos, (f) demanda +30%, (g) seguir pidiendo lo mismo con la demanda +30%.

> [!check]- Ver respuesta
> **(a)** $q^* = \sqrt{2 \cdot 1200 \cdot 5000/0{,}02} = \sqrt{6 \times 10^8} = \mathbf{24\,495}$ kg (24,5 t). Es menor que 30 t, así que **cabe en un camión**.
>
> **(b)** $t^* = 24\,495/5000 = \mathbf{4{,}9}$ días.
>
> **(c)** $D = 5000 \cdot 365 = 1\,825\,000$ kg/año y $n = 74{,}5$ viajes.
> - Flete: $1200 \cdot 74{,}5 = \mathbf{\$89\,406}$.
> - Almacenamiento: $\frac12 \cdot 24\,495 \cdot 0{,}02 \cdot 365 = \mathbf{\$89\,406}$ (iguales, como en todo EOQ).
> - **Total: \$178 813 por año.** El jarabe no entra, porque lo paga otro sector a fin de mes.
>
> **(d)** El gráfico es como el de B6: recta de almacenamiento, hipérbola de flete y su suma en U.
>
> **(e)** Se puede bajar **$K$** (flete más barato, compartir viajes) o **$c_1$** (tanques más eficientes, menos energía).
> - Bajar $K$ hace bajar la hipérbola: $q^*$ se corre a la **izquierda** (lotes más chicos y más frecuentes).
> - Bajar $c_1$ hace la recta más plana: $q^*$ se corre a la **derecha** (lotes más grandes).
> - En los dos casos, el mínimo baja, porque $CVT^* \propto \sqrt{K\,c_1}$.
>
> **(f)** $d = 6500$: $q^* = \mathbf{27\,928}$ kg (sigue entrando en un camión). Costo: $\sqrt{2 \cdot 1200 \cdot 6500 \cdot 0{,}02} \cdot 365 = \mathbf{\$203\,878}$ por año. Subió un $\sqrt{1{,}3} - 1 = 14\%$.
>
> **(g)** Con $q = 24\,495$ y $d = 6500$: $(1200 \cdot 6500/24\,495 + \frac12 \cdot 24\,495 \cdot 0{,}02) \cdot 365 = (318{,}4 + 244{,}9) \cdot 365 = \mathbf{\$205\,635}$. Es apenas **+0,86%** respecto del óptimo. Con sensibilidad: $\alpha = 24\,495/27\,928 = 0{,}877$ y $\lambda = 1{,}0086$. La demanda subió 30% y el error de no recalcular cuesta menos del 1%.

**D2. Ejercicio 2 (aspirinas).** Envasar ellos ($K = 1000$, $b = 1$) o comprarlas envasadas ($K = 50$, $b = 1{,}25$). $c_1 = 30\%$ de $b$, $D = 150\,000$ cajas/año.

> [!check]- Ver respuesta
> | | Envasar ellos | Comprar envasadas |
> |---|---|---|
> | $c_1 = 0{,}3\,b$ | 0,30 | 0,375 |
> | $q^*$ | $\sqrt{2 \cdot 1000 \cdot 150\,000/0{,}3} = \mathbf{31\,623}$ cajas | $\sqrt{2 \cdot 50 \cdot 150\,000/0{,}375} = \mathbf{6325}$ cajas |
> | Pedidos por año | 4,74 (cada **77 días**) | 23,7 (cada **15,4 días**) |
> | $CVT^*$ | 9487 | 2372 |
> | $CTE^* = bD + CVT^*$ | **\$159 487** | **\$189 872** |
>
> **(b) Conviene envasar ellos:** ahorran unos \$30 385 por año. Aunque el costo variable de comprar envasado es más bajo, la diferencia de precio ($0{,}25 \cdot 150\,000 = \$37\,500$) pesa mucho más. Por eso hay que comparar con **$CTE$**, no con $CVT$.

**D3. Ejercicio 3 (tanques con descuento).** $K = 1200$ por viaje (camión de 30 t), $d = 6500$ kg/día. $c_1$ por kg y por día: 0,030 hasta 20 t, 0,020 de 20 a 40 t y 0,015 de 40 a 60 t.

> [!check]- Ver respuesta
> El stock máximo es $q$, así que el tramo depende de $q$.
>
> | Tanques | Rango de $q$ | $c_1$ | $q^*$ propio | $q$ usado | Costo por día | **Costo anual** |
> |---|---|---|---|---|---|---|
> | 1 | hasta 20 000 | 0,030 | 22 804 (no entra) | 20 000 | $390 + 300 = 690$ | **\$251 850** |
> | 2 | 20 000–40 000 | 0,020 | **27 928** (entra) | 27 928 | 558,6 | **\$203 878** |
> | 3 | 40 000–60 000 | 0,015 | 32 249 (no entra) | 40 000 | $195 + 300 = 495$ | **\$180 675** |
>
> **(a)** Esos son los costos mínimos para 1, 2 y 3 tanques.
>
> **(b)** Aplicando el modelo tal cual, conviene **alquilar 3 tanques y pedir 40 t** por vez.
>
> **Ojo:** el enunciado aclara que cada camión carga 30 t. Un pedido de 40 t necesita **2 viajes**, así que $K = 2400$. Con 3 tanques, el óptimo pasa a ser $q = 45\,607$ kg, con un costo de **\$249 698**. En ese caso conviene **2 tanques y pedir 27 928 kg** (un camión) por \$203 878. En el parcial conviene plantear las dos lecturas y justificar.
>
> **(c)** Son tres curvas en U, cada una válida solo en su tramo (como el gráfico de descuentos del resumen). La de 3 tanques es la más baja, pero su mínimo cae fuera del tramo.

**D4. Ejercicio 4 (plaquetas).** Las computadoras usan 2, 4 y 8 plaquetas (demandas de 250, 100 y 10), más 20 para mantenimiento. $b = 96$ y $c_1 = b/3$. El $CTE$ óptimo actual es \$100 000. El proveedor ofrece \$2 de rebaja si se reduce a la mitad el número de pedidos.

> [!check]- Ver respuesta
> - $D = 250 \cdot 2 + 100 \cdot 4 + 10 \cdot 8 + 20 = \mathbf{1000}$ plaquetas/año y $c_1 = 32$.
> - **Despejar $K$:** $100\,000 = 96 \cdot 1000 + \sqrt{2 \cdot K \cdot 1000 \cdot 32}$, así que $\sqrt{64\,000\,K} = 4000$ y $\mathbf{K = 250}$.
> - Política actual: $q^* = \sqrt{2 \cdot 250 \cdot 1000/32} = 125$, es decir, **8 pedidos por año**.
> - Con el descuento: 4 pedidos de 250 a \$94. Con $c_1 = 94/3 = 31{,}33$: $CTE = 94\,000 + \frac12 \cdot 250 \cdot 31{,}33 + 250 \cdot 4 = 94\,000 + 3917 + 1000 = \mathbf{\$98\,917}$.
> - **Conviene aceptar:** ahorra unos \$1083 por año. Con $c_1 = 32$ también conviene (\$99 000).

**D5. Ejercicio 5 (parlantes).** $D = 4000$/mes, $K = 12\,000$, $c_1' = 3$/mes, $i = 10\%$ mensual. $b = 11$ si se producen menos de 10 000, 10 entre 10 000 y 80 000, y 9,5 si son más de 80 000.

> [!check]- Ver respuesta
> $c_{1i} = 3 + 0{,}1\,b_i$. Se aplica el algoritmo desde el precio más bajo:
>
> | $b_i$ | $c_{1i}$ | $q_i^*$ | ¿Factible? | Costo evaluado (\$/mes) | Mejor hasta ahora |
> |---|---|---|---|---|---|
> | 9,5 | 3,95 | 4930 | No (< 80 000) | $CTE(80\,000) = 38\,000 + 158\,000 + 600 = 196\,600$ | 196 600 |
> | 10 | 4,0 | 4899 | No (< 10 000) | $CTE(10\,000) = 40\,000 + 20\,000 + 4800 = 64\,800$ | 64 800 |
> | 11 | 4,1 | **4839** | **Sí** | $CTE = 44\,000 + \sqrt{2 \cdot 12\,000 \cdot 4000 \cdot 4{,}1} = 63\,839$ | **63 839**, fin |
>
> **Fabricar lotes de 4839 parlantes**, con un costo de \$63 839 por mes. Los descuentos no compensan: para llegar a 10 000 unidades hay que mantener mucho stock con un $c_1$ alto.

**D6. Ejercicio 6 (Speedy Wheels).** 500 bicicletas/mes, $K = 1000$, $b = 400$, capital comprometido 15% anual y \$40 anuales de guarda. (b) Costo de faltante: \$150 por bicicleta y por año.

> [!check]- Ver respuesta
> $D = 6000$/año y $c_1 = 0{,}15 \cdot 400 + 40 = \$100$ por bicicleta y por año.
>
> **(a)** $q^* = \sqrt{2 \cdot 1000 \cdot 6000/100} = \mathbf{346{,}4}$ bicicletas (unas 3 semanas de venta). $CVT = \sqrt{2 \cdot 1000 \cdot 6000 \cdot 100} = \mathbf{\$34\,641}$ por año.
>
> **(b)** Con $c_2 = 150$:
> - $q^* = 346{,}4\sqrt{250/150} = \mathbf{447{,}2}$.
> - $S^* = 346{,}4\sqrt{150/250} = \mathbf{268{,}3}$.
> - Faltante máximo $= \mathbf{178{,}9}$.
> - $CVT = 34\,641\sqrt{0{,}6} = \mathbf{\$26\,833}$ (−22,5%).
> - Hay stock el 60% del tiempo.

**D7. Ejercicio 7 (Computer Center, la Power).** 13 por semana, $b = 3000$, entrega en media semana, $c_1 = 20\%$ de $b$, $K = 75$. (e) Costo de faltante: \$200 por computadora y por año.

> [!check]- Ver respuesta
> $D = 13 \cdot 52 = 676$/año y $c_1 = \$600$ por unidad y por año.
>
> **(a)** Con $q = 5$: $CVT = 75 \cdot 676/5 + \frac12 \cdot 5 \cdot 600 = 10\,140 + 1500 = \mathbf{\$11\,640}$ por año, más la compra de $3000 \cdot 676 = \$2\,028\,000$.
>
> **(b)** $q^* = \sqrt{2 \cdot 75 \cdot 676/600} = \sqrt{169} = \mathbf{13}$.
>
> **(c)** Se pide en promedio **una vez por semana** ($13/13$). Se pide cuando quedan $SR = 0{,}5 \cdot 13 = \mathbf{6{,}5}$ computadoras.
>
> **(d)** $CVT^* = \sqrt{2 \cdot 75 \cdot 676 \cdot 600} = \$7800$. La reducción es de **\$3840 (33%)**. Con sensibilidad: $\alpha = 5/13$ y $\lambda = 1{,}492$.
>
> **(e)** Con $c_2 = 200$: $CVT = 7800\sqrt{200/800} = \mathbf{\$3900}$, es decir, **\$3900 menos (−50%)**. La política es $q^* = 26$ y $S^* = 6{,}5$, con un faltante máximo de 19,5. Hay stock solo el 25% del tiempo, porque $c_1$ es el triple de $c_2$.

**D8. Ejercicio 8 (Honest Henry, Tritón).** $K = 1500$, $c_1 = 3000$ por auto y por año, $c_2 = 1000$, $D = 900$/año, nivel de servicio 75%, demanda en el $LT \sim N(50, 15)$.

> [!check]- Ver respuesta
> **(a)**
> - **Cantidad** (EOQ clásico, como en las diapos): $q = \sqrt{2 \cdot 1500 \cdot 900/3000} = \mathbf{30}$ autos.
> - Hillier usa el EOQ con faltantes: $30\sqrt{4000/1000} = 60$ autos. Conviene aclarar el criterio.
> - **Stock de reorden:** $P(x \le SR) = 0{,}75$, así que $SR = 50 + 0{,}674 \cdot 15 = \mathbf{60{,}1 \approx 60}$ autos.
>
> **(b)** Stock de seguridad $= SR - E[x] = 60 - 50 = \mathbf{10}$ autos.

**D9. Ejercicio 9 (J. C. Ward, heladeras).** 80 por mes, entrega en 1 semana, demanda en el $LT \sim U(10, 30)$, $K = 100$, $c_1 = 15$/mes, $c_2 = 3$/mes, nivel de servicio (medida 1) 0,8.

> [!check]- Ver respuesta
> **(a)**
> - $SR = 10 + 0{,}8 \cdot (30 - 10) = \mathbf{26}$ y stock de seguridad $= 26 - 20 = 6$.
> - $q = \sqrt{2 \cdot 80 \cdot 100/15} = \mathbf{32{,}7}$ por pedido (EOQ clásico). Con Hillier: $32{,}7\sqrt{18/3} = 80$.
>
> **(b)** Con 960 heladeras por año hay $960/32{,}7 = 29{,}4$ ciclos por año. Cada ciclo tiene probabilidad 0,2 de faltante, así que hay unos **5,9 ciclos con faltante por año**. Con $q = 80$: 12 ciclos y **2,4 por año**.
>
> Si se lo interpreta como **unidades faltantes**: el faltante esperado por ciclo es $(30 - 26)^2/(2 \cdot 20) = 0{,}4$. Da 11,8 unidades por año ($q = 32{,}7$) o 4,8 ($q = 80$).

**D10. Examen final 19/12/2017, ejercicio 3 (Shopalot).** 10 000 cajas de soda por año, \$5 por pedido, mantener una caja un año cuesta el 20% del precio. Precios: \$4,40 si $q < 200$, \$4,20 si $200 \le q < 400$ y \$4,00 si $q \ge 400$. ¿Cuánto pedir, cuántos pedidos por año y cuál es el costo anual?

> [!check]- Ver respuesta
> | $b_i$ | $c_1 = 0{,}2\,b_i$ | $q_i^*$ | ¿Factible? | Costo evaluado |
> |---|---|---|---|---|
> | 4,00 | 0,80 | 353,6 | No (< 400) | $CTE(400) = 40\,000 + 160 + 125 = 40\,285$ |
> | 4,20 | 0,84 | 345,0 | Sí | $CTE = 42\,000 + 289{,}8 = 42\,290$ (no mejora) |
>
> **Pedir 400 cajas**, $10\,000/400 = 25$ pedidos por año. Costo anual: **\$40 285**.

---

# Parte E — Integradoras

**E1.** ¿Qué tipo de problema de optimización es el EOQ básico? ¿Y el EOQ con faltantes? ¿Por qué alcanza con igualar las derivadas a cero?

> [!check]- Ver respuesta
> - El **EOQ básico** es un **PNL irrestricto de una variable**: $\min CTE(q)$ con $q > 0$. Como $CTE''(q) = 2KD/q^3 > 0$, es **convexa**, y en una minimización convexa todo mínimo local es global. Por eso alcanza la condición de primer orden $CTE'(q) = 0$.
> - El **EOQ con faltantes** es un **PNL irrestricto de dos variables** $(q, S)$. Los términos $S^2/q$ y $(q - S)^2/q$ son convexos para $q > 0$ (son "cuadrado sobre lineal") y $KD/q$ también. Entonces el gradiente nulo da el mínimo global.
> - El **modelo estocástico** también se resuelve con las condiciones de primer orden, pero el sistema no tiene solución cerrada y hay que iterar (Hadley–Whitin), como los métodos numéricos del Parcial 2.

**E2.** *(complemento)* Una empresa maneja $n$ productos que comparten un depósito de superficie $A$. Cada producto ocupa $s_i$ por unidad. Plantee el problema y encuentre la forma del lote óptimo.

> [!check]- Ver respuesta
> **Planteo:**
> $$\min \sum_i \left(\frac{K_iD_i}{q_i} + \tfrac12\,q_i\,c_{1i}\right) \quad \text{s.a.} \quad \sum_i s_i\,q_i \le A$$
> Es un **PNL con una restricción de desigualdad**: se usa KKT.
> - Si los EOQ individuales entran en el depósito, la restricción no está activa ($\lambda = 0$) y cada producto usa su EOQ.
> - Si no entran, la restricción está activa. Del lagrangiano:
> $$-\frac{K_iD_i}{q_i^2} + \tfrac12 c_{1i} + \lambda s_i = 0 \Rightarrow q_i = \sqrt{\frac{2K_iD_i}{c_{1i} + 2\lambda s_i}}$$
> Se busca $\lambda > 0$ tal que $\sum s_i q_i = A$.
>
> **Interpretación:** $\lambda$ es el costo de un m² más de depósito (precio sombra). Funciona como si el costo de mantener fuera más alto.

**E3.** ¿Qué relación hay entre los modelos de pronóstico (Parcial 2) y los modelos de stock?

> [!check]- Ver respuesta
> - La **demanda $D$** que usan los modelos de stock sale de un **pronóstico**. La clasificación de la demanda supone datos confiables para pronosticar.
> - Si el pronóstico se equivoca en un 30%, el análisis de sensibilidad dice que el costo sube menos del 1% (raíz cuadrada y $\lambda$ plano).
> - La **incertidumbre del pronóstico** (por ejemplo, el desvío de los errores, como el RMSE) es lo que se usa como $\sigma$ para dimensionar el **stock de seguridad**. Un mejor pronóstico permite tener menos stock.
> - Si la demanda tiene **tendencia o estacionalidad** (Holt, Winters), ya no es constante: es una demanda determinística variable o probabilística no estacionaria, y el EOQ clásico deja de ser adecuado.

**E4.** Compare el modelo con faltantes admitidas (determinístico) con el modelo estocástico de revisión continua. ¿Por qué aparecen faltantes en cada uno?

> [!check]- Ver respuesta
> - En el **determinístico**, los faltantes son **planeados**: se decide tenerlos porque mantener stock es caro, y se sabe exactamente cuándo y cuántos habrá ($q - S$ en cada ciclo).
> - En el **estocástico**, los faltantes son **aleatorios**: aparecen solo en los ciclos en que la demanda del $LT$ supera a $SR$. El stock de seguridad $SR - E[x]$ reduce su probabilidad.
> - Además, $c_2$ se mide distinto: por unidad y por tiempo en el determinístico, por unidad faltante en el estocástico de las diapos.

---

# Simulacros

> [!example] Simulacro 1 — Teoría (40 min)
> A2 · A4 · A6 · A10 · A13 · B1 · B5 · B9 · B15

> [!example] Simulacro 2 — Práctica (60 min)
> D1 (a, b, c, g) · D5 · D7 · C6 · B14 · E1

> [!example] Simulacro 3 — Mixto (50 min)
> A8 · A16 · B10 · B12 · D3 · D8 · D10
