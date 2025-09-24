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