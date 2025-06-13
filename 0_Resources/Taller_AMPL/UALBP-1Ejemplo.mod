reset;
model;

# Conjuntos
set Tareas;
set Estaciones:= 1..card(Tareas);
set Precedencias within {Tareas, Tareas};

# Parametros
param P{Tareas} > 0;
param C >0; # Takt Time

# Variables
var Z{Estaciones} binary;
var X{Tareas, Estaciones} binary; # Red original
var Y{Tareas, Estaciones} binary; # Red fantasma

# Funcion objetivo
minimize z: sum{j in Estaciones} Z[j];

# Restricciones
s.t. R1{j in Estaciones}:
	sum{i in Tareas} P[i] * (X[i,j] + Y[i,j]) <= C * Z[j];
	
s.t. R2{i in Tareas}:
	sum{j in Estaciones} (X[i,j] + Y[i,j]) = 1;

s.t. R3{(k,i) in Precedencias}:
	sum{j in Estaciones} j * X[k,j] <= sum{j in Estaciones} j * X[i,j];
	
s.t. R4{(k,i) in Precedencias}:
	sum{j in Estaciones} j * Y[k,j] <= sum{j in Estaciones} j * Y[i,j];
	
s.t. R5{j in Estaciones: j < card(Tareas)}:
	Z[j+1] <= Z[j];

# Datos
data UALBP-1Ejemplo.dat;


# Opciones solver
option solver highs;
option omit_zero_cols 1;
option omit_zero_rows 1;
expand;
solve;
option show_stats 1;
display z, C, X, Y;


