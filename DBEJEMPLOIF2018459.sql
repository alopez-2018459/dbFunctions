Drop database if exists DBEjemploIf2018459;
Create database DBEjemploIf2018459;

use DBEjemploIf2018459;

Create table Personas(
	codigoPersona int not null auto_increment,
    nombrePersona varchar(100) not null,
    primerApellido varchar(100) not null,
    segundoApellido varchar(100) not null,
    edad int not null,
    primary key PK_codigoPersona (codigoPersona)
);


-- ------------------ Agregar Persona ----------------

Delimiter $$
	Create procedure sp_AgregarPersona(in nombrePersona varchar(100), in primerApellido varchar(100), in segundoApellido varchar(100), in edad int)
		Begin 
			insert into Personas(nombrePersona, primerApellido, segundoApellido, edad)
				values(nombrePersona, primerApellido, segundoApellido, edad);
        End $$
Delimiter ;

call sp_AgregarPersona('Antonio', 'Cazas', 'Guerra', 25);
call sp_AgregarPersona('Jose', 'Gonzales', 'Herrera', 35);
call sp_AgregarPersona('Juan', 'Perez', 'Arreaga', 28);
call sp_AgregarPersona('Fenando', 'Sol', 'Bedrick', 15);
call sp_AgregarPersona('Maria', 'Con', 'Mendez', 16);

Select P.nombrePersona, P.primerApellido, P.edad, if(edad >=18, 'Mayor de edad', 'Menor de edad')
	as Estado from Personas P;