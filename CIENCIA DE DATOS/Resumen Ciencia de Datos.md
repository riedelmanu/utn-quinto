---
tipo: resumen
materia: Ciencia de Datos
tags: [resumen, ciencia-de-datos]
---
# Resumen de estudio — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · [[Inicio]] · Preguntas respondidas: [[Preguntas de estudio - Ciencia de Datos]]

> [!info] Cómo usar este resumen
> Una sección por unidad, con link a las diapositivas originales. Las partes marcadas como *(complemento)* no están textuales en las diapos (o estaban solo como imagen) y las agregué para que el tema cierre.

**Índice**
- [[#0. Introducción]]
- [[#1. Metodologías para proyectos de Ciencia de Datos]]
- [[#2. Conocimiento de los Datos]]
- [[#3. Preparación de los Datos]]
- [[#4. Modelado — Regresión Lineal]]
- [[#5. Modelado — Clasificación]]
- [[#6. Modelado — Validación]]
- [[#7. Modelado — Agrupamiento]]
- [[#8. Modelado — Asociaciones]]
- [[#9. Modelado — Detección de Anomalías]]
- [[#10. Minería de Texto]]
- [[#11. Sistemas Recomendadores]]
- [[#Preguntas de repaso]]

---

## 0. Introducción
📎 [[Clase 1 - Introduccion.pdf]]

**Ciencia de Datos / BI:** conjunto de técnicas, herramientas y metodologías para transformar **datos en conocimiento** novedoso, oportuno y útil para la **toma de decisiones estratégicas** en una organización.

**Breve historia:** búsqueda de patrones → estadística → computación (más cálculo) → internet (explosión de almacenamiento) → IA (conocimiento más complejo).

**Big Data — las 3 V:** **Volumen**, **Velocidad**, **Variedad**.

**OLTP vs OLAP** *(complemento)*: OLTP = sistemas transaccionales (operación diaria, muchas escrituras cortas). OLAP = sistemas analíticos (consultas agregadas sobre históricos, para decidir).

### Tipos de analíticas (modelos)
| Tipo | Pregunta | Qué da |
|---|---|---|
| **Descriptiva** | ¿Qué pasó? ¿Qué está pasando? | Visión general: reportes, dashboards |
| **Predictiva** | ¿Qué va a pasar? ¿Por qué? | Proyecciones, alarmas, tendencias |
| **Prescriptiva** | ¿Qué debo hacer? ¿Por qué? | Cursos de acción con mayor probabilidad de lograr objetivos |

**Machine Learning:** rama de la IA que estudia cómo los sistemas aprenden a partir de datos. En minería de datos se usa para **generalizar patrones**; puede ser descriptivo o predictivo. (Ejemplo clásico de la diapo: dataset *clima → juega o no*.)

**Roles:** Analista de Datos, Científico de Datos, Ingeniero de Datos, Ingeniero en IA, GenAI Engineer.
**Herramientas:** Visualización (Tableau, Power BI, Qlik, Python) · Modelado (Python, R, Keras, TensorFlow, RapidMiner, WEKA) · Big Data (GCP, Azure, AWS, Databricks, Spark) · Orquestación (Docker, Kubernetes).

---

## 1. Metodologías para proyectos de Ciencia de Datos
📎 [[Clase 2 - CRISPDM.pdf]]

- **Ciencia de datos:** sistematiza el *proceso* de extracción de conocimiento.
- **Minería de datos:** los *algoritmos* que encuentran patrones implícitos (estadística, IA, ML, visualización).
- **Motivación:** igual que la crisis del software dio origen a la Ingeniería de Software, aplicar algoritmos "a las apuradas" sin gestión no satisface a los stakeholders → hacen falta metodologías.

### KDD (Fayyad et al., 1996)
Primer intento de generalizar el proceso. **Problemas:**
1. Se centra solo en lo técnico (preparación y evaluación técnica).
2. No tiene en cuenta los intereses del cliente.
3. No contempla la implementación del conocimiento obtenido.

### CRISP-DM (1999)
*Cross Industry Standard Process for Data Mining.* Diseñado por más de 300 organizaciones; incorpora buenas prácticas; abierto; incluye actividades de **negocio**; dice **el qué, no el cómo**; independiente de herramientas.

| # | Fase | Actividades clave |
|---|---|---|
| 1 | **Entendimiento del negocio** | Objetivos de negocio → objetivos de minería de datos; recursos; plan. *¿Qué quiere lograr el cliente? ¿Restricciones?* |
| 2 | **Entendimiento de los datos** | Adquirir, explorar, verificar calidad; patrones obvios; hipótesis |
| 3 | **Preparación de los datos** | Selección, integración, limpieza, formateo, transformación. **~90 % del tiempo**, iterativa |
| 4 | **Modelado** | Elegir técnicas, diseñar tests, construir y evaluar modelo. Se cicla con la fase 3 |
| 5 | **Evaluación** | Contra los **objetivos de negocio**; decidir cómo usar resultados |
| 6 | **Implementación** | Informes, herramientas para la toma de decisiones |

**¿Por qué CRISP-DM?** Genérico, uniforme y estándar; lenguaje común; flexible; independiente de herramientas; actividades bien definidas.

---

## 2. Conocimiento de los Datos
📎 [[Clase 3 - Conocimiento de los datos-1.pdf]] · [[Clase 3 - Visualizaciones de datos-1.pdf]]

Fase 2 de CRISP-DM: ver si los datos sirven, planificar la preparación y extraer patrones triviales (correlaciones simples).

**Vocabulario:** dato = ejemplo = instancia = fila = objeto. Atributo = dimensión = variable = columna. Univariado vs multivariado.

### Tipos de atributos
| Tipo | Descripción | Ejemplo | Medidas válidas |
|---|---|---|---|
| **Nominal** (categórico) | Nombres/categorías, aunque sean números | Color de ojos, estado civil | Moda |
| **Binario** | Nominal con 2 estados. **Simétrico** (igual peso) o **asimétrico** | Arg/Extranjero · Test +/− | Moda |
| **Ordinal** | Nominal con orden; magnitud entre valores desconocida | Niño < Adolescente < Adulto | Moda, **mediana** (no promedio) |
| **Numérico intervalado** | Escala equiespaciada, sin cero absoluto; tiene sentido la diferencia | °C, fechas | Diferencias, media |
| **Numérico ratio** | Con **cero absoluto** | Kelvin, peso, precio, años de experiencia | Todo (cocientes, media, mediana…) |

**Discretos** (conjunto finito o infinito numerable) vs **continuos** (reales).

### Medidas de tendencia central
- **Media:** $\bar{x} = \frac{1}{n}\sum x_i$ — **sensible a extremos**.
- **Mediana:** valor que parte los datos ordenados en dos mitades (si *n* es par, promedio de los dos centrales). Mejor para datos asimétricos.
- **Moda:** valor más frecuente; sirve para cualitativos; puede ser **multimodal** o no existir.
- Comparándolas se detecta **sesgo** (simétrico: media ≈ mediana ≈ moda).

### Medidas de dispersión
- **Varianza:** $\sigma^2 = \frac{1}{n}\sum (x_i-\bar{x})^2$ · **Desviación estándar** $\sigma = \sqrt{\sigma^2}$. Sirve para detectar **outliers**.
- **Rango** = máx − mín. **Cuartiles** Q1, Q2 (mediana), Q3: dividen en 4 partes de 25 %. **IQR = Q3 − Q1**.

### Visualización
| Gráfico | Uso |
|---|---|
| **Histograma / barras** | Distribución de frecuencias (barras si es nominal; *bins* si es numérico) |
| **Boxplot** | Resumen de 5 números: mín, Q1, Q2, Q3, máx. Bigotes hasta 1,5·IQR; lo que queda afuera = **outlier** |
| **Scatterplot** | Correlación/patrón entre 2 numéricos; muestra clusters y anomalías |
| **Scatterplot matrix** | Todos los pares de variables |
| **Dimensiones extra** | Color, forma, tamaño; heatmaps; gráfico radial; caras de Chernoff (n<19) |

---

## 3. Preparación de los Datos
📎 [[Clase 4 - Preparacion de los datos.pdf]]

Mala calidad de datos → malos resultados. **Factores de calidad:** precisión (ruido/errores), completitud, consistencia, credibilidad, interpretabilidad.

**Actividades principales:** Selección → Limpieza → Integración → Reducción → Transformación.

### Limpieza
**Valores faltantes — estrategias:**
1. **Ignorar la tupla** (si falta la clase u otros atributos; cuidado con perder demasiadas).
2. **Completar a mano** (costoso).
3. **Constante global** ("unknown") — el algoritmo la toma como valor válido.
4. **Medida de tendencia central** (media/mediana, idealmente **por clase**).
5. **Valor más probable** (predicho con otro modelo).
> Ojo: un faltante puede tener **semántica** (no siempre es error).

**Ruido** (error aleatorio de medición) — suavizado:
- **Binning:** ordenar, dividir en contenedores y reemplazar por media, mediana o fronteras.
  *Ejemplo* {4, 8, 15, 21, 21, 24, 25, 28, 34}, bins de 3:
  - Por medias: (9, 9, 9) (22, 22, 22) (29, 29, 29)
  - Por fronteras: (4, 4, 15) (21, 21, 24) (25, 25, 34)
- **Regresión:** reemplazar por el valor de la función ajustada.
- **Detección de anomalías / clustering:** lo que queda fuera de los grupos se reemplaza o elimina.

### Integración
- **Problema de identificación de entidades:** qué atributos coinciden entre fuentes (ID vs DNI), semántica de vacíos, atributos dependientes (descuento por factura vs por línea).
- **Redundancia:** atributos derivables (edad ↔ fecha de nacimiento), detectable con **correlación**.
- **Filas duplicadas** (tablas desnormalizadas) → una fila por entidad.
- **Conflictos de valores:** unidades/escala/codificación distintas (pies vs metros).

### Reducción
- **Dimensionalidad** (menos atributos): Wavelet, **PCA** (proyectan a menos dimensiones), **selección de subconjunto de atributos** (elimina irrelevantes).
- **Numerosidad** (menos filas): paramétricos (regresión: guardo solo parámetros) y no paramétricos (muestreo, clusters).

### Transformación
Construcción de atributos · Agregación (diario → mensual) · **Normalización** · **Discretización** · Jerarquías conceptuales (calle → ciudad → provincia).

*(complemento — "Investigar")*
- **Min-max:** $x' = \frac{x-\min}{\max-\min}$ → [0, 1]
- **Z-score:** $x' = \frac{x-\bar{x}}{\sigma}$
- **Escalado decimal:** $x' = x/10^j$
- Discretización: igual ancho, igual frecuencia, por clustering, basada en entropía.

---

## 4. Modelado — Regresión Lineal
📎 [[Clase 5 - Modelado 1 - regresion lineal.pdf]]

Caso: ventas vs inversión en publicidad (TV, radio, diario) en 200 mercados → *¿en qué conviene invertir?*

$$Y = f(\vec{x}) + \varepsilon$$

### ¿Para qué estimar f?
- **Predicción:** interesa $\hat{Y}$, no la forma de $f$ (caja negra). Error = **reducible** (método imperfecto) + **irreducible** (ε, factores no considerados → cota del modelo).
- **Inferencia:** interesa la **relación** (¿qué variables influyen y cómo?) → funciones simples.

**Aprendizaje supervisado:** se entrena con un **conjunto de entrenamiento** con X e Y conocidos.

| Paramétricos | No paramétricos |
|---|---|
| Asumen forma (ej. lineal) y estiman p+1 coeficientes | No asumen forma |
| Simples, interpretables | Mejor ajuste |
| Menos precisos si la forma no es la real | Necesitan más datos, complejos, sensibles al ruido |

**Trade-off precisión vs interpretabilidad**, según el objetivo (predicción vs inferencia).

### Regresión lineal
Relaciona predictores con una salida **numérica**. Simple e interpretable → muy usada para inferencia.
- **Simple:** $\hat{Y} = \hat\beta_0 + \hat\beta_1 x$
- **Residuo:** $e_i = y_i - \hat{y}_i$
- **Mínimos cuadrados:** minimizar $RSS = \sum e_i^2 = \sum (y_i - \hat\beta_0 - \hat\beta_1 x_i)^2$

$$\hat\beta_1 = \frac{\sum (x_i-\bar{x})(y_i-\bar{y})}{\sum (x_i-\bar{x})^2} \qquad \hat\beta_0 = \bar{y} - \hat\beta_1 \bar{x}$$

- **Múltiple:** $Y = \beta_0 + \beta_1 x_1 + \dots + \beta_p x_p + \varepsilon$, minimizando el RSS análogo.

---

## 5. Modelado — Clasificación
📎 [[Clase 6 - Modelado 1 - clasificacion.pdf]]

¿Respuesta **cualitativa**? Codificar clases como números y usar regresión **no sirve**: el orden/valor de la codificación cambia la función.

**Clasificación:** aprendizaje supervisado para predecir el atributo **clase** (cualitativo).
Técnicas: regresión logística, SVM, **árboles de decisión** (TDIDT: ID3, CART, C4.5, C5.0).

### Árboles de decisión
- Nodo interno = condición sobre un atributo · Rama = resultado de la condición · Hoja = clase.
- Se traducen a **reglas**: `IF Age = Youth AND Student = No → No`. Sirven para inferencia y predicción.

**Algoritmo básico (recursivo):**
1. Si el conjunto está vacío o todos son de la misma clase → fin.
2. Elegir una variable.
3. Particionar según sus valores.
4. Repetir en cada partición.

**¿Qué atributo elegir?** El que deje particiones más **puras** (árbol pequeño):
- **ID3 → Ganancia de información** (entropía de Shannon)
- **CART → Índice Gini** (impureza)

*(complemento — fórmulas)*
$$Entropía(D) = -\sum p_i \log_2 p_i \qquad Gain(A) = Entropía(D) - \sum_j \frac{|D_j|}{|D|} Entropía(D_j)$$
$$Gini(D) = 1 - \sum p_i^2$$

### Matriz de confusión y métricas
|  | Real 1 | Real 0 |
|---|---|---|
| **Predicho 1** | VP | FP |
| **Predicho 0** | FN | VN |

$$Accuracy = \frac{VP+VN}{VP+VN+FP+FN} \quad Sensitivity\ (Recall) = \frac{VP}{VP+FN} \quad Specificity = \frac{VN}{VN+FP}$$

**Ejemplo (droga, 5000 pacientes: 500 mueren, 4500 no):** VP = 150, VN = 4000 → FN = 350, FP = 500.
- Accuracy = 4150/5000 = **0,83**
- Specificity = 4000/4500 = **0,889**
- Sensitivity = 150/500 = **0,30** → **el 70 % de los que morirían no se detectan.**

> [!important] Moraleja
> Una accuracy alta no alcanza: hay que mirar el desempeño **por clase**, sobre todo la que es crítica para el negocio.

---

## 6. Modelado — Validación
📎 [[P8_Modelado-validacion.pdf]]

Supervisado: target **cuantitativo → regresión**; **cualitativo → clasificación**.
Medir la precisión sobre los propios datos de entrenamiento engaña: 100 % puede ser **overfitting** (el modelo "copia" los datos, no el patrón).

### Bias y varianza
| | Qué indica | Problema | Cómo reducirlo |
|---|---|---|---|
| **Bias alto** | El modelo no captura el fenómeno | **Underfitting** (ej. lineal para algo cuadrático) | Modelos más complejos/no paramétricos, datos representativos, buenos parámetros |
| **Varianza alta** | El modelo cambia mucho con otros datos | **Overfitting** | Modelos más simples/paramétricos, más datos (*data augmentation*), **ensambles** |

**Bias-variance tradeoff:** buscar el equilibrio (y considerar la interpretabilidad).

### Train / Test
Se parte el dataset etiquetado: $Train \cup Test = D$, $Train \cap Test = \emptyset$. Proporciones comunes **80/20** o **2/3–1/3**, con la **misma proporción de clases** en ambos.

**Muestreo:** aleatorio simple (no asegura proporción de clases) · **estratificado** (aleatorio dentro de cada clase) · por cuotas (no aleatorio) · sistemático ($pos_i = pos_{i-1} + k$).

### Validación cruzada
Varios muestreos sucesivos; se **promedian** los resultados → independiza el resultado de la partición.
- **LOOCV:** n iteraciones, entrena con n−1 y valida con 1; error = promedio (MSE). ✅ usa todos los datos, resultado único. ❌ muy costoso.
- **K-Folds:** k grupos al azar; cada uno es test una vez. Más eficiente que LOOCV a cambio de algo más de error; elegir k según el tiempo disponible (típico 5 o 10).

---

## 7. Modelado — Agrupamiento
📎 [[P11_Modelado-agrupamiento-DBSCAN.pdf]]

**Clustering:** particionar los datos en grupos con elementos **similares entre sí** y **distintos** de los de otros grupos (no supervisado).
Tipos: particionamiento (**K-Means**), jerárquicos, basados en grillas, basados en **densidad**.

### K-Means
Basado en **centroides**, iterativo, distancia **euclídea**.
*(complemento)* Pasos: elegir k centroides → asignar cada punto al más cercano → recalcular centroides → repetir hasta que no cambien.
**Inconvenientes:** costoso con muchos datos, muchas evaluaciones de distancia, solo encuentra **clusters esféricos** (y hay que fijar k).

### DBSCAN (1996)
*Density-Based Spatial Clustering of Applications with Noise.* Clusters = **regiones densas**; parámetros **ε** y **MinPts**. Detecta formas arbitrarias y **ruido**.

| Concepto | Definición |
|---|---|
| **ε-vecindario** de p | Objetos a distancia ≤ ε de p |
| **Objeto central (core)** | Tiene ≥ MinPts objetos en su ε-vecindario |
| **Directamente alcanzable (ddr)** | p está en el ε-vecindario de un core q |
| **Alcanzable por densidad (dr)** | Existe una cadena de objetos directamente alcanzables de q a p |
| **Densamente conectado (dc)** | p y r son alcanzables desde un mismo q |

**Algoritmo:** para cada objeto x no clasificado: si es core → crear cluster con todos los alcanzables por densidad desde x; si no → marcarlo como **ruido** (puede luego quedar como borde de otro cluster).
**Problema:** clusters de **densidades distintas** → los menos densos quedan como ruido (hay variantes, ej. OPTICS).

---

## 8. Modelado — Asociaciones
📎 [[P9_Modelado-asociaciones.pdf]]

Caso supermercado: transacciones = listas de productos → encontrar relaciones para armar promociones (*market basket analysis*).

- **Base transaccional:** $D = \{T_j \mid T_j \subseteq I,\ T_j \neq \emptyset\}$
- **Itemset frecuente:** subconjunto que aparece frecuentemente (interesan los **máximos**).
- **Regla de asociación:** $A \Rightarrow B$ con $A, B \neq \emptyset$, $A \cap B = \emptyset$.

$$support(A \Rightarrow B) = P(A \cup B) \qquad confidence(A \Rightarrow B) = P(B|A) = \frac{support(A \cup B)}{support(A)}$$

**Regla fuerte:** soporte ≥ min_sup **y** confianza ≥ min_conf.

*Ejemplo de la diapo* (T1 {Leche, Pan, Cereales}, T2 {Leche, Azúcar, Pan, Huevos}, T3 {Manteca, Pan, Leche}, T4 {Huevos, Azúcar}):
- {Leche} ⇒ {Pan}: supp = 3/4 = 0,75 · conf = 0,75/0,75 = **1**
- {Leche} ⇒ {Cereales}: supp = 1/4 = 0,25 · conf = 0,25/0,75 = **0,33**

### Algoritmo A-priori (Agrawal y Srikant, 1994)
1. Encontrar itemsets frecuentes **por niveles**: los de tamaño k se generan a partir de los frecuentes de tamaño k−1, mientras haya.
2. Para cada frecuente F y cada subconjunto A: probar $A \Rightarrow F - A$; si supera min_conf → regla fuerte.

**Propiedad A-priori (antimonótona):** todo subconjunto de un itemset frecuente es frecuente → si un subconjunto **no** es frecuente, se poda el candidato.

> [!example]- Ejercicio resuelto (dataset de la diapo 17, min_sup = 40 % elegido por mí)
> Transacciones: 1 {Pan, Manteca, Leche} · 2 {Huevos, Leche, Yogurt} · 3 {Pan, Queso, Huevos, Leche} · 4 {Huevos, Leche, Yogurt} · 5 {Queso, Leche, Yogurt}
> - **L1** (≥2): Leche 5, Huevos 3, Yogurt 3, Pan 2, Queso 2 (Manteca 1 ✗)
> - **L2:** {Leche, Huevos} 3, {Leche, Yogurt} 3, {Leche, Pan} 2, {Leche, Queso} 2, {Huevos, Yogurt} 2
> - **L3:** {Leche, Huevos, Yogurt} 2 (los demás candidatos se podan porque algún par no es frecuente)
> - **Reglas desde {L, H, Y}:** {H, Y}⇒L conf 1 · {L, H}⇒Y 0,67 · {L, Y}⇒H 0,67 · H⇒{L, Y} 0,67 · Y⇒{L, H} 0,67 · L⇒{H, Y} 0,4

**Representaciones:** **booleana** (matriz transacción × ítem con 0/1) y **por listas** (cada ítem → lista de transacciones que lo contienen; formato vertical).

---

## 9. Modelado — Detección de Anomalías
📎 [[P12_Modelado-anomalías.pdf]]

Caso: fraude con tarjeta de crédito (monto o lugar inusual).
**Anomalía (outlier):** objeto que se desvía significativamente de lo normal, *como si lo hubiera generado otro mecanismo*.

**Anomalía ≠ ruido:** el ruido es error aleatorio (se elimina en la preparación); la anomalía es interesante porque revela **otro mecanismo**.

### Tipos
- **Global:** se desvía de todo el dataset (ej. intrusiones en una red).
- **Contextual:** anómala en un contexto (28 °C en otoño).
- **Local:** contextual donde el contexto es la **densidad** del vecindario.
- **Colectiva:** un subconjunto que, junto, se desvía (100 paquetes demorados el mismo día).

### Enfoques
- **Supervisados:** expertos etiquetan normal/anormal → clasificador (re-entrenar periódicamente).
- **Semi-supervisados:** pocos datos etiquetados para modelar la normalidad.
- **No supervisados:** clustering; falla si los normales no tienen patrón y los anómalos sí.

### Técnicas
- **Estadísticas:** normales = región de alta probabilidad.
  - **Boxplot** (paramétrico, univariado): fuera de [Q1 − 1,5·IQR, Q3 + 1,5·IQR]; con distribución normal adentro queda el ~99,3 %.
  - **Histograma** (no paramétrico): cae en un bin de baja frecuencia → anómalo (depende del tamaño del bin).
- **Basadas en clustering** (complementario al agrupamiento):
  1. ¿No pertenece a ningún cluster? → outlier
  2. ¿Está muy lejos de su cluster más cercano? → outlier
  3. ¿Pertenece a un cluster chico/disperso y aislado? → todo el cluster es outlier
- Pendientes en la cursada: basadas en **distancia** y en **densidad** (ej. LOF).

---

## 10. Minería de Texto
📎 [[MineradeTexto.pdf]]

**Contexto:** Big Data (las 3 V) → gran parte de los datos son **no estructurados**, y la mayoría son **textos** (documentos, blogs, tweets). Hacen falta técnicas diseñadas para este tipo de dato.

**Minería de texto (*text mining*):** proceso de **extraer conocimiento** a partir de **datos textuales no estructurados**.

**Aplicaciones:** análisis de sentimientos (feedback de usuarios) · investigación de mercado (tendencias y modas) · detección de fraudes (reclamos fraudulentos) · investigación científica (patrones en papers, charlas).

### Terminología
| Término | Definición |
|---|---|
| **Corpus** | Colección de documentos de texto. Uno o varios idiomas · estático o dinámico · etiquetado o no |
| **Documento** | Unidad discreta de información textual dentro de la colección. Relación muchos a muchos con los corpus; puede no corresponder a un documento físico; semi-estructurado o no estructurado |
| **Características** | **Caracteres** (bolsa de caracteres, **n-gramas**) · **palabras** · **términos** (palabras o frases con carga semántica) · **conceptos** (categorización) |

Ejemplo de la diapo: *"Messi emprendió un viaje profesional hasta convertirse en el jugador más importante del mundo."* Se puede describir por sus caracteres, sus palabras, términos como "jugador más importante" o conceptos como *fútbol*.

### Preparación de textos
La minería de textos **depende mucho de la preparación**. Objetivo: crear **representaciones estructuradas** que "expongan" el significado del texto a los algoritmos. Tiene **tres partes**:

| # | Parte | Qué hace |
|---|---|---|
| 1 | **Preprocesamiento preparatorio** | Documento "crudo" → **secuencia de caracteres**. Sacar el texto de un PDF, imagen u audio; identificar la estructura (párrafos, columnas, conclusiones) y los metadatos (título, autores). Depende de la representación del texto |
| 2 | **Procesamiento de Lenguaje Natural (PLN)** | Procesamientos **generales**, independientes del problema; dependen del **idioma** |
| 3 | **Representación numérica** | Pasar el texto a **vectores** que puedan usar los algoritmos |

**PLN — tareas:**
- **Tokenización:** dividir el texto en palabras o términos (*tokens*).
- **Lematización:** llevar cada palabra a su **lema** (forma no flexionada por género, número, conjugación). *Huida, Huirá, Huiremos, Huyó → Huir*.
- **Etiquetado de partes del discurso (POS):** verbo, sustantivo, preposición, adjetivo… (o categorías especializadas).
- **Análisis sintáctico:** sujeto, predicado, modificadores, objetos, subordinadas.
- *(complemento)* **Stopwords** (sacar palabras vacías: "el", "de", "que"), **normalización** (minúsculas, tildes, puntuación) y **stemming** (cortar sufijos hasta la raíz; más rápido pero más tosco que lematizar).

> [!example] Ejemplo de la diapo (Chequeado, elecciones 2023)
> Palabras más repetidas en los discursos de Massa y Milei. "Argentina / Argentino / Argentinos", "Todos / Todas" y "Quiero / Queremos" se cuentan **por separado** aunque son la misma palabra → sin lematizar, el conteo se reparte y la representación pierde fuerza.

**Representación numérica:**
- **Bolsa de palabras (*bag of words*):** ignora el orden.
  - **Conjunto (set) / one-hot:** 1 si el término está en el documento, 0 si no.
  - **Vector de frecuencias:** cuántas veces aparece cada término.
- **TF-IDF:** **importancia** de un término en un documento.
  - **TF:** frecuencia relativa del término en el documento.
  - **IDF:** cuánta información aporta el término según si es **común o raro** en el corpus.

*(complemento — fórmulas)*
$$TF(t,d) = \frac{f_{t,d}}{|d|} \qquad IDF(t) = \log\frac{N}{n_t} \qquad TFIDF(t,d) = TF(t,d)\cdot IDF(t)$$
($N$ = cantidad de documentos, $n_t$ = documentos que contienen $t$.)

> [!example]- Ejemplo comparado (corpus de 3 documentos, log base 10)
> d1 = "el gato come pescado, el gato duerme" · d2 = "el perro come carne" · d3 = "el perro duerme"
>
> | d1 | el | gato | come | pescado | duerme | perro | carne |
> |---|---|---|---|---|---|---|---|
> | One-hot | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
> | Frecuencias | 2 | 2 | 1 | 1 | 1 | 0 | 0 |
> | TF-IDF | **0** | **0,136** | 0,025 | 0,068 | 0,025 | 0 | 0 |
>
> "el" aparece en los 3 documentos → IDF = log(3/3) = 0 → **no aporta nada**, aunque sea la más frecuente. "gato" es frecuente en d1 y no aparece en otros → es la que mejor **caracteriza** a d1.

- **Embeddings:** representación **vectorial densa** de una palabra, frase o concepto en un **espacio métrico**. Se busca que:
  - palabras **similares** queden **vecinas**;
  - las relaciones se conserven: la distancia de una palabra a su opuesto sea parecida a la de otro par (*man → woman ≈ king → queen*).
  - Ejemplo: **Word2Vec**. *(complemento)* Son vectores de pocas dimensiones (100–300) aprendidos del contexto, a diferencia de la bolsa de palabras: vectores enormes (un lugar por término del vocabulario), **dispersos** y sin semántica ("auto" y "coche" son ortogonales).

### Actividades de minería
- **Agrupamiento:** particionar la colección según su similitud. Sirven los algoritmos clásicos (K-Means) sobre los vectores, con cambios: **similitud coseno** como distancia, y el centroide **excluye las palabras poco frecuentes**.
- **Clasificación:** predecir la clase de los documentos. Los espacios son **dispersos**: la **presencia** de un término informa más que su ausencia. Algoritmos: **K-NN**, **clasificador de Bayes**, **SVM para espacios dispersos**.
- **Más:** descubrimiento de novedades, **modelado de temas**, búsqueda de asociaciones, búsqueda de anomalías.

### Similitud entre vectores de texto *(complemento — "Investigar")*
- **Coseno:** $\cos(\vec{a},\vec{b}) = \frac{\vec{a}\cdot\vec{b}}{\|\vec{a}\|\,\|\vec{b}\|}$ → mide el **ángulo**, no el largo. La más usada en texto y embeddings. Distancia coseno = 1 − cos.
- **Producto punto:** igual al coseno si los vectores están normalizados.
- **Euclídea / Manhattan:** dependen de la **magnitud** (un documento largo queda "lejos" aunque hable de lo mismo).
- **Jaccard:** $\frac{|A \cap B|}{|A \cup B|}$, para representaciones de **conjunto** (one-hot).

📓 Práctica: `3.07.gdr.text_mining.ipynb` → análisis de sentimientos sobre reseñas de Amazon con **TF-IDF + regresión logística**.

---

## 11. Sistemas Recomendadores
📎 [[Ciencia_de_datos___Sistemas_recomendadores.pdf]]

En la web se pide **feedback** a los usuarios: **explícito** (Netflix pregunta si te gustó una película) o **implícito** (basado en las interacciones con el sitio).

**Idea:** **predecir las preferencias** de los usuarios.
- **Usuario:** entidad que tiene preferencias y a la que le recomendamos.
- **Item:** producto o servicio que se recomienda.
- Se recomienda a partir de las **interacciones históricas** usuario–item.

**Hipótesis:** hay **dependencias significativas** entre usuarios y actividades alrededor de los items (quien ve un documental histórico probablemente quiera más documentales que películas de acción). Se aprenden de la **matriz de ratings**; **más interacciones** → mejores predicciones.

### Formulación del problema
| Versión | Qué se busca |
|---|---|
| **Predicción** | El rating de un par (usuario, item). Matriz **incompleta** $M_{m \times n}$ (m usuarios, n items): con los valores observados se predicen los faltantes → *matrix completion problem* |
| **Ranking** | No hace falta toda la matriz: solo los **top-k items** para un usuario (o top-k usuarios para un item) → *top-k recommendation problem* |

### Objetivos
Negocio: **aumentar la ganancia** por venta de productos o servicios. Para eso las recomendaciones deben tener:
- **Relevancia:** interesantes para el usuario.
- **Novedad:** items que el usuario **no consumió** antes.
- **Serendipia:** cierta **sorpresa**, descubrir preferencias que no había considerado.
- **Diversidad:** si hay variedad, es más probable que elija al menos uno.

### Tipos
Datos que usan: **interacciones** usuario–item (ratings, comportamiento) y **características** (atributos) de usuarios e items.

| Tipo | Usa | Idea |
|---|---|---|
| **Filtro colaborativo** | Interacciones de **muchos usuarios** | Matriz **dispersa** (cada usuario consumió una mínima parte). Se "imputan" los faltantes, porque los ratings están muy correlacionados entre usuarios e items |
| **Basado en contenido** | Preferencias + **atributos de los items** | Le gustó *Terminator* y no hay datos de otros usuarios → buscar películas con descripción parecida. Por usuario: modelo de **regresión o clasificación** con las descripciones de los items que consumió y sus puntajes |
| *(complemento)* **Basado en conocimiento** | **Requisitos explícitos** del usuario + conocimiento del dominio | Reglas/restricciones o casos similares. Para items que se compran poco (casas, autos) |
| *(complemento)* **Híbrido** | Combinación | Suma las ventajas (ej. contenido para items nuevos + colaborativo para el resto) |

**Filtro colaborativo — variantes:**
- **Basados en vecindarios:**
  - **User-based:** el rating de (usuario, item) se imputa con lo que opinan **de ese item** los **usuarios con preferencias similares**.
  - **Item-based:** se imputa con lo que opinó **ese usuario** de **items similares**.
- **Basados en modelos:** un modelo de **machine learning** aprende las relaciones implícitas (ej. **factorización de matrices**).

> [!example] Ejemplo de la diapo (5 usuarios × 4 apps; ¿le gusta el item 3 al usuario 5?)
> | | Item 1 | Item 2 | Item 3 | Item 4 |
> |---|---|---|---|---|
> | U1 | ♥ | ✗ | ♥ | ♥ |
> | U2 | | ♥ | ✗ | ✗ |
> | U3 | ♥ | ♥ | ✗ | |
> | U4 | ✗ | | ♥ | |
> | **U5** | ♥ | ♥ | **?** | ✗ |
>
> - **User-based:** los usuarios parecidos a U5 son **U2 y U3** (coinciden en los items 1, 2 y 4). Los dos dieron ✗ al item 3 → **predicción ✗**.
> - **Item-based:** el item más parecido al 3 es el **4** (U1 y U2 los calificaron igual). U5 le dio ✗ al item 4 → **predicción ✗**.

*(complemento — fórmulas)*
- Similitud entre usuarios: **Pearson** o **coseno** sobre los ratings en común (centrados por la media de cada usuario).
- Predicción user-based: $\hat{r}_{uj} = \mu_u + \frac{\sum_{v \in P_u(j)} sim(u,v)\,(r_{vj} - \mu_v)}{\sum_{v \in P_u(j)} |sim(u,v)|}$ ($P_u(j)$ = los k usuarios más similares a u que puntuaron j).
- **Factorización (SVD):** $M \approx U_k \Sigma_k V_k^T$. Usuarios e items quedan en un espacio de **k factores latentes** y el producto reconstruye la matriz **completa**.

**Cold start (inicio frío)** *(complemento)*: usuario o item **nuevo, sin interacciones** → el filtro colaborativo no puede recomendar. Se resuelve con contenido, conocimiento, popularidad, preguntas de onboarding o sistemas híbridos (ver [[Preguntas de estudio - Ciencia de Datos#Unidad 11 — Sistemas recomendadores|preguntas]]).

📓 Práctica (MovieLens): `3.08.gdr.user-based_reccomendation_system.ipynb` (user-based con similitud coseno) · `3.09.gdr.matrix_factorization.ipynb` (SVD con k = 50).

---

## Preguntas de repaso
> Las preguntas oficiales de la cátedra, respondidas, están en [[Preguntas de estudio - Ciencia de Datos]].

- [ ] ¿Diferencia entre analítica descriptiva, predictiva y prescriptiva? Dar un ejemplo de cada una.
- [ ] ¿Qué le falta a KDD que sí tiene CRISP-DM? Nombrar las 6 fases en orden.
- [ ] ¿Por qué no se puede calcular el promedio de un atributo ordinal?
- [ ] Diferencia entre atributo intervalado y ratio.
- [ ] ¿Cuándo conviene la mediana en lugar de la media?
- [ ] Nombrar 5 estrategias para tratar valores faltantes y sus desventajas.
- [ ] Aplicar binning por medias y por fronteras a un conjunto dado.
- [ ] Error reducible vs irreducible. Predicción vs inferencia.
- [ ] Métodos paramétricos vs no paramétricos: ventajas y desventajas.
- [ ] ¿Por qué no usar regresión lineal para una clase cualitativa?
- [ ] Calcular accuracy, sensitivity y specificity a partir de una matriz de confusión.
- [ ] Bias alto vs varianza alta: síntoma y solución.
- [ ] LOOCV vs K-Folds.
- [ ] ¿Por qué K-Means falla con clusters no esféricos y DBSCAN no?
- [ ] Definir objeto central, ddr, dr y dc en DBSCAN.
- [ ] Calcular soporte y confianza de una regla. Enunciar la propiedad A-priori.
- [ ] Diferencia entre ruido y anomalía. Tipos de anomalías.
- [ ] Nombrar las tres partes de la preparación de textos y qué hace cada una.
- [ ] Tokenización vs lematización vs stemming. ¿Qué problema muestra el ejemplo de Chequeado?
- [ ] Calcular one-hot, frecuencias y TF-IDF de un documento. ¿Por qué una palabra muy frecuente puede tener TF-IDF 0?
- [ ] ¿Por qué se usa similitud coseno en texto y no distancia euclídea?
- [ ] Relevancia, novedad, serendipia y diversidad: definir cada una.
- [ ] Problema de predicción vs problema de ranking.
- [ ] Resolver una matriz chica con user-based y con item-based.
- [ ] Colaborativo vs contenido vs conocimiento. ¿Cuál sirve ante un cold start?
