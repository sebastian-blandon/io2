reset;
model;

# SETS
set Tareas;
set Precedencias within {Tareas,Tareas};

# PARAMETROS
param T{Tareas} >=0 default 0;

# VARIABLES
var X{Tareas} >=0 integer;

# FUNCION OBJETIVO
minimize Z:
	sum{i in Tareas} X[i];

# RESTRICCIONES
s.t. Orden_Tareas {(j,i) in Precedencias}: # j precede a i
	X[i] - X[j]  >= T[i];


# DATOS
data CPM1_FinishTime.dat;

# SOLVER
option solver highs;
expand;
option ommit_zero_rows 1;
solve;
display X;