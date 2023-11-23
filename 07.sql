create schema actividad07;
use actividad07;

create table calle (
	idcalle int not null primary key auto_increment,
    nombre varchar(30)
);

alter table calle
add fk_idlocalidad int not null,
add constraint calle_pertenece_localidad 
foreign key (fk_idlocalidad) 
references localidad(idlocalidad);

create table localidad(
	idlocalidad int not null primary key auto_increment,
    nombre varchar(50)
);
create table provincia(
	idprovincia int not null primary key auto_increment,
    nombre varchar(50)
);

insert into localidad (idlocalidad,nombre)values(1,"Lanus");
insert into localidad (nombre)values("Pompeya");
insert into localidad (nombre)values("Avellaneda");
insert into provincia (idprovincia,nombre)values(1, "Buenos Aires");
insert into provincia (nombre)values("CABA");
insert into calle (idcalle,nombre,fk_idlocalidad)values(1,"9 de julio",1);
insert into calle (nombre,fk_idlocalidad)values("Hipólito Yrigoyen",2);
insert into calle (nombre,fk_idlocalidad)values("Mitre",1);
insert into calle (nombre,fk_idlocalidad)values("Saenz",2);

create table cliente(
	dni int primary key,
	apellido varchar(45) not null,
	nombre varchar(45)not null,
	calle_idcalle int not null,
	localidad_idlocalidad int not null,
	provincia_idprovincia int not null,
    numero_calle int not null,
	foreign key (calle_idcalle) references calle(idcalle),
    foreign key (localidad_idlocalidad) references localidad(idlocalidad),
    foreign key (provincia_idprovincia) references provincia(idprovincia)
);

create table obra_social(
	codigo int not null primary key,
    nombre varchar (50)
);
insert into obra_social values (1,"UTA");
insert into obra_social values (2,"Andrade");
insert into obra_social values (3,"UCON");

-- Mostramos definición:
show create table cliente;
-- Agregamos registros:
insert into cliente values(12345678, "Belgrano", "Manuel", 1,1,1,2345);
insert into cliente values(23456789, "Saavedra", "Cornelio",1,1,1,1234); 
insert into cliente values(44444444, "Moreno", "Mariano", 3,3,1,3333);
insert into cliente values(33333333, "Larrea", "Juan", 4,2,2,2345);
insert into cliente values(22222222, "Moreno", "Manuel", 4,2,2,7777);
-- Mostramos clientes:
select * from cliente; -- todos los clientes
select dni,apellido from cliente;-- solo dni y apellido

-- Consultamos registros por dni:
select apellido,nombre from cliente where dni=12345678;

-- Consultamos registros por apellido:
select * from cliente where cliente.apellido="Saavedra";

-- Consultamos clientes de la calle 9 de julio
select * from cliente where calle_idcalle=1;

-- Consultamos clientes de la calle 9 de Julio con el número 2345
select * from cliente where calle_idcalle=1 and numero_calle=2345;

-- Consultamos clientes que vivan en la calle 9 de Julio 
-- o en la calle Mitre
select * from cliente where calle_idcalle=1 or calle_idcalle=3;

-- agregamos obras sociales a los clientes
-- creamos la tabla intermedia que representa la relación opcional 1:n entre cliente y obra social 
create table cliente_tiene_obra_social(
	cliente_dni int primary key,
	obra_social_codigo int not null,
	nro_afiliado int not null,
	foreign key (cliente_dni) references cliente(dni),
    foreign key (obra_social_codigo) references obra_social(codigo)
);

-- Insertamos datos en la tabla. El cliente Cornelio Saavedra no tiene obra social
-- por ello no existe un registro con su dni en la misma
insert into cliente_tiene_obra_social values (22222222, 2, 11223344);
insert into cliente_tiene_obra_social values (33333333, 2, 33445566);
insert into cliente_tiene_obra_social values (44444444, 2, 12356987);
insert into cliente_tiene_obra_social values (12345678,  1, 87654321);

-- Consultas más complejas (joins)
-- Consultamos todos los clientes con su calle usando alias de tabla
-- Inner join: todos los registros de una tabla con correlato en la otra
select c.dni, c.apellido, c.nombre, ca.nombre, c.numero_calle from 
cliente c inner join calle ca on c.calle_idcalle=ca.idcalle;

-- igual, definiendo un alias para el campo c.nombre y numero_calle (con as)
select c.dni, c.apellido, c.nombre, ca.nombre as calle, c.numero_calle as numero from cliente c 
inner join calle ca on c.calle_idcalle=ca.idcalle;

-- inner join con filtro por nombre de localidad
select c.dni, c.apellido, c.nombre, l.nombre as Localidad from cliente c 
inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
where l.nombre="Avellaneda";

-- Left join: Todos los registros de la izquierda y sólo los de la 
-- derecha que participan en la relación.
select ca.nombre as calle, dni, apellido, c.nombre from calle ca
left join cliente c on ca.idcalle=c.calle_idcalle;

-- Right join: Todos los registros de la derecha y los de la izquierda que 
-- participan en la relación.
select cos.nro_afiliado, dni, apellido, c.nombre from cliente_tiene_obra_social cos
right join cliente c on c.dni=cos.cliente_dni;

-- Vemos como un right join se puede escribir como un left join y viceversa.
-- esta consulta es similar a la anterior
select cos.nro_afiliado, dni, apellido, c.nombre from cliente c 
	left join cliente_tiene_obra_social cos on c.dni=cos.cliente_dni;

