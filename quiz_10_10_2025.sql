use bdmascotas;
/* 1.incluir en la tabla vacuna el campo para la fecha de vigencia de la vacuna 
2. Crear una funcion para saber si la vacuna esta vigente o esta vencida
2. crear función para mostrar el nombre de la mascota, raza y el nombre del cliente 
3.crar trigger que impida que se elimine una mascota registrada
4. trigger que cuando se elimine un cliente lo guarde en una tabla que se llame clientes eliminados
5. en la tabla cliente agregar un campo que se llame fecha de actualizacion y crear un trigger para 
que cada vez que se actualice un cliente se actualice automaticamente ese campo de fecha*/

alter table Vacuna
add column fechaVigencia date;
insert into Vacuna (nombreVacuna, fechaRegistro, numLote, fechaVigencia)
values
('Rabia', '2024-09-22', 128, '2025-09-22'),
('Moquillo', '2024-10-18', 222, '2025-10-18'),
('Parvovirosis', '2024-02-22', 325, '2025-02-22'),
('Hepatitis', '2024-09-25', 489, '2025-09-25'),
('Leptospirosis', '2024-08-10', 565, '2025-08-10');
describe vacuna;

delimiter $$

create function fn_EstadoVacuna(fechaVig datetime)
returns varchar(20)
deterministic
begin
    if fechaVig >= current_timestamp then
        return 'Vigente';
    else
        return 'Vencida';
    end if;
end$$
delimiter ;

SELECT nombreVacuna, fechaVigencia, fn_EstadoVacuna(fechaVigencia) AS Estado
FROM Vacuna;

delimiter $$

create function InfoMascotaCliente(p_idMascota int)
returns varchar(200)
deterministic
begin
    declare info varchar(200);

    select concat(
        'Mascota: ', m.nombreMascota,
        ', Raza: ', m.raza,
        ', Dueño: ', c.nombreCliente1, ' ', c.apellidoCliente1
    )
    into info
    from Mascota m
    inner join Cliente c on m.documentoClienteFK = c.documentoCliente
    where m.idMascota = p_idMascota
    limit 1;

    return info;
end$$
delimiter ;

delimiter $$

create trigger evitar_eliminar_mascota
before delete on Mascota
for each row
begin
    signal sqlstate '45000'
	set message_text = '⚠️ No se puede eliminar una mascota registrada.';
end$$
delimiter ;

create table if not exists ClientesEliminados (
    documentoCliente varchar(50),
    nombreCliente1 varchar(50),
    nombreCliente2 varchar(50),
    apellidoCliente1 varchar(50),
    apellidoCliente2 varchar(50),
    direccionCliente varchar(100),
    fechaEliminacion timestamp default current_timestamp 
);

delimiter $$

create trigger guardar_cliente_eliminado
after delete on Cliente
for each row
begin
    insert into ClientesEliminados (
        documentoCliente, 
        nombreCliente1, 
        nombreCliente2,
        apellidoCliente1, 
        apellidoCliente2, 
        direccionCliente
    )
    VALUES (
        old.documentoCliente, 
        old.nombreCliente1, 
        old.nombreCliente2,
        old.apellidoCliente1, 
        old.apellidoCliente2, 
        old.direccionCliente
    );
end$$
delimiter ;

alter table Cliente
add column fechaActualizacion timestamp null;

delimiter $$

create trigger actualizar_fecha_cliente
before update on Cliente
for each row
begin 
    set new.fechaActualizacion = now();
end$$
delimiter ;
