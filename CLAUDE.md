# Vault de Obsidian — UTN

Esta carpeta es a la vez un vault de Obsidian y el espacio de trabajo de Claude Code.

## Convenciones para notas
- Notas en Markdown (`.md`), en español.
- Usar enlaces de Obsidian `[[Nombre de nota]]` (no links Markdown relativos) entre notas.
- Cada materia tiene una nota índice `MATERIA/MATERIA.md`; enlazar ahí las notas nuevas de esa materia.
- `Inicio.md` es la nota principal del vault.
- Frontmatter YAML con al menos `tipo` (clase | tp | materia | resumen) y `materia`.
- Plantillas en `_Plantillas/` (Clase, TP).
- Tareas con checkboxes `- [ ]`.

## No tocar
- `.obsidian/` salvo que se pida explícitamente.
- `.venv/`, `data/` y el repo git de `CIENCIA DE DATOS/ciencia-de-datos`.

## Ciencia de Datos
- Diapositivas en `CIENCIA DE DATOS/Diapositivas/<n>. <Unidad>/`; resumen en `CIENCIA DE DATOS/Resumen Ciencia de Datos.md`.
- `CIENCIA DE DATOS/ciencia-de-datos/` es un repo compartido: nunca guardar ahí diapositivas, resúmenes ni notas personales.

## Sincronización (GitHub)
- Este vault está en el repo privado https://github.com/riedelmanu/utn-quinto (rama `main`), usado para sincronizar dos computadoras.
- Al empezar a trabajar: `git pull`. Después de crear o modificar notas/archivos: commit con mensaje descriptivo en español y `git push`.
- `CIENCIA DE DATOS/ciencia-de-datos/` es un **submódulo** (repo compartido https://github.com/riedelmanu/ciencia-de-datos). Sus cambios se commitean y pushean dentro de esa carpeta; en el repo del vault solo se actualiza el puntero del submódulo.
- Clonar en otra computadora: `git clone --recurse-submodules https://github.com/riedelmanu/utn-quinto`. Actualizar: `git pull --recurse-submodules`.

## Investigación Operativa
- Todo lo del 2° parcial (PNL y Pronósticos) va en `INVESTIGACION OPERATIVA/Parcial 2/`: notas en la raíz de esa carpeta, material de la cátedra en `Material de cátedra/`, libros y resúmenes de otros alumnos en `Libros y resúmenes/`. La nota índice es `Parcial 2.md`.
- Todo lo del 3er parcial (Modelos de stock / inventarios) va en `INVESTIGACION OPERATIVA/Parcial 3/` con la misma estructura (`Material de cátedra/`, `GeoGebra/`, `img/`). La nota índice es `Parcial 3.md`. Los libros y resúmenes de otros alumnos siguen en `Parcial 2/Libros y resúmenes/`.
- En preguntas de práctica, las respuestas van en callouts plegados (`> [!check]- Ver respuesta`).
