set search_path to prototipo, public;

-- Modulo 1: gestion de ubicaciones (rf-08, rf-09, rf-10)

create table ubicaciones (
    id_ubicacion serial primary key,
    nombre varchar(100) not null,
    direccion varchar(150) not null,
    ciudad varchar(50) not null,
    capacidad int not null check (capacidad > 0)
);

-- rf-09: asociar eventos a una ubicacion
alter table eventos
    add column id_ubicacion int references ubicaciones(id_ubicacion);

-- rf-09: prevenir eventos simultaneos en la misma ubicacion
create or replace function evitar_traslape_ubicacion()
returns trigger as $$
begin
    if new.id_ubicacion is not null and exists (
        select 1 from eventos
        where id_ubicacion = new.id_ubicacion
          and id_evento <> coalesce(new.id_evento, -1)
          and fecha_inicio < new.fecha_fin
          and fecha_fin > new.fecha_inicio
    ) then
        raise exception 'Ya existe un evento programado en esta ubicacion en ese horario.';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_evitar_traslape_ubicacion
before insert or update on eventos
for each row execute function evitar_traslape_ubicacion();

-- rf-10: ranking de ubicaciones mas solicitadas
create view vista_ranking_ubicaciones as
select
    u.id_ubicacion,
    u.nombre,
    u.ciudad,
    count(e.id_evento) as total_eventos
from ubicaciones u
left join eventos e on e.id_ubicacion = u.id_ubicacion
group by u.id_ubicacion, u.nombre, u.ciudad
order by total_eventos desc;


-- Modulo 2: disponibilidad de usuarios (rf-11, rf-12)

create table tipos_disponibilidad (
    id_tipo serial primary key,
    nombre varchar(20) not null unique
);

insert into tipos_disponibilidad (nombre) values
    ('Disponible'), ('Ocupado'), ('No_disponible');

create table disponibilidades (
    id_disponibilidad serial primary key,
    id_usuario int not null references usuarios(id_usuario),
    fecha date not null,
    hora_inicio time not null,
    hora_fin time not null,
    id_tipo int not null references tipos_disponibilidad(id_tipo),
    constraint check_horas_disponibilidad check (hora_fin > hora_inicio)
);

-- rf-12: funcion para saber si un usuario esta libre en un rango de horario
create or replace function usuario_disponible(
    p_id_usuario int, p_fecha date, p_hora_inicio time, p_hora_fin time
) returns boolean as $$
declare
    conflicto boolean;
begin
    select exists (
        select 1 from disponibilidades d
        join tipos_disponibilidad t on t.id_tipo = d.id_tipo
        where d.id_usuario = p_id_usuario
          and d.fecha = p_fecha
          and t.nombre in ('Ocupado', 'No_disponible')
          and d.hora_inicio < p_hora_fin
          and d.hora_fin > p_hora_inicio
    ) into conflicto;
    return not conflicto;
end;
$$ language plpgsql;


-- Modulo 3: tareas asociadas a eventos (rf-15, rf-16, rf-17)

create table tareas (
    id_tarea serial primary key,
    id_evento int not null references eventos(id_evento) on delete cascade,
    id_usuario_responsable int references usuarios(id_usuario),
    titulo varchar(100) not null,
    descripcion text,
    prioridad varchar(10) not null default 'Media'
        check (prioridad in ('Alta','Media','Baja')),
    estado varchar(20) not null default 'Pendiente'
        check (estado in ('Pendiente','En_progreso','Completada','Cancelada')),
    fecha_limite date
);

-- rf-16 / rf-17: vista de carga de trabajo y tareas vencidas por usuario
create view vista_tareas_pendientes_por_usuario as
select
    u.id_usuario,
    u.nombre,
    u.apellido,
    count(*) filter (where t.estado in ('Pendiente','En_progreso')) as tareas_activas,
    count(*) filter (
        where t.estado not in ('Completada','Cancelada')
          and t.fecha_limite < current_date
    ) as tareas_vencidas
from usuarios u
left join tareas t on t.id_usuario_responsable = u.id_usuario
group by u.id_usuario, u.nombre, u.apellido;