reset;
model;

# SETS
param N >=0 integer; # Cantidad de tareas
set Tarea:= {1..N};
set Estacion:= {1..N};
set Precedencia within {Tarea,Tarea};

# PARAMETROS
param C >=0; # Takt Time
param P{Tarea} >=0; # Tiempo de procesamiento de cada tarea

# VARIABLES
var Y{Estacion} binary; # Abrir estaciones
var X{Tarea,Estacion} binary; # Asignar una estacion a cada tarea

# FUNCION OBJETIVO
minimize Z:
	sum{j in Estacion} Y[j];

# RESTRICCIONES
s.t. TaktTime {j in Estacion}:
	sum{i in Tarea} P[i]*X[i,j] <= C*Y[j];
	
s.t. AsignaTarea {i in Tarea}:
	sum{j in Estacion} X[i,j] = 1;

s.t. Precedencias {(k,i) in Precedencia}:
	sum{j in Estacion} j*X[k,j] <= sum{j in Estacion} j*X[i,j];

s.t. CrearEstaciones {j in Estacion: j+1<=N}:
	Y[j+1] <= Y[j];

# DATOS
data AssemblyLineBalancing.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Y, X;