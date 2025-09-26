create database TechCorp;
use TechCorp;
create table empleados(
idEmpleado int primary key auto_increment,
nombre varchar(50) not null,
edad int not null, 
salario varchar(100) not null, 
fecha_ingreso date not null, 
area varchar(100) not null
);

insert into empleados (idEmpleado, nombre, edad, salario, fecha_ingreso, area)
values(" ", "Juan Pérez", 32, 3800, "2019-06-15", "Ventas"),
(" ", "Ana Gómez", 45, 5500, "2018-08-01", "IT"),
(" ", "Carlos Rodríguez", 28, 3200, "2022-03-10", "Recursos Humanos"),
(" ", "María Sánchez", 35, 4600, "2020-02-25", "Ventas"),
(" ", "Laura Martínez", 39, 4800, "2021-05-30", "Marketing");

select nombre, edad, salario from empleados;
select * from empleados where salario>4000;
select * from empleados where area = "Ventas";
select * from empleados where edad between 30 and 40;
select * from empleados where fecha_ingreso> "2020-12-31";


