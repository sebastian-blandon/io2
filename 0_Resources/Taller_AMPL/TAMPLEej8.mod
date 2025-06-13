reset;
model;

# SETS
param N integer >=0;
set Trabajadores:= {1..N};
param M integer >=0;
set Tareas:= {1..M};

# PARAMETROS
param C{Trabajadores,Tareas} >=0;

# VARIABLES
var X{Trabajadores,Tareas} binary;

# FUNCION OBJETIVO
minimize Costo:
	sum{i in Trabajadores, j in Tareas} C[i,j]*X[i,j];

# RESTRICCIONES
s.t. Limite_Trabajadores {j in Tareas}:
	1 <= sum{i in Trabajadores} X[i,j] <= 3;
	
s.t. Limite_Tareas {i in Trabajadores}:
	sum{j in Tareas} X[i,j] <= 1;

# DATOS
data TAMPLEej8.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X;

