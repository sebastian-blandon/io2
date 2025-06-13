reset;
model;

# SETS
set Productos;

# PARAMETROS
param I{Productos} >=0;
param P{Productos} >=0;
param Peso_max >=0;

# VARIABLES
var X{Productos} binary;


# FUNCION OBJETIVO
maximize Ingreso:
	sum{i in Productos} I[i]*X[i];

# RESTRICCIONES
s.t. Peso:
	sum{i in Productos} P[i]*X[i] <= Peso_max;

# DATOS
data TAMPLEej3.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 0;
expand;
solve;
display Ingreso, X, Peso.body;


