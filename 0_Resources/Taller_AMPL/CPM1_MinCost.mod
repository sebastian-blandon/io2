reset;
model;

# SETS
set Tareas;
set Precedencias within {Tareas,Tareas};

# PARAMETROS
param H{Tareas} >=0 default 0; # Costo indirecto por periodo de tiempo por tarea i
param C{Tareas} >=0 default 0; # Costo normal para la tarea i
param S{Tareas} >=0 default 0; # Costo acelerado para la tarea i
param P{Tareas} >=0 default 0; # Tiempo normal para la tarea i
param A{Tareas} >=0 default 0; # Tiempo acelerado para la tarea i

# VARIABLES
var X{Tareas} integer >=0; # Tiempo de terminación de la tarea i
var Y{Tareas} binary; # Hacer o no la tarea i en tiempo normal
var Z{Tareas} binary; # Hacer o no la tarea i en tiempo acelerado

# FUNCION OBJETIVO
minimize Costo_Total:
		sum{i in Tareas} (H[i]*X[i] + C[i]*Y[i] + S[i]*Z[i]);

# RESTRICCIONES
s.t. Orden_Tareas {(j,i) in Precedencias}:
	X[i] - X[j]  >= (P[i]*Y[i]+A[i]*Z[i]);
	
s.t. Modalidad {i in Tareas}:
	Y[i] + Z[i] = 1;

# DATOS
data CPM1_MinCost.dat;

# OPCIONES DEL SOLVER
option solver highs;
option ommit_zero_rows 1;
expand;
solve;
display Costo_Total, Y, Z;