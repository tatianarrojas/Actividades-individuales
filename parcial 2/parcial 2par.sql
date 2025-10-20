create database BD_TechNova;
use BD_TechNova;
CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);
CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamento INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamento INT,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
id_proyecto INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);
/*Inserciones para las tablas*/
describe departamento;
insert into Departamento(id_departamento, nombre, presupuesto)
values(" ", "Ventas", 12033),
(" ", "Marketing", 11500),
(" ", "Recursos humanos", 10200);
select * from departamento;
describe empleado;
insert into Empleado(id_empleado, nombre, cargo, salario, id_departamento, fecha_ingreso)
values(" ", "Juan Perez", "Gerente ventas", 150, 1, "2022-09-22"),
(" ", "Diana Carvajal", "Asesora de ventas", 110, 1, "2023-07-24"),
(" ", "Nerea Gomez", "Creativa", 125, 2, "2024-03-22"),
(" ", "Andres Diaz", "Comunnity Manager", 110, 2, "2024-09-10"),
(" ", "Ariana Grande", "Psicologa", 120, 3, "2025-01-02");

describe proyecto;
insert into Proyecto(id_proyecto, nombre, fecha_inicio, presupuesto, id_departamento)
values(" ", "Fiesta Navidad", "2025-10-01", 60, 3),
(" ", "Campaña Instagram", "2025-03-10", 150, 2),
(" ", "Renovacion Oracle", "2025-04-10", 200, 1);
select * from proyecto;
insert into Proyecto (id_proyecto, nombre, fecha_inicio, presupuesto, id_departamento)
values(" ", "Actualización credenciales", "2025-10-01", 60, 1);

describe Asignacion;
insert into Asignacion(id_asignacion, id_empleado, id_proyecto, horas_trabajadas)
values(" ", 2, 3, 672),
(" ", 1, 3, 672),
(" ", 3, 2, 1008),
(" ", 4, 2, 1008),
(" ", 5, 1, 84);

/* Reto 14 Control de proyectos */
/* Subconsulta proyectos sin asignar*/
select p.nombre, p.id_proyecto, a.id_proyecto 
from Proyecto p 
left join Asignacion a on p.id_proyecto = a.id_proyecto 
where a.id_proyecto is null;
/*Procedimiento: EliminarProyectosInactivos() */

Delimiter $$
create procedure EliminarProyectosInactivos(in id_proyecto int)
begin
    declare v_id int;
     select a.id_proyecto into v_id
    from asignacion a
    where a.id_proyecto = id_proyecto
    limit 1;
    
    if v_id is null then
        delete from proyecto 
        where id_proyecto = id_proyecto;
	end if;
end$$
delimiter ;

call EliminarProyectosInactivos(1);

/* crear trigger: AFTER DELETE registrar acción*/
/*primero creamos la tabla de proyectos eliminados*/
create table proyectoEliminado (Proyecto 
old.id_proyecto INT,
old.nombre VARCHAR(100),
old.fecha_inicio DATE,
old.presupuesto DECIMAL(12,2),
old.id_departamento INT,
fecha_eliminado date
);

Delimiter $$
Create trigger afterdelete_registrar
after delete on proyecto
for each row
begin
	insert into proyectosEliminados values (old.id_proyecto, old.nombre, old.fecha_inicio, old.presupuesto, now());
end;
$$
Delimiter 

/*Crear transaccion*/

start transaction;
delete from proyecto where id_proyecto=4;
rollback;



