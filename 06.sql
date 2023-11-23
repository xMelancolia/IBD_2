create database actividad06;
drop database actividad06;
create schema actividad06;
-- En provincia: (1, Buenos Aires) y (2, CABA)
-- En localidad: (1, Lanús), (2, Pompeya), (3, Avellaneda)
-- En calles: (1, 9 de Julio) , (2, Hipólito Yrigoyen) , (3, Mitre), (4, Sáenz)

create table calle(
	id_calle int not null primary key auto_increment,
	nombre varchar(50)
);
drop table calle;

alter table calle rename to calle1;
alter table calle1 rename to calle;
alter table calle change column nombre nom varchar(100);
alter table calle change column nom nombre varchar(100);

insert into calle (id_calle,nombre)values(1,"9 de julio");
insert into calle (nombre)values("Hipólito Yrigoyen");
insert into calle (nombre)values("Mitre");
insert into calle (nombre)values("Saenz");


create table localidad(
	id_localidad int not null primary key auto_increment,
    nombre varchar(50)
);
drop table localidad;

alter table localidad rename to localidad1;
alter table localidad1 rename to localidad;
alter table localidad change column nombre nom varchar(100);
alter table localidad change column nom nombre varchar(100);

insert into localidad (id_localidad,nombre)values(1,"Lanus");
insert into localidad (nombre)values("Pompeya");
insert into localidad (nombre)values("Avellaneda");

create table provincia(
	id_provincia int not null primary key auto_increment,
    nombre varchar(50)
);
drop table provincia;

alter table provincia rename to provincia1;
alter table provincia1 rename to provincia;
alter table provincia change column nombre nom varchar(100);
alter table provincia change column nom nombre varchar(100);

insert into provincia (id_provincia,nombre)values(1, "Buenos Aires");
insert into provincia (nombre)values("CABA");


