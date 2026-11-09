---
tipo: resumen
materia: Ciencia de Datos
tags: [resumen, ciencia-de-datos]
---
# Resumen de estudio — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · [[Inicio]] · Preguntas respondidas: [[Preguntas de estudio - Ciencia de Datos]]

> [!info] Cómo usar este resumen
> Una sección por unidad, con link a las diapositivas originales. Todo lo que está acá sale de las diapos de la cátedra, **explicado en detalle**: cada sigla, cada símbolo de las fórmulas y cada ejemplo están desarrollados aunque en la diapo aparezcan solo nombrados o como imagen.
> Las partes marcadas como *(complemento)* no están textuales en las diapos (o estaban solo como imagen) y las agregué para que el tema cierre.
> Si una sigla te quedó colgada, están todas juntas en [[#Glosario de siglas y símbolos]].

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
- [[#Glosario de siglas y símbolos]]
- [[#Preguntas de repaso]]

---

## 0. Introducción
📎 [[Clase 1 - Introduccion.pdf]]

### Qué es la Ciencia de Datos

> [!quote] Definición de la diapo
> **Ciencia de Datos / BI** (*Business Intelligence*, Inteligencia de Negocios): conjunto de técnicas, herramientas y metodologías para transformar **datos en conocimiento** novedoso, oportuno y útil para la **toma de decisiones estratégicas** en una organización.

Conviene desarmar la definición, porque cada palabra está puesta a propósito:

- **Datos → conocimiento:** el dato solo (una fila de una tabla de ventas) no sirve para decidir. El conocimiento es el **patrón** que esos datos esconden ("las ventas de este producto caen cuando sube la temperatura").
- **Novedoso:** si el patrón ya lo sabía todo el mundo en la empresa, no agrega valor.
- **Oportuno:** tiene que llegar **a tiempo** para decidir. Un patrón descubierto después de la decisión no sirve.
- **Útil para decisiones estratégicas:** el destinatario es quien decide, no el área técnica.

**Relación con la carrera (ISI — Ingeniería en Sistemas de Información):** la ciencia de datos entra dentro de las incumbencias del ingeniero en sistemas porque se ocupa del **procesamiento de la información** que la organización produce, transporta y almacena. Los modelos matemáticos y computacionales que se ven a lo largo de la carrera son los que permiten implementar estas técnicas.

### Breve historia

La idea de buscar patrones en los datos es vieja; lo que fue cambiando es la capacidad técnica para hacerlo:

1. **Desde siempre:** se buscan patrones en los datos para tomar decisiones.
2. **Estadística:** aparecen las primeras técnicas formales para encontrar esos patrones.
3. **Computación:** aumentan muchísimo las posibilidades de **cálculo**.
4. **Internet:** las posibilidades de **almacenamiento y procesamiento** explotan exponencialmente.
5. **Inteligencia Artificial:** en los últimos años permite extraer conocimiento **más complejo** a partir de los datos.

### Big Data — las 3 V

La sociedad está "datificada": se generan datos de forma masiva, a gran velocidad y en múltiples formatos. Esas tres características son las que definen el fenómeno:

| V | Qué significa | Ejemplo |
|---|---|---|
| **Volumen** | Cantidad de datos generados y almacenados; escalas que no se pueden analizar a mano ni con herramientas tradicionales | Todos los tickets de una cadena de supermercados durante años |
| **Velocidad** | Ritmo al que los datos se generan y al que hay que procesarlos (muchas veces casi en tiempo real) | Transacciones de tarjetas de crédito, clics en un sitio |
| **Variedad** | Formatos distintos: estructurados (tablas), semi-estructurados (JSON, logs) y **no estructurados** (texto, imágenes, audio, video) | Reseñas de productos + fotos + planilla de ventas |

> [!note] Por qué importa para la materia
> Las 3 V son las que **justifican** que hagan falta técnicas nuevas: por volumen y velocidad hacen falta algoritmos **escalables**, y por variedad hacen falta técnicas específicas para datos no estructurados (de ahí la unidad de [[#10. Minería de Texto]]).

### OLTP vs OLAP *(complemento — en la diapo está solo como imagen)*

Son los dos tipos de sistemas que conviven en una organización; entender la diferencia explica **de dónde salen** los datos que se analizan.

| | **OLTP** (*On-Line Transaction Processing*) | **OLAP** (*On-Line Analytical Processing*) |
|---|---|---|
| Para qué | Operación diaria del negocio | Análisis para la toma de decisiones |
| Operaciones | Muchas escrituras cortas (altas, bajas, modificaciones) | Pocas consultas, pero grandes y agregadas |
| Datos | Actuales, de detalle, normalizados | Históricos, resumidos, orientados al análisis |
| Usuario | Operativo (cajero, vendedor) | Analista, gerencia |
| Ejemplo | Sistema de facturación | Data warehouse con las ventas de 5 años |

### Tipos de analíticas (modelos)

"Analíticas" o "modelos" es otro término para los **tipos de análisis** que se pueden hacer. Los distintos autores dan definiciones distintas; lo que importa es clasificarlas **según su utilidad**:

| Tipo | Preguntas que responde | Qué entrega | Ejemplo |
|---|---|---|---|
| **Descriptiva** | ¿Qué pasó? ¿Qué está pasando? | Visión general de la situación actual: **reportes** y **dashboards** | Tablero con las ventas del mes por sucursal |
| **Predictiva** | ¿Qué va a pasar? ¿Por qué va a pasar? | Proyecciones de variables o eventos futuros; permite **adelantarse a tendencias y disparar alarmas** | Pronóstico de demanda del próximo trimestre |
| **Prescriptiva** | ¿Qué debo hacer? ¿Por qué debo hacerlo? | **Cursos de acción** y decisiones de negocio con mayor probabilidad de impactar en el logro de los objetivos | "Conviene reforzar la publicidad en radio en estos 3 mercados" |

> [!tip] Cómo se encadenan
> Son niveles de **madurez analítica** acumulativos: primero hay que poder describir lo que pasó, después se puede predecir, y recién con una predicción confiable tiene sentido prescribir una acción.

### Machine Learning

- **Machine Learning (ML)** o **aprendizaje automático**: rama de la **IA** (Inteligencia Artificial) que estudia **cómo los sistemas inteligentes aprenden a partir de los datos**.
- En **minería de datos** se usa para **generalizar patrones** a partir de los datos.
- Puede usarse tanto de forma **descriptiva** como **predictiva**.

> [!example] Ejemplo de la diapo — *clima → juega o no*
> Un dataset de 14 filas con los atributos **Clima** (Soleado / Nublado / Lluvioso), **Temperatura** (Alta / Media / Baja), **Humedad** (Alta / Normal) y **Viento** (Sí / No), y el atributo objetivo **Juega o no** (Sí / No).
>
> | Clima | Temperatura | Humedad | Viento | Juega |
> |---|---|---|---|---|
> | Soleado | Alta | Alta | No | No |
> | Soleado | Alta | Alta | Sí | No |
> | Nublado | Alta | Alta | No | Sí |
> | Lluvioso | Media | Alta | No | Sí |
> | Lluvioso | Baja | Normal | No | Sí |
> | … | | | | |
>
> El algoritmo **no recibe la regla**: la tiene que **generalizar** a partir de los ejemplos (por caso, "si está nublado, siempre juega"). Es el mismo tipo de dataset con el que se arman los [[#Árboles de decisión|árboles de decisión]] de la unidad 5.

### Roles y herramientas

**Roles en la industria:** Analista de Datos · Científico de Datos · Ingeniero de Datos · Ingeniero en Inteligencia Artificial · GenAI Engineer.

**Herramientas:**

| Categoría | Herramientas |
|---|---|
| **Visualización** | Tableau, Power BI, Qlik, Python |
| **Modelado** | Python, R, Keras, TensorFlow, RapidMiner, WEKA |
| **Big Data** | GCP, Azure, AWS, Databricks, Apache Spark |
| **Orquestación** | Docker, Kubernetes |

---

## 1. Metodologías para proyectos de Ciencia de Datos
📎 [[Clase 2 - CRISPDM.pdf]]

### Ciencia de datos vs minería de datos

Son dos cosas distintas y suele entrar como pregunta:

| | **Ciencia de datos** | **Minería de datos** |
|---|---|---|
| Qué es | Sub-disciplina de la informática que le da a la Inteligencia de Negocios herramientas para extraer el conocimiento **implícito** en los repositorios de la organización | Los **algoritmos** que exploran el conjunto de datos y encuentran las regularidades o patrones implícitos |
| Alcance | El **proceso completo**: lo sistematiza considerando todas las actividades involucradas | El **paso técnico** dentro de ese proceso |
| Base | Metodologías y gestión | Estadística, IA, aprendizaje automático, visualizaciones |

Los algoritmos de minería permiten analizar bases de datos **desproporcionadas para el análisis manual**, y son **escalables**, lo que los adapta a las necesidades del big data.

### Por qué hace falta una metodología

El argumento de la diapo es una **analogía con la crisis del software**:

1. Los proyectos de software fallaban porque la industria se enfocaba en **generar código** sin asegurar la calidad de lo producido.
2. Esa gran cantidad de código sin gestionar se volvía **inmanejable**.
3. La crisis dio origen a la **Ingeniería de Software** (1980): la aplicación de un enfoque **sistemático, disciplinado y cuantificable** al desarrollo, operación y mantenimiento de software.
4. **De forma análoga**, aplicar algoritmos de minería de datos de manera apresurada, sin actividades de gestión de recursos, lleva a **no dar respuesta satisfactoria a las necesidades de los stakeholders**.

### KDD (Fayyad et al., 1996)

**KDD** = *Knowledge Discovery in Databases* (descubrimiento de conocimiento en bases de datos). Fue el **primer intento de generalizar** el proceso de extracción de conocimiento a partir de los datos.

*(complemento — en la diapo el proceso está como imagen)* Sus cinco actividades son:

1. **Selección:** elegir los datos objetivo.
2. **Preprocesamiento:** limpieza de ruido y de valores faltantes.
3. **Transformación:** reducción y proyección de atributos, dejarlos en el formato adecuado.
4. **Minería de datos:** aplicar los algoritmos para encontrar patrones.
5. **Interpretación / evaluación:** analizar los patrones y convertirlos en conocimiento.

**Problemas de KDD** (los tres que justifican CRISP-DM):

1. **Se centra solo en lo técnico:** las actividades directamente relacionadas con aplicar los algoritmos, es decir la preparación de los datos y la evaluación **técnica** de los resultados.
2. **No tiene en cuenta los intereses del cliente.**
3. **No contempla la implementación** del conocimiento obtenido.

### CRISP-DM (1999)

**CRISP-DM** = *Cross Industry Standard Process for Data Mining* (proceso estándar inter-industrias para minería de datos). Es un proceso o metodología **estándar** desarrollado en 1999. Características:

- Fue diseñado conjuntamente por **más de 300 organizaciones**.
- **Incorpora las mejores prácticas** para asegurar calidad.
- Es una **propuesta abierta**.
- **Incorpora actividades relacionadas al negocio** (lo que le faltaba a KDD).
- **No especifica el cómo, sino el qué.**
- Es **independiente de las herramientas** que se usan.

**Estructura jerárquica** *(complemento — en la diapo está como imagen)*: las actividades se agrupan en 4 niveles, de lo general a lo particular:

1. **Fases** (las 6 de abajo).
2. **Tareas genéricas:** comunes a cualquier proyecto (ej. "verificar la calidad de los datos").
3. **Tareas especializadas:** cómo se hace esa tarea genérica en un contexto concreto (ej. "limpiar los valores numéricos faltantes").
4. **Instancias de proceso:** el registro de lo que efectivamente se hizo y qué resultó en un proyecto real.

#### Las 6 fases

| # | Fase | Actividades clave | La pregunta de fondo |
|---|---|---|---|
| 1 | **Entendimiento del negocio** | Establecer los **objetivos del negocio** (en el lenguaje del negocio); conocer los **recursos** disponibles; traducirlos a **objetivos de minería de datos** (en términos técnicos); crear la planificación | ¿Qué quiere lograr el cliente? ¿Cuáles son las restricciones? |
| 2 | **Entendimiento de los datos** | **Adquirir** los datos, **explorarlos** y **verificar su calidad**. Familiarizarse con formatos, estructuras y semántica; formular hipótesis; extraer los patrones obvios o triviales | ¿Los datos que tengo sirven para responder eso? |
| 3 | **Preparación de los datos** | Selección, integración, limpieza, formateo y transformación: construir el dataset a partir de los datos crudos. Toma **~90 % del tiempo**; son actividades **repetitivas y sin un orden fijo** | ¿Cómo dejo los datos en condiciones de ser minados? |
| 4 | **Modelado** | Seleccionar las técnicas según los objetivos de minería, **diseñar los tests**, construir el modelo, establecer los valores de los parámetros y evaluarlo. Se **cicla muchas veces** con la fase 3, porque cada técnica pide los datos de otra forma | ¿Qué algoritmo encuentra el patrón? |
| 5 | **Evaluación** | Evaluar los resultados **contra los objetivos de negocio** (no solo técnicamente), decidir los cursos de acción y determinar si quedaron **cuestiones importantes del negocio sin considerar** | ¿Esto le sirve al cliente? |
| 6 | **Implementación** | Informes que especifican todo lo referido al proyecto y sus resultados; se pueden construir herramientas o software que faciliten la toma de decisiones | ¿Cómo se usa esto en la organización? |

> [!important] El ciclo de vida es iterativo, no lineal
> El orden no es rígido: se vuelve atrás cuando hace falta. Las idas y vueltas típicas son **Negocio ↔ Datos** y, sobre todo, **Preparación ↔ Modelado**. Si en la Evaluación los resultados no satisfacen los objetivos, se vuelve al **Entendimiento del negocio**. El círculo exterior del diagrama indica que el proyecto mismo es cíclico: lo implementado genera nuevas preguntas y nuevos proyectos.

**¿Por qué CRISP-DM?**
- El proceso es **genérico, uniforme y estándar**.
- Permite que todos los responsables **hablen el mismo idioma**.
- Es **flexible**: sirve para múltiples escenarios, tipos de problemas y tipos de datos.
- Es **independiente de las herramientas** utilizadas.
- Sus **actividades bien definidas** permiten comprender bien el curso del proyecto.

---

## 2. Conocimiento de los Datos
📎 [[Clase 3 - Conocimiento de los datos-1.pdf]] · [[Clase 3 - Visualizaciones de datos-1.pdf]]

Es la **fase 2 de CRISP-DM**. Sirve para tres cosas:

1. Determinar si los datos disponibles **son adecuados** para extraer conocimiento útil para decidir.
2. Saber **qué estrategias y actividades** van a hacer falta en la preparación de datos (fase 3).
3. Extraer los **patrones obvios o triviales**, como correlaciones simples entre variables.

### Vocabulario

| Concepto | Sinónimos | Qué es |
|---|---|---|
| **Dato** | ejemplo, instancia, fila, objeto, tupla | Representación de una **entidad** del dominio del problema |
| **Atributo** | dimensión, variable, columna | Una **característica** del objeto modelado |

Los datos con un solo atributo se llaman **univariados**; los que tienen varios, **multivariados**.

> El **tipo** de un atributo está determinado por el **conjunto de posibles valores** que puede tomar.

### Tipos de atributos

| Tipo | Descripción | Ejemplo | Medidas válidas |
|---|---|---|---|
| **Nominal** (categórico) | "Relativo a los nombres": toma símbolos o nombres de cosas. Representa **categorías, códigos o estados**. Aunque los valores sean números, su semántica es **categórica, no cuantitativa** | Color de pelo, color de ojos, estado civil | **Moda** |
| **Binario** | Caso especial de nominal con **dos estados** (0 y 1); también llamado booleano. Es **simétrico** si ambos valores tienen igual peso o importancia, y **asimétrico** si son semánticamente dispares | Simétrico: Argentino / Extranjero. Asimétrico: Positivo / Negativo en un test de cáncer | **Moda** |
| **Ordinal** | Nominal cuyos valores tienen un **orden**. Muchas veces **la magnitud entre valores consecutivos no se conoce**. Se puede calcular una distancia entre pares. Puede salir de **discretizar** un atributo continuo | {Niño, Adolescente, Adulto, Anciano} | Moda y **mediana**, **no promedio** |
| **Numérico intervalado** (*interval-scaled*) | Cuantitativo. Valores en una escala **equiespaciada** (misma distancia entre sí), ordenados, que pueden ser positivos, negativos o cero. Tiene sentido la **diferencia** entre valores | Temperatura en °C, fechas de calendario | Diferencias, media |
| **Numérico ratio** (*ratio-scaled*) | Numérico con un **cero absoluto**. Ordenados; se pueden calcular diferencias **y cocientes** | Temperatura en Kelvin (0 K = −273,15 °C), años de experiencia, cantidad de palabras, peso, largo, ancho, latitud, longitud, precio | Todas (promedio, mediana, cocientes…) |

> [!warning] Por qué importa el tipo (pregunta clásica)
> Porque **determina qué medidas y qué operaciones son válidas**.
> - En un **ordinal** codificado con números ({1 = Niño, 2 = Adolescente, 3 = Adulto}) el promedio "2" no significa nada: no se sabe si la distancia Niño→Adolescente es la misma que Adolescente→Adulto. Se puede usar moda y mediana.
> - En un **intervalado** como °C no hay cero absoluto: 20 °C **no es el doble de calor** que 10 °C, porque el 0 °C es convencional. La diferencia sí tiene sentido ("hay 10 grados más").
> - En un **ratio** como el peso sí: 20 kg es el doble de 10 kg, porque el 0 kg significa "ausencia de peso".

**Discretos vs continuos:** para algunos algoritmos es útil esta otra clasificación. Un atributo es **discreto** si tiene un conjunto de valores finito o infinito **contable** (pueden o no ser enteros); si no es discreto, es **continuo**, y generalmente representa números reales.

### Descriptores estadísticos

Hace falta una idea general de **cómo se comporta** el conjunto de datos. Los descriptores estadísticos sirven para identificar propiedades de los datos y para **encontrar ruido o anomalías**.

#### Medidas de tendencia central

Indican **en torno a qué valor se acumulan** los datos, es decir, cuál es el comportamiento esperado.

- **Promedio o media ($\bar{x}$):** para $n$ observaciones $x_1, x_2, \dots, x_n$ de un atributo numérico,
  $$\bar{x} = \frac{\sum_{i=1}^{n} x_i}{n} = \frac{x_1 + x_2 + \dots + x_n}{n}$$
  Es una medida **muy sensible a los extremos y a las anomalías**: un número muy pequeño de observaciones alcanza para perturbar el promedio. Como respuesta a este problema se suele usar la mediana.
- **Mediana:** el valor que parte el conjunto de datos **ordenado** en dos subconjuntos de igual tamaño. Si la cantidad de datos es **par**, es el promedio entre los dos valores centrales. Para datos **asimétricos** es una medida más realista del centro de la distribución. Aplica a datos numéricos, pero se puede extender a datos **ordenados** (ordinales).
- **Moda:** el valor con **mayor frecuencia** entre las observaciones. Se puede calcular tanto para datos **cualitativos como cuantitativos** (es la única de las tres que sirve para nominales). Si la frecuencia máxima coincide entre dos o más valores, el atributo es **multimodal**; y la moda **puede no existir** si todos los valores tienen la misma frecuencia.

> [!tip] Detectar sesgo comparándolas
> Comparando las tres medidas se determina si las observaciones tienen **sesgo** (*skew*):
> - **Simétrica:** media ≈ mediana ≈ moda.
> - **Sesgo positivo** (cola a la derecha): moda < mediana < media — la media se "va" hacia los valores altos.
> - **Sesgo negativo** (cola a la izquierda): media < mediana < moda.

#### Medidas de dispersión

Además del centro, hace falta saber **qué tan dispersos** están los datos alrededor de ese centro, es decir, cuál es la distancia promedio de los valores a la medida de tendencia central.

- **Varianza ($\sigma^2$):** la distancia promedio **al cuadrado** de las observaciones hacia la media general.
  $$\sigma^2 = \frac{1}{n}\sum_{i=1}^{n} (x_i - \bar{x})^2$$
  Se eleva al cuadrado para que las diferencias por encima y por debajo de la media no se cancelen entre sí.
- **Desviación estándar ($\sigma$):** la **raíz cuadrada** de la varianza. Tiene la ventaja de estar en **las mismas unidades** que el atributo original.
  $$\sigma = \sqrt{\sigma^2}$$
  Usando la desviación estándar como criterio es posible identificar **outliers** (valores atípicos). *(complemento)* El criterio habitual es el de los **tres sigma**: se considera anómalo todo valor fuera de $[\bar{x} - 3\sigma,\ \bar{x} + 3\sigma]$, que bajo una distribución normal deja afuera solo el ~0,3 % de los datos.
- **Rango:** la diferencia entre el valor **máximo** y el **mínimo**.
- **Cuartiles:** los valores que dividen el rango en **4 secciones con el 25 % de los datos cada una**. Q1 deja el 25 % por debajo, **Q2 es la mediana** y Q3 deja el 75 % por debajo. Dan una medida del **centro, la dispersión y la forma** de la distribución.
- **IQR** (*Inter-Quartile Range*, rango intercuartil) *(complemento)*: $IQR = Q3 - Q1$. Es el ancho del 50 % central de los datos; a diferencia del rango, **no lo afectan los extremos**.

### Visualización

Las medidas anteriores describen cada atributo **aislado**, y muchas veces las tendencias son difíciles de apreciar mirando números. La **visualización** representa los datos de forma visual para comunicar de manera clara y eficiente, y hace mucho más fácil comprender cómo se comportan.

Antes de visualizar, los datos deben estar **descriptos en su totalidad**: todos los intervinientes del proyecto tienen que conocer la **semántica** de cada atributo, desde la fuente y el mecanismo de obtención hasta sus estadísticas.

| Gráfico | Tipo | Para qué sirve |
|---|---|---|
| **Histograma / gráfico de barras** | Univariado | Muestra la **distribución de frecuencias** de un atributo. Si el atributo es **nominal**, la altura de cada barra es la frecuencia de cada valor del dominio y se llama **gráfico de barras**; si es **numérico**, se llama **histograma** y el rango se discretiza en $n$ subrangos (**bins**), típicamente de igual ancho |
| **Boxplot** (diagrama de cajas o de bigotes) | Univariado | Resume la distribución con **5 números**: mínimo, Q1, mediana (Q2), Q3 y máximo |
| **Scatterplot** (gráfico de dispersión) | Multivariado | Observa si existe **correlación o patrón entre dos atributos numéricos**. Cada par de valores es un par de coordenadas en el plano. Además muestra si hay **clusters** o **anomalías** |
| **Scatterplot matrix** (matriz de dispersión) | Multivariado | Una grilla con el scatterplot de **todos los pares** de variables, para cuando hay más de dos |

**Cómo se lee un boxplot** (los cuartiles solos no dicen nada de los extremos, por eso el resumen de 5 números):

- Los **extremos de la caja** son Q1 y Q3, así que la caja representa el **rango intercuartil** (el 50 % central).
- La **línea dentro de la caja** es la **mediana (Q2)**.
- Los **bigotes** son dos líneas que se extienden hacia el máximo y el mínimo, **siempre que esos valores no superen 1,5 veces el rango intercuartil**.
- Todo lo que queda **fuera de los bigotes** es un **outlier**, y se dibuja como punto suelto.

**Dimensiones extra:** se puede agregar información codificada como **color, forma o tamaño** de los puntos. Otras opciones para muchas variables: **heatmaps**, **gráfico radial** y **caras de Chernoff** (útiles con menos de 19 variables, porque cada variable se mapea a un rasgo de la cara).

---

## 3. Preparación de los Datos
📎 [[Clase 4 - Preparacion de los datos.pdf]]

Es la **fase 3 de CRISP-DM**. La idea central:

> [!important] La baja calidad de los datos se traslada a los resultados
> Los datos "sucios" afectan directamente a los resultados de los modelos y generan **desconfianza en los stakeholders**. Aunque muchos algoritmos manejan internamente algunas cuestiones (datos incompletos, ruido), esos métodos **no suelen ser robustos**: por eso se justifica limpiar antes.

### Factores de calidad de los datos

| Factor | Qué problema detecta |
|---|---|
| **Precisión** | Ruidos o errores en los valores |
| **Completitud** | Atributos, filas o valores perdidos |
| **Consistencia** | Valores inesperados o contradictorios |
| **Credibilidad** | Datos que parecen no ser reales |
| **Interpretabilidad** | Valores codificados sin una interpretación conocida |

### Actividades principales

**Selección → Limpieza → Integración → Reducción → Transformación** (en la práctica se hacen repetidamente y sin un orden fijo).

| Actividad | En qué consiste |
|---|---|
| **Selección** | Decidir **qué datos** se van a usar: qué atributos y qué filas. Criterios: **relevancia** para los objetivos de minería, **calidad** y **restricciones técnicas** (como límites de volumen) planteadas al inicio |
| **Limpieza** | Despojar a los datos de valores perdidos, ruido, anomalías e inconsistencias |
| **Integración** | Unificar la información cuando está en **varios repositorios distintos** (y posiblemente en distintos formatos), para darle a los algoritmos una **única entrada**, evitando redundancia e inconsistencia |
| **Reducción** | Obtener una representación **más chica** de los datos que produzca los mismos resultados (o muy similares), por restricciones técnicas o de eficiencia |
| **Transformación** | Dejar los datos en la forma en que los algoritmos trabajan mejor o en que los resultados se entienden mejor |

### Limpieza — valores perdidos o ausentes

> *Si en un dataset encontrás tuplas con valores ausentes para un atributo dado… ¿qué hacés?*

| # | Estrategia | Cuándo / Desventaja |
|---|---|---|
| 1 | **Ignorar las tuplas** | Se usa generalmente cuando falta el **atributo CLASE** y además faltan otros atributos de esa tupla. **Cuidado:** la cantidad de tuplas ignoradas no puede ser grande, porque el dataset puede quedar inutilizable |
| 2 | **Completar los valores a mano** | Demanda **demasiado tiempo y recursos**; no es factible si la cantidad de faltantes es considerable |
| 3 | **Usar una constante global** (ej. la etiqueta `unknown`) | Es simple, pero los algoritmos **interpretarán erróneamente que es un valor normal** y lo usarán como a cualquier otro. Por eso puede no ser útil |
| 4 | **Usar una medida de tendencia central** (promedio o mediana) | El valor debe calcularse **por cada CLASE**, así que **no es aplicable si justamente falta la clase** |
| 5 | **Usar el valor más probable** | Se predice el faltante con **otra técnica de minería de datos**, en base a los demás atributos. Se justifica si esos valores son muy necesarios para cumplir los objetivos de minería |

> [!warning] Un faltante no siempre es un error
> Muchas veces los datos perdidos **tienen una semántica asociada** (por ejemplo, "fecha de baja" vacía significa que el cliente sigue activo). Esto debe estar especificado en la **descripción de los datos** hecha en la fase anterior.

### Limpieza — ruido

> **Ruido:** un **error aleatorio** en la medición de una variable.

Se puede ver con técnicas de visualización como **scatterplots, boxplots o histogramas**. Dado un atributo numérico (el precio, por ejemplo), se lo puede **"difuminar"** con estas técnicas:

**1. Binning** (de *bin* = contenedor). Difumina el conjunto de datos **ordenado** consultando los "vecindarios" de valores: se ordenan los datos, se dividen en contenedores y los valores de cada contenedor se reemplazan por su **media**, su **mediana** o sus **valores frontera**.

> [!example] Ejemplo de la diapo
> Datos ordenados: **{4, 8, 15, 21, 21, 24, 25, 28, 34}** → bins de 3 elementos:
> - **Bins:** (4, 8, 15) · (21, 21, 24) · (25, 28, 34)
> - **Suavizado por medias:** cada valor se reemplaza por el promedio de su bin.
>   - (4 + 8 + 15)/3 = 9 → **(9, 9, 9)**
>   - (21 + 21 + 24)/3 = 22 → **(22, 22, 22)**
>   - (25 + 28 + 34)/3 = 29 → **(29, 29, 29)**
> - **Suavizado por fronteras:** cada valor se reemplaza por **la frontera más cercana** de su bin (el mínimo o el máximo del bin).
>   - Bin (4, 8, 15): fronteras 4 y 15; el 8 está más cerca del 4 → **(4, 4, 15)**
>   - Bin (21, 21, 24): fronteras 21 y 24 → **(21, 21, 24)**
>   - Bin (25, 28, 34): fronteras 25 y 34; el 28 está más cerca del 25 → **(25, 25, 34)**

**2. Regresión.** Se aproximan los valores con una **función que mejor se ajuste** a los datos, y los valores reales se reemplazan por el valor que da la función, reduciendo así el ruido. **Riesgo:** si el ajuste no es bueno, **se pierde demasiada información**.

**3. Detección de anomalías / clustering.** Con métodos de agrupamiento se agrupan los valores que siguen cierta lógica; los valores con ruido que no se ajustan al comportamiento normal **quedan excluidos** de los grupos. Esos valores pueden **reemplazarse por el promedio o la mediana de su cluster más cercano**, o **eliminarse**.

### Integración

Al unir fuentes aparecen cuatro problemas:

**1. Problema de identificación de entidades** (*entity identification problem*): cómo hacer coincidir **esquemas y objetos** de fuentes diferentes.
- Hay que determinar qué atributos compartidos por las distintas fuentes tienen **los mismos valores y la misma semántica**; por ejemplo `ID` en un sistema y `DNI` en otro. Esto se obtiene de la **descripción de los datos**.
- Las fuentes pueden tener **distinta semántica y formato** para el mismo atributo: ¿un campo en blanco significa lo mismo en ambos sistemas?
- Cuidado con los **atributos dependientes unos de otros**: por ejemplo, los descuentos pueden aplicarse **a la factura completa** en un sistema y **a cada línea de la factura** en otro.

**2. Redundancia y correlación:** un atributo es **redundante** si puede **derivarse de otro** (la edad es redundante si se tiene la fecha de nacimiento). Las **inconsistencias en la nomenclatura** también pueden esconder redundancias. Se detectan con técnicas de **correlación**, que determinan si el valor de un atributo implica el valor de otro.

**3. Filas duplicadas:** el uso de **tablas desnormalizadas** genera redundancia a nivel de filas. Pueden aparecer **inconsistencias** entre esas filas: se refieren a la misma entidad pero tienen valores distintos (por problemas de actualización). Hay que detectarlas y dejar **una sola fila por entidad**.

**4. Detección y resolución de conflictos de valores:** para un mismo atributo, dos fuentes pueden diferir en la **representación, la escala o la codificación** (altura en pies vs en metros; distancias en cm vs en kilómetros).

### Reducción

| Tipo | Qué reduce | Técnicas |
|---|---|---|
| **Reducción de la dimensionalidad** | La cantidad de **atributos o variables** (columnas) | **Wavelet Transform** (transformada ondícula) y **PCA** (*Principal Components Analysis*, análisis de componentes principales), que **proyectan** el conjunto de datos a un espacio de menor dimensión; y **attribute subset selection** (selección de subconjunto de atributos, mediante clasificación bayesiana o TDIDT), que **elimina** las dimensiones redundantes o irrelevantes para cierto objetivo |
| **Reducción de la numerosidad** | La cantidad de **filas** | **Paramétricos:** regresión — se estiman los datos con una función y solo se almacenan **sus parámetros**, con lo cual el volumen es menor. **No paramétricos:** muestreo (seleccionar aleatoriamente un subconjunto, con estrategias complejas para asegurar la validez de los modelos) y clusters |

### Transformación y discretización

Los datos se transforman para que los algoritmos trabajen **más eficientemente** o para **entender mejor** los resultados:

- **Construcción de atributos:** crear atributos nuevos a partir de otros, para ayudar al proceso de minería.
- **Agregación:** valores diarios agregados en semanales, mensuales o anuales.
- **Normalización:** escalar los atributos para que queden en un rango reducido, o todos en el mismo rango, **para que no influyan de forma desproporcionada** en los resultados (si un atributo va de 0 a 1 000 000 y otro de 0 a 1, el primero domina cualquier cálculo de distancia).
- **Discretización:** reemplazar valores numéricos por **etiquetas de intervalos**. Pueden resultar **jerarquías de conceptos**, y se pueden generar varios atributos a partir de distintas discretizaciones de una misma variable.
- **Jerarquías conceptuales:** para datos **nominales**, agruparlos en categorías más amplias que los contengan (calles → ciudades → provincias).

> [!note]- *(complemento — la diapo lo deja como "Investigar")* Técnicas de normalización y discretización
> **Normalización:**
> - **Min-max:** lleva el atributo a un rango fijo, típicamente $[0, 1]$. Conserva las relaciones originales, pero es **sensible a outliers** (un extremo comprime a todo el resto).
>   $$x' = \frac{x - \min}{\max - \min}$$
> - **Z-score** (puntaje estándar): deja el atributo con media 0 y desviación estándar 1. Sirve cuando no se conocen el mínimo y el máximo, o hay outliers.
>   $$x' = \frac{x - \bar{x}}{\sigma}$$
> - **Escalado decimal:** mueve la coma decimal tantos lugares ($j$) como haga falta para que todos los valores queden en $[-1, 1]$.
>   $$x' = \frac{x}{10^{j}}$$
>
> **Discretización:**
> - **Igual ancho:** se divide el rango en $k$ intervalos del mismo tamaño. Simple, pero si la distribución es despareja algunos bins quedan vacíos y otros con casi todo.
> - **Igual frecuencia:** cada intervalo contiene **la misma cantidad de datos**.
> - **Por clustering:** se agrupan los valores y cada cluster es una categoría.
> - **Basada en entropía:** se eligen los puntos de corte que dejen las particiones **más puras respecto de la clase** (misma idea que los [[#Árboles de decisión|árboles de decisión]]). Es **supervisada**, a diferencia de las anteriores.

---

## 4. Modelado — Regresión Lineal
📎 [[Clase 5 - Modelado 1 - regresion lineal.pdf]]

### El caso que motiva la unidad

Un cliente quiere **mejorar las ventas** de un producto. Se tiene una base de datos de las ventas en **200 mercados**, junto con el dinero invertido en tres tipos de publicidad: **TV, radio y periódicos**. No se pueden aumentar las ventas directamente: hay que **incentivar la demanda indirectamente** mediante publicidad.

> **¿En qué tipo de publicidad conviene invertir?**

### El planteo general

Lo que se busca es **estimar** el valor de una respuesta $Y$ a partir de distintos estimadores $X_1, X_2, \dots, X_p$, asumiendo que existe una relación entre las variables independientes y la dependiente:

$$Y = f(\vec{x}) + \varepsilon$$

| Símbolo | Qué es |
|---|---|
| $Y$ | La **respuesta** o variable **dependiente**: lo que se quiere estimar (las ventas) |
| $X_1 \dots X_p$ | Los **predictores**, **estimadores** o variables **independientes**: lo que se conoce (inversión en TV, radio, diario) |
| $p$ | La cantidad de predictores |
| $f$ | La **relación real** (desconocida) entre los predictores y la respuesta |
| $\varepsilon$ | El **error** o término irreducible: todo lo que afecta a $Y$ y no está en $\vec{x}$ |
| $\hat{f}$, $\hat{Y}$ | El "sombrerito" indica **estimado**: $\hat{f}$ es la función que construye el modelo y $\hat{Y}$ la predicción que produce |

Los **métodos de aprendizaje** son los distintos acercamientos para estimar esa función, o sea la relación que subyace a los datos.

### ¿Para qué se estima f?

**1. Predicción.** A veces los valores de los predictores son **fáciles de obtener**, pero el de $Y$ no.

> [!example] Ejemplo de la diapo
> $X_1 \dots X_p$ son características de la sangre de un paciente, fáciles de conseguir con un análisis de laboratorio, e $Y$ es el **riesgo de que el paciente sufra una reacción adversa** a un medicamento. Interesa conocer el riesgo **antes** de administrar la droga.

En predicción se busca una función $\hat{Y} = \hat{f}(\vec{x})$ que estime el valor real de $Y$. **No interesa la forma de la función** en sí, sino la respuesta y su precisión: la función es una **caja negra** y puede ser tan compleja como haga falta para asegurar la calidad de la respuesta.

La precisión de $\hat{f}$ depende de **dos tipos de error**:

| Error | Causa | ¿Se puede reducir? |
|---|---|---|
| **Reducible** | Los **métodos** elegidos para el modelado no son perfectos | **Sí** — es lo que atacan las técnicas de modelado: achicar la diferencia entre el valor real y el estimado |
| **Irreducible** ($\varepsilon$) | $Y$ **no es solo función de $X$**: hay innumerables factores que no se están considerando en el modelado | **No** — supone una **cota superior** a la capacidad del modelo |

**2. Inferencia.** Otras veces no interesa el valor de $Y$, sino **la relación misma** entre los predictores y la respuesta:
- ¿Qué variables **influyen más** sobre la respuesta?
- ¿**De qué forma** influye cada variable?
- ¿Se puede resumir la relación con una **función simple**?

Acá **sí interesa la forma de la función**, y conviene que sea **lo más simple posible**. Es el caso del ejemplo de la publicidad: qué medio impacta más en las ventas y de qué manera.

### Aprendizaje supervisado y métodos para estimar f

Para generar la función hay que **entrenarla**: hace falta un conjunto de observaciones donde se conozcan **tanto los valores históricos de las variables independientes como su respuesta asociada**. Ese tipo de aprendizaje se llama **supervisado**, y el conjunto de observaciones, **conjunto de entrenamiento**.

| | **Métodos paramétricos** | **Métodos no paramétricos** |
|---|---|---|
| Cómo funcionan | **2 pasos:** (1) se **asume la forma** de la función (lineal, cuadrática…) y se plantea un modelo genérico $f(\vec{x}) = \beta_0 + \beta_1 x_1 + \dots + \beta_p x_p$; (2) se **entrena o ajusta** estimando los coeficientes | **No hacen suposiciones** sobre la forma de la función; se busca construir una función que se aproxime a los puntos del entrenamiento **de forma suave** |
| Ventaja | El problema se reduce a estimar **$p+1$ coeficientes** en lugar de una función entera. Simples e interpretables | El **ajuste es mejor** que con los paramétricos |
| Desventaja | Al prefijar la forma, se **fuerza** al modelo a seguirla, lo que **reduce la precisión** si la forma real es otra. Y cuanto más flexibles las formas propuestas, más difícil estimar los coeficientes | Necesitan **muchas más observaciones**, las funciones resultantes son **muy complejas** y pueden ser **demasiado sensibles al ruido** |

> [!important] Trade-off precisión vs interpretabilidad (*comprensión*)
> Al elegir un método hay que decidir entre las dos cosas: los métodos **más simples de interpretar** suelen ser **más imprecisos e inflexibles**; los métodos **flexibles** incorporan relaciones complejas que resultan **difíciles de interpretar y analizar**. La elección también está condicionada por el objetivo: **predicción** (prioriza precisión) o **inferencia** (prioriza interpretabilidad).

### Regresión lineal

Es uno de los métodos de modelado **más simples** del aprendizaje supervisado. Busca relacionar **de forma lineal** un conjunto de predictores con una salida **NUMÉRICA**. Viene de la estadística, es muy usada, y como es simple y fácil de interpretar **se usa mucho para inferencia**.

**Regresión lineal simple:** predecir una respuesta cuantitativa $Y$ a partir de **un único predictor** $x$.

$$Y \approx \beta_1 x + \beta_0 \qquad \hat{Y} = \hat\beta_1 x + \hat\beta_0$$

Donde $\hat\beta_0$ es la **ordenada al origen** (el valor estimado de $Y$ cuando $x = 0$) y $\hat\beta_1$ es la **pendiente** (cuánto cambia $Y$ por cada unidad que aumenta $x$).

**Estimación de los coeficientes.** En la práctica los coeficientes son desconocidos y hay que estimarlos a partir de los datos. El conjunto de entrenamiento son $n$ pares de observaciones $\{(x_i, y_i)\},\ i = 1 \dots n$, y se busca la recta que **más se aproxime a todos los puntos**.

**Método de los mínimos cuadrados.** Se define el **residuo** como la diferencia entre el valor observado y el valor estimado para un predictor dado:

$$e_i = y_i - \hat{y}_i$$

Y se minimiza el **RSS** (*Residual Sum of Squares*, suma de los cuadrados de los residuos):

$$RSS = e_1^2 + e_2^2 + \dots + e_n^2 = \sum_{i=1}^{n} (y_i - \hat\beta_0 - \hat\beta_1 x_i)^2$$

> [!note] Por qué al cuadrado
> Porque si se sumaran los residuos tal cual, los positivos y los negativos **se cancelarían** y una recta pésima podría dar suma cero. Al elevar al cuadrado todos los errores suman positivo, y además **se penalizan más los errores grandes**.

Resolviendo por álgebra, los coeficientes que minimizan esa función son:

$$\hat\beta_1 = \frac{\sum_{i=1}^{n} (x_i - \bar{x})(y_i - \bar{y})}{\sum_{i=1}^{n} (x_i - \bar{x})^2} \qquad \hat\beta_0 = \bar{y} - \hat\beta_1 \bar{x}$$

**Regresión lineal múltiple.** El mundo no es tan sencillo y generalmente hay **más de un predictor** por respuesta:

$$Y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \dots + \beta_p x_p + \varepsilon$$

Para estimar los $p$ parámetros se minimiza el RSS análogo:

$$RSS = \sum_{i=1}^{n} (y_i - \hat\beta_0 - \hat\beta_1 x_{i1} - \hat\beta_2 x_{i2} - \dots - \hat\beta_p x_{ip})^2$$

---

## 5. Modelado — Clasificación
📎 [[Clase 6 - Modelado 1 - clasificacion.pdf]]

### De la regresión a la clasificación

Repaso: la **regresión lineal** es un método **paramétrico** que encuentra la dependencia entre un conjunto de predictores y una variable objetivo **numérica (cuantitativa)**.

> *¿Y si la respuesta es cualitativa?*

Se podría **codificar cada valor discreto con un número entero** y usar regresión lineal. **¿Problemas?**

> [!warning] El orden importa
> Dependiendo de qué números se usen para codificar y, sobre todo, **del orden de los mismos**, la función resultante **será distinta**, por lo que no se extraerá correctamente el modelo que subyace a los datos.
>
> *Para verlo:* si se codifica {Soltero = 1, Casado = 2, Divorciado = 3}, la regresión asume que Casado está "en el medio" entre Soltero y Divorciado, y que la distancia Soltero→Casado es igual a Casado→Divorciado. Cambiando el orden de la codificación cambia la recta y cambian las conclusiones, cuando en realidad **las categorías no tienen ningún orden**.

### Qué es clasificar

> **Clasificación:** actividad del **aprendizaje supervisado** en la cual, a partir de un conjunto de tuplas $x_i = (x_{i1}, x_{i2}, \dots, x_{i(p-1)}, clase)$, se busca **predecir el valor del atributo clase** (cualitativo) a partir de los demás atributos de la tupla.

**Clasificadores** (las técnicas para hacerlo):
- **Regresión logística**
- **SVM** (*Support Vector Machines*, máquinas de vectores de soporte)
- **Algoritmos TDIDT** (*Top-Down Induction of Decision Trees*, inducción de árboles de decisión de arriba hacia abajo): **ID3, CART, C4.5, C5.0**

### Árboles de decisión

Son estructuras de árbol en las que:

| Elemento | Qué representa |
|---|---|
| **Nodo interno** | Una **condición** sobre el valor de una determinada variable o predictor |
| **Rama** | La **decisión** de evaluar la condición del nodo padre, es decir, cada resultado posible de esa condición |
| **Hoja** | El valor del **atributo clase** |

**Reglas de decisión.** Recorriendo el árbol desde la raíz hasta cada hoja se extraen reglas:

```
IF Age = Youth AND Student = No   → No
IF Age = Youth AND Student = Yes  → Yes
IF Age = Middle_Aged              → Yes
...
```

(El ejemplo de la diapo es *¿compra o no compra una computadora?*)

Estas reglas sirven para:
- **Describir el comportamiento** de los datos → **inferencia**.
- **Predecir el atributo clase** de tuplas nuevas no clasificadas → **predicción**.

En uno u otro caso hay que buscar un **equilibrio entre precisión e interpretabilidad**, según los objetivos planteados.

**Algoritmo básico** (recursivo):

1. Si el conjunto de datos está **vacío**, o si **todos los elementos pertenecen a la misma clase** → **fin** (se crea una hoja).
2. **Seleccionar una variable.**
3. **Particionar** el conjunto de datos según los valores de esa variable.
4. Por cada partición, **ejecutar el algoritmo** de nuevo.

### ¿Qué atributo seleccionar? Métricas

Las **métricas** son los criterios que determinan cuál es el **mejor atributo para particionar**. La idea es que el árbol resulte **lo más pequeño posible**, con pocos nodos y ramas, lo que se logra eligiendo en cada paso el atributo que deja las particiones **más "puras"** (que cada partición tenga, en lo posible, una sola clase).

| Algoritmo | Métrica | Qué busca |
|---|---|---|
| **ID3** | **Ganancia de información** (entropía de Shannon) | **Minimizar la información necesaria** para clasificar las tuplas, de forma que las particiones sean lo más puras posibles respecto de las clases |
| **CART** | **Índice Gini** | Representar el **nivel de impureza** de cada partición |

> [!note]- *(complemento — fórmulas)* Entropía, ganancia y Gini
> - **Entropía** de un conjunto $D$: mide el "desorden" o la cantidad de información necesaria para saber de qué clase es una tupla. Vale **0** si todas las tuplas son de la misma clase (partición pura) y es **máxima** cuando las clases están repartidas en partes iguales.
>   $$Entrop\acute{i}a(D) = -\sum_{i=1}^{m} p_i \log_2 p_i$$
>   donde $p_i$ es la proporción de tuplas de la clase $i$ en $D$ y $m$ la cantidad de clases.
> - **Ganancia de información** de un atributo $A$: cuánto baja la entropía al particionar por $A$. Se elige el atributo con **mayor ganancia**.
>   $$Gain(A) = Entrop\acute{i}a(D) - \sum_{j} \frac{|D_j|}{|D|}\, Entrop\acute{i}a(D_j)$$
>   donde $D_j$ es cada partición generada por los valores de $A$, y $\frac{|D_j|}{|D|}$ la pondera por su tamaño.
> - **Índice Gini:** mide la impureza; vale **0** en una partición pura. Se elige el atributo que deja el Gini **más bajo**.
>   $$Gini(D) = 1 - \sum_{i=1}^{m} p_i^2$$

### Bondad del modelo: la matriz de confusión

Para evaluar si el método realmente **aprendió el patrón implícito**, se usa una herramienta llamada **matriz de confusión**, que se construye **contando los aciertos y los errores** del proceso de clasificación con el modelo generado.

> [!important] Las cuatro celdas, una por una
> La matriz compara, para cada tupla, **lo que el modelo predijo** contra **lo que realmente era** (el valor esperado). De ahí salen cuatro casos. Por convención, la clase que interesa detectar se llama **positiva (1)** y la otra **negativa (0)**:
>
> | Sigla | Nombre | Definición de la diapo | Cómo leerlo |
> |---|---|---|---|
> | **VP** | **Verdaderos Positivos** (*True Positives, TP*) | Se predice **1** y se espera **1** | **Acierto:** el modelo dijo "sí" y era "sí" |
> | **VN** | **Verdaderos Negativos** (*True Negatives, TN*) | Se predice **0** y se espera **0** | **Acierto:** el modelo dijo "no" y era "no" |
> | **FP** | **Falsos Positivos** (*False Positives, FP*) | Se predice **1** y se espera **0** | **Error:** falsa alarma — dijo "sí" y era "no" |
> | **FN** | **Falsos Negativos** (*False Negatives, FN*) | Se predice **0** y se espera **1** | **Error:** se le escapó — dijo "no" y era "sí" |
>
> Truco para no confundirse: la **primera palabra** dice si el modelo **acertó** (Verdadero) o **se equivocó** (Falso); la **segunda** dice **qué predijo** el modelo (Positivo = 1, Negativo = 0).

Armada como tabla, con las predicciones en las filas y la realidad en las columnas:

|  | Real 1 (positivo) | Real 0 (negativo) |
|---|---|---|
| **Predicho 1** | **VP** — acierto | **FP** — falsa alarma |
| **Predicho 0** | **FN** — se escapó | **VN** — acierto |

La **diagonal principal** (VP y VN) son los aciertos; lo de afuera, los errores. Y la suma de las cuatro celdas es **el total de tuplas evaluadas**.

### Métricas que salen de la matriz

| Métrica | Qué determina | Fórmula | Se lee como |
|---|---|---|---|
| **Accuracy** (precisión) | Qué tan **acertado** es el modelo **en general** | $\dfrac{VP + VN}{VP + VN + FP + FN}$ | Aciertos sobre el total de casos |
| **Sensitivity** (sensitividad o **recall**) | Si los **positivos** son correctamente detectados | $\dfrac{VP}{VP + FN}$ | De todos los que **realmente eran 1**, ¿a cuántos pescó? |
| **Specificity** (especificidad) | Si los **negativos** son correctamente detectados | $\dfrac{VN}{VN + FP}$ | De todos los que **realmente eran 0**, ¿a cuántos pescó? |

> [!tip] Cómo recordar los denominadores
> El denominador de accuracy es **todo el dataset**. El de sensitivity es **toda la columna "Real 1"** ($VP + FN$, es decir los positivos reales). El de specificity es **toda la columna "Real 0"** ($VN + FP$, los negativos reales). Por eso las dos últimas miden el desempeño **por clase** y la accuracy, el desempeño global.

### Ejemplo resuelto de la diapo — la droga

> [!example] Modelo que predice si un paciente muere o no al tomar una droga
> **Datos:** 5000 ejemplos de prueba, de los cuales **500 pacientes mueren** y **4500 no**.
> Resultados del modelo: **VP = 150** y **VN = 4000**.
>
> **Paso 1 — deducir las otras dos celdas.** La diapo da solo los aciertos, pero los errores salen de las totales por clase:
> - Positivos reales (mueren) = 500 = VP + FN → **FN = 500 − 150 = 350** (350 pacientes que morían y el modelo dijo que no)
> - Negativos reales (no mueren) = 4500 = VN + FP → **FP = 4500 − 4000 = 500** (500 pacientes que no morían y el modelo dijo que sí)
>
> |  | Real: muere (1) | Real: no muere (0) | Total predicho |
> |---|---|---|---|
> | **Predicho: muere (1)** | VP = **150** | FP = **500** | 650 |
> | **Predicho: no muere (0)** | FN = **350** | VN = **4000** | 4350 |
> | **Total real** | **500** | **4500** | **5000** |
>
> **Paso 2 — las métricas:**
> - $Accuracy = \dfrac{150 + 4000}{5000} = \dfrac{4150}{5000} = \mathbf{0{,}83}$
> - $Specificity = \dfrac{4000}{4500} = \mathbf{0{,}889}$
> - $Sensitivity = \dfrac{150}{500} = \mathbf{0{,}30}$
>
> **Paso 3 — interpretación (lo que pide la diapo):** el modelo detecta **muy bien** los casos en que los pacientes **no mueren**, lo cual **no es crítico para el negocio**, pero **no detecta bien** los casos en que sí mueren: **el 70 % de los pacientes que morirían al tomar la droga no son detectados** (los 350 FN sobre 500).

> [!important] Moraleja
> Una **accuracy alta no alcanza**: el 0,83 se explica porque la clase "no muere" es el 90 % del dataset, y acertarle a esa clase ya "infla" la métrica. Por eso es necesario evaluar **no solo la precisión del modelo, sino su comportamiento frente a cada clase**, sobre todo la que es **crítica para el negocio**.
>
> Este es también el motivo por el que en la unidad de validación se usa **muestreo estratificado** (ver [[#Cuestiones metodológicas: Train / Test]]): si el conjunto de prueba no respeta la proporción de clases, la clase minoritaria puede quedar casi sin representación y las métricas por clase pierden sentido.

---

## 6. Modelado — Validación
📎 [[P8_Modelado-validacion.pdf]]

### Repaso: qué es un modelo

Los modelos buscan **representar el conjunto de datos** mediante distintas herramientas, como funciones o árboles. Los algoritmos "aprenden" el **patrón o la tendencia implícita** entre los datos, con algoritmos que vienen de la estadística, del aprendizaje automático y de la inteligencia artificial.

Una de las actividades de la minería de datos es **relacionar** los valores de una serie de atributos de entrada con los valores de un atributo de salida o **target**. Ese aprendizaje se llama **supervisado**, porque se tiene un conjunto de datos donde constan **tanto las entradas como el valor asociado del atributo objetivo**. Se puede usar para **predecir** el valor de la salida o para determinar la relación implícita entre los atributos (**inferencia**).

| Tipo de atributo objetivo | La actividad se llama |
|---|---|
| **Cuantitativo** (numérico) | **Regresión** |
| **Cualitativo** (categórico) | **Clasificación** |

### El problema: medir sobre los datos de entrenamiento engaña

Una vez generado el modelo hay que determinar si **realmente encontró el patrón oculto**. Lo primero que se hizo hasta ahora fue someter al modelo **los mismos datos con los que se lo entrenó** y contar los aciertos: esa es una primera medida de precisión o *accuracy*.

> *Pero… si el modelo ajusta con un 100 % de precisión, ¿significa que es un buen modelo? ¿Qué nos asegura que al ingresar datos nuevos vamos a tener los resultados correctos?*

> [!warning] Sobreajuste (*overfitting*)
> En algunas oportunidades el modelo generado **sobre-ajusta**: aprende a **"copiar" los datos de entrenamiento**, pero **no el patrón detrás de los mismos**. Por eso acierta el 100 % sobre lo que ya vio y falla con datos nuevos: **perdió poder de generalización**.

### Bias y varianza

| | Qué indica | Problema asociado | Cómo reducirlo |
|---|---|---|---|
| **Bias (sesgo)** | Qué tan **lejos está el modelo de capturar la naturaleza del fenómeno** | **Bias alto = underfitting** (sub-ajuste): el modelo no es suficientemente potente para comprender el patrón de fondo. Ejemplo típico: usar una **función lineal para aproximar una cuadrática** | Usar modelos **más complejos o no paramétricos**; asegurarse de que los **datos sean representativos**; **configurar correctamente los parámetros** |
| **Varianza** | Qué tanto **cambia el modelo si se lo entrena con distintos datos** | **Varianza alta = overfitting**: si el modelo cambia mucho, está copiando los datos y no capturando la naturaleza del fenómeno. Suele pasar con **modelos muy complejos o no paramétricos** | Usar modelos **más simples o paramétricos**; usar **más datos** (*data augmentation*); **métodos ensamblados** (varios modelos combinados) |

> [!important] Bias-variance tradeoff
> Hay que **encontrar el balance** entre bias y varianza seleccionando métodos apropiados: bajar uno típicamente sube el otro. Y hay que recordar que la **interpretabilidad** del modelo es otro factor que puede ayudar a decidirse por uno u otro.

### Cuestiones metodológicas: Train / Test

En un problema de aprendizaje supervisado generalmente se tiene:
- un conjunto de datos **con** los valores del atributo objetivo (datos de **entrenamiento**);
- un conjunto de datos **sin** esos valores (los que se quieren predecir).

Pero el proceso de evaluación necesita un **tercer conjunto**: el de **testing**, que **debe estar etiquetado**, porque solo así se puede determinar si los valores predichos se corresponden con los esperados.

En la práctica no se tiene un conjunto aparte para eso, así que el procedimiento común es **particionar el conjunto etiquetado**:

$$Train \cup Test = D \qquad Train \cap Test = \emptyset$$

Es decir: entre los dos cubren todo el dataset $D$ y **no comparten ninguna tupla** (si compartieran, se estaría evaluando con datos que el modelo ya vio, que es el problema original).

**Tamaño:** no existe ninguna regla sobre la proporción. La más común es la **regla de Pareto, 80 % – 20 %**.

> [!important] Misma proporción de clases
> Es importante que en **ambos conjuntos haya la misma proporción de valores para el atributo objetivo**. Si no, se puede entrenar o evaluar con una clase casi ausente, y las métricas por clase (sensitivity, specificity) dejan de ser confiables.

**Métodos de muestreo:**

| Método | Cómo funciona | Observación |
|---|---|---|
| **Aleatorio simple** | Se generan números aleatorios para seleccionar $n$ elementos de la base | **No asegura** la misma representatividad de clases |
| **Estratificado** | Se **divide el conjunto según los valores del atributo objetivo** y, por cada subconjunto, se selecciona aleatoriamente un porcentaje para testing | Las proporciones por clase pueden ser o no las mismas. Es el que **resuelve** el problema del anterior |
| **Por cuotas** | Similar al estratificado pero **no aleatorio**: se pueden elegir los individuos por conveniencia | Introduce sesgo del analista |
| **Sistemático** | Se elige un elemento al azar y a partir de él los siguientes según una función dada, por ejemplo $pos_i = pos_{i-1} + 3$ | Simple, pero problemático si los datos tienen algún orden periódico |

### Validación cruzada (*Cross Validation* o X-Validation)

> *¿Cómo aseguramos que las muestras elegidas son las mejores opciones para generar y evaluar los modelos? ¿Cómo sabemos que los resultados son independientes de la partición generada?*

La validación cruzada usa **sucesivos muestreos** del conjunto de datos, obteniendo en cada iteración conjuntos **distintos** de entrenamiento y de prueba. Al finalizar, **se promedian los resultados** de todas las iteraciones. Así el resultado deja de depender de una partición en particular.

Hay dos variantes principales:

**1. LOOCV** (*Leave One Out Cross Validation*, validación cruzada dejando uno fuera).
- Sea $n$ el tamaño de la base: se toman **$n-1$ elementos para entrenamiento** y se deja **1 tupla para validación**.
- Se realizan **$n$ entrenamientos**, variando en cada oportunidad el elemento apartado.
- El error total del modelo es el **promedio de los errores** de cada entrenamiento (**error cuadrático medio**, MSE).

| Ventajas | Desventajas |
|---|---|
| Se usan **todos los elementos** para el entrenamiento, pero no se incorporan todos los errores individuales | **Muy costoso** de implementar: son **$n$ iteraciones** |
| No se considera solo el error de un único conjunto de pruebas | |
| El error es **único** para el conjunto de datos: no difiere en función de la partición realizada | |

**2. K-Folds Cross Validation** (validación cruzada por grupos).
- Es una alternativa a LOOCV: se divide el conjunto de datos **de manera aleatoria en $k$ grupos** (*folds*) de aproximadamente el mismo tamaño.
- Cada grupo es el conjunto de test **una vez**, mientras los otros $k-1$ entrenan.
- Es **más eficiente que LOOCV**, porque se hacen **menos ajustes del modelo**, a expensas de **incorporar mayores errores**.
- Hay que determinar una buena configuración del **tamaño de $k$ en función del tiempo disponible** para la creación del modelo. *(complemento: los valores típicos son 5 o 10.)*

> [!tip] LOOCV vs K-Folds en una línea
> LOOCV es **K-Folds con $k = n$**: máxima cantidad de datos de entrenamiento y resultado único, pero carísimo. K-Folds cambia un poco de precisión por **mucho menos costo computacional**.

---

## 7. Modelado — Agrupamiento
📎 [[P11_Modelado-agrupamiento-DBSCAN.pdf]]

### Qué es el agrupamiento

> **Agrupamiento (*clustering*):** actividad de la minería de datos que busca **particionar o clasificar el conjunto de datos en grupos o clases**, de forma tal que cada grupo esté conformado por elementos **similares entre sí** y **considerablemente distintos** de los elementos de otros grupos.

Es **aprendizaje no supervisado**: a diferencia de la clasificación, **no hay un atributo clase** conocido de antemano; los grupos los descubre el algoritmo.

**Tipos de algoritmos:**
- **Particionamiento** (K-Means)
- **Jerárquicos**
- **Basados en grillas**
- **Basados en densidad** (DBSCAN)

### K-Means (método de particionamiento)

- Busca **particionar** el conjunto de datos.
- Está basado en **centroides** (el centro de cada grupo).
- Es **iterativo**: en cada iteración se **recalculan los centroides**.
- La asignación de puntos se realiza usando la **distancia euclidiana**.

*(complemento — los pasos, que en la diapo están como animación)*

1. Elegir $k$ (la cantidad de clusters) y tomar $k$ centroides iniciales.
2. **Asignar** cada punto al centroide más cercano.
3. **Recalcular** cada centroide como el promedio de los puntos que le fueron asignados.
4. Repetir 2 y 3 **hasta que los centroides no cambien** (o el cambio sea mínimo).

**Inconvenientes:**
- **Costoso** si la cantidad de datos es grande.
- Requiere **muchas evaluaciones de la función de distancia**.
- Solo encuentra **clusters esféricos**: como asigna por distancia a un punto central, los grupos que forma son siempre "bolas" alrededor del centroide.
- *(complemento)* Hay que **fijar $k$ de antemano**, y el resultado depende de los centroides iniciales.

### Métodos basados en densidad

El problema que motiva el cambio de enfoque: hay conjuntos de datos (las clásicas "medialunas" o anillos de las diapos) donde **K-Means falla**. ¿Qué caracteriza a esos clusters?

- Evidentemente los clusters **no están "juntos"** en el espacio en forma de bola.
- Los clusters están formados por **regiones densas de puntos**.
- La **densidad** está dada por la **cantidad de puntos en una región del espacio**.
- Tiene sentido, entonces, detectar estos grupos basándose en ese criterio.

### DBSCAN (1996)

**DBSCAN** = *Density Based Spatial Clustering of Applications with Noise* (agrupamiento espacial basado en densidad para aplicaciones con ruido). Usa el concepto de densidad mediante **dos parámetros de entrada**, y es uno de los algoritmos más utilizados de la historia de la minería de datos, junto con K-Means.

**Parámetros de entrada:**

| Parámetro | Qué es |
|---|---|
| **ε** (epsilon o *Eps*) | El **radio** que define el vecindario de un punto |
| **MinPts** | La **cantidad mínima de puntos** que debe haber en ese vecindario para considerarlo denso |

**Idea básica:**
- Si un objeto $q$ está **densamente conectado** a otro objeto $p$, entonces $q$ y $p$ **pertenecen al mismo cluster**.
- Si $q$ **no** está densamente conectado a ningún objeto, entonces $q$ se clasifica como **ruido**.

**Conceptos, en orden (cada uno se apoya en el anterior):**

| Concepto | Definición de la diapo | En criollo |
|---|---|---|
| **ε-vecindario** (*ε-neighborhood*) de $p$ | El conjunto de todos los objetos que se encuentran **a distancia ≤ ε** de $p$ | El círculo de radio ε centrado en $p$ |
| **Objeto central** (*core object*, co) | $q$ es un objeto central **si y solo si** hay **por lo menos MinPts objetos** en el ε-vecindario de $q$ | $q$ está en una zona densa: tiene suficientes vecinos cerca |
| **Directamente alcanzable por densidad** (*directly density reachable*, **ddr**) | $p$ es ddr desde $q$ **si y solo si** $q$ es un objeto central **y** $p$ pertenece al ε-vecindario de $q$ | $p$ es vecino de un core. Ojo: **no es simétrico** — $p$ puede no ser core |
| **Alcanzable por densidad** (*density reachable*, **dr**) | $p$ es dr desde $q$ **si y solo si** existe una **cadena de objetos** $q_1, q_2, \dots, q_n$ tal que $q_1$ es ddr desde $q$, $q_2$ es ddr desde $q_1$, …, y $p$ es ddr desde $q_n$ | Se llega de $q$ a $p$ **saltando de core en core**, encadenando vecindarios |
| **Densamente conectado** (*density connected*, **dc**) | $p$ está dc a un objeto $r$ **si y solo si** existe un objeto $q$ que es alcanzable desde $p$ **y** alcanzable desde $r$ | $p$ y $r$ cuelgan del **mismo** núcleo denso, aunque no se alcancen entre sí directamente. Esta sí es **simétrica**, y es la relación que define el cluster |

**Algoritmo:**

```
Entrada: MinPts, ε
Salida:  el conjunto de datos clasificado en grupos

Para cada objeto x de D:
   Si x no está clasificado:
      Si x es un objeto central:
         Crear un cluster y recolectar todos los objetos
         densamente alcanzables desde x
      Si x NO es un objeto central:
         Clasificar x como ruido
```

> [!note] Sobre el "ruido"
> Un punto marcado como ruido **puede dejar de serlo después**: si más adelante aparece un core que lo tiene en su ε-vecindario, pasa a ser un punto **borde** de ese cluster. Lo que nunca cambia es que un punto borde no expande el cluster (solo los core lo hacen).

El ejemplo de la diapo se resuelve con **MinPts = 3** y **Eps = 2 cm**.

**Ventajas respecto de K-Means** *(complemento, se deduce de lo anterior)*: detecta clusters de **forma arbitraria** (no solo esféricos), **no hay que fijar la cantidad de clusters** de antemano, e identifica explícitamente el **ruido**.

> [!warning] Problema de DBSCAN: clusters de distinta densidad
> Si los clusters poseen **densidades distintas**, los que **no cumplan** con las condiciones de MinPts y Eps **serán detectados como ruido** — porque ε y MinPts son **globales**, los mismos para todo el dataset, y una densidad que sirve para un cluster deja afuera a otro más disperso.
> Existen **variantes** que permiten explorar dinámicamente distintos rangos de densidades *(complemento: OPTICS es la más conocida)*.

---

## 8. Modelado — Asociaciones
📎 [[P9_Modelado-asociaciones.pdf]]

### El escenario

Los contrata el **gerente de ventas de un supermercado** que quiere aumentar las ventas. Las bases de datos del supermercado consisten en un conjunto de **transacciones o compras** de cada cliente en cada oportunidad; cada transacción es una **lista no ordenada de productos, de largo variable**.

| Transacción | Productos |
|---|---|
| T1 | {Leche, Pan, Cereales} |
| T2 | {Leche, Azúcar, Pan, Huevos} |
| T3 | {Manteca, Pan, Leche} |
| T4 | {Huevos, Azúcar} |

> **Objetivo de minería:** encontrar **relaciones entre los productos comprados** para que el gerente pueda generar **promociones** a partir de ellas. (Es lo que se conoce como *market basket analysis*, análisis de la canasta de compras.)

### Conceptos

**Base de datos transaccional.** Sea un conjunto de ítems $I = \{I_1, I_2, \dots, I_m\}$; una base transaccional $D$ está formada por un conjunto de tuplas, siendo **cada tupla un subconjunto de ítems**:

$$D = \{T_j \mid T_j \subseteq I,\ T_j \neq \emptyset\},\quad j = 1 \dots n$$

**Conjunto de ítems frecuentes** (*frequent itemset*): un subconjunto de ítems que **se repite de forma frecuente** en las transacciones de la base. Interesan los **frecuentes máximos**, es decir los del **máximo tamaño posible** (si {Leche, Pan, Huevos} es frecuente, informar también {Leche, Pan} agrega poco).

**Regla de asociación.** Se dice que una transacción $T$ **contiene** a un conjunto de ítems $A$ si $A \subseteq T$. Una regla de asociación es una implicación de la forma

$$A \Rightarrow B \qquad \text{con } A \subseteq I,\ B \subseteq I,\ A \neq \emptyset,\ B \neq \emptyset,\ A \cap B = \emptyset$$

La última condición ($A \cap B = \emptyset$, no comparten ítems) evita reglas triviales del tipo "quien compra leche y pan, compra pan".

### Soporte y confianza

Cada regla $A \Rightarrow B$ tiene dos valores asociados:

| Medida | Definición | Fórmula | Qué contesta |
|---|---|---|---|
| **Soporte** (*support*) | El **porcentaje de las transacciones de la base** que contienen al patrón $A \cup B$ | $support(A \Rightarrow B) = P(A \cup B)$ | ¿Qué tan **frecuente** es este combo en todo el supermercado? |
| **Confianza** (*confidence*) | El **porcentaje de las transacciones que contienen a $A$** que **también contienen a $B$** | $confidence(A \Rightarrow B) = P(B \mid A) = \dfrac{support(A \cup B)}{support(A)}$ | De los que llevaron $A$, ¿qué proporción llevó también $B$? Es la **fuerza** de la regla |

> [!tip] La diferencia en una línea
> El **soporte** mide sobre **toda la base** (dice si vale la pena mirar la regla); la **confianza** mide **solo sobre las transacciones que tienen $A$** (dice qué tan confiable es la implicación). Una regla puede tener confianza 1 y ser inútil si su soporte es mínimo, porque se cumple en dos tickets de un millón.

> **Reglas fuertes:** las reglas cuyo soporte y confianza **superan un umbral mínimo** (**min_sup** y **min_conf**).

> [!example] Ejemplo de la diapo
> $I$ = {Leche, Pan, Cereales, Huevos, Manteca, Azúcar}, con las 4 transacciones de arriba.
>
> **Regla {Leche} ⇒ {Pan}:**
> - $Supp = P(\{Leche, Pan\}) = 3/4 = \mathbf{0{,}75}$ — las transacciones T1, T2 y T3 contienen ambos.
> - $Conf = \dfrac{P(\{Leche, Pan\})}{P(\{Leche\})} = \dfrac{0{,}75}{0{,}75} = \mathbf{1}$ — Leche aparece en T1, T2 y T3 (soporte 0,75) y en **todas** esas también hay Pan.
>
> **Regla {Leche} ⇒ {Cereales}:**
> - $Supp = P(\{Leche, Cereales\}) = 1/4 = \mathbf{0{,}25}$ — solo T1.
> - $Conf = \dfrac{0{,}25}{0{,}75} = \mathbf{0{,}333}$ — de las 3 transacciones con leche, solo 1 tiene cereales.

### Algoritmo genérico

El algoritmo básico para encontrar reglas de asociación consta de **2 etapas**:

1. Encontrar **todos los patrones frecuentes** (soporte > min_sup).
2. **Generar las reglas fuertes** a partir de esos patrones frecuentes (confianza > min_conf).

Los distintos algoritmos usan este mismo método, pero con **distintas estrategias para mejorar la eficiencia**.

### Algoritmo A-priori (Agrawal y Srikant, 1994)

- Es un procedimiento **iterativo por niveles**.
- En cada nivel $k$ se generan los conjuntos de ítems frecuentes de **tamaño $k$** usando los frecuentes de **tamaño $k-1$**.
- El tamaño de $k$ **sigue aumentando mientras $k-1$ tenga itemsets frecuentes**.
- Posteriormente se **generan las reglas** a partir de cada itemset.

> [!important] Propiedad A-priori o antimonótona
> **Todos los subconjuntos de un conjunto de ítems frecuente son también frecuentes.**
>
> Lo que se usa en la práctica es el **contrarrecíproco**: si un subconjunto **no** es frecuente, **ningún conjunto que lo contenga puede serlo**, así que el candidato se **poda** sin ni siquiera contar sus apariciones. Eso es lo que hace al algoritmo eficiente: evita recorrer la base para candidatos condenados de antemano.

**Generación de reglas.** Una vez obtenidos los ítems frecuentes $F$, por cada **subconjunto $A$ de $F$** se prueba la confianza de la regla $A \Rightarrow F - A$. Si supera el umbral mínimo, es una **regla fuerte**, y se sabe cuál conjunto de ítems **condiciona la compra** de otro subconjunto.

> [!example]- Ejercicio resuelto (dataset de la diapo 17, min_sup = 40 % → ≥ 2 de 5 transacciones)
> **Transacciones:** 1 {Pan, Manteca, Leche} · 2 {Huevos, Leche, Yogurt} · 3 {Pan, Queso, Huevos, Leche} · 4 {Huevos, Leche, Yogurt} · 5 {Queso, Leche, Yogurt}
>
> **L1 — itemsets frecuentes de tamaño 1** (contar cada ítem):
> Leche 5 · Huevos 3 · Yogurt 3 · Pan 2 · Queso 2 → todos frecuentes. **Manteca 1 ✗** (se descarta, y con ella todo candidato que la contenga).
>
> **L2 — tamaño 2** (se combinan los de L1 y se cuentan):
> {Leche, Huevos} 3 · {Leche, Yogurt} 3 · {Leche, Pan} 2 · {Leche, Queso} 2 · {Huevos, Yogurt} 2 → frecuentes.
> {Pan, Huevos} 1, {Pan, Yogurt} 0, {Pan, Queso} 1, {Queso, Huevos} 1, {Queso, Yogurt} 1 → ✗.
>
> **L3 — tamaño 3:** el único candidato que sobrevive a la poda es **{Leche, Huevos, Yogurt}**, con soporte 2 (transacciones 2 y 4). Los demás candidatos se podan **porque alguno de sus pares no es frecuente** (por ejemplo {Leche, Pan, Queso} se descarta sin contar, porque {Pan, Queso} no está en L2).
>
> **Reglas desde {Leche, Huevos, Yogurt}** (soporte del itemset = 2/5 = 0,4):
>
> | Regla | Confianza | Cuenta |
> |---|---|---|
> | {Huevos, Yogurt} ⇒ {Leche} | **1** | 2/2 |
> | {Leche, Huevos} ⇒ {Yogurt} | 0,67 | 2/3 |
> | {Leche, Yogurt} ⇒ {Huevos} | 0,67 | 2/3 |
> | {Huevos} ⇒ {Leche, Yogurt} | 0,67 | 2/3 |
> | {Yogurt} ⇒ {Leche, Huevos} | 0,67 | 2/3 |
> | {Leche} ⇒ {Huevos, Yogurt} | 0,4 | 2/5 |
>
> Con min_conf = 0,6, todas serían fuertes **menos la última**.

### Representaciones de los datos

| Representación | Estructura | Ejemplo |
|---|---|---|
| **Booleana** | Una **matriz** con una fila por transacción y una columna por ítem; la celda vale **1** si la transacción contiene ese ítem y **0** si no | T1: 1 1 1 · T2: 1 0 1 · T3: 0 1 1 |
| **Por listas** (formato vertical) | Se **invierte** la representación usual: una fila por **ítem**, con su nombre o ID y la **lista de transacciones que lo contienen** | Item 1 → {T1, T2} · Item 2 → {T1, T3} · Item 3 → {T1, T2, T3} |

*(complemento)* La representación por listas hace muy barato calcular el soporte de una combinación: es el **tamaño de la intersección** de las listas de sus ítems.

---

## 9. Modelado — Detección de Anomalías
📎 [[P12_Modelado-anomalías.pdf]]

### El caso práctico

Son **auditores en un banco**. Para proteger a los clientes de fraudes y robos, el trabajo es determinar si se hicieron **compras extrañas** con su tarjeta de crédito: por ejemplo, si se compra por un **monto mucho mayor al habitual**, o la compra se hizo **lejos de los lugares donde se compra usualmente**, es probable que no la haya hecho el dueño de la tarjeta. Ante esa situación se contacta al cliente para certificar que haya sido él.

La mayoría de las transacciones son **normales**; un **cambio significativo en los hábitos** del usuario puede indicar que la usó otra persona. La idea principal es **detectar las transacciones que se desvían considerablemente de la norma**.

### Qué es una anomalía

> **Anomalía (*outlier*, *anomaly*):** un objeto de la base de datos con valores de sus atributos que **se desvían significativamente de los valores normales** de los mismos, **como si hubiesen sido generados por otro mecanismo**.

### Anomalía vs ruido (pregunta clásica)

| | **Ruido** | **Anomalía** |
|---|---|---|
| Qué es | Un **error aleatorio** o varianza en una variable | Un dato generado por un **mecanismo distinto** al que generó el resto |
| Interés | **Ninguno**: hay que **eliminarlo en la etapa de preparación** de los datos | **Mucho**: ese mecanismo **induce un patrón** en los datos anómalos, y es el mecanismo o la justificación lo que realmente interesa, más allá del dato individual |
| Ejemplo de la diapo | Un cliente compra un día una prenda de ropa **más cara de lo habitual**; si se tomara como outlier se estaría molestando al cliente con **falsas alarmas** | Una tarjeta usada simultáneamente en dos países: hay un mecanismo detrás (el fraude) |

### Tipos de anomalías

| Tipo | Definición | Ejemplo de la diapo |
|---|---|---|
| **Global** | Puntos que se desvían de la **totalidad** de los puntos de la base de datos | Detección de **intrusiones en una red** |
| **Contextual** | Un objeto que se desvía respecto de los valores normales **en un contexto específico** | "La temperatura de hoy es de 28 °C": como hoy es **otoño** resulta excepcional; si la medición fuese en **primavera** el valor no sería extraño |
| **Local** | Un tipo particular de anomalía contextual: se da en contextos donde **la densidad** se usa como medida de normalidad. Un punto es anomalía local si la **densidad de su vecindario se desvía considerablemente de la densidad de su entorno** | Un punto en una zona rala, pegado a una región muy densa |
| **Colectiva** | Un **subconjunto** de datos que, **juntos**, se desvían del comportamiento normal del dataset (individualmente cada uno puede ser normal) | Si **un** paquete de Mercado Libre se demora no es raro; pero si **más de 100 se demoran el mismo día**, hay un mecanismo retrasando sistemáticamente las entregas |

### Enfoques según el etiquetado

| Enfoque | Cómo funciona | Observación |
|---|---|---|
| **Supervisados** | **Expertos del dominio** clasifican el dataset en normal / anormal, y con esos datos etiquetados se genera un **modelo de clasificación** para los datos nuevos que ingresen | Deben **actualizarse cada cierto tiempo**, porque el comportamiento normal puede cambiar |
| **Semi-supervisados** | Se usan en bases donde es posible conseguir que **una pequeña porción** de los datos esté etiquetada. Esos datos sirven para encontrar los **vecindarios o grupos de datos normales** y entrenar un modelo que **describa la normalidad**; después ese modelo detecta los outliers | El punto medio cuando etiquetar todo es inviable |
| **No supervisados** | Como muchas veces no se puede etiquetar a mano, se recurre a **clustering**: los puntos normales (de comportamiento similar) quedan agrupados y los anormales, alejados | **Puede fallar:** ese alejamiento puede no suceder, por ejemplo si los **datos normales no siguen un patrón marcado** (están uniformemente distribuidos) y son los **anormales los que siguen un patrón** |

### Algoritmos y técnicas

**1. Métodos estadísticos.** Asumen cuál es la **normalidad** de los datos: como los datos son generados por cierto **proceso estocástico**, los normales son los que se ubican en una **región de alta probabilidad**, y las anomalías, los de **regiones de baja probabilidad**.

| Técnica | Tipo | Cómo decide |
|---|---|---|
| **Boxplot** | **Paramétrico**, para distribuciones **univariadas** | Es anómalo lo que cae fuera de los bigotes, es decir fuera de $[Q1 - 1{,}5 \cdot IQR,\ Q3 + 1{,}5 \cdot IQR]$. Entre el mínimo y el máximo así definidos se encuentra el **99,3 % de los datos** (bajo distribución normal) |
| **Histograma** | **No paramétrico**: no asume una distribución previa, sino que la **aprende** a partir del modelado | Si un dato cae en un bin de **alta frecuencia**, el comportamiento es **normal**; si cae en un bin de **baja frecuencia**, es **anómalo**. **Depende del tamaño del bin** |

**2. Métodos basados en clustering.** Mientras el clustering busca conjuntos de datos **similares entre sí**, la detección de anomalías busca los datos que están **lejos de esos grupos**: son **actividades complementarias**. Usar clustering es además beneficioso porque muchas veces **los datos anómalos están agrupados**, al haber sido generados por otro mecanismo.

**Estrategia**, dado un punto cualquiera de la base:

1. ¿El objeto **no pertenece a ningún cluster**? → **Outlier**.
2. ¿Hay una **gran distancia** entre el objeto y su cluster más cercano? → **Outlier**.
3. ¿El objeto pertenece a un **cluster disperso y aislado**? → **todos los objetos de ese cluster** son outliers.

**Métodos pendientes** (nombrados en la diapo, no desarrollados en la cursada): métodos basados en **distancia** y basados en **densidad** *(complemento: el más conocido es LOF, Local Outlier Factor, que es el que detecta las anomalías **locales** definidas arriba)*.

---

## 10. Minería de Texto
📎 [[MineradeTexto.pdf]]

### Contexto

**Big Data (las 3 V)** → una gran proporción de los datos es **no estructurada**, y un **gran porcentaje de esos son textos** (documentos, artículos de blogs, tweets, entre otros). Hacen falta **técnicas específicamente diseñadas** para tratar con esta clase de datos: una tabla de números se puede meter directo en un algoritmo, un texto no.

> **Minería de texto (*text mining*):** el proceso de **extraer conocimiento a partir de datos textuales no estructurados**.

**Aplicaciones:**

| Aplicación | Qué hace |
|---|---|
| **Análisis de sentimientos** | Analizar el **feedback** de los usuarios de un servicio o producto |
| **Investigación de mercado** | Determinar **tendencias y modas** |
| **Detección de fraudes** | Por ejemplo, identificar **reclamos fraudulentos** |
| **Investigación científica** | Identificar **patrones y relaciones** en comunicaciones científicas (papers, charlas, etc.) |

### Terminología

| Término | Definición | Características |
|---|---|---|
| **Corpus** | Una **colección de documentos** de texto | Único o múltiples **idiomas** · **estático** o **dinámico** (si se le agregan documentos) · **etiquetado** o no (si cada documento tiene una clase asociada) |
| **Documento** | Una **unidad discreta de información textual** dentro de una colección | Relación **muchos a muchos** con los corpus (un documento puede estar en varios corpus) · puede tener o no relación con un **documento físico** · puede ser **semi-estructurado o no estructurado** |
| **Características o atributos** | Aquello con lo que se describe un documento | **Caracteres** (letras, números, símbolos: bolsa de caracteres, **n-gramas**) · **palabras** · **términos** (palabras o frases **con carga semántica**) · **conceptos** (categorización) |

> [!example] Ejemplo de la diapo
> *"Messi emprendió un viaje profesional hasta convertirse en el jugador más importante del mundo."*
>
> El mismo texto se puede describir por:
> - sus **caracteres** (y secuencias de $n$ caracteres, los *n-gramas*);
> - sus **palabras** ("Messi", "emprendió", "un", …);
> - sus **términos**, que son los que cargan significado ("jugador más importante", "viaje profesional");
> - sus **conceptos**, que ni siquiera aparecen escritos en el texto: *fútbol*, *deporte*.
>
> Cuanto más arriba en esa escala, más semántica se captura y más procesamiento hace falta.

### Preparación de textos

> [!important] La minería de textos es **altamente dependiente de la preparación** de los documentos
> **Objetivo:** crear **representaciones estructuradas** de los documentos. Estas representaciones buscan **"exponer" el significado** de los textos para que sea accedido por los algoritmos de minería.

Tiene **tres partes**:

| # | Parte | Qué hace |
|---|---|---|
| 1 | **Preprocesamiento preparatorio** | Convierte un documento **"crudo"** en un formato adecuado para seguir procesando: una **secuencia de caracteres**. Incluye **obtener el texto** de un PDF, una imagen o un audio; **identificar partes de su estructura** (párrafos, columnas, conclusiones); e **identificar metadatos** (título, autores). **Depende de la representación del texto** |
| 2 | **Procesamiento de Lenguaje Natural (PLN)** | Procesamientos **generales, independientes del problema**, que **dependen de las características del lenguaje** (o sea, del **idioma**) |
| 3 | **Representación numérica** | Pasar el texto a **vectores** que los algoritmos puedan usar |

#### PLN — tareas

- **Tokenización:** dividir el texto en **palabras o términos** (los *tokens*). Es el primer corte: convierte una cadena de caracteres en una lista de unidades.
- **Lematización:** hallar el **lema** o **forma no flexionada** de una palabra (por género, número, conjugación, etc.) **para estandarizarla**.
  - Ejemplo de la diapo: *Huida, Huirá, Huiremos, Huyó* → **Huir**.
- **Etiquetado de partes del discurso** (*POS tagging*):
  - **Categorías básicas:** verbo, sustantivo, preposición, adjetivo, etc.
  - **Categorías más complejas:** corpus de categorías especializadas.
- **Análisis sintáctico:** identificación de **sujeto, predicado, modificadores, objetos, oraciones subordinadas**, etc.
- *(complemento — tareas habituales que la diapo no lista pero el ejemplo de Chequeado presupone)*
  - **Normalización:** pasar todo a minúsculas, sacar tildes y signos de puntuación.
  - **Stopwords:** eliminar las **palabras vacías** ("el", "de", "que", "y"), que son muy frecuentes y no aportan significado.
  - **Stemming:** cortar los sufijos hasta llegar a la **raíz** ("jugador", "jugando" → "jug"). Es **más rápido pero más tosco** que lematizar: la raíz puede no ser una palabra real.

> [!example] Ejemplo de la diapo — Chequeado, elecciones 2023
> Un gráfico con las **palabras más repetidas** en los discursos de Massa y de Milei. El problema que muestra: "Argentina / Argentino / Argentinos", "Todos / Todas" y "Quiero / Queremos" **se cuentan por separado**, aunque en los tres casos se trata de la misma palabra flexionada.
>
> **Moraleja:** sin **lematizar**, el conteo **se reparte** entre las variantes y la representación pierde fuerza: una palabra importante puede quedar abajo en el ranking solo porque aparece conjugada de cinco formas distintas.

#### Representación numérica

**Bolsa de palabras (*bag of words*):** representa el documento por las palabras que contiene, **ignorando el orden**.

| Variante | Qué guarda | Ejemplo para "el gato come pescado, el gato duerme" |
|---|---|---|
| **Conjunto (*set*) / One-hot encoding** | **1** si el término está en el documento, **0** si no | "gato" → 1, "perro" → 0 |
| **Vector de frecuencia** | **Cuántas veces** aparece cada término | "gato" → 2, "el" → 2, "come" → 1 |

**TF-IDF** (*term frequency – inverse document frequency*): indica la **importancia de una palabra en un documento**.

- **TF** (*term frequency*): la **frecuencia relativa** del término en el documento.
- **IDF** (*inverse document frequency*): indica **cuánta información brinda ese término**, en función de si es un término **común o raro** en el corpus.

> [!note] La intuición
> Un término es importante para un documento si **aparece mucho en él** (TF alto) **y poco en los demás** (IDF alto). Una palabra que aparece en todos los documentos no distingue nada, por más que se repita.

*(complemento — fórmulas)*

$$TF(t,d) = \frac{f_{t,d}}{|d|} \qquad IDF(t) = \log\frac{N}{n_t} \qquad TFIDF(t,d) = TF(t,d) \cdot IDF(t)$$

| Símbolo | Significado |
|---|---|
| $t$ | El término |
| $d$ | El documento |
| $f_{t,d}$ | Cantidad de veces que el término $t$ aparece en el documento $d$ |
| $\lvert d \rvert$ | Cantidad total de términos del documento $d$ |
| $N$ | Cantidad total de documentos del corpus |
| $n_t$ | Cantidad de documentos que contienen el término $t$ |

> [!example]- Ejemplo comparado (corpus de 3 documentos, log base 10)
> - **d1** = "el gato come pescado, el gato duerme" (7 términos)
> - **d2** = "el perro come carne"
> - **d3** = "el perro duerme"
>
> | d1 | el | gato | come | pescado | duerme | perro | carne |
> |---|---|---|---|---|---|---|---|
> | **One-hot** | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
> | **Frecuencias** | 2 | 2 | 1 | 1 | 1 | 0 | 0 |
> | **TF-IDF** | **0** | **0,136** | 0,025 | 0,068 | 0,025 | 0 | 0 |
>
> **Cómo salen un par de números:**
> - **"el":** aparece en los 3 documentos → $IDF = \log(3/3) = \log 1 = 0$ → TF-IDF **0**, aunque sea la palabra **más frecuente** de d1. **No aporta nada** para distinguir documentos.
> - **"gato":** $TF = 2/7 = 0{,}286$; aparece solo en d1 → $IDF = \log(3/1) = 0{,}477$ → $TFIDF = 0{,}286 \times 0{,}477 = \mathbf{0{,}136}$. Es la palabra que mejor **caracteriza** a d1.
> - **"come":** $TF = 1/7 = 0{,}143$; aparece en d1 y d2 → $IDF = \log(3/2) = 0{,}176$ → $TFIDF = 0{,}025$.

**Embeddings:** representación **vectorial** de una frase, término, palabra o concepto **en un espacio métrico** (un espacio donde está definida una distancia). Se buscan propiedades como:

- Si dos palabras son **similares**, deben ser **vecinas** en ese espacio.
- Si esas dos palabras tienen **opuesto**, las distancias a sus respectivos opuestos deben ser **similares** (el clásico *man → woman ≈ king → queen*).

El ejemplo nombrado es **Word2Vec**.

*(complemento — por qué son mejores que la bolsa de palabras)* Los embeddings son vectores **densos y de pocas dimensiones** (típicamente 100–300), aprendidos a partir del **contexto** en que aparecen las palabras. La bolsa de palabras, en cambio, genera vectores **enormes** (un lugar por cada término del vocabulario), **dispersos** (casi todo ceros) y **sin semántica**: "auto" y "coche" quedan en dimensiones distintas, tan lejos entre sí como "auto" y "banana".

### Actividades de minería sobre texto

| Actividad | Objetivo | Particularidades |
|---|---|---|
| **Agrupamiento** | **Particionar la colección** de documentos según su **similitud** | Se pueden usar los algoritmos clásicos (K-Means) sobre la representación vectorial, **con dos modificaciones**: la función de distancia pasa a ser la **similitud coseno**, y en el cálculo del **centroide se excluyen las palabras poco frecuentes** |
| **Clasificación** | Construir un modelo **predictivo de la clase** de una colección de documentos | Hay que tener en cuenta que los espacios vectoriales son **dispersos**: **la presencia de un término es más informativa que su ausencia**. Algoritmos: **K-NN**, **clasificador de Bayes** y **SVM para espacios dispersos** |
| **Más** | Descubrimiento de **novedades** · **modelado de temas** · búsqueda de **asociaciones** · búsqueda de **anomalías** | |

### Similitud entre vectores de texto *(complemento — la diapo lo deja como lectura: Aggarwal 3.3)*

| Medida | Fórmula | Cuándo se usa |
|---|---|---|
| **Coseno** | $\cos(\vec{a}, \vec{b}) = \dfrac{\vec{a} \cdot \vec{b}}{\lVert \vec{a} \rVert \, \lVert \vec{b} \rVert}$ | **La más usada en texto y embeddings.** Mide el **ángulo** entre los vectores, no su largo: dos documentos que hablan de lo mismo quedan cercanos aunque uno sea mucho más largo. La **distancia coseno** es $1 - \cos$ |
| **Producto punto** | $\vec{a} \cdot \vec{b}$ | Equivale al coseno **si los vectores están normalizados** |
| **Euclídea / Manhattan** | $\sqrt{\sum (a_i - b_i)^2}$ / $\sum \lvert a_i - b_i \rvert$ | Dependen de la **magnitud**: un documento largo queda "lejos" de uno corto aunque traten el mismo tema. Por eso **no** se usan en texto crudo |
| **Jaccard** | $\dfrac{\lvert A \cap B \rvert}{\lvert A \cup B \rvert}$ | Para representaciones de **conjunto** (one-hot): términos compartidos sobre términos totales |

📓 Práctica: `3.07.gdr.text_mining.ipynb` → análisis de sentimientos sobre reseñas de Amazon con **TF-IDF + regresión logística**.

---

## 11. Sistemas Recomendadores
📎 [[Ciencia_de_datos___Sistemas_recomendadores.pdf]]

### El contexto

En contextos web es una práctica común **solicitar feedback a los usuarios** sobre el contenido ofrecido:

| Tipo de feedback | Cómo se obtiene | Ejemplo |
|---|---|---|
| **Explícito** | Se le **pregunta** al usuario | Netflix pide que indique si una película o serie le gustó o no |
| **Implícito** | Se deduce de las **interacciones del usuario** con el sitio | Qué miró, cuánto tiempo, qué cliqueó, qué compró |

> **La idea de los sistemas recomendadores es predecir las preferencias de los usuarios.**

| Término | Definición |
|---|---|
| **Usuario** | La entidad que **posee preferencias** y a la que le hacemos recomendaciones |
| **Item** | El **producto o servicio** que está siendo recomendado |

Las recomendaciones se basan usualmente en las **interacciones históricas** entre usuarios e items.

**Hipótesis de trabajo:** existen **dependencias significativas** entre los usuarios y las actividades alrededor de los items. Por ejemplo, un usuario que consume un **documental histórico** es más probable que esté interesado en **documentales** que en **películas de acción**. La idea es **aprender esas relaciones a partir de la matriz de ratings** y usarlas para hacer predicciones; **cuantas más interacciones haya**, mejor se entienden las relaciones y **más acertadas** son las predicciones.

### Formulación del problema

| Versión | Qué se busca |
|---|---|
| **Predicción** | Predecir el **rating** para un par ordenado (Usuario, Item). Se asume que hay datos de entrenamiento en una **matriz incompleta** $M_{m \times n}$ ($m$ usuarios, $n$ items), donde los **valores observados** se usan para predecir los **valores perdidos o no observados** → ***matrix completion problem*** |
| **Ranking** | En la práctica **no hace falta predecir todos los valores** de $M$, sino solo obtener los **top-k items** para un usuario determinado (o los **top-k usuarios** para un item) → ***top-k recommendation problem*** |

### Objetivos

El principal **objetivo de negocio** detrás de un sistema recomendador es **incrementar la ganancia** por la venta de servicios o productos. Para eso, las recomendaciones deben cumplir cuatro requisitos:

| Requisito | Definición | Por qué importa |
|---|---|---|
| **Relevancia** | Los items recomendados deben ser **relevantes (interesantes)** para el usuario | Es lo mínimo: si no le interesa, no lo consume |
| **Novedad** | Deben ser **novedosos**: items que el usuario **no haya consumido** en el pasado | Recomendarle algo que ya compró no genera una venta nueva |
| **Serendipia** | Los usuarios deben encontrar **cierta sorpresa**, descubrir **nuevas preferencias** que tal vez no habían considerado | Va más allá de la novedad: no es solo "nuevo", es **inesperado y acertado** |
| **Diversidad** | Si hay **variedad** entre las recomendaciones, hay **mayor posibilidad de que el usuario elija al menos una** | Recomendar 10 películas casi idénticas es jugarse todo a una sola apuesta |

### Tipos de sistemas recomendadores

Los sistemas funcionan con **dos tipos de datos**: las **interacciones** entre usuarios e items (ratings, comportamiento) y las **características (atributos)** de usuarios e items. Según cómo usan esa información:

| Tipo | Qué datos usa | Idea |
|---|---|---|
| **Filtro colaborativo** | Las **preferencias de múltiples usuarios** | Las matrices son **dispersas**, porque la cantidad de productos suele ser grande y cada usuario consumió solo una **pequeña proporción**. La idea es **"imputar" los valores faltantes usando los conocidos**, ya que los ratings observados suelen estar **muy correlacionados** entre varios usuarios e items |
| **Basado en contenido** | Las preferencias **+ información contextual (atributos) de los items** | A un usuario le gustó **Terminator** y no se tiene información de otros usuarios; entonces se mira la **descripción** de esa película para encontrar otras parecidas. Por cada usuario se usan las descripciones de los items con los que interactuó y el puntaje que les asignó, y con eso se crea un **modelo de regresión o clasificación** |
| *(complemento)* **Basado en conocimiento** | **Requisitos explícitos** del usuario + conocimiento del dominio | Reglas, restricciones o casos similares. Sirve para items que se compran **muy pocas veces** (casas, autos), donde no hay historial útil |
| *(complemento)* **Híbrido** | Combinación de los anteriores | Suma las ventajas: contenido para los items nuevos, colaborativo para el resto |

### Filtro colaborativo — variantes

**1. Basados en vecindarios** (*neighborhood-based*):

| Variante | Cómo imputa el rating del par (Usuario, Item) |
|---|---|
| **User-based** | Con base en **lo que opinan de ese Item los usuarios con preferencias similares** al usuario en cuestión |
| **Item-based** | Con base en **lo que opinó ese usuario de otros productos similares** al item en cuestión |

**2. Basados en modelos:** se utilizan modelos de **machine learning** para aprender las **relaciones implícitas** entre los datos y hacer predicciones *(complemento: el caso típico es la **factorización de matrices**)*.

> [!example] Ejemplo de la diapo (5 usuarios × 4 apps; ¿le gusta el item 3 al usuario 5?)
> ♥ = le gustó · ✗ = no le gustó · celda vacía = no lo consumió
>
> | | Item 1 | Item 2 | Item 3 | Item 4 |
> |---|---|---|---|---|
> | U1 | ♥ | ✗ | ♥ | ♥ |
> | U2 | | ♥ | ✗ | ✗ |
> | U3 | ♥ | ♥ | ✗ | |
> | **U5** | ♥ | ♥ | **?** | ✗ |
> | U4 | ✗ | | ♥ | |
>
> - **User-based:** se buscan los usuarios **parecidos a U5** mirando los items que ambos calificaron. **U2 y U3** son los más parecidos (coinciden con U5 en los items 1, 2 y 4). Los dos le dieron **✗ al item 3** → **predicción: ✗**.
> - **Item-based:** se busca el item **más parecido al 3** mirando cómo lo calificaron los usuarios. El más parecido es el **item 4** (U1 y U2 los calificaron igual). U5 le dio **✗ al item 4** → **predicción: ✗**.
>
> Las dos vías llegan al mismo resultado, pero el razonamiento es distinto: una compara **filas** (usuarios) y la otra, **columnas** (items).

> [!note]- *(complemento — fórmulas)* Cómo se calcula en la práctica
> - **Similitud entre usuarios:** se usa **Pearson** o **coseno** sobre los ratings que tienen en común, **centrados por la media de cada usuario** (para corregir que hay usuarios que puntúan siempre alto y otros siempre bajo).
> - **Predicción user-based:**
>   $$\hat{r}_{uj} = \mu_u + \frac{\sum_{v \in P_u(j)} sim(u,v)\,(r_{vj} - \mu_v)}{\sum_{v \in P_u(j)} \lvert sim(u,v) \rvert}$$
>   donde $\hat{r}_{uj}$ es el rating estimado del usuario $u$ para el item $j$, $\mu_u$ la media de ratings de $u$, $P_u(j)$ el conjunto de los $k$ usuarios más similares a $u$ que puntuaron $j$, $sim(u,v)$ la similitud entre $u$ y $v$, y $r_{vj}$ el rating que $v$ le dio a $j$. En criollo: se parte del promedio del usuario y se lo corrige con **cuánto se desviaron de su propio promedio** los usuarios parecidos, pesando cada uno por su similitud.
> - **Factorización de matrices (SVD):** $M \approx U_k \Sigma_k V_k^T$. Usuarios e items quedan representados en un espacio de **$k$ factores latentes** (dimensiones aprendidas, del tipo "cuán de acción es la película" / "cuánto le gusta la acción al usuario"), y el producto de esas matrices **reconstruye la matriz completa**, incluidos los faltantes.

> [!warning] Cold start (inicio frío) *(complemento)*
> Un usuario o un item **nuevo, sin interacciones**, deja al filtro colaborativo sin nada con qué trabajar: no hay vecinos ni ratings que correlacionar. Se resuelve con sistemas **basados en contenido** (alcanza con los atributos del item), **basados en conocimiento**, recomendaciones por **popularidad**, **preguntas de onboarding** o sistemas **híbridos**. Está desarrollado en [[Preguntas de estudio - Ciencia de Datos#Unidad 11 — Sistemas recomendadores|las preguntas de estudio]].

📓 Práctica (MovieLens): `3.08.gdr.user-based_reccomendation_system.ipynb` (user-based con similitud coseno) · `3.09.gdr.matrix_factorization.ipynb` (SVD con k = 50).

---

## Glosario de siglas y símbolos

**Siglas**

| Sigla | Significado | Unidad |
|---|---|---|
| **BI** | *Business Intelligence* — Inteligencia de Negocios | 0 |
| **IA** | Inteligencia Artificial | 0 |
| **ML** | *Machine Learning* — aprendizaje automático | 0 |
| **OLTP / OLAP** | *On-Line Transaction / Analytical Processing* | 0 |
| **KDD** | *Knowledge Discovery in Databases* | 1 |
| **CRISP-DM** | *Cross Industry Standard Process for Data Mining* | 1 |
| **IQR** | *Inter-Quartile Range* — rango intercuartil ($Q3 - Q1$) | 2 |
| **PCA** | *Principal Components Analysis* — análisis de componentes principales | 3 |
| **RSS** | *Residual Sum of Squares* — suma de cuadrados de los residuos | 4 |
| **TDIDT** | *Top-Down Induction of Decision Trees* | 5 |
| **SVM** | *Support Vector Machines* | 5 |
| **VP / VN** | Verdaderos Positivos / Verdaderos Negativos (aciertos) | 5 |
| **FP / FN** | Falsos Positivos / Falsos Negativos (errores) | 5 |
| **MSE** | *Mean Squared Error* — error cuadrático medio | 6 |
| **LOOCV** | *Leave One Out Cross Validation* | 6 |
| **DBSCAN** | *Density Based Spatial Clustering of Applications with Noise* | 7 |
| **ddr / dr / dc** | Directamente alcanzable por densidad / alcanzable por densidad / densamente conectado | 7 |
| **LOF** | *Local Outlier Factor* | 9 |
| **PLN / NLP** | Procesamiento de Lenguaje Natural | 10 |
| **TF-IDF** | *Term Frequency – Inverse Document Frequency* | 10 |
| **POS** | *Part Of Speech* — partes del discurso | 10 |
| **K-NN** | *K-Nearest Neighbors* — k vecinos más cercanos | 10 |
| **SVD** | *Singular Value Decomposition* — descomposición en valores singulares | 11 |

**Símbolos**

| Símbolo | Significado |
|---|---|
| $\bar{x}$ | Media o promedio de $x$ |
| $\sigma$ / $\sigma^2$ | Desviación estándar / varianza |
| $\hat{Y}$, $\hat{f}$, $\hat\beta$ | El "sombrerito" indica **valor estimado** por el modelo |
| $\varepsilon$ | Error irreducible del modelo |
| $\beta_0$ / $\beta_1 \dots \beta_p$ | Ordenada al origen / coeficientes de la regresión |
| $e_i$ | Residuo de la observación $i$: $y_i - \hat{y}_i$ |
| $p_i$ | Proporción de tuplas de la clase $i$ |
| **ε** / **MinPts** | Radio del vecindario / mínimo de puntos (DBSCAN) |
| $A \Rightarrow B$ | Regla de asociación: "si se lleva $A$, se lleva $B$" |
| $P(B \mid A)$ | Probabilidad condicional de $B$ dado $A$ (= confianza) |
| $M_{m \times n}$ | Matriz de ratings de $m$ usuarios por $n$ items |

---

## Preguntas de repaso
> Las preguntas oficiales de la cátedra, respondidas, están en [[Preguntas de estudio - Ciencia de Datos]]. Las preguntas tipo parcial, en [[Preguntas de ejemplo del parcial - Ciencia de Datos]].

- [ ] ¿Diferencia entre analítica descriptiva, predictiva y prescriptiva? Dar un ejemplo de cada una.
- [ ] Diferencia entre ciencia de datos y minería de datos.
- [ ] ¿Qué le falta a KDD que sí tiene CRISP-DM? Nombrar las 6 fases en orden.
- [ ] ¿Cuáles son los 4 niveles de la estructura jerárquica de CRISP-DM?
- [ ] ¿Por qué no se puede calcular el promedio de un atributo ordinal?
- [ ] Diferencia entre atributo intervalado y ratio.
- [ ] ¿Cuándo conviene la mediana en lugar de la media?
- [ ] ¿Cómo se construye un boxplot? ¿Hasta dónde llegan los bigotes y qué queda afuera?
- [ ] Nombrar las 5 estrategias para tratar valores faltantes y la desventaja de cada una.
- [ ] Aplicar binning por medias y por fronteras a un conjunto dado.
- [ ] ¿Qué es el problema de identificación de entidades? Dar un ejemplo.
- [ ] Reducción de dimensionalidad vs de numerosidad: qué reduce cada una y con qué técnicas.
- [ ] Error reducible vs irreducible. Predicción vs inferencia.
- [ ] Métodos paramétricos vs no paramétricos: ventajas y desventajas.
- [ ] ¿Qué minimiza el método de los mínimos cuadrados y por qué al cuadrado?
- [ ] ¿Por qué no usar regresión lineal para una clase cualitativa?
- [ ] Definir VP, VN, FP y FN, y ubicarlos en la matriz de confusión.
- [ ] Calcular accuracy, sensitivity y specificity a partir de una matriz de confusión, y explicar qué mide cada una.
- [ ] En el ejemplo de la droga, ¿por qué la accuracy de 0,83 es engañosa?
- [ ] Diferencia entre ganancia de información (ID3) e índice Gini (CART).
- [ ] Bias alto vs varianza alta: síntoma, nombre del problema y solución.
- [ ] ¿Por qué el conjunto de test debe estar etiquetado y por qué debe ser disjunto del de train?
- [ ] Muestreo aleatorio simple vs estratificado: ¿por qué importa para la sensitividad?
- [ ] LOOCV vs K-Folds: ventajas, desventajas y relación entre ambos.
- [ ] ¿Por qué K-Means falla con clusters no esféricos y DBSCAN no?
- [ ] Definir ε-vecindario, objeto central, ddr, dr y dc en DBSCAN.
- [ ] ¿Cuál es el principal problema de DBSCAN y por qué se produce?
- [ ] Calcular soporte y confianza de una regla. ¿Cuál es la diferencia conceptual entre las dos?
- [ ] Enunciar la propiedad A-priori y explicar cómo se usa para podar candidatos.
- [ ] Diferencia entre ruido y anomalía. Nombrar y ejemplificar los 4 tipos de anomalías.
- [ ] Enfoques supervisado, semi-supervisado y no supervisado para anomalías. ¿Cuándo falla el no supervisado?
- [ ] Nombrar las tres partes de la preparación de textos y qué hace cada una.
- [ ] Tokenización vs lematización vs stemming. ¿Qué problema muestra el ejemplo de Chequeado?
- [ ] Calcular one-hot, frecuencias y TF-IDF de un documento. ¿Por qué una palabra muy frecuente puede tener TF-IDF 0?
- [ ] ¿Por qué se usa similitud coseno en texto y no distancia euclídea?
- [ ] ¿Qué dos modificaciones necesita K-Means para agrupar documentos?
- [ ] Relevancia, novedad, serendipia y diversidad: definir cada una.
- [ ] Problema de predicción vs problema de ranking.
- [ ] Resolver una matriz chica con user-based y con item-based.
- [ ] Colaborativo vs contenido vs conocimiento. ¿Cuál sirve ante un cold start?
