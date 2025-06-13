reset;
model;

# Conjuntos
param M integer > 0; # Cantidad de estaciones
set Estaciones:= 1..M;
set Tareas;
set Precedencias within {Tareas,Tareas};

# Parametros
param t{Tareas} > 0;

# Variables
var C >=0, <= 100;
var Y{Estaciones} binary;
var X{Tareas, Estaciones} binary;


# Funcion objetivo
minimize Z: C * sum{j in Estaciones} Y[j];

# Restricciones
s.t. R1{j in Estaciones}:
	sum{i in Tareas} t[i] * X[i,j] <= C * Y[j];
	
s.t. R2{i in Tareas}:
	sum{j in Estaciones} X[i,j] = 1;
	
s.t. R3{(k,i) in Precedencias}:
	sum{j in Estaciones} j * X[k,j] <= sum{j in Estaciones} j * X[i,j];
	
s.t. R4{j in Estaciones: j < M}:
	Y[j+1] <= Y[j];

# Datos
data SALBP-EBase.dat;


# Opciones solver
option solver bonmin;
option omit_zero_rows 1;
option omit_zero_cols 1;
expand;
solve;
option show_stats 0;
display C, X, Y;
