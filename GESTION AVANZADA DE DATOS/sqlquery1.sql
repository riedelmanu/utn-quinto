create type Tsexo as enum ('masculino', 'femenino', 'otro');
create type TipoDeDocumento as enum ('DNI', 'Pasaporte', 'Cédula');
create type TPeriodoMateria as enum ('Anual', 'Primer Cuatrimestre','Segundo Cuatrimestre');
create type TEstadoExamen as enum ('Desaprobado', 'Aprobado');

create type TDocumento as (Numero VARCHAR(20), Tipo TipoDeDocumento, ExpedidoPor VARCHAR(100));
create type TDomicilio as (Calle VARCHAR(100), Numero INTEGER, Piso VARCHAR(10), Departamento VARCHAR(10));

create table Personas (
	idPersona serial primary key,
	Nombres VARCHAR(100) not null,
	Apellidos VARCHAR(100) not null,
	Sexo TSexo not null,
    Documento TDocumento not null,
    Domicilio TDomicilio,
    FechaNacimiento DATE not null,
    Foto BYTEA,
    Huella BYTEA,
    Firma BYTEA);
	
create table Carreras (
	idCarrera serial primary key,
	Nombre varchar(50) not null,
	Titulo varchar(50) not null,
	Posgrado bool not null);

create table Alumnos (
	idPersona serial not null references Personas(idPersona),
	Legajo varchar(10) primary key,
	idCarrera serial not null references Carreras(idCarrera),
	FechaIngreso date not null,
	FechaEgreso date);



create table Materias (
	idMateria serial primary key,
	idCarrera serial not null references Carreras(idCarrera),
	Anio integer check (Anio between 1 and 5),
	Periodo TPeriodoMateria not null,
	Costo numeric(10,2) not null);

create table Correlativas (
	idMateriaRequerida serial  not null references Materias(idMateria),
	idMateria serial  not null references Materias(idMateria));

create table ExamenesFinales (
	idExamen serial primary key,
	idMateria serial  not null references Materias(idMateria),
	Legajo varchar(10) not null references Alumnos(Legajo),
	Fecha date not null,
	Nota numeric(4, 2) check (nota between 1 and 10) not null,
	Estado TEstadoExamen not null,
	NumeroActa VARCHAR(20) not null
);

	