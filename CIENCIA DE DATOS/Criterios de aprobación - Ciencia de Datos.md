---
tipo: resumen
materia: Ciencia de Datos
tags: [criterios, evaluacion, ciencia-de-datos]
---
# Criterios de aprobación — Ciencia de Datos

Volver a [[CIENCIA DE DATOS]] · Teoría en [[Resumen Ciencia de Datos]] · Práctica en [[Preguntas de ejemplo del parcial - Ciencia de Datos]]
📎 [[Ciencia de Datos 2026 - Planificación.pdf]] (Anexo A: rúbricas · Anexo B: puntajes)

> [!info] De dónde sale esto
> Todo lo que dice "Logrado / Parcial / No logrado" está tomado textual de las **listas de cotejo** de la planificación. Lo de "Qué saber" y "Ojo" es mío, armado con las diapos, el resumen y los errores del parcial 2025. El PDF se llama "2026" pero el encabezado dice "Ciclo Lectivo 2025": si cambió algo, va a estar en el aula virtual.

**Índice:** [[#Cómo se aprueba]] · [[#RA1 — Marcos metodológicos]] · [[#RA2 — Calidad de los datos]] · [[#RA3 — Algoritmos de minería]] · [[#Mapa criterio → preguntas de práctica]] · [[#Qué tener en cuenta]] · [[#Temas del programa que no están en las diapos]]

---

## Cómo se aprueba

La materia se evalúa **por competencias**: hay 3 **resultados de aprendizaje (RA)**, cada uno con criterios, y cada criterio se puntúa con una lista de cotejo:

| No logrado | Parcial | Logrado |
|---|---|---|
| **0** | **1** | **2** |

| RA | Descripción | Criterios | Puntos |
|---|---|---|---|
| **RA1** | Justificar el uso de **marcos metodológicos** para proyectos de ciencia de datos | 3 | 6 |
| **RA2** | Asegurar la **calidad de los datos** con técnicas de preprocesamiento y transformación | 4 | 8 |
| **RA3** | Utilizar **algoritmos de minería** para extraer patrones y resolver problemas de negocio | 4 | 8 |

### Instrumentos de evaluación (Anexo B)
| Instrumento | Evalúa | Máximo | **Aprueba con** | Margen |
|---|---|---|---|---|
| **Examen teórico conceptual** (escrito) | RA1 + RA2 + RA3, **los 11 criterios** | 22 | **≥ 16** (73 %) | Podés perder 6 puntos |
| **TP integrador + coloquio oral grupal** | RA2 + RA3, 8 criterios | 16 | **≥ 12** (75 %) | Podés perder 4 puntos |

> [!important] La cuenta que importa
> - **Examen:** si todos los criterios te quedan en "parcial" sacás **11/22 y no aprobás**. Necesitás **al menos 5 criterios logrados** (5 × 2 + 6 × 1 = 16), y cada criterio en "no logrado" te obliga a compensarlo con otro logrado.
> - **TP:** con todo parcial sacás 8/16. Necesitás **al menos 4 criterios logrados** (4 × 2 + 4 × 1 = 12).
> - El RA1 **solo se evalúa en el examen**.

### Condiciones de aprobación
- **Promoción (aprobación directa):** aprobar **todos** los instrumentos (examen y TP + coloquio).
- **Si no llegás:** **siempre que hayas rendido el examen teórico**, aprobás "de forma indirecta". En el **final** se evalúan el TP final y **solo los RA que no alcanzaron el mínimo**.
- O sea: **el examen teórico no se puede faltar**. Es lo que te habilita a ir al final (el encabezado del parcial 2025 lo decía: "no es obligatorio para regularizar, pero sí para aprobar").
- **Modalidad del examen:** teórico conceptual escrito + coloquio oral grupal (sobre el TP y conocimiento general de la materia).

---

## RA1 — Marcos metodológicos
*Solo en el examen · 6 puntos*

### 1.1 CRISP-DM y KDD: estructura, ciclo de vida, diferencias
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No describe ninguno de los dos modelos o los confunde gravemente | Describe uno correctamente, o ambos con errores relevantes | Describe y compara ambos modelos con precisión: **estructura, ciclo de vida y diferencias** |

**Qué saber:**
- **KDD** (Fayyad et al., 1996): selección → preprocesamiento → transformación → minería → interpretación/evaluación. Sus 3 problemas según la diapo: solo técnico, no tiene en cuenta al cliente, no contempla la implementación.
- **CRISP-DM** (1999): estructura **jerárquica de 4 niveles** (fases → tareas genéricas → tareas especializadas → instancias de proceso), **6 fases**, ciclo de vida **iterativo** con retroalimentación, dice el **qué** y no el **cómo**, independiente de herramientas.
- La tabla de diferencias (alcance, por dónde empieza, contra qué evalúa, dónde termina, estructura).

**Ojo:**
- Hay que **describir y comparar los dos**: explicar solo CRISP-DM es "parcial".
- No afirmes que KDD "no permite retroalimentación" (error de las dos resoluciones del parcial 2025); Fayyad lo describe como iterativo.
- Nombrá los **4 niveles** cuando pregunten por la estructura.

📖 [[Resumen Ciencia de Datos#1. Metodologías para proyectos de Ciencia de Datos|Resumen U1]]

### 1.2 Fases de CRISP-DM: actividades genéricas y retroalimentación
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No enumera las fases o las confunde entre sí | Enumera las fases pero **omite actividades o la retroalimentación** entre ellas | Enumera todas las fases, **describe sus actividades** y **explica la retroalimentación** |

**Qué saber:**
- Las 6 fases **con sus actividades genéricas**: negocio (objetivos de negocio → objetivos de minería, recursos, plan) · datos (recolectar, describir, explorar, verificar calidad) · preparación (seleccionar, limpiar, integrar, construir, formatear) · modelado (elegir técnica, diseñar tests, construir, evaluar el modelo) · evaluación (contra los objetivos de **negocio**, revisar el proceso, próximos pasos) · implementación (informes, despliegue, monitoreo y mantenimiento).
- La **retroalimentación**: Negocio ↔ Datos, Preparación ↔ Modelado, Evaluación → Negocio, y el círculo exterior (el proyecto genera nuevos proyectos).
- La diferencia entre **evaluar el modelo** (técnica, en el modelado) y la **fase de Evaluación** (contra el negocio).

**Ojo:** enumerar las 6 fases sin actividades, o sin decir cómo se retroalimentan, es "parcial". Siempre las dos cosas.

📖 [[Preguntas de estudio - Ciencia de Datos#Unidad 1 — Metodologías|Preguntas U1]]

### 1.3 Justificación del marco: por qué usar una metodología
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No justifica el uso de un marco metodológico | Justifica de forma **genérica o superficial, sin ejemplos concretos** | Argumenta **con ejemplos concretos** del proyecto por qué el marco es necesario |

**Qué saber:** la analogía con la crisis del software; que aplicar algoritmos "a las apuradas" no satisface a los stakeholders; la traducción objetivos de negocio → objetivos de minería; trazabilidad, lenguaje común, planificación y control.

**Ojo:** lo que separa el 1 del 2 es **el ejemplo concreto**. Llevá uno preparado, idealmente del TP. Por ejemplo:
> Sin entendimiento del negocio, un modelo de fuga de clientes se optimiza por accuracy (90 %) pero detecta pocos de los que se van, que era lo único que le importaba al cliente. Con CRISP-DM, el objetivo de minería ("sensibilidad ≥ 80 %") sale del objetivo de negocio, y la fase de Evaluación lo hubiera detectado antes de implementar.

📖 [[Preguntas de ejemplo del parcial - Ciencia de Datos#P4. Objetivos de negocio y objetivos de minería de datos|Parcial P4]]

---

## RA2 — Calidad de los datos
*Examen y TP · 8 puntos en cada uno*

### 2.1 Conocimiento de los datos: descripción estadística y visualización
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No describe atributos ni usa estadísticos o visualizaciones | Describe atributos pero con visualizaciones o estadísticos **incompletos o mal elegidos** | Describe correctamente con estadísticos y visualizaciones **apropiadas para cada tipo de atributo** |

**Qué saber — la clave es elegir según el tipo:**

| Tipo de atributo | Estadísticos válidos | Visualización |
|---|---|---|
| **Nominal / binario** | Moda, frecuencias | Barras, (torta) |
| **Ordinal** | Moda, **mediana**, cuartiles (**no** promedio) | Barras **en su orden natural**, frecuencias acumuladas |
| **Numérico** (intervalo / ratio) | Media, mediana, moda, rango, cuartiles, varianza, desvío | **Histograma**, **boxplot** |
| **Dos numéricos** | Correlación | **Scatterplot** |
| **Muchos atributos** | Matriz de correlación | **Scatterplot matrix**, **heatmap** |

**Ojo:** el promedio de un nominal u ordinal es un error de los que bajan a "parcial". Comparar media, mediana y moda sirve para detectar **sesgo** en la distribución.

📖 [[Resumen Ciencia de Datos#2. Conocimiento de los Datos|Resumen U2]]

### 2.2 Detección de problemas: valores perdidos, anomalías, sesgos
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No identifica ningún problema de calidad en los datos | Identifica algunos problemas pero los analiza de forma **superficial** | Identifica y fundamenta **todos** los problemas hallados **con evidencia visual y estadística** |

**Qué saber:**
- **Factores de calidad:** precisión, completitud, consistencia, credibilidad, interpretabilidad.
- **Faltantes:** cuántos hay por atributo y si tienen **semántica**.
- **Anomalías:** boxplot (fuera de 1,5·IQR), 3σ, histograma; ruido vs anomalía.
- **Sesgos:** distribución asimétrica (media ≠ mediana), **desbalance de clases**, muestra no representativa.
- Duplicados, inconsistencias de unidades o codificación, redundancia (correlación).

**Ojo:** "fundamentar con evidencia" significa **un gráfico y un número**: "el boxplot de *ingreso* muestra 23 valores por encima de Q3 + 1,5·IQR; la media (85 000) supera mucho a la mediana (52 000), así que la distribución tiene sesgo a la derecha".

📖 [[Preguntas de ejemplo del parcial - Ciencia de Datos#3. Detección de anomalías en un atributo cuantitativo|Ejemplo 3]]

### 2.3 Limpieza y transformación: ETL, normalización, muestreo
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No aplica técnicas de preprocesamiento o las aplica incorrectamente | Aplica técnicas básicas **sin justificar la elección** según el dato o el algoritmo | **Selecciona y justifica** técnicas adecuadas según las características **del dato y del modelo a usar** |

**Qué saber:**
- **Limpieza:** las 5 estrategias para faltantes; ruido (binning, regresión, clustering).
- **Integración:** identificación de entidades, redundancia, duplicados, conflictos de valores.
- **Reducción:** PCA, selección de atributos, muestreo.
- **Transformación:** normalización (min-max, z-score), discretización, jerarquías conceptuales.
- **Muestreo:** aleatorio simple, **estratificado**, por cuotas, sistemático.
- **ETL / ELT** (ver [[#Temas del programa que no están en las diapos|abajo]]).
- **Texto:** tokenización, stopwords, lematización, one-hot / frecuencias / TF-IDF.

**Ojo — justificar por el dato y por el modelo** (la rúbrica pide las dos cosas):
- "Normalizo con z-score **porque uso K-Means**, que usa distancia euclídea y si no el atributo de mayor escala domina" (un árbol de decisión no lo necesita).
- "Imputo con la **moda por clase** porque el atributo es nominal".
- "Paso a **one-hot** porque A-priori necesita una matriz booleana".
- "Uso muestreo **estratificado** porque la clase está desbalanceada".

📖 [[Resumen Ciencia de Datos#3. Preparación de los Datos|Resumen U3]] · [[Preguntas de ejemplo del parcial - Ciencia de Datos#4. Valores perdidos en una variable cualitativa|Ejemplo 4]]

### 2.4 Uso ético y seguridad: anonimización, sesgos algorítmicos
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No considera aspectos éticos ni de seguridad del dato | **Menciona** aspectos éticos **sin implementar estrategias concretas** | **Identifica atributos sensibles** e **implementa estrategias de privacidad y reducción de sesgo** |

> [!warning] No está en las diapos
> Este criterio vale 2 puntos en el examen y 2 en el TP, y ninguna diapositiva lo trata. Lo que sigue es *(complemento)*.

**Qué saber:**
- **Atributos sensibles:** la Ley 25.326 de Protección de Datos Personales (Argentina) llama **datos sensibles** a los que revelan origen racial y étnico, opiniones políticas, convicciones religiosas, filosóficas o morales, afiliación sindical, salud o vida sexual. Además:
  - **Identificadores directos:** nombre, DNI, email, teléfono, dirección.
  - **Cuasi-identificadores:** combinados permiten identificar a alguien (edad + código postal + sexo).
  - **Proxies:** atributos que "esconden" uno sensible (el barrio puede reemplazar al nivel socioeconómico o al origen).
- **Estrategias de privacidad:**
  - **Minimización:** usar solo los atributos necesarios para el objetivo.
  - **Eliminar** los identificadores directos.
  - **Seudonimizar:** reemplazar el DNI por un código o *hash*.
  - **Generalizar:** edad → rangos, dirección → ciudad (son las jerarquías conceptuales de la preparación).
  - **Agregar** los datos.
  - **k-anonimato:** cada combinación de cuasi-identificadores la comparten al menos *k* personas.
  - **Seguridad:** control de acceso, cifrado, consentimiento y finalidad del uso.
- **Estrategias contra el sesgo algorítmico:**
  - Revisar que la muestra sea **representativa**.
  - **Balancear** las clases (submuestreo, sobremuestreo, estratificado).
  - Sacar los atributos sensibles **y sus proxies** (detectarlos por **correlación**).
  - Revisar si la **etiqueta** misma está sesgada (ej. "detenido" en vez de "cometió delito").
  - Medir sensibilidad y especificidad **por grupo**, no solo en general.
  - Preferir modelos **interpretables** para poder auditar.

**Ojo:** "mencionar" = 1 punto. Para el 2 hay que **nombrar el atributo y la estrategia aplicada**: "elimino nombre y DNI, generalizo la edad en rangos de 10 años, saco *barrio* porque correlaciona con *ingreso* y verifico que la sensibilidad sea similar para hombres y mujeres".

📖 [[Preguntas de ejemplo del parcial - Ciencia de Datos#RA 2 — Conocimiento y preparación de los datos|Ejemplo 5 (ética)]]

---

## RA3 — Algoritmos de minería
*Examen y TP · 8 puntos en cada uno*

### 3.1 Asociación problema–modelo
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No asocia el problema de negocio con ningún tipo de modelo o patrón | Asocia correctamente pero **sin justificar** la elección según el dato o el problema | **Justifica** la elección del tipo de modelo según las características **del problema y del dato** |

**Qué saber — guía de decisión:**

| Si el problema… | Tipo | Técnicas vistas |
|---|---|---|
| Predice un **número** y hay datos etiquetados | Supervisado — **regresión** | Regresión lineal |
| Predice una **categoría** y hay datos etiquetados | Supervisado — **clasificación** | Árboles (ID3, CART, C4.5), regresión logística, K-NN, Bayes, SVM |
| Busca **grupos** sin etiqueta | No supervisado — **agrupamiento** | K-Means (k conocido, formas esféricas), DBSCAN (formas arbitrarias, ruido) |
| Busca qué cosas **aparecen juntas** | No supervisado — **asociaciones** | A-priori |
| Busca casos **raros** (fraude, fallas) | **Detección de anomalías** | Boxplot / 3σ, clustering, LOF |
| Trabaja sobre **texto** | **Minería de texto** + lo anterior | TF-IDF + clasificador o clustering |
| **Recomienda** items | **Sistemas recomendadores** | Colaborativo, contenido, popularidad, factorización |

**Ojo:**
- Justificá siempre con el dato: **¿hay etiqueta? ¿de qué tipo es la salida? ¿hace falta interpretabilidad** (inferencia) o solo predecir?
- **Números que son categorías** (genes en {1, 2, 3, 4}) → clasificación, no regresión (parcial P6).
- "Asociar" en el enunciado no siempre significa reglas de asociación.

📖 [[Preguntas de ejemplo del parcial - Ciencia de Datos#Parcial 2025 — resoluciones de alumnos|Parcial P6]] · [[Preguntas de ejemplo del parcial - Ciencia de Datos#P3. Problema de negocio con regresión sobre texto|Parcial P3]]

### 3.2 Construcción de modelos: al menos 2 modelos distintos
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| Construye solo un modelo o ninguno funcional | Construye dos modelos pero **sin ajuste de parámetros ni validación cruzada** | Construye **2 o más modelos** con **validación cruzada** y **ajuste de hiperparámetros** |

**Qué saber:**
- **Partición:** train/test con muestreo **estratificado**.
- **Validación cruzada:** K-folds y LOOCV.
- **Hiperparámetros** de cada técnica:
  - *k* en K-Means y K-NN;
  - profundidad del árbol;
  - ε y MinPts en DBSCAN;
  - min_sup y min_conf en A-priori;
  - min_df y n-gramas en TF-IDF.
- **Evitar la fuga de información:** el preprocesamiento va **dentro** de cada fold (📓 el TF-IDF dentro del *pipeline* en el notebook de minería de texto).

**Ojo:** en el TP es literal, **mínimo 2 modelos**. En el examen, cuando pregunten cómo resolverías un caso, proponé **dos modelos** y decí que los comparás con validación cruzada y ajustando hiperparámetros.

📖 [[Resumen Ciencia de Datos#6. Modelado — Validación|Resumen U6]]

### 3.3 Evaluación y comparación: métricas, trade-off bias–varianza
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| No evalúa ni compara los modelos construidos | Aplica métricas pero **no compara** modelos entre sí **ni analiza el trade-off bias–varianza** | Compara modelos con **métricas adecuadas al problema** y **analiza el bias–varianza** |

**Qué saber:**
- **Clasificación:** matriz de confusión, accuracy, **sensibilidad**, **especificidad**.
- **Regresión:** MSE / RSS.
- **Clustering:** silueta, SSE y método del codo.
- **Asociaciones:** soporte, confianza, lift.
- **Bias alto** = underfitting; **varianza alta** = overfitting. Se ven comparando el desempeño en **train vs test**.

**Ojo:**
- La métrica se **justifica por el negocio**: ¿qué cuesta más, un falso negativo o un falso positivo?
- La accuracy engaña con clases desbalanceadas.
- **Siempre comentá train vs test.** Ejemplo del notebook: el árbol da 0,998 en train y 0,761 en test → varianza alta; la regresión logística da 0,934 y 0,885 → mejor equilibrio.

📖 [[Resumen Ciencia de Datos#5. Modelado — Clasificación|Resumen U5]]

### 3.4 Comunicación de resultados: respuesta al problema del negocio
| No logrado (0) | Parcial (1) | Logrado (2) |
|---|---|---|
| Los resultados no responden al problema planteado o no se comunican | Presenta resultados técnicos **sin traducirlos al lenguaje del negocio** o la audiencia | Comunica resultados en **lenguaje adecuado a la audiencia** y los **vincula al problema de negocio** |

**Qué saber:** la fase de **Implementación** (informes, herramientas para decidir). Traducir métricas a consecuencias: "sensibilidad 0,95" → "de cada 100 piezas falladas, el sistema separa 95; las otras 5 llegan al cliente".

**Ojo:** cerrá cada respuesta de modelado con **qué recibe el cliente y qué significa para su negocio**. La pregunta de ejemplo 6 lo pide explícitamente ("¿Qué tipo de solución se le presentará al cliente?"). En el coloquio pesa mucho.

📖 [[Preguntas de ejemplo del parcial - Ciencia de Datos#RA 3 — Modelado|Ejemplo 6]]

---

## Mapa criterio → preguntas de práctica

| Criterio | Preguntas de ejemplo | Parcial 2025 | Preguntas de estudio |
|---|---|---|---|
| 1.1 CRISP-DM vs KDD | 1 | P7 | U1 |
| 1.2 Fases y retroalimentación | — | P1, P5 | U1 |
| 1.3 Justificación del marco | 1 | P4 | U1 |
| 2.1 Descripción y visualización | 2 | P1 | U2 |
| 2.2 Detección de problemas | 3 | — | U2, U9 |
| 2.3 Limpieza y transformación | 4 | P2 | U3, U10 |
| 2.4 Ética y seguridad | 5 | — | *(no hay)* |
| 3.1 Problema–modelo | 6 | P3, P6 | U4, U5, U7–U11 |
| 3.2 Construcción (≥ 2 modelos) | 6 | — | U6 |
| 3.3 Evaluación y bias–varianza | 6 | — | U5, U6 |
| 3.4 Comunicación | 6 | — | *(no hay)* |

La pregunta de ejemplo **6** (piezas defectuosas) toca **los 4 criterios del RA3** en 10 líneas: es la más completa para practicar. Los criterios **2.4** y **3.4** son los que menos práctica tienen.

---

## Qué tener en cuenta

1. **Rendí el examen teórico sí o sí.** Aunque no llegues al 16, es lo que habilita la aprobación indirecta en el final.
2. **Con todo "parcial" no se aprueba.** En el examen necesitás al menos 5 criterios logrados. Mejor responder algo en todo (un criterio en blanco vale 0) y desarrollar bien los que mejor sabés.
3. **"Parcial" casi siempre significa correcto pero sin justificar o sin ejemplo.** La rúbrica premia **justificar** (por el dato, por el modelo, por el negocio) y dar **ejemplos concretos**.
4. **Respetá los límites de líneas** ("no escriba más de 5 líneas").
5. **Honestidad intelectual:** el parcial 2025 aclaraba que el uso de IA generativa se sanciona según la Ordenanza 613 (art. 2, inc. b).
6. **El coloquio es grupal** y pregunta sobre el TP y sobre la materia en general: todos tienen que poder explicar todo el TP.

### Checklist del TP integrador (RA2 + RA3, aprueba con 12/16)
- [ ] Informe de conocimiento: estadísticos y visualización **según el tipo** de cada atributo (2.1)
- [ ] Problemas de calidad (faltantes, anomalías, sesgos) con **gráfico + número** como evidencia (2.2)
- [ ] Preprocesamiento **justificado por el dato y por el modelo**, incluyendo muestreo (2.3)
- [ ] Atributos sensibles identificados + **anonimización** aplicada + control de **sesgo** (2.4)
- [ ] Problema de negocio asociado al tipo de modelo, **con justificación** (3.1)
- [ ] **≥ 2 modelos** con **validación cruzada** y **ajuste de hiperparámetros** (3.2)
- [ ] Comparación con **métricas adecuadas** + análisis **bias–varianza** (train vs test) (3.3)
- [ ] Conclusiones **en lenguaje del negocio**, vinculadas al problema (3.4)

---

## Temas del programa que no están en las diapos
*(complemento)* El programa analítico los nombra, pero no aparecen (o aparecen solo de pasada) en las diapositivas.

- **ETL vs ELT** (U2):
  - **ETL** (*Extract, Transform, Load*): se extraen los datos de las fuentes, se **transforman antes** (limpieza, integración, formato) y se cargan ya preparados en el data warehouse. Es el enfoque clásico con datos estructurados.
  - **ELT** (*Extract, Load, Transform*): se cargan los datos **crudos** en el destino (data lake o warehouse en la nube) y se transforman **ahí**, cuando se necesitan. Escala mejor y conserva el dato original.
- **Gobernanza de datos** (U2): políticas, roles (dueño del dato, responsable de su calidad), estándares y procesos que aseguran la **calidad, seguridad, privacidad y uso correcto** de los datos en la organización. Conecta con los criterios 2.2 y 2.4.
- **Datos dependientes y no dependientes** (U2, Aggarwal cap. 1):
  - **No dependientes:** cada registro es independiente de los demás (una tabla de clientes).
  - **Dependientes:** hay relaciones entre registros: **series de tiempo**, secuencias, datos espaciales, grafos y redes. El orden o la vecindad importan y no se pueden mezclar libremente al muestrear.
- **Supuestos de la regresión lineal** (U3):
  - **linealidad** de la relación;
  - **independencia** de los errores;
  - **homocedasticidad** (varianza constante de los residuos);
  - **normalidad** de los residuos;
  - poca **multicolinealidad** entre predictores.
- **Modelos naive / valor esperado** (U3): el modelo más simple posible, que sirve de **línea base**. En regresión predice siempre el **promedio**; en clasificación, siempre la **clase mayoritaria**. Un modelo que no supera a la línea base no aporta nada. Con clases desbalanceadas, la línea base ya tiene accuracy alta, y por eso la accuracy engaña.
- **Sistema basado en popularidad** (U3, semana 12): recomienda a todos lo **más visto o mejor puntuado**. No es personalizado, pero no necesita historial del usuario, así que sirve para el **cold start**.
