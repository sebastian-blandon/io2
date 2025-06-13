reset;
model;

# Conjuntos
set Productos;

# Parametros
param precio_unit{Productos} >=0;
param madera_req{Productos} >=0;
param madera_disp >=0;
param tiempo_req{Productos} >=0;
param tiempo_disp >=0;

# Variables
var X{Productos} >=0;

# Funcion objetivo
maximize Z:
	sum{i in Productos} precio_unit[i] * X[i];

# Restricciones
s.t. Madera:
	sum{i in Productos} madera_req[i] * X[i] <= madera_disp;
	
s.t. Tiempo:
	sum{i in Productos} tiempo_req[i] * X[i] <= tiempo_disp;
	
s.t. R1:
	X['Americana'] >= 3;
	
s.t. R2: 
	X['Provenzal'] <= 2;
	
s.t. R3:
	X['Americana'] >= 4;
	

# Datos
data borrar.dat;

# Opciones del solver
option solver highs;
option presolve 0;
expand;
solve;
display Z, X, Madera.slack, Tiempo.slack;




