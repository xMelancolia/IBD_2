#DDL --- DML
#DDL ---- Estructura de la base de datos --- ABM
# CREATE _ ALTER _ DROP _ TRUNCATE
create database DDL_DML;

use DDL_DML;
create table Persona(
	id_persona int not null primary key auto_increment,
    dni int not null,
    nombre varchar(40) not null,
	apellido varchar(40) not null
);

create table Celular(
	numero_serie int not null primary key auto_increment,
    marca varchar(40) not null
);

#ALTER
-- alter table persona drop column peso -> eliminar columna
-- alter table Persona modify column id int not null auto_increment -> puedo hacerlo autoincremental
alter table Persona add peso int; -- agregar Columna
alter table Persona modify column peso float not null; -- modificar una columna
#Generar Relaciones
alter table Celular
add fk_id_persona int,
add constraint fk_persona_celular_tiene
foreign key (fk_id_persona) references Persona(id_persona); 

#TRUNC
-- truncate table Persona -> Borra todos los registros de la tabla Persona. Limpia la tabla

#DML ---- A la manipulacion de los datos ---- ABM(CRUD)
#DML = ABM --- INSERT ---UPDATE --- DELETE ---- LEER(SELECT)

insert into Persona(id_persona,dni,nombre,apellido,peso) value (3,333,"Nicolas","Perez",180);
insert into Persona(dni,nombre,apellido,peso) value (458952,"Matias","Clutch",100);
insert into Celular(marca,fk_id_persona) value("Samsung",3);

#MODIFICAR
update Persona
set apellido = "Lopez"
where id_persona = 3;

#DELETE
delete from Persona
where id_persona = 4; -- Si pongo 3(vinculado con celular) tengo que poner fk a cascada
#SELECT 
 -- select * from actor; -> seleccionar todas las columnas de esta tabla(actor)
 -- where actor_id > 190; -> solo me va a mostrar estos registros si el id es mayor a 160
 -- select actor_id,last_name from actor-> solo estas dos columnas
 -- where actor id > 190 or/and last_name = "TEMPLE"; -> otro ejemplo
 -- order by first_name -> ordenado por nombre en este caso
 -- order by first_name desc -> decensdente