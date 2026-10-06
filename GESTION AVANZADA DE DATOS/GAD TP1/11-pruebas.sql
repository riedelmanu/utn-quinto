-- =============================================================
-- TP I - SQL Avanzado
-- Pruebas de todas las funciones y procedimientos
-- =============================================================

\echo '===== EJERCICIO 12.a - Alumnos que cursan la carrera 1 al 2025-06-01 ====='
SET search_path TO public;
SELECT alumnos_en_carrera(1, '2025-06-01') AS cantidad;

\echo '===== EJERCICIO 12.b - Costo total de la carrera 1 ====='
SELECT costo_de_carrera(1) AS costo_total;

\echo '===== EJERCICIO 12.c y 12.d - Promedios de Tomás Aguirre (idPersona 3) ====='
SELECT promedio_aprobados(3, 1) AS solo_aprobados,
       promedio_general(3, 1)   AS todas_las_notas;

\echo '===== EJERCICIO 12.e - Documento del alumno ED-0005 ====='
SELECT * FROM documento_de_alumno('ED-0005');

\echo '===== EJERCICIO 12.f - Aprobados de la materia 1 durante 2024 ====='
SELECT * FROM aprobados_entre_fechas(1, '2024-01-01', '2024-12-31');

\echo '===== EJERCICIO 12.g - Materias requeridas para cursar la materia 8 ====='
SELECT * FROM materias_requeridas(8);

\echo '===== EJERCICIO 12.h - Costo pendiente de ED-0001 para cursar la materia 8 ====='
SELECT costo_pendiente_para_cursar('ED-0001', 8) AS costo_pendiente;


SET search_path TO universidad;

\echo '===== EJERCICIO 14 - listar_alumnos_por_nota(6) ====='
SELECT * FROM listar_alumnos_por_nota(6);

\echo '===== EJERCICIO 15 - obtener_promedio: alumno con notas y alumno sin notas ====='
SELECT obtener_promedio(1) AS promedio_ana;
SELECT obtener_promedio(2) AS promedio_luis;

\echo '===== EJERCICIO 16 - clasificar_nota ====='
SELECT n AS nota, clasificar_nota(n) AS clasificacion
FROM (VALUES (9.5), (7.0), (5.0), (2.0)) AS t(n);

\echo '===== EJERCICIO 17 - generar_reporte_inscripciones ====='
CALL generar_reporte_inscripciones();

\echo '===== EJERCICIO 18 - inscribir_alumno: alta OK, duplicada y FK inexistente ====='
SELECT inscribir_alumno(2, 1, 7.5) AS alta_correcta;
SELECT inscribir_alumno(1, 1)      AS ya_inscripto;
SELECT inscribir_alumno(99, 1)     AS alumno_inexistente;

\echo '===== EJERCICIO 19 - actualizar_columna_segura ====='
SELECT actualizar_columna_segura('alumnos', 'nombre', 'Ana García (editado)', 1) AS una_fila;
SELECT actualizar_columna_segura('alumnos', 'nombre', 'X', 999)                  AS ninguna_fila;
SELECT actualizar_columna_segura('tabla_que_no_existe', 'nombre', 'X', 1)        AS tabla_inexistente;

\echo '===== EJERCICIO 20 - buscar_por_texto(''matem'') ====='
SELECT * FROM buscar_por_texto('matem');

\echo '===== EJERCICIO 21 - migrar_alumnos_antiguos(2024-01-01) ====='
SELECT id, nombre, fecha_ingreso FROM alumnos ORDER BY id;
CALL migrar_alumnos_antiguos('2024-01-01');
\echo '-- alumnos que quedan:'
SELECT id, nombre, fecha_ingreso FROM alumnos ORDER BY id;
\echo '-- alumnos_historicos:'
SELECT * FROM alumnos_historicos ORDER BY id;


SET search_path TO integrador;

\echo '===== EJERCICIO 22 - Libros cargados ====='
SELECT id, titulo, isbn, generos, (ubicacion).sala AS sala, ejemplares FROM libros ORDER BY id;

\echo '===== EJERCICIO 22 - registrar_prestamo: OK, sin stock, socio y libro inexistentes ====='
SELECT registrar_prestamo(1, 1)  AS prestamo_ok;
SELECT registrar_prestamo(1, 3)  AS sin_ejemplares;
SELECT registrar_prestamo(99, 1) AS socio_inexistente;
SELECT registrar_prestamo(1, 77) AS libro_inexistente;

\echo '===== EJERCICIO 22 - libros_por_genero(''novela'') : array + JSONB ====='
SELECT * FROM libros_por_genero('novela');

\echo '===== EJERCICIO 22 - contar_filas_por : SQL dinámico ====='
SELECT contar_filas_por('libros', 'ejemplares', '0')  AS libros_sin_stock;
SELECT contar_filas_por('socios', 'nombre', 'Ana García') AS socios_ana;
SELECT contar_filas_por('tabla_mala', 'x', '1')       AS tabla_inexistente;
