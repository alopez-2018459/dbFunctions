Drop database if exists DBEjemploFunciones2018459;
Create database DBEjemploFunciones2018459;

Use DBEjemploFunciones2018459;

Create table Datos(
	codigoDato int not null auto_increment,
    num1 int not null,
    num2 int not null,
    suma int,
    resta int,
    multiplicacion int,
    division int,
    primary key PK_codigoDato (codigoDato)
);

Delimiter $$
	create procedure sp_AgregarDato(in num1 int, in num2 int)
	begin
		insert into Datos(num1, num2)
        values(num1, num2);
    end $$
Delimiter ;

call sp_AgregarDato(3,5);


Delimiter $$
	create procedure sp_ListarDatos()
    begin
		select
			D.num1,
            D.num2,
            D.suma,
            D.resta,
            D.multiplicacion,
            D.division
		from Datos D;
    end $$
Delimiter ;

call sp_ListarDatos();


Select D.num1 + D.num2 from Datos D;


Delimiter $$
	create function fn_Sumatoria(valor1 int, valor2 int)
    returns int
    READS SQL DATA DETERMINISTIC
    begin
		declare result int;
        set result = valor1 + valor2;
        return 	result;
    end $$
Delimiter ;

select fn_Sumatoria(3,4) as Resultado;
select fn_sumatoria(D.num1, D.num2) from Datos D;


Delimiter $$
	create function fn_Resta(valor1 int, valor2 int)
    returns int
    READS SQL DATA DETERMINISTIC
    begin
		declare result int;
        set result = valor1 - valor2;
        return 	result;
    end $$
Delimiter ;

select fn_Resta(10,7) as Resultado;


Delimiter $$
	create function fn_Multiplicacion(valor1 int, valor2 int)
    returns int
    READS SQL DATA DETERMINISTIC
    begin
		declare result int;
		set result = valor1 * valor2;
        return result;
    end $$
Delimiter ;

select fn_Multiplicacion(8,5);


Delimiter $$
	create function fn_Division(valor1 int, valor2 int)
    returns int
    READS SQL DATA DETERMINISTIC
    begin
		declare result int;
		set result = valor1 DIV valor2;
        return result;
    end $$
Delimiter ;

select fn_Division(20,5);


Delimiter $$
	create procedure sp_InsertarSuma()
    begin
		insert into Datos(suma)
        values (fn_Sumatoria);
    end $$
Delimiter ;

call sp_InsertarSuma;
Delimiter $$
	create function fn_hora(valor1 int)
    returns varchar(20)
	READS SQL DATA DETERMINISTIC
    begin
		declare horas int;
        declare minutos int;
        declare seg int;
        declare mensaje varchar(20);
			Set mensaje = '';
            set horas = valor1 div 3600;
            set minutos = (valor1 % 3600) % 60;
            set seg = (valor1 % 3600) % 60;
            set mensaje = concat (horas, ':', minutos, ':', seg);
		return mensaje;
    end $$
Delimiter ;

select fn_hora(3970);

Delimiter $$	
	create function fn_moneda(valor1 DECIMAL)
    returns varchar(20)
    READS SQL DATA DETERMINISTIC
    begin
        declare moneda int;
        declare mensaje varchar(20);
			set mensaje = '';
			set moneda = valor1 div 200;
            set mensaje = concat('Q ', moneda);
	return mensaje;
    end $$
Delimiter ;

/*Delimiter $$	
	create function fn_moneda2(valor1 DECIMAL)
    returns varchar(20)
    READS SQL DATA DETERMINISTIC
    begin
        declare moneda int;
        declare mensaje varchar(20);
			set mensaje = '';
			set moneda = (truncate(valor1,2)-floor(valor1)) * 100;
            set mensaje = concat('Q ', moneda);
	return mensaje;
    end $$
Delimiter ;

drop function fn_moneda2;

select fn_moneda2(2385.80);
select fn_moneda(2385.80);*/

select floor(2385.80);

select truncate(2385.80,0);

select (truncate(2385.80,2) - floor(2385.80))*100

Delimiter $$
	create function fn_ValoresCase (Valor1 int) returns varchar(30)
    READS SQL DATA DETERMINISTIC
    Begin 
		Case(valor1)
			when 1 then
				return 'Uno';
			when 2 then
				return 'Dos';
			when 3 then
				return 'Tres';
			when 4 then
				return 'Cuatro';
			when 5 then
				return 'Cinco';
			else 
				return 'No esta en el rango';
		End case;
End$$
Delimiter ;


select fn_ValoresCase(8) as Resultado;

Delimiter $$
	create function fn_mayor2 (Valor1 int, Valor2 int) returns varchar(35)
    READS SQL DATA DETERMINISTIC
    Begin
		Case (valor=valor2)
			when True then
				return 'Son iguales';
			when False then
				Case (Valor1<Valor2)
					when true then
						return concat('El mayor es: ', valor1);
					when false then 
						return concat('El Mayor es;', valor2);
				end case;
			end case;
    End$$
Delimiter ;

							
-- ---------------- EJEMPLOS CICLO WHILE --------------

Delimiter $$
	Create function fn_EjemploWhile(vueltas int) returns int
		READS SQL DATA DETERMINISTIC
		Begin
			declare cont integer default 1;
            while (cont < vueltas) do
				set cont = cont + 1;
			end while;
            return cont;
        ENd $$
Delimiter ;

select fn_EjemploWhile(50) as Cantidad_de_Vueltas;

-- ------------- Sumatoria de los primeros 10 numeros enteros -------------

Delimiter $$
    Create function fn_Suma10(vueltas int) returns int
        READS SQL DATA DETERMINISTIC
        Begin
            declare cont int default 0;
            declare suma int default 0;
            while (cont < vueltas) do
                set cont = cont + 1;
                set suma = suma + cont;
            End while;
            return suma;
        End $$
Delimiter ;

select fn_Suma10(100) as Resultado;

-- ----------------- Factorial de 5 -----------------------

Delimiter $$
	Create function fn_Factorial(valor int) returns int
		READS SQL DATA DETERMINISTIC
		Begin
			declare cont int default 0;
            declare factorial int default 1;
				While (cont < valor) do
					set cont = cont + 1;
                    set factorial = factorial * cont;
				End while;
                return factorial;
        End $$
Delimiter ;

select fn_Factorial(5) as Resultado;

-- ------------------ Ejemplo Repeat --------------------------
select floor(rand()*10);

-- drop function fn_Aleatorios 

Delimiter $$
	Create function fn_Aleatorios(cant int) returns varchar(150)
		READS SQL DATA DETERMINISTIC
        Begin
			declare cont int default 0;
            declare num int default 0;
            declare resultado varchar(150);
            set resultado = '';
            repeat
				set cont = cont + 1;
                set num = floor(rand()*10);
                set resultado = concat(resultado, num, ', ');
			Until (cont = cant)
            end Repeat;
            return resultado;
        End $$
Delimiter ;

select fn_Aleatorios(5) as Números;