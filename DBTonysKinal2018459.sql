/*
		  Alán René Lopéz Lucas
				   IN5AM
		Fecha de creación: 07/02/2022
	  Fecha de modificación: 14/02/2022
*/

drop database if exists DBTonysKinal2018459;
create database DBTonysKinal2018459;

Use DBTonysKinal2018459;

Create table Empresas(
	codigoEmpresa int not null auto_increment,
	nombreEmpresa varchar(150) not null,
	direccion varchar(150) not null,
	telefono varchar(10) not null,
	primary key PK_codigoEmpresa (codigoEmpresa)
);

Create table Presupuesto(
	codigoPresupuesto int not null auto_increment,
	fechaSolicitud date not null,
	cantidadPresupuesto decimal(10,2) not null,
	codigoEmpresa int not null,
	primary key PK_codigoPresupuesto (codigoPresupuesto),
    Constraint FK_Presupuesto_Empresas foreign key (codigoEmpresa) 	
		references Empresas(codigoEmpresa)
);

Create table Servicios(
	codigoServicio int not null auto_increment,
    fechaServicio date not null,
    tipoServicio varchar(100) not null,
    horaServicio time not null,
    lugarServicio varchar(100) not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,
    primary key PK_codigoServicio (codigoServicio),
    Constraint FK_Servicios_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(100) not null,
    primary key PK_codigoTipoEmpleado (codigoTipoEmpleado)
);

