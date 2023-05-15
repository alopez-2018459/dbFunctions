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
    Primary Key PK_codigoDato(codigoDato)
);

-- -------- PROCDIMIENTO ALMACENADO --------
-- -------- AGREGAR -------- 
Delimiter $$
	Create procedure sp_AgregarDato(in num1 int, in num2 int)
		Begin
			Insert Into Datos(num1, num2)
				Values(num1, num2);
        End $$
Delimiter ;

call sp_AgregarDato(3,5);

-- -------- LISTAR --------
Delimiter $$
	Create procedure sp_ListarDato()
		Begin
			Select
				D.num1,
                D.num2,
                D.suma,
                D.resta,
                D.multiplicacion,
                D.division
				from Datos D;
        End $$
Delimiter ;

call sp_ListarDato();

Select D.num1 + D.num2 from Datos D;

Delimiter $$
	Create function fn_Sumatoria(valor1 int, valor2 int) returns int 
        reads sql data deterministic
        Begin
            return valor1 + valor2;
        End $$
Delimiter ;

Select fn_Sumatoria(3,4) as Resultado;

-- EJERCICIO --
-- SUMA --

Select fn_Sumatoria(D.num1, D.num2) as Resultado from Datos D;

-- EJERCICIO 2 --
-- RESTA --

Delimiter $$
	Create function fn_Resta(valor1 int, valor2 int) returns int
        reads sql data deterministic
        Begin
			Declare result int;
            set result = valor1 - valor2;
            return result;
        End$$
Delimiter ;

Select fn_Resta(D.num1, D.num2) as Diferencia from Datos D;

-- MULTIPLICACION --

Delimiter $$
	Create function fn_Multi(valor1 int, valor2 int) returns int
        reads sql data deterministic
        Begin
            return valor1 * valor2;
		End$$
Delimiter ;

Select fn_Multi(D.num1, D.num2) as Producto from Datos D;

-- DIVISON --

Delimiter $$
	Create function fn_Division(valor1 int, valor2 int) returns int
        reads sql data deterministic
        Begin
            return valor1 DIV valor2;
		End$$
Delimiter ;

Select fn_Division(D.num1, D.num2) as Cociente from Datos D;

-- EDITAR DATOS --

Delimiter $$
	Create procedure sp_EditarDato(in codDat int)
		Begin
			Update Datos D
				set suma = fn_Sumatoria(D.num1, D.num2),
					resta = fn_Resta(D.num1, D.num2),
					multiplicacion = fn_Multi(D.num1, D.num2),
					division = fn_Division(D.num1, D.num2)
						where codigoDato = codDat;
		End $$
Delimiter ;

-- 3,5,2

-- -----------Resultado de la 1era raíz -----------

Delimiter $$
	Create function fn_Raiz1(a int, b int, c int) returns decimal
		reads sql data deterministic
			Begin
				return (-b+sqrt((b*b)-(4*a*c)))/(2*a);
            End$$
Delimiter ;

-- -----------Resultado de la 2da raíz -----------

Delimiter $$
	Create function fn_Raiz2(a int, b int, c int) returns decimal(10.5)
		reads sql data deterministic
			Begin
				declare resultado decimal(10.5);
                declare numerador decimal(10.5);
                declare denominador decimal(10.5);
				set numerador = b - sqrt((b*b)-(4*a*c));
                set denominador = 2*a;
				set resultado = numerador / denominador;
                return resultado;
            End$$
Delimiter ;

Select fn_Raiz1(3, 5, 2) as Raíz_1;
Select fn_Raiz2(3, 5, 2) as Raiz_2;

-- ----------- MAYOR DE 2 NÚMEROS -----------
-- drop function fn_MayorDeDos

Delimiter $$
	Create function fn_MayorDeDos(valor1 int, valor2 int) returns varchar(100)
		reads sql data deterministic
		Begin
			if (valor1 > valor2) then
					return 'El primer valor es mayor';
				elseif (valor1 < valor2) then
					return 'El segundo valor es mayor';
				else
					return 'Ambos son iguales';
			end if;
        End$$
Delimiter ;

select fn_MayorDeDos(5, 5) as Mayor;

-- --------------- Positivo Negativo ----------------
Delimiter $$
	Create function fn_PosNega(valor1 int) returns varchar(25)
		reads sql data deterministic
		Begin
			if (valor1 > 0) then
				return 'El valor es positivo';
			else
				return 'El valor es negativo';
			end if;
        End $$
Delimiter ;

select fn_PosNega(-1);

-- ------------------ Cociente y Residuo -----------------------

Delimiter $$
	Create function fn_CocRes(valor1 int, valor2 int) returns varchar(150)
		reads sql data deterministic
        Begin
			declare cociente int;
            declare residuo int;
            declare mensaje varchar(150);
            set mensaje = '';
            set cociente = valor1 div valor2;
            set residuo = valr1 % valor2;
            set mensaje = concat('La division es: ', cociente, 'El residuo es: ', residuo);
            return mensaje;
        End $$
Delimiter ;

select fn_CocRes(8,2) as Resultado;