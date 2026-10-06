---
tipo: resumen
materia: Ciencia de Datos
tags: [resumen, preguntas, ciencia-de-datos]
---
# Preguntas de estudio — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · Teoría en [[Resumen Ciencia de Datos]]

> [!info] Cómo leer esto
> Las respuestas se basan en las diapositivas. Lo que la cátedra pide **investigar** (o que no está en las diapos) está marcado con *(investigar)*. Los "📓" indican el notebook del repo `ciencia-de-datos/notebooks/` donde se ve el tema en práctica.
> "Explotación de información" y "ciencia de datos" se usan como sinónimos.

**Unidades:** [[#Unidad 1 — Metodologías|1]] · [[#Unidad 2 — Conocimiento de los datos|2]] · [[#Unidad 3 — Preparación de los datos|3]] · [[#Unidad 4 — Regresión lineal|4]] · [[#Unidad 5 — Clasificación|5]] · [[#Unidad 6 — Validación|6]] · [[#Unidad 7 — Agrupamiento|7]] · [[#Unidad 8 — Asociaciones|8]] · [[#Unidad 9 — Detección de anomalías|9]]

---

## Unidad 1 — Metodologías

### ¿Por qué es necesario usar una metodología o modelo de proceso para guiar los proyectos de ciencia de datos?
Por la misma razón por la que nació la Ingeniería de Software tras la **crisis del software**: si se aplican algoritmos de minería de datos "a las apuradas", sin gestionar recursos, objetivos ni calidad, el proyecto no responde a las necesidades de los stakeholders. Una metodología:
- **sistematiza** el proceso de extracción de conocimiento (qué actividades, en qué orden, qué entregables);
- conecta los **objetivos del negocio** con los objetivos técnicos de minería de datos;
- da un **lenguaje común** al equipo y al cliente;
- permite **planificar, controlar y asegurar la calidad**, y hace el proceso repetible.

### ¿Cuáles son las actividades involucradas en KDD?
KDD (*Knowledge Discovery in Databases*, Fayyad et al., 1996):
1. **Selección:** elegir los datos objetivo.
2. **Preprocesamiento:** limpieza (ruido, faltantes).
3. **Transformación:** reducción y proyección de atributos, formato adecuado.
4. **Minería de datos:** aplicar algoritmos para encontrar patrones.
5. **Interpretación / evaluación:** analizar los patrones y convertirlos en conocimiento.

*(Las diapos muestran el proceso como imagen; estos son los 5 pasos clásicos de Fayyad.)*

### ¿Con qué necesidad surge CRISP-DM?
De las **falencias de KDD**:
- KDD se centra en lo técnico (preparar los datos, aplicar algoritmos, evaluar técnicamente);
- **no tiene en cuenta los intereses del cliente**;
- **no contempla la implementación** del conocimiento obtenido.

Hacía falta un proceso **estándar, independiente de la industria y de las herramientas**, que incluyera las actividades de **negocio**. CRISP-DM surgió en 1999, diseñado por más de 300 organizaciones.

### ¿Cómo se estructura?
De forma **jerárquica**, en 4 niveles de abstracción (de lo general a lo particular):
1. **Fases** (6).
2. **Tareas genéricas:** comunes a cualquier proyecto (ej. "verificar la calidad de los datos").
3. **Tareas especializadas:** cómo se lleva a cabo la tarea genérica en un contexto (ej. "limpiar valores numéricos faltantes").
4. **Instancias de proceso:** lo que efectivamente se hizo en un proyecto concreto (registro de acciones y resultados).

Además define **qué** hacer, no **cómo** hacerlo.

### ¿Cuáles son sus fases?
1. **Entendimiento del negocio:** objetivos de negocio, recursos, objetivos de minería de datos, plan.
2. **Entendimiento de los datos:** recolectar, describir, explorar y verificar la calidad.
3. **Preparación de los datos:** seleccionar, limpiar, construir, integrar y formatear (~90 % del tiempo).
4. **Modelado:** elegir técnicas, diseñar las pruebas, construir y evaluar técnicamente el modelo.
5. **Evaluación:** ¿los resultados cumplen los **objetivos de negocio**? Revisar el proceso y decidir los próximos pasos.
6. **Implementación:** informes y herramientas para usar los resultados; plan de monitoreo y mantenimiento.

### ¿Cuál es el ciclo de vida?
Las 6 fases forman un **ciclo iterativo, no lineal**:
- el orden **no es rígido**: se vuelve atrás cuando hace falta;
- hay idas y vueltas habituales: **Negocio ↔ Datos** y **Preparación ↔ Modelado** (cada técnica pide los datos de una forma distinta);
- **Evaluación → Negocio:** si los resultados no satisfacen, se replantea el problema;
- el **círculo exterior** del diagrama indica que el proyecto mismo es cíclico: lo aprendido y lo implementado generan nuevas preguntas de negocio y nuevos proyectos.

### ¿Por qué usar CRISP-DM en vez de KDD?
| KDD | CRISP-DM |
|---|---|
| Solo actividades técnicas | Incluye **entendimiento del negocio** y evaluación contra objetivos de negocio |
| No considera al cliente | Parte de los requerimientos de los stakeholders |
| Termina en el patrón | Incluye la **implementación** del conocimiento |
| Proceso académico | **Estándar** de la industria, abierto, con buenas prácticas, independiente de herramientas |

Además es genérico y flexible (sirve para muchos tipos de problemas y de datos), da un lenguaje común y sus actividades están bien definidas. Por eso sigue siendo la metodología más usada.

---

## Unidad 2 — Conocimiento de los datos
📓 `1.01.gdr.data-preparation.ipynb` (shape, info, describe, boxplots)

### ¿Por qué es de suma importancia conocer los datos con los que contamos?
- Para determinar si los datos son **adecuados** para extraer conocimiento útil (si alcanzan para los objetivos del proyecto).
- Para **planificar la preparación**: detectar faltantes, ruido, outliers, tipos incompatibles e inconsistencias.
- Para extraer **patrones obvios o triviales** (ej. correlaciones simples) y formular hipótesis.
- Porque la baja calidad de los datos **se traslada a los resultados** ("garbage in, garbage out").
- Para que todos los participantes entiendan la **semántica** de cada atributo.

### ¿Qué aspectos de los datos deben describirse?
- **Origen** de los datos y **mecanismo de obtención**.
- **Volumen:** cantidad de filas y atributos.
- Para cada atributo: **semántica**, **tipo**, unidades y dominio.
- **Estadísticas:** medidas de tendencia central y de dispersión.
- **Calidad:** faltantes, errores, inconsistencias, outliers.
- **Relaciones** entre atributos.

### Según CRISP-DM, ¿cuáles son las actividades genéricas de la fase de conocimiento de los datos?
1. **Recolectar los datos iniciales.** Salida: informe de recolección.
2. **Describir los datos.** Salida: informe de descripción (formato, cantidad, atributos).
3. **Explorar los datos.** Salida: informe de exploración (consultas, visualizaciones, primeras hipótesis).
4. **Verificar la calidad de los datos.** Salida: informe de calidad (completitud, errores, faltantes).

### ¿Por qué es importante especificar correctamente el tipo de los datos?
Porque el tipo determina **qué operaciones y medidas tienen sentido**, y qué algoritmos y transformaciones pueden aplicarse:
- un nominal codificado con números (ej. código postal) **no** se puede promediar;
- un ordinal admite moda y mediana, pero **no promedio**;
- solo un atributo **ratio** admite cocientes ("el doble de…");
- muchos algoritmos tratan distinto a los atributos discretos y a los continuos;
- un tipo mal asignado lleva a codificaciones erróneas (ej. regresión sobre clases codificadas como números) y a **conclusiones falsas**.

### ¿Por qué motivo podríamos utilizar la moda en vez del promedio para describir un atributo de la base de datos?
- El atributo es **nominal** (o binario): el promedio no tiene sentido; la moda es la única medida de tendencia central válida.
- Interesa el **valor más frecuente o típico** (ej. el talle más vendido) y no un valor promedio que quizás ni existe (ej. 2,3 hijos).
- El promedio es muy **sensible a los extremos**; en distribuciones asimétricas o con outliers no representa el centro.

### Además de las medidas de tendencia central y desviaciones, ¿qué información sobre cada atributo debe constar en un reporte de conocimiento de los datos? *(criterio propio)*
- Nombre, **descripción semántica** y fuente.
- **Tipo** (nominal, binario, ordinal, intervalado, ratio; discreto o continuo) y unidad de medida.
- **Dominio o rango válido**, y valores distintos (cardinalidad).
- **Cantidad y porcentaje de faltantes**, y qué **significan** (¿error o "no aplica"?).
- Mínimo, máximo, cuartiles y **outliers** detectados.
- **Forma de la distribución** (asimetría, multimodalidad), con su gráfico.
- **Frecuencias** de cada categoría (si es nominal).
- **Problemas de calidad**: valores inválidos, inconsistencias de formato, duplicados.
- **Correlaciones o redundancia** con otros atributos y relación con el atributo objetivo.
- Observaciones para la preparación (ej. "normalizar", "discretizar").

### ¿Qué es la visualización de datos?
Es la representación **gráfica** de los datos (gráficos estadísticos, imágenes, tablas) para **comunicar de forma clara y eficiente** su comportamiento. Permite ver tendencias, relaciones, grupos y anomalías que serían difíciles de apreciar mirando números. Es parte central del análisis exploratorio.

### Además del histograma o diagrama de barras, ¿qué otras visualizaciones pueden ser útiles para describir un atributo nominal? *(investigar)*
- **Gráfico de torta / dona:** solo con pocas categorías.
- **Diagrama de Pareto:** barras ordenadas más la curva acumulada.
- **Treemap:** proporciones de muchas categorías o jerarquías.
- **Waffle chart** y **dot plot** (gráfico de Cleveland).
- **Tabla de frecuencias** absolutas y relativas.
- **Gráfico de mosaico o barras apiladas:** para cruzar con otra variable categórica.
- **Nube de palabras:** para texto o etiquetas.

### Además de los boxplots, ¿qué otras visualizaciones son útiles para describir la distribución de un atributo numérico? *(investigar)*
- **Histograma** (con distintos tamaños de *bin*).
- **Curva de densidad** (KDE).
- **Violin plot:** boxplot + densidad.
- **Strip, swarm o jitter plot:** muestran cada punto.
- **ECDF:** distribución acumulada empírica.
- **Q-Q plot:** compara contra una distribución teórica (¿es normal?).
- **Gráfico de líneas o de dispersión contra el tiempo o el índice:** si importa el orden.

### ¿Cuál es la diferencia entre utilizar boxplots y utilizar el criterio de los tres sigma para hallar anomalías en atributos numéricos?
| | Boxplot (1,5·IQR) | Tres sigma (μ ± 3σ) |
|---|---|---|
| Se basa en | **Cuartiles** (Q1, Q3) | **Media y desviación estándar** |
| Supuesto | Ninguno fuerte; sirve para distribuciones asimétricas | Asume distribución **normal** (99,7 % dentro de ±3σ) |
| Robustez | **Robusto**: los outliers casi no mueven los cuartiles | **Sensible**: los propios outliers inflan μ y σ y pueden "esconderse" (efecto *masking*) |
| Simetría | Límites pueden ser asimétricos respecto de la mediana | Límites simétricos |
| Severidad | Bajo normalidad marca ~0,7 % como outliers (límites ≈ ±2,7σ) | Marca ~0,3 % |

En resumen: el boxplot es no paramétrico y robusto; el criterio 3σ es paramétrico y solo funciona bien si los datos son aproximadamente normales.

### ¿Qué consideraciones son importantes a la hora de asignar el color como código visual? *(criterio propio)*
- **Tipo de paleta según el dato:**
  - categórica (tonos distintos) para nominales;
  - secuencial (claro → oscuro) para cantidades;
  - divergente para valores alrededor de un punto medio (ej. ±0).
- **Accesibilidad:** ~8 % de los hombres tiene daltonismo; evitar rojo/verde como único contraste. Usar paletas aptas (viridis) y **no usar el color como único código** (sumar forma o etiquetas).
- **Pocas categorías** (≈ 7 como máximo); si hay más, agrupar en "otros".
- **Consistencia:** la misma categoría lleva el mismo color en todos los gráficos.
- **Semántica y cultura:** rojo = malo o pérdida, verde = bueno. No contradecirlas.
- **Contraste** con el fondo y legibilidad al imprimir en escala de grises.
- **Resaltar lo importante:** gris para el contexto, color para el foco. No decorar.
- Incluir siempre **leyenda o escala**.

---

## Unidad 3 — Preparación de los datos
📓 `1.01.gdr.data-preparation.ipynb` (nulos, imputación, encoding, duplicados) · `3.04.gdr.clustering.ipynb` (MinMaxScaler)

### ¿Cuáles aspectos hacen a la calidad de los datos?
- **Precisión:** sin ruido ni errores.
- **Completitud:** sin atributos, filas o valores faltantes.
- **Consistencia:** sin valores inesperados ni contradictorios.
- **Credibilidad:** datos que parecen reales y confiables.
- **Interpretabilidad:** valores con significado claro (no códigos sin explicar).

*(Otros autores agregan **oportunidad** o actualidad.)*

### ¿Cuáles son las actividades genéricas de la fase de preparación de los datos?
Según CRISP-DM:
1. **Seleccionar** los datos (atributos y filas) según relevancia, calidad y restricciones técnicas.
2. **Limpiar** los datos (faltantes, ruido, anomalías, inconsistencias).
3. **Construir** datos (atributos derivados, registros nuevos, transformaciones).
4. **Integrar** datos de varias fuentes.
5. **Formatear** los datos para la herramienta o algoritmo.

Las diapos agregan **reducción** (dimensionalidad y numerosidad) y **transformación** (normalización, discretización, agregación, jerarquías conceptuales).

### ¿Por qué es importante la preparación de los datos?
- Los datos reales suelen estar **incompletos, ruidosos e inconsistentes**, y la baja calidad se **traslada a los resultados** y a la confianza de los stakeholders.
- Los algoritmos que manejan internamente faltantes o ruido **no suelen ser robustos**.
- Muchos algoritmos exigen formatos específicos: numéricos, normalizados, sin nulos.
- La reducción permite trabajar con restricciones técnicas (tiempo, memoria) sin cambiar mucho los resultados.
- Insume ~90 % del tiempo del proyecto, así que hacerla bien es la clave del éxito.

### ¿Por qué es importante tener un buen entendimiento de los datos previo a esta fase?
Porque el entendimiento es el **diagnóstico** y la preparación es el **tratamiento**:
- se sabe **qué problemas existen** (faltantes, outliers, tipos incorrectos) y su magnitud;
- se conoce la **semántica**: un faltante puede significar algo, y un valor raro puede ser real y no un error;
- se elige la técnica adecuada **según el tipo** de atributo (moda para nominales, mediana para asimétricos, etc.);
- se identifican las claves para la integración (identificación de entidades) y las redundancias.

Sin ese conocimiento se puede borrar información valiosa o introducir sesgos.

### ¿Cuáles son las posibles estrategias para limpiar ruido o anomalías?
- **Binning (suavizado):** ordenar, separar en contenedores y reemplazar por la media, la mediana o las fronteras del bin.
- **Regresión:** reemplazar los valores por los que da la función ajustada (si el ajuste es malo, se pierde información).
- **Clustering o detección de anomalías:** los valores fuera de los grupos se reemplazan por el promedio o la mediana del cluster más cercano, o se **eliminan**.
- **Métodos estadísticos:** boxplot o desviación estándar para detectar, y luego corregir o eliminar.
- **Inspección manual o conocimiento del dominio** para casos puntuales.

### ¿En qué consiste el problema de identificación de entidades?
Al **integrar varias fuentes**, consiste en determinar qué atributos y qué registros de cada fuente corresponden **a la misma entidad del mundo real**. Ejemplos:
- **Atributos equivalentes** con distinto nombre (`ID_cliente` vs `DNI`).
- **Semántica distinta:** ¿un campo vacío significa lo mismo en ambas fuentes?
- **Formatos y unidades distintas** (metros vs pies).
- **Dependencias distintas:** un descuento por factura vs uno por línea de factura.

Se resuelve con la **descripción de los datos** (metadatos). Si se resuelve mal, aparecen **redundancia** (filas o atributos duplicados) e **inconsistencias**.

### ¿Cuáles son algunas técnicas de normalización de atributos? *(investigar)*
- **Min-Max:** $x' = \frac{x - \min}{\max - \min}$ lleva a [0, 1] (o a [a, b]). Sensible a outliers. 📓 `MinMaxScaler`.
- **Z-score (estandarización):** $x' = \frac{x - \bar{x}}{\sigma}$ deja media 0 y desvío 1. 📓 `StandardScaler`.
- **Escalado decimal:** $x' = x / 10^j$, con *j* el menor entero tal que $\max|x'| < 1$.
- **Escalado robusto:** $x' = \frac{x - mediana}{IQR}$; resiste outliers.
- **Transformación logarítmica:** para distribuciones muy asimétricas.

¿Por qué normalizar? En los algoritmos basados en distancia (K-Means, KNN), un atributo de gran magnitud domina. 📓 En el notebook de clustering, `body_mass_g` decidía todo el agrupamiento hasta que se normalizó.

### ¿Cuáles son algunas técnicas de discretización de atributos? *(investigar)*
**No supervisadas** (no usan la clase):
- **Igual ancho:** *k* intervalos del mismo tamaño. Simple, pero sensible a outliers.
- **Igual frecuencia (cuantiles):** cada intervalo tiene la misma cantidad de datos.
- **Basada en clustering:** por ejemplo, K-Means sobre el atributo.
- **Por análisis del histograma.**

**Supervisadas** (usan la clase):
- **Basada en entropía:** elige los cortes que maximizan la ganancia de información (como en los árboles).
- **ChiMerge:** une intervalos adyacentes con distribución de clase similar (test χ²).

**Por conocimiento del dominio:**
- **Manual:** rangos con significado (niño, adolescente, adulto).
- **Jerarquías conceptuales.**

---

## Unidad 4 — Regresión lineal
📓 `3.01.gdr.linear-regresion.ipynb` (dataset de publicidad: TV, radio, diarios → ventas)

### ¿Cuáles son las actividades genéricas de la fase de modelado?
Según CRISP-DM:
1. **Seleccionar la técnica de modelado**, según los objetivos de minería de datos y los supuestos de cada técnica.
2. **Generar el diseño de prueba**: cómo se va a evaluar (train/test, validación cruzada, métricas).
3. **Construir el modelo**: configurar parámetros, entrenar y describir el modelo.
4. **Evaluar el modelo** técnicamente: comparar modelos y ajustar parámetros.

Es habitual volver a la fase de preparación.

### ¿Qué características debe poseer el problema (y el conjunto de datos) para poder usar aprendizaje supervisado?
- Tiene que existir una **variable objetivo** (respuesta) bien definida que se quiera predecir o explicar.
- Hace falta un **conjunto de entrenamiento etiquetado**: observaciones históricas con los valores de los predictores **y** de la respuesta conocidos.
- Se asume que **existe una relación** entre los predictores y la respuesta: $Y = f(X) + \varepsilon$.
- Los datos tienen que ser **suficientes y representativos** de los casos futuros (misma distribución).
- Los predictores tienen que estar **disponibles en el momento de predecir** (en general, más fáciles de obtener que *Y*).

### ¿Cuál es la diferencia entre predicción e inferencia?
| Predicción | Inferencia |
|---|---|
| Interesa el **valor** $\hat{Y}$ y su precisión | Interesa la **relación** entre *X* e *Y* |
| *f* puede ser una **caja negra**, tan compleja como haga falta | Interesa la **forma de *f***: ¿qué variables influyen y cómo? |
| Ej.: riesgo de reacción a una droga según análisis de sangre | Ej.: ¿qué tipo de publicidad impacta más en las ventas? |
| Se prefieren modelos **precisos y flexibles** | Se prefieren modelos **simples e interpretables** |

### ¿Cuál es la diferencia entre métodos paramétricos y no paramétricos?
| Paramétricos | No paramétricos |
|---|---|
| **Suponen la forma** de *f* (ej. lineal) | **No suponen** la forma |
| El problema se reduce a estimar *p+1* coeficientes | Ajustan *f* suavemente a los puntos |
| Necesitan menos datos; simples e interpretables | Necesitan **muchas** observaciones |
| Si la forma real es otra, pierden precisión (**bias**) | Mejor ajuste, pero complejos y **sensibles al ruido** (overfitting) |
| Ej.: regresión lineal | Ej.: árboles, KNN, splines |

### ¿En qué consiste el método de los mínimos cuadrados?
Es el método para **estimar los coeficientes** de la regresión.
1. Para cada observación se define el **residuo** $e_i = y_i - \hat{y}_i$: el valor real menos el estimado.
2. Se buscan los $\hat\beta$ que **minimizan la suma de los residuos al cuadrado**:
$$RSS = \sum_{i=1}^{n} (y_i - \hat\beta_0 - \hat\beta_1 x_i)^2$$
   Se eleva al cuadrado para que los errores positivos y negativos no se cancelen y para penalizar más los errores grandes.
3. Derivando e igualando a cero se obtiene:
$$\hat\beta_1 = \frac{\sum (x_i-\bar{x})(y_i-\bar{y})}{\sum (x_i-\bar{x})^2} \qquad \hat\beta_0 = \bar{y} - \hat\beta_1\bar{x}$$

En regresión múltiple se minimiza el mismo RSS con *p* predictores. 📓 El notebook mide el resultado con el **MSE** (error cuadrático medio).

---

## Unidad 5 — Clasificación
📓 `3.02.gdr.classification.ipynb` (pingüinos, árbol de decisión, `classification_report`)

### ¿Cuál es la diferencia entre regresión y clasificación?
Ambas son **aprendizaje supervisado**. La diferencia está en el tipo de la variable objetivo:
- **Regresión:** objetivo **cuantitativo**, numérico continuo (ej. ventas, precio).
- **Clasificación:** objetivo **cualitativo**, una categoría o clase (ej. compra/no compra, especie).

Cambian también las métricas: MSE o RSS en regresión; matriz de confusión, accuracy, sensitivity y specificity en clasificación.

### ¿Por qué no es posible usar regresión lineal tras codificar la variable categórica con números?
Porque la codificación **impone un orden y unas distancias que no existen**:
- Si se codifica {perro = 1, gato = 2, pez = 3}, el modelo "entiende" que gato está entre perro y pez, y que perro y pez están el doble de lejos.
- **Otra codificación igual de válida** ({gato = 1, pez = 2, perro = 3}) da una **función distinta** y predicciones distintas. El modelo depende de una decisión arbitraria, no del patrón real.
- Además, la regresión devuelve valores continuos (2,4, −0,3) que no corresponden a ninguna clase.

Solo es razonable con dos clases (0/1) o con un orden real (ordinal), e incluso así es mejor usar técnicas de **clasificación** (regresión logística, árboles, SVM).

### Diferencia entre el índice de Gini y la ganancia de información. ¿Cuándo conviene cada uno? *(investigar)*
Ambos miden la **impureza** de una partición, para elegir el atributo de corte que deje los nodos hijos más "puros".

| | Ganancia de información | Índice Gini |
|---|---|---|
| Algoritmos | ID3, C4.5 (*gain ratio*) | **CART** |
| Fórmula | $Entropía = -\sum p_i \log_2 p_i$; ganancia = entropía del padre − entropía ponderada de los hijos | $Gini = 1 - \sum p_i^2$ |
| Rango (2 clases) | 0 a 1 | 0 a 0,5 |
| Costo | Más costoso (logaritmos) | Más **rápido** |
| Sesgo | Favorece atributos con **muchos valores** (ej. un ID); C4.5 lo corrige con *gain ratio* | Tiende a aislar la clase más frecuente; usado con **splits binarios** |

**¿Cuándo usar cada uno?**
- En la práctica dan árboles **muy parecidos** (difieren en un porcentaje bajo de casos).
- **Gini:** datasets grandes, cuando importa la velocidad, árboles binarios (CART; es el *default* de scikit-learn).
- **Entropía o *gain ratio*:** cuando se quiere interpretar en términos de teoría de la información, o con atributos multivaluados (usando *gain ratio*).
- Lo más sensato es tratarlo como un **hiperparámetro** y compararlos con validación cruzada (Unidad 6).

---

## Unidad 6 — Validación
📓 `3.03.gdr.linear-regresion-with-validation.ipynb` (lineal simple vs múltiple vs árbol: el árbol sobreajusta)

### ¿Qué es el sobreajuste del modelo?
El **overfitting** ocurre cuando el modelo **"copia" los datos de entrenamiento** (incluido su ruido) en lugar de aprender el patrón de fondo. Tiene error muy bajo en entrenamiento pero **generaliza mal**: falla con datos nuevos. Un 100 % de aciertos en entrenamiento es una señal de alarma, no de éxito.

### ¿Qué tipo de modelos tienden a sobreajustar?
- Modelos **complejos o flexibles** y **no paramétricos**: árboles de decisión profundos sin poda, KNN con k chico, polinomios de alto grado, redes neuronales grandes.
- Modelos con **muchos parámetros en relación con la cantidad de datos**.
- 📓 En el notebook, el árbol de regresión se adapta perfecto al entrenamiento y predice mal en test.

### ¿Cómo podemos evaluar si un modelo está sobreajustado o poco ajustado?
Comparando el **error en entrenamiento** con el **error en test o validación**:

| Situación | Error train | Error test |
|---|---|---|
| **Underfitting** (bias alto) | Alto | Alto (parecido al de train) |
| **Overfitting** (varianza alta) | Muy bajo | Alto: gran **brecha** con train |
| **Buen ajuste** | Bajo | Bajo y cercano al de train |

Además conviene usar **validación cruzada**: si el resultado varía mucho entre *folds*, hay alta varianza. Las **curvas de aprendizaje**, que grafican el error en función de la complejidad o de la cantidad de datos, también ayudan.

### ¿Qué son el sesgo (bias) y la varianza?
- **Sesgo:** cuánto se aleja el modelo de capturar la **naturaleza del fenómeno**. Es el error por suposiciones demasiado simples. Un bias alto produce **underfitting**.
- **Varianza:** cuánto **cambia el modelo** si se entrena con otros datos. Una varianza alta indica que copia los datos, es decir, **overfitting**.

### ¿Cómo varían el sesgo y la varianza con la complejidad del modelo?
- A mayor complejidad, el **sesgo baja** y la **varianza sube**.
- A menor complejidad, el **sesgo sube** y la **varianza baja**.
- El error de test tiene forma de **U**: el punto óptimo está en el medio. Ese es el **bias-variance tradeoff**.
- El error irreducible pone un piso que ningún modelo supera.

### ¿Qué características debe poseer el conjunto de datos de prueba? ¿Por qué?
- **Etiquetado**, para comparar lo predicho con lo real.
- **Disjunto** del de entrenamiento ($Train \cap Test = \emptyset$): si el modelo ya vio esos datos, la evaluación es optimista y no mide la generalización.
- **Representativo** de los datos reales futuros, con la **misma proporción de clases** que el conjunto total: así las métricas reflejan el desempeño real.
- De **tamaño suficiente** (ej. 20 % o ⅓) para que las métricas sean estables.
- **No usarlo para tomar decisiones de entrenamiento** (elegir hiperparámetros, etc.): si se usa, deja de ser una estimación imparcial (*data leakage*).

### ¿Por qué el muestreo estratificado es necesario, considerando la sensitividad y la especificidad?
- La **sensitivity** se calcula solo sobre los **positivos reales** ($\frac{VP}{VP+FN}$) y la **specificity** solo sobre los **negativos reales**.
- Con un muestreo aleatorio simple y clases desbalanceadas (ej. 10 % positivos), el test puede quedar con **muy pocos positivos o ninguno**. La sensitivity se calcularía sobre una muestra mínima: sería inestable, sin sentido, o directamente imposible de calcular.
- También el entrenamiento puede quedar sin ejemplos suficientes de la clase minoritaria, y el modelo no la aprende. Es el caso de la droga: sensitivity 0,30.
- El **estratificado** garantiza que cada clase esté representada en train y test **en la misma proporción**. Así las métricas por clase son confiables y comparables, y no dependen de la suerte de la partición.

### ¿En qué consiste cross-validation? ¿De qué nos sirve?
Consiste en hacer **muestreos sucesivos** del dataset: en cada iteración se usa un conjunto distinto de entrenamiento y de prueba, y al final se **promedian** los resultados.
- **K-Folds:** se divide en *k* grupos y cada grupo es test una vez (*k* entrenamientos).
- **LOOCV:** *k = n*. Se deja afuera 1 dato por vez; es exacto pero muy costoso.

**Sirve para:**
- obtener una estimación del error **independiente de una partición particular**;
- aprovechar **todos los datos** para entrenar y para evaluar;
- medir la **estabilidad** del modelo (desvío entre *folds*, que indica varianza);
- **comparar modelos** y **ajustar hiperparámetros** de forma justa.

### ¿Cómo podemos seleccionar el mejor algoritmo para modelar un conjunto de datos?
1. Definir la **métrica según el objetivo de negocio**. Por ejemplo, sensitivity si lo crítico es no dejar pasar positivos; MSE en regresión.
2. Elegir **candidatos** acordes al tipo de problema y de datos, y a la necesidad de **interpretabilidad** (inferencia vs predicción).
3. Reservar un **test final** (*hold-out*) y no tocarlo.
4. Evaluar cada candidato y sus hiperparámetros con **validación cruzada estratificada**, usando los mismos *folds* para todos.
5. Comparar la **media y el desvío** de la métrica. Revisar la brecha train/test (bias vs varianza).
6. Elegir el de mejor equilibrio entre desempeño, complejidad, interpretabilidad y costo. Ante empate, el **más simple**.
7. Confirmar con el test final y validar contra los objetivos de negocio (fase de **Evaluación** de CRISP-DM).

---

## Unidad 7 — Agrupamiento
📓 `3.04.gdr.clustering.ipynb` (K-Means sobre pingüinos, normalización, árbol para interpretar clusters)

### ¿Cuál es la diferencia entre aprendizaje supervisado y no supervisado?
| Supervisado | No supervisado |
|---|---|
| Hay una **variable objetivo etiquetada** en los datos de entrenamiento | **No hay etiquetas** ni variable objetivo |
| Aprende a relacionar X → Y para **predecir o explicar** Y | Descubre **estructura o patrones** en los datos (grupos, asociaciones, anomalías) |
| Se valida comparando con los valores reales | La validación es más difícil (no hay "respuesta correcta") |
| Regresión, clasificación | Clustering, reglas de asociación, detección de anomalías no supervisada |

### ¿En qué consiste la idea de agrupamiento o clustering?
En **particionar** el conjunto de datos en grupos (*clusters*) de modo que los elementos de un mismo grupo sean **similares entre sí** (alta cohesión) y **considerablemente distintos** de los de otros grupos (alta separación). La similitud suele medirse con una **distancia**, por ejemplo la euclídea. Es aprendizaje no supervisado: los grupos no se conocen de antemano.

### ¿Qué tipo de estrategias para agrupamiento existen?
- **Particionamiento:** divide en *k* grupos optimizando un criterio (K-Means, K-Medoids).
- **Jerárquicos:** arman un árbol de grupos (dendrograma), aglomerativo (bottom-up) o divisivo (top-down).
- **Basados en densidad:** los clusters son regiones densas separadas por zonas poco densas (DBSCAN, OPTICS).
- **Basados en grillas:** dividen el espacio en celdas y agrupan celdas densas (STING, CLIQUE).

### ¿Cuál es la diferencia entre los métodos de particionamiento y los basados en densidad?
| Particionamiento (K-Means) | Densidad (DBSCAN) |
|---|---|
| Hay que fijar **k** | No hace falta *k*: el número de clusters **emerge** de los datos |
| Basado en **centroides** y distancia al centro | Basado en la **cantidad de vecinos** en una región (ε, MinPts) |
| Encuentra clusters **esféricos** y de tamaño similar | Encuentra clusters de **forma arbitraria** |
| **Todo punto** se asigna a algún cluster | Identifica **ruido** (puntos que no pertenecen a ningún cluster) |
| Sensible a outliers (desplazan el centroide) | Robusto a outliers |
| Problema: formas no convexas | Problema: clusters de **distintas densidades** |

### ¿Cómo funciona K-means?
1. Se elige **k**, la cantidad de grupos.
2. Se ubican **k centroides iniciales**, en general al azar.
3. **Asignación:** cada punto va al centroide más cercano (distancia **euclídea**).
4. **Actualización:** se **recalcula cada centroide** como el promedio de los puntos asignados.
5. Se repiten los pasos 3 y 4 hasta que los centroides no cambian (o se llega a un máximo de iteraciones).

Minimiza la suma de distancias al cuadrado dentro de cada cluster (inercia). **Desventajas:** hay que fijar *k*; depende de la inicialización; es costoso con muchos datos; solo encuentra clusters esféricos; es sensible a la escala (📓 hay que **normalizar**) y a los outliers.

### ¿Por qué DBSCAN no necesita especificar el número de clusters? ¿Qué indican eps y minPts?
Porque los clusters se **construyen por conectividad de densidad**: arranca desde un objeto central y agrega todos los puntos **alcanzables por densidad**. Cada región densa conectada se convierte en un cluster, así que la cantidad de clusters es un **resultado**, no una entrada.
- **ε (eps):** el **radio del vecindario** de cada punto. Define qué tan cerca tienen que estar dos puntos para ser vecinos.
- **MinPts:** la **cantidad mínima de puntos** dentro del ε-vecindario para que un punto sea **objeto central**.

Juntos definen el **umbral de densidad**: "denso" significa al menos MinPts puntos en un radio ε. Los puntos que no son centrales ni alcanzables desde uno se marcan como **ruido**.

### ¿Cuál es la principal desventaja de DBSCAN?
No maneja bien los **clusters de densidades distintas**. Con un único par (ε, MinPts) global, si se ajusta para los grupos densos, los grupos menos densos se clasifican como **ruido**; si se ajusta para los poco densos, los grupos densos cercanos se **fusionan**.

Otras desventajas: es **sensible a la elección de ε y MinPts**, y funciona peor en **alta dimensionalidad**, donde las distancias pierden significado. Hay variantes como **OPTICS** y **HDBSCAN** que exploran distintas densidades.

### ¿Cómo validamos los clusters? ¿Qué métricas usamos? ¿Se puede usar cross-validation? ¿Por qué? *(investigar)*
**Validación interna** (sin etiquetas: mide cohesión y separación):
- **Inercia / SSE:** suma de distancias al cuadrado de cada punto a su centroide. Se usa con el **método del codo** para elegir *k*.
- **Coeficiente de silueta** (−1 a 1): compara la distancia media de cada punto a su cluster con la distancia al cluster vecino. Cerca de 1 es mejor.
- **Davies-Bouldin:** cuanto menor, mejor. **Calinski-Harabasz:** cuanto mayor, mejor.

**Validación externa** (si hay etiquetas reales, como 📓 la especie en el notebook):
- **Pureza**, **Rand ajustado (ARI)**, **información mutua normalizada (NMI)**, o una tabla de contingencia de clusters vs clases.

**Validación relativa:** comparar resultados con distintos parámetros (*k*, ε, MinPts) usando las métricas internas.

**¿Cross-validation?** **No en su forma habitual.** CV estima el error de **predicción** comparando contra valores reales en datos no vistos, y en clustering **no hay variable objetivo** contra la cual medir. Lo que sí se hace:
- **Estabilidad por remuestreo:** agrupar subconjuntos o *bootstrap* de los datos y comprobar si los clusters se mantienen.
- Calcular métricas internas en datos no vistos con modelos que pueden asignar nuevos puntos (K-Means).
- 📓 Entrenar un **clasificador** (árbol) sobre las etiquetas de cluster y validarlo con train/test. Esto mide qué tan **separables e interpretables** son los grupos, no si son "correctos".

---

## Unidad 8 — Asociaciones
📓 `3.05.gdr.association_rules.ipynb` (`mlxtend`: apriori, association_rules, lift)

### ¿En qué tipo de aprendizaje podemos enmarcar la búsqueda de asociaciones?
En el **aprendizaje no supervisado** (descriptivo): no hay una variable objetivo; se buscan **co-ocurrencias** entre ítems en los datos. Es una analítica **descriptiva** cuyos resultados (reglas) también se usan para prescribir acciones, como las promociones.

### ¿A qué llamamos base de datos transaccional?
Es una base donde cada registro es una **transacción**: un **subconjunto no vacío y no ordenado de ítems**, de largo variable, tomado de un conjunto de ítems $I = \{I_1, \dots, I_m\}$. Formalmente, $D = \{T_j \mid T_j \subseteq I,\ T_j \neq \emptyset\}$. Ejemplo: cada compra de un supermercado, como T1 = {Leche, Pan, Cereales}.

Se puede representar como **matriz booleana** (transacción × ítem, con 0/1; 📓 one-hot) o como **listas invertidas** (cada ítem con las transacciones que lo contienen).

### ¿Qué es un conjunto de ítems frecuentes?
Es un **itemset** (subconjunto de ítems) que aparece en las transacciones con un **soporte mayor o igual al mínimo** (min_sup). Interesan especialmente los **frecuentes máximos**, los de mayor tamaño posible. Ejemplo: {Leche, Pan} aparece en 3 de 4 transacciones, soporte 0,75.

### ¿Qué es una regla de asociación?
Es una implicación $A \Rightarrow B$, con $A, B \subset I$ no vacíos y **disjuntos** ($A \cap B = \emptyset$). Se lee "las transacciones que contienen A tienden a contener B". Ejemplo: {Leche} ⇒ {Pan}. Una regla es **fuerte** si su soporte ≥ min_sup y su confianza ≥ min_conf. **No implica causalidad**, solo co-ocurrencia.

### ¿Cuál es la diferencia entre soporte y confianza de una regla?
- **Soporte** $= P(A \cup B)$: proporción de **todas las transacciones** que contienen A y B juntos. Mide qué tan **frecuente o relevante** es la regla en toda la base.
- **Confianza** $= P(B \mid A) = \frac{sup(A \cup B)}{sup(A)}$: de las transacciones que contienen **A**, qué proporción contiene también **B**. Mide qué tan **fiable** es la implicación.

Ejemplo: {Leche} ⇒ {Cereales} tiene soporte 0,25 y confianza 0,33.

El soporte es **simétrico** (A⇒B y B⇒A tienen el mismo); la confianza **no**. 📓 El notebook agrega el **lift** = conf / sup(B): un valor > 1 indica que A y B aparecen juntos **más de lo esperado por azar**.

### ¿Qué es la propiedad antimonótona y cómo participa en la búsqueda de asociaciones?
**Propiedad A-priori (antimonótona):** *todo subconjunto de un itemset frecuente también es frecuente*. Su contrapositiva es la que se usa: **si un itemset no es frecuente, ningún superconjunto suyo puede serlo**, porque agregar ítems nunca aumenta el soporte.

En el algoritmo A-priori se usa para **podar** el espacio de búsqueda:
- los candidatos de tamaño *k* se generan **solo a partir de los frecuentes de tamaño k−1**;
- se descarta, sin contar su soporte en la base, todo candidato con algún subconjunto de tamaño k−1 no frecuente.

Así se evita evaluar las $2^m$ combinaciones posibles y la búsqueda se vuelve viable.

---

## Unidad 9 — Detección de anomalías
📓 `3.06.gdr.anomaly_detection.ipynb` (K-Means + distancia al centroide con criterio de 2σ, y LOF)

### ¿Qué es una anomalía?
Una **anomalía (outlier)** es un objeto cuyos valores **se desvían significativamente** de los valores normales del resto de los datos, **como si hubiera sido generado por otro mecanismo**. Ejemplo: una compra con tarjeta por un monto o en un lugar muy distinto a los habituales.

### ¿En qué se diferencia del ruido?
- **Ruido:** **error aleatorio** o varianza en la medición de una variable. No responde a ningún mecanismo ni patrón (ej. un cliente que un día compra una prenda algo más cara).
- **Anomalía:** fue generada por un **mecanismo distinto** (ej. fraude), y ese mecanismo induce un **patrón** en los datos anómalos.

### ¿Por qué las anomalías son importantes y el ruido se elimina?
- El ruido **no aporta información**: degrada la calidad de los datos y los modelos, y genera **falsas alarmas** (molestar al cliente sin motivo). Por eso se elimina en la **preparación de los datos**.
- La anomalía **es conocimiento**: lo que interesa es el **mecanismo** que la generó (fraude, intrusión en una red, una falla sistemática), más que el dato individual. Detectarla permite actuar.

### ¿Qué tipos de anomalías hay?
- **Global:** se desvía del **conjunto completo** de datos (ej. intrusiones en una red).
- **Contextual:** se desvía **en un contexto específico** (28 °C es anómalo en otoño, no en primavera).
- **Local:** un tipo de contextual donde el contexto es la **densidad**. La densidad de su vecindario difiere mucho de la de su entorno.
- **Colectiva:** un **subconjunto** de datos que, **juntos**, se desvía de lo normal, aunque cada uno por separado no sea raro (100 paquetes demorados el mismo día).

### ¿Cuál es la relación entre búsqueda de anomalías y clustering?
Son **actividades complementarias**: el clustering busca los grupos de datos **similares** y la detección de anomalías busca los datos **lejanos a esos grupos**. Por eso el clustering se usa como herramienta para detectar anomalías: lo normal forma clusters y lo anómalo queda afuera.

Además, como las anomalías provienen de otro mecanismo, a veces **forman sus propios grupos** (pequeños y aislados), y el clustering también los revela. El clustering también se usa en la preparación de datos para limpiar ruido.

### ¿Cómo funciona el método basado en clustering para detectar anomalías?
Primero se agrupan los datos (K-Means, DBSCAN, etc.). Luego, para cada objeto:
1. ¿**No pertenece a ningún cluster**? (ej. DBSCAN lo marca como ruido) → **outlier**.
2. ¿Hay una **gran distancia** entre el objeto y su cluster más cercano? → **outlier**.
3. ¿Pertenece a un cluster **pequeño, disperso y aislado**? → **todos** los objetos de ese cluster son outliers (anomalía colectiva).

📓 En el notebook: K-Means, después la distancia de cada punto a su centroide, y se marcan los que superan la media + 2 desvíos de esas distancias.

### ¿Cuál es la diferencia entre un método basado en distancia y uno basado en densidad? *(investigar)*
- **Basado en distancia:** un punto es outlier si está **lejos de la mayoría** de los demás, con un **umbral global**. Por ejemplo, si menos de una fracción π de los puntos está a distancia ≤ r (outlier DB(r, π)), o si la distancia a su k-ésimo vecino es grande. **Problema:** con regiones de distinta densidad, un umbral global falla. Marca como outliers a los puntos de un cluster disperso y no detecta un punto cercano a un cluster muy denso.
- **Basado en densidad:** compara la **densidad local** del punto con la **densidad de sus vecinos**. Es outlier si está en una región **mucho menos densa que la de su vecindario**. Es relativo y local, así que detecta **anomalías locales** aunque haya clusters de distintas densidades.

### ¿Qué tipo de método es LOF? ¿Por qué? *(investigar)*
**LOF (*Local Outlier Factor*) es un método basado en densidad** (y local). Para cada punto:
1. Calcula su **densidad local de alcanzabilidad** (*lrd*), a partir de las distancias a sus *k* vecinos más cercanos.
2. Su **LOF** es el **cociente** entre la densidad promedio de sus vecinos y su propia densidad.
   - LOF ≈ 1: densidad similar a la de sus vecinos → **normal**.
   - LOF ≫ 1: mucho menos denso que sus vecinos → **outlier**.

Es de densidad porque no usa un umbral de distancia global: **compara densidades relativas** en cada vecindario. Usa distancias para estimar la densidad, pero la decisión se toma por densidad relativa. 📓 En el notebook detecta más anomalías que el método de clustering, justamente porque mira cada vecindario.

### ¿Qué hacemos con las anomalías descubiertas? ¿Por qué?
**No se eliminan automáticamente** (a diferencia del ruido), porque son **conocimiento**:
1. **Analizarlas e investigarlas** con expertos del dominio, para entender el **mecanismo** que las generó (fraude, falla, intrusión, error de carga).
2. **Actuar** según el negocio. En el caso del banco: bloquear la tarjeta o **contactar al cliente** para confirmar la operación.
3. **Si resultan ser errores o ruido**, se tratan en la preparación: corregirlas, imputarlas o eliminarlas.
4. **Si son reales**, se conservan, se reportan y pueden **etiquetarse** para entrenar más adelante un modelo **supervisado** que las detecte. También pueden analizarse por separado (no "contaminan" a los modelos de lo normal).
5. **Actualizar el modelo** periódicamente, porque el comportamiento "normal" cambia con el tiempo.
