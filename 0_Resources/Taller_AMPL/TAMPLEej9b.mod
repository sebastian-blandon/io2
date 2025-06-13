reset;
model;

# SETS
set Nodos;
set Arcos within {Nodos cross Nodos};

# PARAMETROS
param Costo{Arcos} >=0;
param Suministro{Nodos} >=0 default 0;
param Demanda{Nodos} >=0 default 0;

# VARIABLES
var X{Arcos} integer >=0;

# FUNCION OBJETIVO
minimize Costo_Total:
	sum{(i,j) in Arcos} Costo[i,j]*X[i,j];

# RESTRICCIONES
s.t. Balance {k in Nodos}:
	Suministro[k] + sum{(i,k) in Arcos} X[i,k]>=
	Demanda[k] + sum{(k,j) in Arcos} X[k,j];
	
# DATOS
data TAMPLEej9b.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo_Total, X, Balance.body, Balance.slack;