# Agenda Digital "Tres Patitos" — Proyecto 1

Extension de la base de datos y la interfaz grafica de la Agenda Digital Tres Patitos, agregando tres módulos nuevos sobre el sistema base proporcionado por el curso.

## Módulos implementados

- Gestión de Ubicaciones (RF-08 a RF-10)
- Disponibilidad de Usuarios y Gestión de Tiempos (RF-11 y RF-12)
- Tareas Asociadas a Eventos (RF-15 a RF-17)

## Estructura del repositorio

agenda-tres-patitos/
├── script.sql # Script base del profesor (nucleo del sistema)
├── extension_modulos.sql # Script de los 3 modulos nuevos
├── agenda.py # Interfaz grafica (Python + customtkinter)
└── docs/
├── modelo-conceptual-y-logico.md
├── diagrama-chen.png
├── Matriz-de-Trazabilidad.md
├── evidencias-gui.md
└── capturas/

## Requisitos previos

- PostgreSQL 18 (o superior)
- Python 3.10 (o superior)
- Librerias de Python:
```bash
  pip install customtkinter psycopg2-binary tkcalendar
```