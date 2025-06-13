reset;
model;

# SETS
set Nodos;

# PARAMETROS
param C{Nodos,Nodos} >=0 default 0;
param H{Nodos,Nodos} binary default 0;
param Cap{Nodos} >=0 default 0;
param Dem{Nodos} >=0 default 0;
param F{Nodos} binary default 0;
param Nod{Nodos} binary default 1;

# VARIABLES
var X{Nodos,Nodos} integer >=0;

# FUNCION OBJETIVO
minimize Costo:
	sum{i in Nodos, j in Nodos} C[i,j]*X[i,j];

# RESTRICCIONES
s.t. Cap_Fabricas {i in Nodos}:
	sum{j in Nodos} F[i]*H[i,j]*X[i,j] <= Cap[i];
	
s.t. Balance {j in Nodos}:
	sum{i in Nodos} Nod[j]*(H[i,j]*X[i,j] - H[j,i]*X[j,i]) = Dem[j];

# DATOS
data TAMPLEej9.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X, Cap_Fabricas.body, Cap_Fabricas.slack, Balance.body, Balance.slack;


