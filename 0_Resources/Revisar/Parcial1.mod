reset;
model;

# Conjuntos
set Productos;

# Parametros
param precio_uni{Productos} >=0;
param madera_req{Productos} >=0;
param tiempo_req{Productos} >=0;
param Madera_disp >=0;
param Tiempo_disp >=0;

# Variables
var X{Productos} >=0;

# FO
maximize Z:
	sum{i in Productos} precio_uni[i] * X[i];
	
# Restricciones
s.t. Madera:
	sum{i in Productos} madera_req[i] * X[i] <= Madera_disp;
	
s.t. Tiempo:
	sum{i in Productos} tiempo_req[i] * X[i] <= Tiempo_disp;
	
s.t. R1:
	X['americana'] <=2;
	
s.t. R2:
	X['provenzal'] >= 4;
	
s.t. R3:
	X['americana'] <=1;
	
s.t. R4:
	X['provenzal'] >=5;
	


# Datos
data Parcial1.dat;

# Opciones del solver
option solver highs;
option presolve 0;
option highs_options 'alg:parallel=on tech:threads=8 tech:outlev_mp=1 tech:outlev=1 tech:miploglev=2';
#expand;
solve;
display Z, X, Madera.slack, Tiempo.slack;