Create table Empleados(
	codigoEmpleado int not null auto_increment,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(150) not null,
    gradoCocinero varchar(50),
    codigoTipoEmpleado int,
    primary key PK_codigoEmpleado (codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key (codigoTipoEmpleado) 
		references TipoEmpleado(codigoTipoEmpleado)
);

Create table Servicios_has_Empleados(
	codigoServicioHasEmpleado int not null auto_increment,
	Servicios_codigoServicio int,
    Empleados_codigoEmpleado int,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    Primary key PK_codigoServicioHasEmpleado(codigoServicioHasEmpleado),
    constraint FK_Servicios_codigoServicio foreign key (Servicios_codigoServicio)
		references Servicios(codigoServicio),
	constraint FK_Empleados_codigoEmpleados foreign key (Empleados_codigoEmpleado)
		references Empleados(codigoEmpleado)
);

Create table Productos(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(150) not null,
    cantidad int,
    primary key PK_codigoProducto (codigoProducto)
);

Create table TipoPlato(
	codigoTipoPlato int not null auto_increment,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato (codigoTipoPlato)
);

Create Table Platos(
	codigoPlato int not null auto_increment,
	cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int,
    primary key PK_codigoPlato (codigoPlato),
	constraint FK_Platos_TipoPlato foreign key (codigoTipoPlato)
		references TipoPlato(codigoTipoPlato)
);

Create table Productos_has_Platos(
	codigoProductoHasPlato int not null auto_increment,
	Productos_codigoProducto int,
    Platos_codigoPlato int,
    Primary key PK_codigoProductoHasPlato(codigoProductoHasPlato),
    constraint FK_Productos_Platos foreign key (Productos_codigoProducto)
		references Productos(codigoProducto),
	constraint FK_Platos_Productos foreign key (Platos_codigoPlato)
		references Platos(codigoPlato)
);

Create table Servicios_has_Platos(
	codigoServicioHasPlato int not null auto_increment,
	servicios_codigoServicio int,
    Platos_codigoPlato int,
    Primary key PK_codigoServicioHasPlato(codigoServicioHasPlato),
    constraint FK_Servicios_Platos foreign key (servicios_codigoServicio)
		references Servicios(codigoServicio),
	constraint FK_Platos_Servicios foreign key (Platos_codigoPlato)
		references Platos(codigoPlato)
);

-- --------------------------PROCEDIMIENTOS ALMACENADOS ----------------------

-- -------------------------------- **EMPRESAS** ----------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create procedure sp_AgregarEmpresas(in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(150))
    Begin
		insert into Empresas(nombreEmpresa, direccion, telefono)
			values(nombreEmpresa, direccion, telefono);
    End $$
Delimiter ;

call sp_AgregarEmpresas('Restaurante Noble', '18av E C33-20 Zona 12', '22325588'); 
call sp_AgregarEmpresas('Restaurante Rey', '12av C Zona 14', '2225338545'); 
call sp_AgregarEmpresas('Restaurante Realeza', '4ta av B Zona 4', '2233554411'); 

-- -------------------- Listar ----------------------
Delimiter $$
	Create procedure sp_ListarEmpresas()
		Begin 
			select 
				E.nombreEmpresa,
                E.direccion,
                E.telefono
				from Empresas E;
        End $$
Delimiter ;

call sp_ListarEmpresas;


-- -------------------- Buscar ----------------------


Delimiter $$
	Create procedure sp_BuscarEmpresas(in codEmp int)
		Begin 
			select 
				E.nombreEmpresa,
                E.direccion,
                E.telefono
				from Empresas E where codigoEmpresa = codEmp;
        End $$
Delimiter ;

call sp_BuscarEmpresas(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create procedure sp_EliminarEmpresas(in codEmp int)
		Begin 
			delete from Empresas
				where codigoEmpresa = codEmp;
        End $$
Delimiter ;

call sp_EliminarEmpresas(3);


-- -------------------- Editar ----------------------


Delimiter $$
	Create procedure sp_EditarEmpresas(in nombrEmp varchar(20), in codEmp int)
		Begin
			update Empresas E
				set E.nombreEmpresa = nombrEmp
					where codigoEmpresa=codEmp;
        End $$
Delimiter ;

call sp_EditarEmpresas ('Restaurante Entrada', 2);

-- drop procedure sp_EditarEmpresas





-- -------------------------------- **PRESUPUESTOS** ----------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create procedure sp_AgregarPresupuesto(in fechaSolicitud date, in cantidadPresupuesto decimal (10,2), in codigoEmpresa int)
		Begin 
			insert into Presupuesto(fechasolicitud, cantidadPresupuesto, codigoEmpresa)
				values (fechasolicitud, cantidadPresupuesto, codigoEmpresa);
        End$$
Delimiter ;

-- drop procedure sp_AgregarPresupuesto;

call sp_AgregarPresupuesto('2022-01-31', 35200.00, 1);
call sp_AgregarPresupuesto('2021-12-01', 20250.00, 2);


-- -------------------- Listar ----------------------
Delimiter $$
	Create procedure sp_ListarPresupuesto()
		Begin
			Select
				P.codigoPresupuesto,
				P.fechaSolicitud,
				P.cantidadPresupuesto, 
				P.codigoEmpresa
				from Presupuesto P;
        End $$
Delimiter ;

call sp_ListarPresupuesto();


-- -------------------- Buscar ----------------------


Delimiter $$
	Create procedure sp_BuscarPresupuesto(in codPre int)
		Begin 
			Select 
				P.codigoPresupuesto,
                P.fechaSolicitud,
                P.cantidadPresupuesto,
                P.codigoEmpresa
                from Presupuesto P where codigoPresupuesto = codPre;
		End $$
Delimiter ;

call sp_BuscarPresupuesto(2)


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create procedure sp_EliminarPresupuesto(in codPre int)
		Begin
			delete from Presupuesto
				where codPre = codigoPresupuesto;
        End $$
Delimiter ;

call sp_EliminarPresupuesto(2);


-- -------------------- Editar ----------------------


Delimiter $$
	Create procedure sp_EditarPresupuesto(in fechaSoli date, in cantPre int, in codEmp int, in codPre int)
		Begin
			update Presupuesto P
				set P.fechaSolicitud = fechaSoli,
					P.cantidadPresupuesto = cantPre,
                    P.codigoEmpresa = codEmp
                    where codigoPresupuesto = codEmp;
        End $$
Delimiter ;

call sp_EditarPresupuesto('2021-12-25', 52000, 1, 1);





-- -------------------------------- **SERVICIOS** --------------------------------

-- -------------------- Agregar ----------------------

-- drop procedure sp_AgregarServicio;

Delimiter $$
	Create procedure sp_AgregarServicio(in fechaServicio date, in tipoServicio varchar(100), in horaServicio time, in lugarServicio varchar(100), in telefonoContacto varchar(10), in codigoEmpresa int)
		Begin
			Insert into Servicios(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa)
				values(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa);
        End $$
Delimiter ;

call sp_AgregarServicio('2022-2-1', 'Limpieza del Establecimiento', '9:30:00', 'Restaurante 1', '35487755', 1);
call sp_AgregarServicio('2022-1-28', 'Revisión del Estado del Establecimiento', '9:30:00', 'Restaurante 2', '45885566', 1);
call sp_AgregarServicio('2022-1-31', 'Lista de Personal', '5:30:00', 'Restaurante 2', '45885566', 2);
call sp_AgregarServicio('2022-2-10', 'Reparaciones Electricas', '5:15:00', 'Restaurante 2', '45885566', 2);


-- -------------------- Listar ----------------------

Delimiter $$
	Create procedure sp_ListarServicios()
		Begin
			Select 
				S.codigoServicio,
                S.fechaServicio,
                S.horaServicio,
                S.lugarServicio,
                S.telefonoContacto,
                S.codigoEmpresa
				from Servicios S;
        End $$
Delimiter ;


call sp_ListarServicios();

-- -------------------- Buscar ----------------------

Delimiter $$
	Create procedure sp_BuscarServicio(in codServ int)
		Begin
			Select
				S.codigoServicio,
                S.fechaServicio,
                S.horaServicio,
                S.lugarServicio,
                S.telefonoContacto,
                S.codigoEmpresa
                from Servicios S where codigoServicio = codServ;
        End $$
Delimiter ;

call sp_BuscarServicio(1);


-- -------------------- Eliminar ----------------------


-- drop procedure sp_EliminarServicio;

Delimiter $$
	Create procedure sp_EliminarServicio(in codServ int) 
		Begin
			delete from Servicios 
				where codigoServicio = codServ;
        End $$
Delimiter ;

call sp_EliminarServicio(4);


-- -------------------- Editar ----------------------


-- drop procedure sp_EditarServicio;

Delimiter $$
	Create procedure sp_EditarServicio(in fechaSer date, in tipoSer varchar(100), in horaSer time, in lugarSer varchar(100), in telefonoSer varchar(10), in codEmpresa int, in codServicio int)
		Begin 
			Update Servicios S 
				set S.fechaServicio = fechaSer,
					S.tipoServicio = tipoSer,
                    S.horaServicio = horaSer,
                    S.lugarServicio = lugarSer,
                    S.telefonoContacto = telefonoSer,
                    S.codigoEmpresa = codEmpresa
                    where codigoServicio = codServicio;
        End $$
Delimiter ;

call sp_EditarServicio('2022-1-31', 'Presentacion de Platillos', '10:00:00', 'Restaurante 1', '33554488', 1,1);





-- ----------------------------- **TIPO EMPLEADO** ----------------------------------------------------------

-- -------------------- Agregar ----------------------


-- drop procedure sp_AgregarTipoEmpleado;

Delimiter $$
	Create procedure sp_AgregarTipoEmpleado(in descripcion varchar(100))
		Begin
			insert into tipoEmpleado(descripcion)
				values (descripcion);
        End $$
Delimiter ;

call sp_AgregarTipoEmpleado('Supervisor');
call sp_AgregarTipoEmpleado('Atención al Cliente');
call sp_AgregarTipoEmpleado('Cocinero');
call sp_AgregarTipoEmpleado('Mesero');
call sp_AgregarTipoEmpleado('Encargado en Limpieza');


-- -------------------- Listar ----------------------

-- drop procedure sp_ListarTipoEmpleado;

Delimiter $$
	Create procedure sp_ListarTipoEmpleado()
		Begin
			Select D.descripcion from TipoEmpleado D;
        End $$
Delimiter ;

call sp_ListarTipoEmpleado();


-- -------------------- Buscar ----------------------

Delimiter $$
	Create procedure sp_BuscarTipoEmpleado(in codTP int)
		Begin
			Select D.descripcion from TipoEmpleado D where codigoTipoEmpleado = codTP;
        End $$
Delimiter ;

call sp_BuscarTipoEmpleado(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarTipoEmpleado(in codTP int)
		Begin
			Delete from TipoEmpleado 
				where codigoTipoEmpleado = codTP;
        End$$
Delimiter ;

call sp_EliminarTipoEmpleado(5);

-- -------------------- Editar ----------------------

Delimiter $$
	Create Procedure sp_EditarTipoEmpleado(in descrTE varchar(100), in codTE int)
		Begin
			update TipoEmpleado T
				set T.descripcion = descrTE
					where T.codigoTipoEmpleado = codTE;
        End$$
Delimiter ;

call sp_EditarTipoEmpleado('Gerente', 2);






-- ----------------------------- **EMPLEADOS** ----------------------------------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create Procedure sp_AgregarEmpleados(in numeroEmpleado int, in apellidosEmpleado varchar(150), in nombresEmpleado varchar(150),
		in direccionEmpleado varchar(150), in telefonoContacto varchar(150), in gradoCocinero varchar(50), in codigoTipoEmpleado int)
		Begin
			insert into empleados(numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado, telefonoContacto, gradoCocinero, codigoTipoEmpleado)
				values (numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado, telefonoContacto, gradoCocinero, codigoTipoEmpleado);
        End$$
Delimiter ;

call sp_AgregarEmpleados(01, 'Coakley  Valencik', 'Frank  Hale', '3A Calle A, Zona 3, Guatemala City', '51448856', '0', 1);
call sp_AgregarEmpleados(02, 'Stout  Emery', 'Roberto   Oisin ', '2A Avenida, Zona 10, Guatemala City', '42336655', '0', 2);
call sp_AgregarEmpleados(03, 'Coakley  Valencik', 'Frank  Hale', '24 Calle A, Zona 5, Guatemala City' ,'55847565', '10', 3);
call sp_AgregarEmpleados(04, 'Coakley  Valencik', 'Frank  Hale', '12 Avenida , Zona 12, Guatemala City', '34556545', '0', 4);


-- -------------------- Listar ----------------------


Delimiter $$
	Create Procedure sp_ListarEmpleados()
		Begin
			select 
				E.numeroEmpleado,
                E.apellidosEmpleado,
                E.nombresEmpleado,
                E.direccionEmpleado,
                E.telefonoContacto,
                E.gradoCocinero,
                E.codigoTipoEmpleado
                from Empleados E;
        End$$
Delimiter ;

call sp_ListarEmpleados();

-- -------------------- Buscar ------------------------

-- drop procedure sp_BuscarEmpleado;

Delimiter $$
	Create Procedure sp_BuscarEmpleado(in codEmp int)
		Begin
			select 
				E.numeroEmpleado,
                E.apellidosEmpleado,
                E.nombresEmpleado,
                E.direccionEmpleado,
                E.telefonoContacto,
                E.gradoCocinero,
                E.codigoTipoEmpleado
                from Empleados E where codigoEmpleado = codEmp;
        End$$
Delimiter ;

call sp_BuscarEmpleado(2);


-- -------------------- Eliminar ----------------------


-- drop procedure sp_EliminarEmpleado;

Delimiter $$
	Create Procedure sp_EliminarEmpleado(in codEmp int)
		Begin
			delete from Empleados
				where codigoEmpleado = codEmp;
        End$$
Delimiter ;

call sp_EliminarEmpleado(4);


-- -------------------- Editar ----------------------

-- drop procedure sp_EditarEmpleado;

Delimiter $$
	Create Procedure sp_EditarEmpleado(in numEmp int, in apellidosEmp varchar(150), in nombresEmp varchar(150), in direccionEmp varchar(150), in telContacto varchar(150), 
    in gradoCoc varchar(50), in codTE int, in codEmp int)
		Begin
			Update Empleados E
				set numeroEmpleado = numEmp,
					apellidosEmpleado = apellidosEmp,
                    nombresEmpleado = nombresEmp,
                    direccionEmpleado = direccionEmp,
                    telefonoContacto = telContacto,
                    gradoCocinero = gradoCoc,
                    codigoTipoEmpleado = codTE
                    where codigoEmpleado = codEmp;
        End$$
Delimiter ;

call sp_EditarEmpleado('03', 'Botkin Rhodes', 'Kelsey Silvia', '12 Avenida , Zona 12, Guatemala City', '51425598', '10', 3, 3);




-- ----------------------------- **SERVICIOS_HAS_EMPLEADOS** ----------------------------------------------------------

-- -------------------- Agregar ----------------------

-- drop procedure sp_AgregarServiciosHasEmpleados;

Delimiter $$
	Create Procedure sp_AgregarServiciosHasEmpleados(in Servicios_codigoServicio int, in Empleados_codigoEmpleado int, in fechaEvento date, in horaEvento time, in lugarEvento varchar(150))
		Begin
			insert into Servicios_has_Empleados(Servicios_codigoServicio, Empleados_codigoEmpleado, fechaEvento, horaEvento, lugarEvento)
					values (Servicios_codigoServicio, Empleados_codigoEmpleado, fechaEvento, horaEvento, lugarEvento);
        End$$
Delimiter ;

call sp_AgregarServiciosHasEmpleados(1, 1, '2022-02-16', '13:25:00', 'Restaurante 1');
call sp_AgregarServiciosHasEmpleados(2, 2, '2022-02-14', '10:00:00', 'Restaurante 1');
call sp_AgregarServiciosHasEmpleados(3, 3, '2022-02-14', '09:30:00', 'Restaurante 2');


-- -------------------- Listar ----------------------


Delimiter $$
	Create Procedure sp_ListarServiciosHasEmpleados()
		Begin
			select 
				S_E.Servicios_codigoServicio,
				S_E.Empleados_codigoEmpleado,
                S_E.fechaEvento,
                S_E.horaEvento,
                S_E.lugarEvento
                from servicios_has_empleados S_E;
        End$$
Delimiter ;

call sp_ListarServiciosHasEmpleados();


-- -------------------- Buscar ------------------------


Delimiter $$
	Create Procedure sp_BuscarServiciosHasEmpleados(in codServicios int)
		Begin
			select 
				S_E.Servicios_codigoServicio,
				S_E.Empleados_codigoEmpleado,
                S_E.fechaEvento,
                S_E.horaEvento,
                S_E.lugarEvento
                from servicios_has_empleados S_E where Servicios_codigoServicio = codServicios;
        End$$
Delimiter ;

call sp_BuscarServiciosHasEmpleados(3);

-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarServiciosHasEmpleados(in codServicios int)
		Begin
			delete from servicios_has_empleados 
				where Servicios_codigoServicio = codServicios;
        End$$
Delimiter ;

call sp_EliminarServiciosHasEmpleados(3);


-- -------------------- Editar ----------------------


Delimiter $$
	Create Procedure sp_EditarServiciosHasEmpleados(in ServCodigoServicio int, in EmpCodigoEmpleado int, in feEvento date, in hrEvento time, in luEvento varchar(150))
		Begin
			update servicios_has_empleados S_E
				set 
					S_E.Empleados_codigoEmpleado = EmpCodigoEmpleado,
                    S_E.fechaEvento = feEvento,
                    S_E.horaEvento = hrEvento,
                    S_E.lugarEvento = luEvento
                    where S_E.Servicios_codigoServicio = ServCodigoServicio;
        End $$
Delimiter ;

call sp_EditarServiciosHasEmpleados(2, 2, '2022-02-14', '08:20:00', 'Restaurante 1');





-- ----------------------------- **PRODUCTOS** ----------------------------------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create Procedure sp_AgregarProductos(in nombreProducto varchar(150), in cantidad int)
		Begin
			insert into Productos(nombreProducto, cantidad)
				values(nombreProducto, cantidad);
        End$$
Delimiter ;

call sp_AgregarProductos ('Ingredientes', 300 );
call sp_AgregarProductos ('Productos de Limpieza', 85 );
call sp_AgregarProductos ('Mesas', 75 );
call sp_AgregarProductos ('Decoracion', 350 );
call sp_AgregarProductos ('Herramientas', 500 );

-- -------------------- Listar ----------------------

Delimiter $$
	Create Procedure sp_ListarProductos()
		Begin
			select
				P.nombreProducto,
                P.cantidad
                from Productos P;
        End$$
Delimiter ;

call sp_ListarProductos();

-- -------------------- Buscar ------------------------

Delimiter $$
	Create Procedure sp_BuscarProductos(in codP int)
		Begin
			select
				P.nombreProducto,
                P.cantidad
                from Productos P where codigoProducto = codP;
        End$$
Delimiter ;

call sp_BuscarProductos(1);

-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarProducto(in codP int)
		Begin
			delete from productos
				where codigoProducto = codP;
        End$$
Delimiter ;

call sp_EliminarProducto(5)

-- -------------------- Editar ----------------------

Delimiter $$
	Create Procedure sp_EditarProductos(in nombreProd varchar(150), in cant int, in codProd int)
		Begin
			update Productos P 
				set P.nombreProducto = nombreProd,
                    P.cantidad = cant
                    where P.codigoProducto = codProd;
        End$$
Delimiter ;

call sp_EditarProductos('Sillas', 300, 4);





-- -------------------------------- **TIPO PLATO** ----------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create Procedure sp_AgregarTipoPlato(in descripcionTipo varchar(100))
		Begin
			insert into tipoplato(descripcionTipo)
				values (descripcionTipo);
        End$$
Delimiter ;

call sp_AgregarTipoPlato('Entradas');
call sp_AgregarTipoPlato('Platillos Principales');
call sp_AgregarTipoPlato('Platillos Especiales');
call sp_AgregarTipoPlato('Postres');
call sp_AgregarTipoPlato('JAIC0s9d0');



-- -------------------- Listar ----------------------

Delimiter $$
	Create Procedure sp_ListarTipoPlato()
		Begin
			select 
				TP.codigoTipoPlato,
                TP.descripcionTipo
				from tipoplato TP;
        End $$
Delimiter ;

call sp_ListarTipoPlato();


-- -------------------- Buscar ------------------------

Delimiter $$
	Create Procedure sp_BuscarTipoPlato(in codTipoPlato int)
		Begin
			select 
				TP.codigoTipoPlato,
                TP.descripcionTipo
				from tipoplato TP where codigoTipoPlato = codTipoPlato;
        End$$
Delimiter ;

call sp_BuscarTipoPlato(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarTipoPlato(in codTipoPlato int)
		Begin
			delete from tipoplato
				where codigoTipoPlato = codTipoPlato;
        End$$
Delimiter ;

call sp_EliminarTipoPlato(5);


-- -------------------- Editar ----------------------

Delimiter $$
	Create Procedure sp_EditarTipoPlato (in descrTipo varchar(100), in codTipoPlato int)
		Begin
			update tipoplato TP
				set descripcionTipo = descrTipo
					where codigoTipoPlato = codTipoPlato;
        End$$
Delimiter ;

call sp_EditarTipoPlato ('Especialidades', 3);





-- -------------------------------- **PLATOS** ----------------------------------

-- -------------------- Agregar ----------------------

-- drop procedure sp_AgregarPlatos;

Delimiter $$
	Create Procedure sp_AgregarPlatos(in cantidad int, in nombrePlato varchar(50), in desripcionPlato varchar(150), in precioPlato decimal(10,2), in codigoTipoPlato int)
		Begin
			insert into Platos(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato)
				values (cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato);
        End$$
Delimiter ;

call sp_AgregarPlatos(50, 'Ceviche de palmito', 'refrescante ceviche vegano o vegetariano.', 35.50, 1);
call sp_AgregarPlatos(75, 'Pierna de cordero', 'Pierna de cordero con miel de romero, aceito de oliva, pimienta, 1,5dl de vino blanco.', 320.75, 2);
call sp_AgregarPlatos(75, 'Pepián', 'Pepián de pollo y su consistencia  son un majar exquisito. ', 125.50, 3);
call sp_AgregarPlatos(80, 'Rosquillas gallegas de Carnaval', 'Rosquillas fritas, esponjosas y deliciosas.', 15.50, 4);
call sp_AgregarPlatos(50, 'Ceviche de palmito', 'refrescante ceviche vegano o vegetariano', 35.50, 4);


-- -------------------- Listar ----------------------

-- drop procedure sp_ListarPlatos;

Delimiter $$
	Create Procedure sp_ListarPlatos()
		Begin
			select 
				P.codigoPlato,
				P.cantidad,
                P.nombrePlato,
                P.descripcionPlato,
                P.precioPlato,
                P.codigoTipoPLato
                from Platos P;
        End$$
Delimiter ;

call sp_ListarPlatos();


-- -------------------- Buscar ------------------------

-- drop procedure sp_BuscarPlatos;

Delimiter $$
	Create Procedure sp_BuscarPlatos(in codP int)
		Begin
			select 
				P.codigoPlato,
				P.cantidad,
                P.nombrePlato,
                P.descripcionPlato,
                P.precioPlato,
                P.codigoTipoPLato
                from Platos P where codigoPlato = codP;
        End$$
Delimiter ;

call sp_BuscarPlatos(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarPlato(in codP int)
		Begin
			delete from Platos
				where codigoPlato = codP;
        End$$
Delimiter ;

call sp_EliminarPlato(5);


-- -------------------- Editar ----------------------


Delimiter $$
	Create Procedure sp_EditarPlato(in cant int, in nomPlato varchar(50), in descrPlato varchar(150), in prePlato decimal (10,2), in codTP int, in codP int)
		Begin
			update Platos P
				set P.cantidad = cant,
					P.nombrePlato = nomPlato,
                    P.descripcionPlato = descrPlato,
                    P.precioPlato = prePlato,
                    P.codigoTipoPlato = codTP
                    where codigoPlato = codTP;
        End$$
Delimiter ;

call sp_EditarPlato(90, 'Rosquillas huecas', 'Los dulces de convento siempre son deliciosos.', 25.50, 4, 4);





-- -------------------------------- **PRODUCTOS HAS PLATOS** ----------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create Procedure sp_AgregarProductos_has_Platos(in Productos_codigoProducto int, in Platos_codigoPlato int)
		Begin
			insert into Productos_has_Platos(Productos_codigoProducto, Platos_codigoPlato)
				values(Productos_codigoProducto, Platos_codigoPlato);
        End$$
Delimiter ;

call sp_AgregarProductos_has_Platos(1, 2);
call sp_AgregarProductos_has_Platos(2, 1);
call sp_AgregarProductos_has_Platos(3, 1);
call sp_AgregarProductos_has_Platos(4, 1);


-- -------------------- Listar ----------------------

Delimiter $$
	Create Procedure sp_ListarProductos_has_Platos()
		Begin
			select 
				PHP.codigoProductoHasPlato,
				PHP.Productos_codigoProducto,
                PHP.Platos_codigoPlato
				from Productos_has_Platos PHP;
        End$$
Delimiter ;

call sp_ListarProductos_has_Platos();


-- -------------------- Buscar ------------------------

Delimiter $$
	Create Procedure sp_BuscarProductos_has_Platos(in codPhp int)
		Begin
			select 
				PHP.codigoProductoHasPlato,
				PHP.Productos_codigoProducto,
                PHP.Platos_codigoPlato
				from Productos_has_Platos PHP where codigoProductoHasPlato = codPhp;
        End$$
Delimiter ;

call sp_BuscarProductos_has_Platos(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarProductos_has_Platos(in codPhp int)
		Begin
			delete from Productos_has_Platos
				where codigoProductoHasPlato = codPhp;
        End$$
Delimiter ;


call sp_EliminarProductos_has_Platos(4);

-- -------------------- Editar ----------------------

Delimiter $$
	Create Procedure sp_EditarProductos_has_Platos(in Prod_codProducto int, in Platos_codPlato int, in codPhp int)
		Begin
			update Productos_has_Platos PHP
				set PHP.Productos_codigoProducto = Prod_codProducto,
					PHP.Platos_codigoPlato = Platos_codPlato
					where PHP.codigoProductoHasPlato = codPhp;
        End$$
Delimiter ;

call sp_EditarProductos_has_Platos(1,1,1);





-- -------------------------------- **SERVICIOS HAS PLATOS** ----------------------------------

-- -------------------- Agregar ----------------------

Delimiter $$
	Create Procedure sp_AgregarServicios_has_Platos(in servicios_codigoServicio int, in platos_codigoPlato int)
		Begin
			insert into Servicios_has_Platos(servicios_codigoServicio, platos_codigoPlato)
				values(servicios_codigoServicio, platos_codigoPlato);
        End$$
Delimiter ;

call sp_AgregarServicios_has_Platos(1,1);
call sp_AgregarServicios_has_Platos(1,1);
call sp_AgregarServicios_has_Platos(1,3);
call sp_AgregarServicios_has_Platos(1,4);


-- -------------------- Listar ----------------------

Delimiter $$
	Create Procedure sp_ListarServicios_has_Platos()
		Begin
			select 
				SHP.codigoServicioHasPlato,
                SHP.servicios_codigoServicio,
                SHP.platos_codigoPlato
                from Servicios_has_Platos SHP;
					
        End$$
Delimiter ;

call sp_ListarServicios_has_Platos();


-- -------------------- Buscar ------------------------

Delimiter $$
	Create Procedure sp_BuscarServicios_has_Platos(in codSHP int)
		Begin
			select 
				SHP.codigoServicioHasPlato,
                SHP.servicios_codigoServicio,
                SHP.platos_codigoPlato
                from Servicios_has_Platos SHP where codigoServicioHasPlato = codSHP;
        End$$
Delimiter ;

call sp_BuscarServicios_has_Platos(1);


-- -------------------- Eliminar ----------------------


Delimiter $$
	Create Procedure sp_EliminarServicios_has_Platos(in codSHP int)
		Begin
			delete from Servicios_has_Platos 
				where codigoServicioHasPlato = codSHP;
        End$$
Delimiter ;

call sp_EliminarServicios_has_Platos(4)


-- -------------------- Editar ----------------------

Delimiter $$
	Create Procedure sp_EditarServicios_has_Platos(in sCodigoServicio int, in pCodigoPlato int, in codSHP int)
		Begin
			update Servicios_has_Platos SHP
				set SHP.servicios_codigoServicio = sCodigoServicio,
					SHP.platos_codigoPlato = pCodigoPlato
                where codigoServicioHasPlato = codSHP;
        End$$
Delimiter ;

call sp_EditarServicios_has_Platos(1,2,2);