-- Traemos a los clientes sin obra social
select cos.nro_afiliado, dni, apellido, c.nombre from cliente c
    left join cliente_tiene_obra_social cos on c.dni=cos.cliente_dni
    where isnull(cos.nro_afiliado);

-- Traemos a los clientes con obra social
select cos.nro_afiliado, dni, apellido, c.nombre from cliente c
left join cliente_tiene_obra_social cos on c.dni=cos.cliente_dni
where not isnull(cos.nro_afiliado);


-- Consultas aún más complejas:
-- joins múltiples: Queremos consultar todos los clientes de IOMA:
select c.dni, c.apellido, c.nombre, o.nombre
from cliente c 
inner join cliente_tiene_obra_social co on c.dni=co.cliente_dni
inner join obra_social o on co.obra_social_codigo=o.codigo
where o.nombre="IOMA";

----- PRACTICA -------
-- Muestra cliente completo
select * from cliente c;

-- Solo Clientes de la  provincia de buenos aires
select c.dni, c.apellido, c.nombre, p.nombre as provincia from cliente c 
inner join provincia p on c.provincia_idprovincia=p.idprovincia
where p.nombre= "buenos aires";

-- Solo clientes viviendo en la calle "9 de julio"
select c.dni, c.apellido, c.nombre, ca.nombre as calle from cliente c 
inner join calle ca on c.calle_idcalle=ca.idcalle
where ca.nombre= "9 de julio";

-- Solo clientes con el dni = "33333333"
select * from cliente c
where c.dni= "33333333";

-- sólo de las localidades de avellaneda y lanus
select c.dni, c.apellido, c.nombre, l.nombre as Localidad from cliente c 
inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
where l.nombre="Avellaneda" or l.nombre= "lanus";

-- sólo los clientes de PAMI y IOMA
select c.dni, c.apellido, c.nombre, o.nombre from cliente c 
inner join cliente_tiene_obra_social co on c.dni=co.cliente_dni
inner join obra_social o on co.obra_social_codigo=o.codigo
where o.nombre="IOMA" or o.nombre= "PAMI";

-- sólo los clientes de IOMA que vivan en la calle Mitre
select c.dni, c.apellido, c.nombre, ca.nombre as calle from cliente c 
inner join calle ca on c.calle_idcalle=ca.idcalle
inner join cliente_tiene_obra_social co on c.dni=co.cliente_dni
inner join obra_social o on co.obra_social_codigo=o.codigo
where ca.nombre= "Mitre" and o.nombre = "IOMA";

create table laboratorio(
	codigo int not null primary key auto_increment,
    nombre varchar(50) not null
);
insert into laboratorio (codigo,nombre)values(1,"Bayer");
insert into laboratorio (nombre)values("Roemmers");
insert into laboratorio (nombre)values("Farma");
insert into laboratorio (nombre)values("Elea");

create table producto(
	codigo int not null primary key,
    nombre varchar(60),
    laboratorio_idlaboratorio int not null,
    descripcion varchar(120),
    precio int,
	foreign key (laboratorio_idlaboratorio) references laboratorio(codigo)
);
insert into producto (codigo,nombre,descripcion,precio,laboratorio_idlaboratorio)values(1,"Bayaspirina","Aspirina por tira 10 unidades",10,1);
insert into producto (codigo,nombre,descripcion,precio,laboratorio_idlaboratorio)values(2,"Ibuprofeno","Ibuprofeno tira 6 unidades",20,3);
insert into producto (codigo,nombre,descripcion,precio,laboratorio_idlaboratorio)values(3,"Amoxidal 500","Antibiotico de amplio espectro",300,2);
insert into producto (codigo,nombre,descripcion,precio,laboratorio_idlaboratorio)values(4,"Redoxon","Complemento vitaminico",120,1);
insert into producto (codigo,nombre,descripcion,precio,laboratorio_idlaboratorio)values(5,"Atomo","Crema desinflamante",90,3);


create table venta (
	idventa int primary key,
    fecha varchar(60),
    cliente_idcliente int,
    foreign key (cliente_idcliente) references cliente(dni)
);
insert into venta (idventa,fecha,cliente_idcliente)values(1,"20-08-20",12345678);
insert into venta (idventa,fecha,cliente_idcliente)values(2,"20-08-20",33333333);
insert into venta (idventa,fecha,cliente_idcliente)values(3,"20-08-22",22222222);
insert into venta (idventa,fecha,cliente_idcliente)values(4,"20-08-22",44444444);
insert into venta (idventa,fecha,cliente_idcliente)values(5,"20-08-22",22222222);
insert into venta (idventa,fecha,cliente_idcliente)values(6,"20-08-23",12345678);


-- Todas las ventas, indicando número, fecha, apellido y nombre del cliente
select v.idventa, v.fecha, c.apellido, c.nombre,c.dni as cliente from venta v 
inner join cliente c on v.cliente_idcliente=c.dni
order by v.idventa;

-- sólo las del cliente con dni 12345678
select v.idventa, v.fecha, c.apellido, c.nombre as cliente from venta v 
inner join cliente c on v.cliente_idcliente=c.dni
where c.dni="12345678";

-- Los clientes que no tienen ventas registradas
select * from cliente where dni not in(select cliente_idcliente from venta);
-- Todos los laboratorios
select * from laboratorio;

-- Todos los productos indicando a que laboratorio pertenecen
select p.codigo, p.nombre, p.descripcion, p.precio,l.nombre as laboratorio from producto p
inner join laboratorio l on p.laboratorio_idlaboratorio=l.codigo;

-- - Los laboratorios que no tienen productos registrados
select * from laboratorio where codigo not in(select laboratorio_idlaboratorio from producto);