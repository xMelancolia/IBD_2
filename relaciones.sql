Create database unla;

use unla;
-- drop schema unla; -> borrar base de datos
drop table alumnos;
create table alumnos(
dni int not null,
nombre varchar(40) not null,
apellido varchar(40),
edad int not null,
-- clave primaria
primary key(dni)
-- clave foranea 
-- fk_id_contacto int not null <- otra forma de agregar fk

);

create table contacto(
	id_contacto int not null primary key auto_increment,
	mail varchar(40) not null,
	tel int not null
);

create table materia(
	id_Materia int not null primary key auto_increment,
	nombre varchar(40) not null
);
drop table alumnos_x_materias;
-- TABLA INTERMEDIA alumnos >---< materias (muchos a muchos)
create table alumnos_x_materias(
	fk_id_materia int not null,
    fk_dni int not null 

);

-- RELACIONES
-- Alumno-contacto relacion 1-1 1-<
 alter table alumnos
 add fk_id_contacto int not null,
 add constraint alumno_tiene_un_contacto -- nombre de la relacion
 foreign key (fk_id_contacto) -- esta es la fk que esta en alumnos
 references contacto(id_contacto);
 
-- Alumno-materia relacion n a m  
alter table alumnos_x_materias
add constraint alumnos_x_materias_materia
foreign key (fk_id_materia)
references materia(id_Materia);

alter table alumnos_x_materias
add constraint alumnos_x_materias_alumno
foreign key (fk_dni)
references alumnos(dni);


