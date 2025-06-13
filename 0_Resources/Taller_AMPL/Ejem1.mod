# CONTADORES, INDICES
param N integer >=0; # Cantidad de referencias de botas
set Productos:= {1..N}; # Conjunto de referencias/productos

# PARAMETROS
param P{Productos} >=0; # Precio por cada referencia de botas
param M{Productos} >=0; # Cantidad de materia prima requerida para cada tipo de botas
param T{Productos} >=0; # Cantidad de tiempo requerido por cada tipo de botas
param M_disponible >=0; # Materia prima disponible
param T_disponible >=0; # Tiempo disponible

# VARIABLES
var X{Productos} integer >=0; # Cantidad de pares a producir de cada tipo de botas

# FUNCION OBJETIVO
maximize Ingresos:
	sum{i in Productos} P[i] * X[i];

# RESTRICCIONES
s.t. Materia_Prima:
	sum{i in Productos} M[i] * X[i] <= M_disponible;
s.t. Tiempo:
	sum{i in Productos} T[i] * X[i] <= T_disponible;

# CONFIGURACIONES DEL SOLVER
option solver scip;