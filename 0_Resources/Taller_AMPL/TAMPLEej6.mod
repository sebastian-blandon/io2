reset;
model;

# SETS
set Productos;

# PARAMETROS
param MC{Productos} >=0;
param D{Productos} integer >=0;
param MP{Productos} >=0;
param MP_max >=0;
param MO{Productos} >=0;
param MO_max >=0;
param HM{Productos} >=0;
param HM_max >=0;

# VARIABLES
var X{Productos} integer >=0;

# FUNCION OBJETIVO
maximize Utilidad_Marginal:
	sum{i in Productos} MC[i]*X[i];

# RESTRICCIONES
s.t. Demanda{i in Productos}:
	X[i] <= D[i];
	
s.t. Materia_Prima:
	sum{i in Productos} MP[i]*X[i] <= MP_max;
	
s.t. Mano_Obra:
	sum{i in Productos} MO[i]*X[i] <= MO_max;
	
s.t. Horas_Maquina:
	sum{i in Productos} HM[i]*X[i] <= HM_max;

# DATOS
data TAMPLEej6.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Utilidad_Marginal, X, Materia_Prima.body, Mano_Obra.body, Horas_Maquina.body;


