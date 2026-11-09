---
tipo: resumen
materia: Ciencia de Datos
tags: [parcial, preguntas, ciencia-de-datos]
---
# Preguntas de ejemplo del parcial — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · Teoría en [[Resumen Ciencia de Datos]] · Preguntas guía en [[Preguntas de estudio - Ciencia de Datos]]

> [!info] Cómo usar esta nota
> Preguntas de ejemplo que pasó el profesor, agrupadas por **RA** (resultado de aprendizaje). Primero intentá responder y después abrí **Ver respuesta**. Cuando el enunciado limita las líneas, la respuesta respeta ese límite y la explicación extendida está aparte, en **Desarrollo**.
> En el original hay dos preguntas con el número 4; acá van numeradas de corrido (1 a 6).

**Índice:** [[#RA 1 — Metodologías|RA 1]] · [[#RA 2 — Conocimiento y preparación de los datos|RA 2]] · [[#RA 3 — Modelado|RA 3]]

---

## RA 1 — Metodologías

### 1. CRISP-DM vs KDD
> ¿Por qué es preferible utilizar una metodología como CRISP-DM por sobre un modelo como KDD? Explique las diferencias explayándose en actividades y estructura de ambas opciones.

> [!check]- Ver respuesta
> Porque un proyecto de ciencia de datos no fracasa por los algoritmos sino por **no satisfacer a los stakeholders**. KDD (Fayyad et al., 1996) es un **modelo de proceso técnico**: describe cómo pasar de los datos a los patrones, pero no cómo gestionar un proyecto. CRISP-DM (1999) es una **metodología estándar** que incluye además las actividades de **negocio** y de **implementación**.
>
> **KDD — actividades y estructura.** Es una **secuencia de pasos** de un solo nivel (con posibles retornos): **selección** de los datos objetivo → **preprocesamiento** (limpieza de ruido y faltantes) → **transformación** (reducción, formato) → **minería de datos** (algoritmos) → **interpretación/evaluación** de los patrones. Sus falencias: se centra solo en lo técnico, **no tiene en cuenta los intereses del cliente** y **no contempla la implementación** del conocimiento.
>
> **CRISP-DM — actividades y estructura.** Es **jerárquica**, con 4 niveles de abstracción: **fases → tareas genéricas → tareas especializadas → instancias de proceso**. Tiene 6 fases que forman un **ciclo iterativo**: **entendimiento del negocio** (objetivos de negocio → objetivos de minería, recursos, riesgos, plan) → **entendimiento de los datos** (recolectar, describir, explorar, verificar calidad) → **preparación** (seleccionar, limpiar, integrar, construir, formatear) → **modelado** → **evaluación** contra los objetivos de **negocio** → **implementación** (informes, despliegue, plan de monitoreo y mantenimiento). Cada tarea produce un **entregable** documentado.
>
> | | KDD | CRISP-DM |
> |---|---|---|
> | Alcance | Solo técnico | Negocio + técnico |
> | Empieza por | Los datos | Los objetivos del cliente |
> | Evalúa | Calidad técnica de los patrones | Si se cumplen los **objetivos de negocio** |
> | Termina en | El patrón descubierto | La **implementación** y su mantenimiento |
> | Estructura | Pasos en secuencia, un nivel | Jerárquica (4 niveles), ciclo iterativo, con entregables |
> | Gestión | No contempla recursos, riesgos ni plan | Plan de proyecto, recursos, riesgos, costos/beneficios |
>
> Los pasos de KDD quedan **contenidos** en CRISP-DM: selección, preprocesamiento y transformación ≈ preparación de los datos; minería ≈ modelado; interpretación ≈ evaluación técnica. CRISP-DM agrega lo que KDD no tiene.
>
> **Conclusión:** CRISP-DM es preferible porque es **genérico, estándar y completo**, independiente de la industria y de las herramientas. Da un **lenguaje común** entre el equipo y el cliente, dice **qué** hacer (no cómo) y permite planificar, controlar y repetir el proceso.

---

## RA 2 — Conocimiento y preparación de los datos

### 2. Visualización de un atributo categórico ordinal
> Dado un atributo de tipo categórico ordinal. ¿Qué visualización de datos cree que podría utilizar para describirlos?

> [!check]- Ver respuesta
> - **Diagrama de barras** con las categorías en su **orden natural** (ej. Bajo < Medio < Alto) y no ordenadas por frecuencia, para no perder la información del orden. Muestra la frecuencia absoluta o relativa de cada categoría y permite ver la **moda**.
> - **Frecuencias acumuladas** (barras u ogiva): como hay orden, tiene sentido acumular, y permite ubicar la **mediana** y los **cuartiles**, que son medidas válidas para un ordinal (el promedio no).
> - **Barra apilada al 100 %** (o divergente si es una escala tipo Likert, "muy en desacuerdo → muy de acuerdo"): muestra la proporción de cada nivel y permite comparar entre grupos.
> - **Heatmap** si se lo cruza con otro atributo, con las categorías ordenadas en el eje.
>
> Evitaría el **gráfico de torta**: no muestra el orden y es difícil comparar ángulos. Si se codifica con color, usaría una **escala de intensidad** (de claro a oscuro) que refleje el orden, no colores sin relación entre sí.

### 3. Detección de anomalías en un atributo cuantitativo
> ¿Qué técnicas utilizaría para detectar anomalías en un atributo cuantitativo?

> [!check]- Ver respuesta
> **Univariadas (solo ese atributo):**
> - **Boxplot / rango intercuartil:** es anómalo lo que queda fuera de $[Q1 - 1{,}5 \cdot IQR,\ Q3 + 1{,}5 \cdot IQR]$. Se basa en cuartiles, así que **las propias anomalías no lo desplazan**, y sirve aunque la distribución sea asimétrica.
> - **Criterio de los tres sigma (z-score):** es anómalo lo que esté a más de $3\sigma$ del promedio. Supone una distribución aproximadamente **normal**, y como la media y el desvío son sensibles a los extremos, las anomalías pueden "esconderse".
> - **Histograma:** los valores que caen en *bins* de muy baja frecuencia son candidatos (depende del ancho del bin).
>
> **Considerando otros atributos:**
> - **Gráfico de dispersión** con otro atributo, o anomalías **contextuales** (comparar dentro de un contexto: 28 °C es raro en otoño).
> - **Basadas en clustering:** puntos que no pertenecen a ningún cluster (ruido de DBSCAN) o muy lejos de su centroide (K-Means).
> - **Basadas en distancia** (lejos de la mayoría de los puntos) o **en densidad** (**LOF**, para anomalías locales).
>
> Después **no las elimino automáticamente**: analizo si son **ruido** (error de carga o medición → se corrige o elimina en la preparación) o una **anomalía real** generada por otro mecanismo, que es conocimiento.

### 4. Valores perdidos en una variable cualitativa
> ¿De qué forma podría solucionar el problema de valores perdidos en una variable cualitativa?

> [!check]- Ver respuesta
> Primero analizo **por qué faltan**: el faltante puede tener **semántica** ("no corresponde", "no quiso responder") y no ser un error. Según eso:
> 1. **Ignorar la tupla:** si son pocas o si lo que falta es la clase. Cuidado con perder demasiados datos.
> 2. **Completar manualmente:** preciso pero costoso; sirve si son pocos.
> 3. **Constante global** ("Desconocido"): se agrega como una **categoría más**. Es la mejor opción cuando el faltante tiene significado, pero el algoritmo la toma como un valor válido.
> 4. **Moda** (no el promedio, que no existe para atributos cualitativos), idealmente **la moda de los registros de la misma clase**. Si es **ordinal**, también la **mediana**.
> 5. **Valor más probable:** predecirlo con un **clasificador** (árbol de decisión, K-NN, Bayes) entrenado con los otros atributos. Es el más preciso, pero el más costoso.
>
> La estrategia elegida se documenta en el reporte de preparación de los datos.

### 5. Implicaciones éticas: predecir si una persona es propensa a cometer un delito *(máx. 5 líneas)*
> Imagina que lo contratan para implementar un sistema de predicción para determinar si una persona es propensa a cometer un delito o no. ¿Qué implicaciones éticas encuentra en este problema? Expláyese utilizando conceptos de la ciencia de datos. No escriba más de 5 líneas.

> [!check]- Ver respuesta (≤ 5 líneas)
> Los datos históricos (detenciones, condenas) reflejan a quién se persiguió, no quién delinque: el modelo aprende ese **sesgo** y lo amplifica (más patrullaje → más detenciones). Aunque se excluyan atributos sensibles, el barrio funciona como **proxy** y discrimina igual. Un **falso positivo** estigmatiza a un inocente, y la **accuracy engaña** porque la clase es minoritaria. Además usa **datos personales**, y una caja negra no se puede explicar ni auditar.

> [!info]- Desarrollo (para entender, no para escribir)
> - **Sesgo en los datos de entrenamiento:** la etiqueta disponible no es "cometió un delito" sino "fue detenido o condenado". Es una variable **proxy** que depende de dónde y a quién se controló más. Datos sesgados → modelo sesgado (*garbage in, garbage out*).
> - **Ciclo de retroalimentación:** si el modelo dice que un barrio es "riesgoso", se patrulla más, se detecta más delito ahí y los nuevos datos refuerzan la predicción.
> - **Discriminación indirecta:** sacar la etnia o el género no alcanza; atributos correlacionados (barrio, ingresos, nivel educativo) los reconstruyen.
> - **Costo de los errores:** un falso positivo afecta la libertad y la reputación de alguien que no hizo nada. Hay que mirar el desempeño **por clase** (sensibilidad, especificidad) y **por grupo**, no solo la accuracy, que es engañosa con clases desbalanceadas.
> - **Interpretabilidad:** decisiones que afectan derechos requieren poder explicar el porqué (inferencia), no solo predecir con una caja negra.
> - **Privacidad y consentimiento:** se usan datos personales sensibles.
> - **Responsabilidad:** ¿quién responde por un error del modelo? En la fase de **evaluación** de CRISP-DM hay que preguntarse si el sistema debe implementarse.

---

## RA 3 — Modelado

### 6. Detección de piezas defectuosas en una línea de producción *(máx. 10 líneas)*
> Una empresa posee una línea de producción de piezas para automóviles. Una de las máquinas de dicha línea puede producir piezas con algunas fallas de calidad, por lo que quieren identificarlas y separarlas oportunamente. Las piezas salen de la línea en una cinta transportadora y son captadas por una cámara que las enfoca desde arriba. La empresa los contacta y les dice que posee videos históricos y pueden enseñarles cuáles piezas son las defectuosas en los videos.
>
> Sin ahondar en algoritmos particulares, determine los pasos a seguir indicando: tipo de aprendizaje a utilizar, tipo de algoritmos a utilizar, cómo haría el entrenamiento de los modelos, y cómo haría la validación. ¿Qué métricas deberían usarse? ¿Por qué? ¿Qué tipo de solución se le presentará al cliente? No escriba más de 10 líneas.

> [!check]- Ver respuesta (≤ 10 líneas)
> **Aprendizaje supervisado**: el cliente puede etiquetar las piezas → **clasificación binaria** (defectuosa / correcta) sobre imágenes. **Preparación:** extraer de los videos una imagen por pieza, etiquetarla con el experto y balancear las clases, porque las fallas son pocas. **Algoritmos:** clasificadores de imágenes (visión por computadora). **Entrenamiento:** train/test 80/20 con **muestreo estratificado**, sin que una misma pieza quede en ambos. **Validación:** **validación cruzada estratificada** para elegir modelo y parámetros, y prueba final con el test reservado. **Métricas:** matriz de confusión, priorizando la **sensibilidad** de la clase defectuosa (dejar pasar una pieza fallada es el error más caro) sin descuidar la **especificidad** (no descartar piezas buenas); la accuracy engaña por el desbalance. **Solución:** un modelo **predictivo** en la línea que analiza en tiempo real la imagen de la cámara y separa o alerta las piezas defectuosas, con monitoreo y reentrenamiento.

> [!info]- Desarrollo (para entender, no para escribir)
> Siguiendo CRISP-DM:
> 1. **Negocio:** el objetivo es separar las piezas falladas *a tiempo*. Hay que definir con el cliente cuánto cuesta dejar pasar una fallada vs descartar una buena, y qué velocidad tiene la cinta (el modelo tiene que responder rápido).
> 2. **Datos:** los videos son datos **no estructurados**. Se extraen los fotogramas, se recorta cada pieza y el experto la etiqueta. Hay que verificar la calidad: iluminación, desenfoque, piezas superpuestas.
> 3. **Preparación:** normalizar tamaño y brillo. Los defectos son la **clase minoritaria**, así que se balancea con submuestreo, sobremuestreo o *data augmentation* (rotar, cambiar el brillo).
> 4. **Modelado:** clasificación supervisada sobre imágenes. Si casi no hubiera ejemplos de piezas falladas, una alternativa es la **detección de anomalías** (aprender cómo es una pieza "normal" y marcar lo que se desvía).
> 5. **Validación:** el muestreo **estratificado** mantiene la proporción de defectuosas en train y test. Hay que evitar la **fuga de información**: fotogramas consecutivos de una misma pieza son casi idénticos y, si quedan en train y en test, el resultado sale inflado. Conviene separar por pieza o por fecha del video. Comparar train vs test para detectar **overfitting**.
> 6. **Métricas:** si el 2 % de las piezas son defectuosas, un modelo que dice "todas correctas" tiene 98 % de accuracy y no sirve. Por eso se usan la **sensibilidad** (recall de la clase defectuosa), la **especificidad** y la precisión, eligiendo el umbral según los costos de cada error.
> 7. **Implementación:** el modelo corre sobre la cámara en tiempo real y acciona un separador o una alarma. Hay que **monitorearlo** y reentrenarlo si cambian las piezas, la cámara o la iluminación.
