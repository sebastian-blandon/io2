reset;
model;
## SALBP-2: minimiza el tiempo de ciclo, se conoce el # de estaciones

# Conjuntos
param M >0 integer; # Cantidad de estaciones
set Estaciones:= 1..M;
set Tareas;
set Precedencias within {Tareas, Tareas};

# Parametros
param t{Tareas} >=0;

# Variables
var C >=0; # Tiempo de ciclo
var X{Tareas, Estaciones} binary;
var S{Estaciones} >=0; # Tiempo de ciclo de cada estacion
var max_S >= 0; # Para almacenar el maximo de Sj
var idle{Estaciones} >=0; # Tiempo ocioso de cada estacion

# Funcion objetivo
minimize Z: C;

# Restricciones
s.t. R1{i in Tareas}: # Asignar una tarea solo en una estacion
	sum{j in Estaciones} X[i,j] = 1;
	
s.t. R2{j in Estaciones}:
	sum{i in Tareas} t[i] * X[i,j] <= C;
	
s.t. R3{(k,i) in Precedencias}:
	sum{j in Estaciones} j*X[k,j] <= sum{j in Estaciones} j*X[i,j];


s.t. R5{j in Estaciones}:
	S[j] = sum{i in Tareas} t[i] * X[i,j];
	
s.t. R6{j in Estaciones}:
	max_S >= S[j]; 
	
s.t. R7{j in Estaciones}:
	idle[j] = max_S - sum{i in Tareas} t[i] * X[i,j];


# Datos
data SALBP-2.dat;

# Configuraciones del solver
option solver highs;
expand;
solve;
option omit_zero_cols 1;
option omit_zero_rows 1;
display Z, X, S, idle;
printf "Eficiencia= %g\n", (sum{i in Tareas} t[i] /(Z*M))*100;

