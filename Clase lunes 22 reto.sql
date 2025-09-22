create database ventasTienda;

use ventasTienda;

create table cliente(
idCliente int auto_increment primary key,
documentoCliente varchar(50) not null,
nombreCliente varchar(50) not null, 
email varchar(50) unique,
telefono varchar(50),
fechaReistro timestamp default current_timestamp
);

alter table cliente add direccionCliente varchar(200);
alter table cliente modify telefono varchar(15) not null;
describe cliente;
alter table cliente drop column direccionCliente;
describe cliente;
alter table cliente change email emailCliente varchar(50) unique;

create table pedido(
idPedido int auto_increment primary key,
idClienteFK int,
fechaPedido date,
totalPedido decimal (10,2)
);
alter table pedido
add constraint FKclientepedido
foreign key (idClienteFk)
references cliente(idCliente);

drop table pedido;
drop table cliente;

create table usuario(
idUsuario int auto_increment primary key,
nombreUsuario varchar(50) not null,
email varchar(50) unique
);

alter table cliente add idUsuarioFK int;
alter table cliente
add constraint FKusuariocliente
foreign key (idUsuarioFK)
references usuario(idUsuario);

use ventasTienda;
describe cliente;
insert into cliente (idCliente, documentoCliente, nombreCliente, email, telefono, fechaReistro) 
values(" ", "1015639424", "Juan Jose Ramirez", "juan@gmail.com", "3202050999", "2025-09-22"),
(" ", "1015639524", "Juan Mora", "juanmor@gmail.com", "3202070999", "2025-09-20"),
(" ", "1022639424", "Juanita Ramirez", "juanitar@gmail.com", "3222050999", "2025-09-21"),
(" ", "1015639596", "Valentina Suarez", "valensuar@gmail.com", "3112050999", "2025-09-22"),
(" ", "1015639424", "Juan Jose Ramirez", "juan@gmail.com", "3202050999", "2025-09-22");

select * from cliente;
select * from pedido;
insert into usuario
values(" ", 





