---
tipo: resumen
materia: Ciencia de Datos
tags: [parcial, preguntas, ciencia-de-datos]
---
# Preguntas de ejemplo del parcial — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · Teoría en [[Resumen Ciencia de Datos]] · Preguntas guía en [[Preguntas de estudio - Ciencia de Datos]]

> [!info] Cómo usar esta nota
> Dos partes: las **preguntas de ejemplo** que pasó el profesor (1 a 6, agrupadas por **RA**, resultado de aprendizaje) y el **parcial de 2025** con dos resoluciones de alumnos (P1 a P7). Primero intentá responder y después abrí **Ver respuesta**. Cuando el enunciado limita las líneas, la respuesta respeta ese límite y la explicación extendida está aparte, en **Desarrollo**.
> En el original de las preguntas de ejemplo hay dos con el número 4; acá van numeradas de corrido (1 a 6).

**Índice:** Preguntas de ejemplo: [[#RA 1 — Metodologías|RA 1]] · [[#RA 2 — Conocimiento y preparación de los datos|RA 2]] · [[#RA 3 — Modelado|RA 3]] — [[#Parcial 2025 — resoluciones de alumnos|Parcial 2025]]

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

---

## Parcial 2025 — resoluciones de alumnos
📎 [[GRANDI, TOBÍAS - PARCIAL.pdf]] · [[ciaponi_ciencia_de_datos (1).pdf]]

> [!info] Sobre este parcial
> Parcial escrito de noviembre de 2025 (Google Forms, 7 preguntas). Según el encabezado evalúa los criterios **C1.1, C1.2, C1.3, 2.1, 3.1 y 3.2** de la planificación, y **no es obligatorio para regularizar pero sí para aprobar** (después hay un oral final).
> Los dos PDF son **resoluciones de dos alumnos del mismo examen, sin la corrección del profesor**, así que pueden tener errores. Por eso cada pregunta tiene las dos resoluciones transcriptas (solo corregí tildes y erratas mínimas), una **respuesta modelo** basada en las diapos y un callout con las **correcciones** a cada resolución.
> Temas: CRISP-DM vs KDD, conocimiento de los datos, minería de texto, regresión y clasificación.

### P1. Conocimiento de los datos antes de la preparación
> ¿Por qué resulta necesaria una etapa de conocimiento de los datos antes de la preparación de los mismos? ¿Por qué no hacer la exploración y la preparación a la vez?

> [!quote]- Resolución Grandi
> Resulta necesario una etapa de conocimiento de los datos debido a que en ella se buscará recopilar los mismos, entender si son útiles para alcanzar los objetivos de minería de datos hallados anteriormente en la etapa de conocimiento del negocio, comprender distintas relaciones existentes y los comportamientos de ciertos atributos (medidas de dispersión, medidas de centralización, distribuciones, correlaciones, etc.) y, a su vez, comenzar a determinar la calidad de los datos. En la etapa de preparación se buscará poder seleccionar los atributos, limpiarlos y transformarlos para los distintos modelos que se entrenarán en la etapa de modelado. Por otro lado, también es útil tener separadas estas etapas (conocimiento y preparación de los datos) debido a que tiene sentido crear una retroalimentación entre la etapa de preparación y modelado (para poder ajustar los datos en función de los modelos elegidos), y no tendría sentido que esta retroalimentación implique realizar todo un conocimiento de los datos de nuevo, debido a que los datos son siempre los mismos, sólo se busca cambiar su representación.

> [!quote]- Resolución Ciaponi
> Esta etapa es importante porque nos permite conocer el contenido, calidad y limitaciones de los datos antes de transformarlos. En sí su objetivo principal es el de conocer en su totalidad los datos, tanto su significado como sus tipos, semántica, visualizaciones, etc.
>
> Trabajarlas por separado nos da la ventaja de conocer en su totalidad todos los datos antes de realizar una actividad de la preparación (como borrar ciertos datos que quizás sean relevantes en realidad).

> [!check]- Ver respuesta
> **¿Por qué antes?** Porque para preparar los datos hay que saber **qué** preparar y **cómo**. La fase de conocimiento (recolectar, describir, explorar y verificar la calidad) produce los reportes que **definen las estrategias de preparación**: qué atributos tienen faltantes y si esos faltantes tienen semántica, cuáles tienen ruido o anomalías, de qué tipo es cada atributo (y qué operaciones son válidas), cuáles son redundantes o están correlacionados. Además permite decidir si los datos **sirven** para los objetivos de minería: si no sirven, se vuelve al negocio antes de invertir en la preparación, que lleva ~90 % del tiempo. También deja patrones triviales e hipótesis.
>
> **¿Por qué no a la vez?** Porque la exploración es **descriptiva y no modifica los datos**, mientras que la preparación los **transforma** (elimina, imputa, normaliza, discretiza). Si se mezclan:
> - se toman decisiones **sin la visión completa** del dataset: borrar como error una anomalía que era conocimiento, eliminar tuplas con faltantes que tenían significado, imputar con la media un atributo muy sesgado;
> - se describen datos ya alterados y se pierde la referencia de los **datos originales**, así que el proyecto deja de ser replicable y auditable;
> - la preparación **itera con el modelado** (cada técnica pide los datos de otra forma). Con las fases separadas, esas iteraciones no obligan a volver a explorar todo.

> [!warning]- Correcciones a las resoluciones
> - **Grandi:** explica bien qué hace cada fase y suma el argumento de la iteración preparación ↔ modelado. Le falta el argumento central del "¿por qué no a la vez?": preparar sin conocer los datos lleva a decisiones equivocadas (borrar, imputar o transformar mal).
> - **Ciaponi:** es corta, pero tiene justo ese argumento central (no borrar datos que en realidad eran relevantes). Le falta decir que la exploración define las estrategias de preparación y que permite ver si los datos sirven para los objetivos.

### P2. Preparación de textos para A-priori *(opción múltiple)*
> Se está buscando determinar qué conceptos importantes suelen aparecer juntos en papers de ciencia de datos, utilizando el algoritmo a-priori. ¿Qué actividades se podrían realizar en la etapa de preparación de datos para lograr este objetivo?
> ☐ Stop-word removal ☐ Lematización ☐ Vectorización One-hot encoding ☐ Vectorización por frecuencia ☐ Vectorización TF-IDF ☐ Tokenización ☐ Otros: ___

> [!quote]- Resoluciones (lo que marcó cada uno)
> | Opción | Grandi | Ciaponi |
> |---|---|---|
> | Tokenización | ✔ | ✔ |
> | Stop-word removal | | ✔ |
> | Lematización | ✔ | ✔ |
> | One-hot encoding | | |
> | Vector de frecuencias | | ✔ |
> | TF-IDF | ✔ | |
> | Otros | | |

> [!check]- Ver respuesta
> A-priori trabaja sobre una **base transaccional**: cada **paper es una transacción** y cada **concepto es un ítem**. El soporte cuenta en cuántos papers **aparece** un conjunto de conceptos, así que solo importa la **presencia**, no cuántas veces aparece.
>
> | Opción | ¿Va? | Por qué |
> |---|---|---|
> | **Tokenización** | ✔ | Separar el texto en términos |
> | **Stop-word removal** | ✔ | "el", "de", "que" están en todos los papers y formarían itemsets frecuentes sin significado |
> | **Lematización** | ✔ | "clasificador / clasificadores" tienen que ser el mismo ítem; si no, el soporte se reparte |
> | **One-hot encoding** | ✔ | **Es la representación que usa A-priori**: matriz booleana paper × concepto (📓 así se arma en `3.05.gdr.association_rules.ipynb` para `mlxtend`) |
> | **Vector de frecuencias** | ✗ | A A-priori no le importa cuántas veces aparece un concepto; habría que binarizarlo igual |
> | **TF-IDF** | ✗ | Da pesos continuos que A-priori no usa. Matiz defendible: puede servir como **filtro** para quedarse con los términos "importantes" antes de binarizar, pero la representación final es binaria |
> | **Otros** | ✔ | Extraer **términos compuestos / n-gramas** ("árbol de decisión" y "machine learning" son un solo concepto) · minúsculas y sin puntuación · extraer el texto de los PDF y quedarse con título, abstract y palabras clave · descartar términos muy raros |

> [!warning]- Correcciones a las resoluciones
> - **Los dos olvidaron one-hot encoding**, que es justamente la representación que necesita A-priori.
> - **Grandi:** marcó TF-IDF (no es la representación que usa A-priori) y no marcó stop-word removal, sin la cual las palabras vacías dominarían los itemsets frecuentes.
> - **Ciaponi:** marcó vector de frecuencias, que no hace falta porque A-priori solo mira la presencia.

### P3. Problema de negocio con regresión sobre texto
> Describa un problema de negocio que pueda ser resuelto con regresión, sobre datos textuales. Explique indicando datos de entrada y de salida.

> [!quote]- Resolución Grandi
> Si se quisiera, por ejemplo, utilizar un modelo que ayude a los empleados a completar formularios o planillas. Suponiendo que se tiene un dataset con texto que fue utilizado en la creación de formularios/planillas por otros empleados a lo largo del tiempo, se podría entrenar un modelo que realice un autocompletado basándose en los datos históricos. Los datos de entrada serían, por ejemplo, los primeros 5 campos de los formularios/planillas y los datos de salida serían los campos restantes.

> [!quote]- Resolución Ciaponi
> Datos de entrada: opiniones de Mercado Libre en texto. Ej: "muy bueno el producto, compra satisfactoria", "muy malo, llegó roto".
>
> La salida van a ser las estrellas asignadas por el cliente.
>
> Se debería plantear TF-IDF para formar vectores numéricos (luego de una preparación que dejara solo las palabras más importantes), los cuales podemos usar como entrada para una regresión, con su rating correspondiente como salida.

> [!check]- Ver respuesta
> La regresión predice una salida **numérica continua**, así que el problema tiene que tener un número como salida.
>
> **Ejemplo:** una inmobiliaria quiere **sugerir el precio** de una propiedad a partir de la **descripción del aviso**, para orientar a quien publica y detectar avisos sobrevaluados o subvaluados.
> - **Entrada:** el texto de la descripción ("departamento 2 ambientes a estrenar, balcón, cochera, frente al río…"). Se tokeniza, se sacan stopwords, se lematiza y se pasa a **TF-IDF**, que da un vector numérico (se le pueden sumar atributos estructurados como los m²).
> - **Salida:** el **precio** (numérico continuo).
> - **Modelo:** regresión lineal múltiple sobre los vectores TF-IDF; se evalúa con MSE y validación cruzada.
>
> Otros ejemplos: tiempo de resolución de un ticket de soporte según su texto, cantidad de "me gusta" de una publicación, salario de una oferta laboral según su descripción.

> [!warning]- Correcciones a las resoluciones
> - **Grandi:** autocompletar formularios **no es regresión**: la salida es texto o categorías (sería generación de texto o clasificación), no un valor numérico. Además no explica cómo se representa el texto.
> - **Ciaponi:** correcto en lo esencial: texto → TF-IDF → regresión → rating, con la preparación explicada. Matiz: las estrellas son un valor **ordinal discreto** (1 a 5), que también se podría plantear como clasificación; un ejemplo con salida continua (precio, tiempo) lo deja más claro.

### P4. Objetivos de negocio y objetivos de minería de datos
> Por qué resulta relevante el planteo metodológico de objetivos de negocio y objetivos de minería de datos, para llevar adelante un proyecto de ciencia de datos.

> [!quote]- Resolución Grandi
> Los objetivos de negocio resultan interesantes de plantear debido a que es lo que nuestro cliente quiere lograr con el proyecto y, por otro lado, los objetivos de minería de datos son aquellos que buscaremos nosotros, como científicos de datos, lograr para dar respuesta a los objetivos de negocio.

> [!quote]- Resolución Ciaponi
> La principal ventaja que nos brinda este enfoque es la de alinear el trabajo técnico (es decir, todas las actividades que realizamos desde un punto de vista técnico para conseguir los resultados) con las necesidades reales de la organización (dadas por los objetivos de negocio).
>
> Este planteo implica varias cuestiones además de la ya nombrada, como poder garantizar mayor trazabilidad de las actividades a realizar (sabemos para qué hacemos las cosas, qué queremos obtener) y principalmente garantizar calidad y utilidad de los resultados.

> [!check]- Ver respuesta
> En la fase de **entendimiento del negocio**, CRISP-DM pide establecer los **objetivos de negocio**, expresados en términos del negocio ("reducir la fuga de clientes un 10 %"), y **traducirlos** a **objetivos de minería de datos**, expresados en términos técnicos ("predecir qué clientes abandonarán en los próximos 3 meses con sensibilidad ≥ 80 %"), cada uno con su **criterio de éxito**. Es relevante porque:
> - **Alinea** el trabajo técnico con lo que necesita el cliente y evita proyectos técnicamente correctos pero inútiles, que es la causa de fracaso que motivó las metodologías (como la crisis del software).
> - **Guía las decisiones técnicas:** qué datos hacen falta, qué técnica usar (clasificación, clustering…) y qué métrica optimizar (ej. sensibilidad si lo crítico es no perder clientes).
> - **Define cuándo el proyecto es exitoso:** el modelado se evalúa contra los criterios de minería de datos y la fase de **Evaluación** contra los objetivos de negocio.
> - Da un **lenguaje común** y **trazabilidad** entre los stakeholders y el equipo técnico, y delimita el alcance.
> - Es lo que **le falta a KDD**, que no tiene en cuenta los intereses del cliente.

> [!warning]- Correcciones a las resoluciones
> - **Grandi:** define cada tipo de objetivo pero **no explica por qué es relevante** plantearlos, que es lo que pide la pregunta. Faltan la traducción entre lenguajes, los criterios de éxito y su uso en la evaluación.
> - **Ciaponi:** bien: alineación, trazabilidad, calidad y utilidad de los resultados. Podría sumar un ejemplo y la conexión con la fase de Evaluación.

### P5. Evaluación en el modelado vs fase de Evaluación
> Explique cuál es la diferencia entre la evaluación realizada en la fase de modelado de CRISP-DM y la fase de Evaluación propiamente dicha.

> [!quote]- Resolución Grandi
> La actividad de evaluación en la fase de modelado de CRISP-DM tiene como objetivo evaluar los modelos entrenados, buscaremos evaluar las distintas configuraciones de hiperparámetros y que los modelos no realicen overfitting, todo esto a través de distintas métricas de validación. Por otro lado, la fase de evaluación de la metodología busca evaluar nuestros modelos frente a los objetivos de minería de datos planteados en la etapa de conocimiento del negocio, comprobar si ellos los cumplen o no y decantarnos por un modelo final.

> [!quote]- Resolución Ciaponi
> La etapa de evaluación que se encuentra en la fase de modelado evalúa la calidad técnica del modelo, su objetivo principal es el de medir el rendimiento del modelo y ajustar parámetros. Se podría decir que responde la pregunta: ¿el modelo está aprendiendo bien?
>
> Por otro lado, la FASE de evaluación realiza una evaluación global de todo el proyecto. No analiza solo el rendimiento técnico, sino que también si el modelo cumple los objetivos de negocio definidos en la primera fase.
>
> Podemos notar que una gran diferencia está en sus objetivos y alcance: mientras la evaluación dentro del modelado mide la eficacia técnica de un modelo, la fase de evaluación busca un análisis global, con revisión con los stakeholders y validación de la utilidad del modelo.
>
> A su vez, la fase de evaluación puede llegar a derivar en una revisión de alguna fase previa, si se detecta algún error o no se llegan a los objetivos requeridos.

> [!check]- Ver respuesta
> | | Evaluar el modelo (tarea del **Modelado**) | Fase de **Evaluación** |
> |---|---|---|
> | Qué evalúa | El **modelo**, técnicamente | Los **resultados de todo el proceso** |
> | Contra qué | Los **objetivos / criterios de éxito de minería de datos** (accuracy, sensibilidad, MSE…) | Los **objetivos de negocio** |
> | Cómo | Diseño de tests: train/test, validación cruzada, comparar modelos y parámetros, detectar overfitting | Revisión con los stakeholders: ¿el resultado sirve al negocio? ¿quedó afuera alguna cuestión importante del negocio? Se revisa el proceso |
> | Quién | El científico de datos | El equipo junto con el cliente |
> | Resultado | Modelo ajustado y ranking de modelos (puede volver a la preparación) | Decidir los próximos pasos: implementar, iterar (volver al negocio) o iniciar un nuevo proyecto |
>
> **Ejemplo:** un modelo de fraude con 99 % de accuracy y buena validación cruzada aprueba la evaluación técnica. Pero si detecta el fraude días después, cuando ya no se puede bloquear la tarjeta, no cumple el objetivo de negocio y falla en la fase de Evaluación.

> [!warning]- Correcciones a las resoluciones
> - **Grandi:** la parte del modelado está bien, pero dice que la fase de Evaluación compara contra los **objetivos de minería de datos**. Es al revés: esos se verifican en el modelado, y la fase de Evaluación compara contra los **objetivos de negocio** (lo dice la diapo de CRISP-DM).
> - **Ciaponi:** correcta y completa: calidad técnica vs análisis global contra el negocio, revisión con stakeholders y posible vuelta a fases previas.

### P6. Genes y tipos de cáncer: ¿qué actividad de minería?
> Un grupo de científicos busca asociar un conjunto de genes con patologías específicas. La base de datos de entrada posee 10 atributos de entrada Ti, y un atributo de salida. Los atributos de entrada toman valores enteros {1,2,3,4} según la base nitrogenada que se encuentra en la posición i de la secuencia (1: Timina, 2: Guanina, 3: Adenina, 4: Citosina).
> El atributo de salida, también entero, corresponde con cuatro tipos de cáncer: (1: cáncer de hígado, 2: cáncer de pulmón, 3: cáncer de páncreas, 4: cáncer de piel).
> Indique qué actividad de la minería de datos utilizaría. Explique.

> [!quote]- Resolución Grandi
> Debido a que tenemos datos de entrada y uno de salida categórico, resulta de interés aplicar técnicas de aprendizaje supervisado, específicamente de clasificación. Esto se debe a que buscamos clasificar las distintas configuraciones de bases nitrogenadas en los distintos tipos de cáncer.

> [!quote]- Resolución Ciaponi
> Inicialmente podemos definir que va a ser un problema de aprendizaje supervisado, puesto que tenemos una variable objetivo.
>
> Las variables son categóricas (por más que estén representadas con números) por lo que buscamos resolver es un problema de clasificación.
>
> En este caso, queremos predecir el tipo de cáncer (1 a 4) a partir de 10 atributos de entrada (T1, T2, …, T10).
>
> Podríamos aplicar clasificadores como árboles de decisión.

> [!check]- Ver respuesta
> **Clasificación** (aprendizaje supervisado, multiclase): hay un atributo de salida conocido (el tipo de cáncer) que se quiere predecir o explicar a partir de T1…T10.
> - **La trampa:** las entradas y la salida son enteros, pero son atributos **nominales**. El número es solo un código: que Timina sea 1 y Citosina 4 no implica orden ni distancia. Por eso **no es regresión**: predecir "2,5" no significa nada, y codificar clases con números para usar regresión es justamente lo que no se puede hacer.
> - **Preparación:** tratar los Ti como categóricos (one-hot si el algoritmo usa distancias).
> - **Algoritmo:** un **árbol de decisión** maneja atributos nominales y genera **reglas** interpretables ("si T3 = Adenina y T7 = Guanina → cáncer de pulmón"). Eso les sirve a los científicos para **asociar** posiciones y bases con cada patología (inferencia), no solo para predecir.
> - **Validación:** muestreo estratificado y matriz de confusión por clase.
>
> Aunque el enunciado dice "asociar", no es búsqueda de reglas de asociación: hay un atributo de salida definido. Las reglas del árbol cumplen ese papel.

> [!warning]- Correcciones a las resoluciones
> - **Grandi:** correcto, pero no justifica por qué no es regresión aunque la salida sea un entero, que es el punto clave del ejercicio.
> - **Ciaponi:** la mejor de las dos: aclara que las variables son categóricas aunque estén representadas con números y propone árboles de decisión. Podría sumar que el árbol también sirve por su interpretabilidad.

### P7. Estructura jerárquica de CRISP-DM vs KDD
> Explique por qué la estructura jerárquica de CRISP-DM representa una mejora frente al uso del modelo KDD para llevar adelante proyectos de ciencia de datos.

> [!quote]- Resolución Grandi
> La estructura jerárquica de CRISP-DM nos facilita conocer lo que debemos y no debemos realizar en cada una de las fases y actividades genéricas, garantizando de este modo una correcta aplicación de la metodología como así también un orden y estructura sobre las tareas a llevar a cabo. Asimismo, CRISP-DM nos brinda retroalimentaciones entre distintas etapas, generando un modelo iterativo incremental capaz de ajustarse a lo largo del proyecto, como también etapas que involucran al negocio y cómo se utilizarán los resultados.
> Por otro lado, KDD sólo nos especifica sus fases de manera amplia y poco específicas, no contempla retroalimentaciones (por lo que es un modelo con estructura más similar a cascada) ni tampoco nos brinda fases que involucren al negocio o cómo aplicar los resultados.

> [!quote]- Resolución Ciaponi
> KDD tenía una estructura secuencial, las etapas en este caso se ejecutan una después de la otra. Esto es algo muy importante (para mal) ya que no nos permite realizar retroalimentaciones ni contempla jerarquías. Está centrada en lo técnico, en los pasos necesarios para llevar a cabo la minería.
>
> CRISP-DM plantea una estructura jerárquica la cual tiene una sólida división de responsabilidades entre FASES, la cual se planteó no solo pensando en la división de las actividades, sino que también en la retroalimentación de las mismas.
>
> Su estructura jerárquica nos permite ir de lo general a lo particular, contextualizando las actividades y brindando un mejor seguimiento de las mismas.
>
> A su vez esta estructura nos facilita la estandarización y trazabilidad, lo cual es bastante deseable para hacer el proyecto reproducible.

> [!check]- Ver respuesta
> CRISP-DM organiza sus actividades en **4 niveles**: **fases → tareas genéricas → tareas especializadas → instancias de proceso**. Es una mejora frente a KDD porque:
> - **Va de lo general a lo particular:** los niveles de arriba son **genéricos** (sirven para cualquier proyecto, industria o herramienta) y los de abajo se **adaptan al contexto** (ej. "limpiar los datos" → "imputar los faltantes numéricos con la mediana"). Así es un estándar y a la vez es aplicable a cada caso.
> - **Cada tarea genérica tiene entregables** (reportes): permite **planificar, controlar y hacer seguimiento**, y deja el proyecto **documentado, trazable y reproducible**. Las instancias de proceso registran lo que realmente se hizo.
> - **Funciona como guía:** dice **qué** hacer en cada fase (no cómo), así no se olvidan actividades, y da un **lenguaje común** al equipo y al cliente.
> - **Incluye niveles y fases que KDD no tiene:** entendimiento del negocio, evaluación contra los objetivos de negocio e implementación.
>
> KDD, en cambio, es una secuencia de 5 pasos (selección, preprocesamiento, transformación, minería, interpretación) **de un solo nivel**, centrada en lo técnico, sin descomposición en tareas ni entregables.

> [!warning]- Correcciones a las resoluciones
> - **Los dos** afirman que KDD **no permite retroalimentación** y es "tipo cascada". Ojo: Fayyad lo describe como un proceso **interactivo e iterativo**, con retornos entre pasos, y las críticas de la diapo son otras (solo técnico, no tiene en cuenta al cliente, no contempla la implementación). Mejor no apoyar la respuesta en eso.
> - La pregunta es sobre la **estructura jerárquica**, y **ninguno nombra los 4 niveles**.
> - **Grandi:** se centra en la retroalimentación y en las fases de negocio, que no son consecuencia de la jerarquía.
> - **Ciaponi:** acierta con "de lo general a lo particular", la estandarización y la trazabilidad; es la que más se acerca a lo que se pregunta.
