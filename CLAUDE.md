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
