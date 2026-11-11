---
materia: GESTION AVANZADA DE DATOS
entrega: 
estado: resuelto
tipo: tp
tags: [tp, similitud]
---
# TP6 - Extracción de características

Volver a [[GESTION AVANZADA DE DATOS]]

## Consigna
Trabajo Práctico III de búsquedas por similitud: preprocesamiento y extracción de características de imágenes, textos y sonidos.
- Ej 1: tres colecciones (6 objetos con 18 + 6 fotos, 12 documentos y 6 consultas, 4 frases con 12 + 4 audios), manifiesto y relevancia.
- Ej 2 y 3: imágenes con píxeles, histograma de 25 colores y ResNet50 (layer2 y layer4).
- Ej 4 a 6: texto con tokenización, stemming, bolsa de palabras, TF-IDF y BGE-M3.
- Ej 7 y 8: sonido con MFCC (resumen de 26 y secuencias con DTW) y wav2vec 2.0.
- Interpretación de las representaciones acústicas y Ej 9: métricas P@3 y R@3, tiempos, almacenamiento y elección.

## Archivos
- `TP6-Extraccion-de-caracteristicas-resuelto.pdf`: resolución.
- `TP6-Extraccion-de-caracteristicas.ipynb`: notebook con las consignas, el código y las respuestas.
- `datos/`: originales, procesados, características, resultados, manifiesto y relevancia.
- `2026_Similitud - Practico 3 - Extraccion de Caracteristicas.pdf`: enunciado.

## Datos
- Fotos: objetos del dataset COIL-100 pegados sobre fondos distintos (aro, morrón y barco, en dos colores cada uno).
- Audios: voz Eddy del sintetizador de macOS, cada repetición a otra velocidad.
- Si se cambian por fotos y grabaciones propias con los mismos nombres, el notebook corre igual, pero el análisis del PDF habría que reescribirlo.

## Avance
- [x] Resolver los nueve ejercicios y la interpretación
- [ ] Revisar y entregar
