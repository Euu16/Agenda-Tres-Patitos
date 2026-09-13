# Matriz de Trazabilidad

| Req. | Fase | Tarea | Estado |
|---|---|---|---|
| RF-08 | 1. Modelo Conceptual | Definir la entidad ubicaciones y sus atributos (id_ubicacion, nombre, direccion, ciudad, capacidad). | Completado |
| RF-08 | 2. Modelo Lógico | Estructurar la tabla relacional ubicaciones. | Completado |
| RF-08 | 3. Modelo Físico | Codificar el CREATE TABLE ubicaciones en PostgreSQL. | Completado |
| RF-08 | 4. Interfaz Gráfica | Desarrollar pestaña y formulario CRUD de ubicaciones. | Completado |
| RF-09 | 1. Modelo Conceptual | Relación de cardinalidad entre Eventos y ubicaciones. | Completado |
| RF-09 | 2. Modelo Lógico | Incorporar id_ubicacion como FK en eventos. | Completado |
| RF-09 | 3. Modelo Físico | Añadir la relación referencial en PostgreSQL. | Completado |
| RF-09 | 4. Interfaz Gráfica | Selectores para consultar histórico por ubicación. | Completado |
| RF-10 | 3. Modelo Físico | Consultas para el ranking de recintos más solicitados. | Completado |
| RF-10 | 4. Interfaz Gráfica | Panel de reportes de solo lectura. | Completado |
| RF-11 | 1. Modelo Conceptual | Definir disponibilidades y catálogo tipos_disponibilidad. | Completado |
| RF-11 | 2. Modelo Lógico | Tablas relacionales para disponibilidad con FK a usuarios. | Completado |
| RF-11 | 3. Modelo Físico | Creación de tablas y catálogos en PostgreSQL. | Completado |
| RF-11 | 4. Interfaz Gráfica | Módulo CRUD de disponibilidad. | Completado |
| RF-12 | 3. Modelo Físico | Consultas para detectar cruces/traslapes temporales. | Completado |
| RF-12 | 4. Interfaz Gráfica | Salidas analíticas de usuarios libres en rango horario. | Completado |
| RF-15 | 1. Modelo Conceptual | Definir tareas vinculada a eventos. | Completado |
| RF-15 | 2. Modelo Lógico | FKs entre tarea, evento y usuario responsable. | Completado |
| RF-15 | 3. Modelo Físico | Crear tabla tareas con restricciones de estado. | Completado |
| RF-15 | 4. Interfaz Gráfica | Formularios CRUD completo de tareas. | Completado |
| RF-16 | 3. Modelo Físico | Consultas de tareas pendientes/vencidas por usuario. | Completado |
| RF-16 | 4. Interfaz Gráfica | Desplegar métricas en pantalla. | Completado |
| RF-17 | 3. Modelo Físico | Consulta de reporte cuantitativo de tareas activas/vencidas. | Completado |
| RF-17 | 4. Interfaz Gráfica | Reporte de seguimiento en el módulo de tareas. | Completado |