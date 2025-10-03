/* DDL create-alter-drop-truncate-Rename*/
/* Crear BD*/
create database BDMascotas; 
/* Drop BD*/
drop database BDMascotas;
/* habilitar la BD*/
use bdmascotas;
/* creación de tablas nombre tabls atributos restricciones relacion*/

create table Mascota (
idMascota int primary key auto_increment,
nombreMascota varchar(50) not null, 
raza varchar (25) not null,
generoMascota varchar(25) not null,
tipoMascota varchar(25) not null,
fechaCreacion timestamp default current_timestamp
);
/* describe*/
describe mascota;

CREATE TABLE Cliente (
    documentoCliente varchar (50)  primary key,
    nombreCliente1 VARCHAR(50) NOT NULL,
	nombreCliente2 VARCHAR(50)  NULL,
    apellidoCliente1 varchar (50) not null,
    apellidoCliente2 varchar(50) null,
    direccionCliente VARCHAR(50)
    );


CREATE TABLE Vacuna (
    idVacuna INT AUTO_INCREMENT PRIMARY KEY,
    nombreVacuna VARCHAR(50) NOT NULL,
    fechaRegistro DATE
);

CREATE TABLE VacunaMascota (
    idVacunaMascota INT AUTO_INCREMENT PRIMARY KEY,
    idMascota INT NOT NULL,
    idVacuna INT NOT NULL,
    fechaAplicacion DATE,
    FOREIGN KEY (idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (idVacuna) REFERENCES Vacuna(idVacuna)
);
/* alteraciones */ 
alter table mascota add column documentoClienteFk varchar(50);
alter table mascota modify column documentoClienteFk int;
alter table 
/* relaciones*/

add constraint fKClienteMascota
foreign key (documentoClientefK)
references cliente(documentoCliente);
alter table vacuna add column numLote varchar(50) not null;

use bdmascotas;
describe mascota;

insert into mascota (idMascota, nombreMascota, raza, generoMascota, tipoMascota, fechaCreacion) 
values(" ", "Lulu", "persa", "femenino", "gato", "2025-09-22"),
(" ", "Mechas", "egipcio", "macho", "gato", "2025-09-20"),
(" ", "Buñuelo", "pug", "macho", "perro", "2025-09-21"),
(" ", "Capuchino", "chinchilla", "hembra", "chinchilla", "2025-09-19");
select * from mascota;
select * from mascota where nombreMascota like '%a%';
select * from mascota where nombreMascota like 'Lu%';

describe vacuna;
insert into vacuna (idVacuna, nombreVacuna, fechaRegistro, numLote)
values(" ", "Rabia", "2024-09-22", "128"),
(" ", "Moquillo", "2024-10-18", "222"),
(" ", "Parvovirosis", "2024-02-22", "325"),
(" ", "Hepatitis", "2024-09-25", "489"),
(" ", "Leptospirosis", "2024-08-10", "565");
select * from vacuna;
select * from mascota where nombreMascota='Lulu';
select * from mascota where nombreMascota!='Lulu';
select * from mascota where raza in ('persa','egipcio');
select * from mascota where raza='gato' or generoMascota='femenino';
select * from mascota order by nombreMascota asc;
select * from mascota group by raza; 

select min(numLote) as 'menorlote' from vacuna;
select sum(numLote) as 'totalLote' from vacuna;

select avg(numLote) as 'promedioLote' from vacuna;
select categoria, avg(precio) as 'promedioPrecio'
from producto
group by categoria
having avg(precio)>200;
use bdmascotas;
/*Modificaciones update sintaxis:
update nombretabla set campo=valor, campo1=valor1 where condicion
en un campo cambiemos varios registros y en un registro cambiemos varios campos*/
select * from mascota;
update mascota set nombreMascota= 'copo' where idMascota=1;
update mascota set raza='persa', generoMascota='femenino' where idMascota=2;
update mascota set nombreMascota='Mishi' where idMascota= 1 or idMascota= 2 ;
/*Delete
sintaxis delete from nombreTabla where condicion begin rollback commit
reglas acid= atomicidad, consistencia, aislamiento, durabilidad 
-begin-commit-rollback*/
start transaction;
delete from mascota where idMascota=1;
commit;

start transaction;
delete from mascota where idMascota=1;
rollback;

select * from mascota

insert into mascota (idMascota, nombreMascota, raza, generoMascota, tipoMascota, fechaCreacion) 
values(" ", "Lulu", "persa", "femenino", "gato", "2025-09-22"),
(" ", "Mechas", "egipcio", "macho", "gato", "2025-09-20");

show variables like 'autocommit';
show processlist; 
select * from information_schema.innodb_trx;
show binary logs;
/* views- triggers- procedimientos almacenados
create view nombreVista as select campos from tabla where condicion;
select * from nombrevists

vista que muestre clientes y el nombre de la mascota asociada */
create view vistaMascota as select m.nombreMascota as 'nombre Mascota', m.raza as 'tipo mascota' from mascota m;
select * from vistaMascota;

create view vistaCliente as select c. documentoCliente, m.nombreMascota as 'Nombre Mascota' from cliente c inner join m.nombreMascota as 'Nombre Mascota' from mascota m;





 

