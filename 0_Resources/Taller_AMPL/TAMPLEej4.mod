reset;
model;

# SETS
param N integer >=0;
set Equipos:= {1..N};

# PARAMETROS
param C{Equipos} >=0;
param Control{Equipos} >=0;
param Control_min >=0;

# VARIABLES
var X{Equipos} integer >=0;

# FUNCION OBJETIVO
minimize Costo:
	sum{i in Equipos} C[i]*X[i];

# RESTRICCIONES
s.t. Req_Control:
	(sum{i in Equipos} Control[i]*X[i]) / (sum{i in Equipos} X[i]) >= Control_min;

s.t. Equipos_Q:
	sum{i in Equipos} X[i] = 4;

# DATOS
data TAMPLEej4.dat;

# SOLVER
option solver bonmin;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X, Req_Control.body;


