reset;
model;

# SETS
set Jobs;
set Machines;

# PARAMETROS
param Utilidad{Jobs} >=0;
param P{Jobs, Machines} >=0 default 0; # Processing Time
param D{Jobs} >=0; # Demanda de cada trabajo
param A{Machines} >=0 default 0; # Available Time

# VARIABLES
var X{Jobs} integer >=0;

# FUNCION OBJETIVO
maximize Utilidades:
	sum{i in Jobs} Utilidad[i]*X[i];

# RESTRICCIONES
s.t. Tiempo{j in Machines}:
	sum{i in Jobs} P[i,j]*X[i] <= A[j];

s.t. Demanda{i in Jobs}:
	X[i] <= D[i];
	
# DATOS
data TOC.dat;

# SOLVER
option solver highs;
option show_zero_rows 0;
expand;
solve;
display Utilidades, X, Demanda.slack, Tiempo.body, Tiempo.slack;
