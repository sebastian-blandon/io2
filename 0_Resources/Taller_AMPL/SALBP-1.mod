reset;
model;
## SALBP-1: minimiza la cantidad de estaciones

# Conjuntos
set Tareas;
param N:= card(Tareas); # Cantidad de tareas
set Estaciones:= 1..N;
set Precedencias within {Tareas,Tareas};

# Parametros
param C > 0; # Takt Time
param t{Tareas} >0; # Tiempo de procesamiento de cada tarea

# Variables
var X{Tareas,Estaciones} binary; # Asignar la tarea i en la estacion j
var Y{Estaciones} binary; # Abrir la estacion j
var S{Estaciones} >=0; # Tiempo de ciclo de cada estacion
var max_S >= 0; # Para almacenar el maximo de Sj
var idle{Estaciones} >=0; # Tiempo ocioso de cada estacion


# Funcion objetivo
minimize Z: sum{j in Estaciones} Y[j];

# Restricciones
s.t. R1{j in Estaciones}: # No sobrepasar el Takt Time
	sum{i in Tareas} t[i] * X[i,j] <= C*Y[j];
	
s.t. R2{i in Tareas}: # Una estacion en una tarea
	sum{j in Estaciones} X[i,j] = 1;
	
s.t. R3{(k,i) in Precedencias}: # Precedencias
	sum{j in Estaciones} j * X[k,j] <= sum{j in Estaciones} j * X[i,j];
	
s.t. R4{j in Estaciones: j<=(N-1)}:
	Y[j+1] <= Y[j];
	
s.t. R5{j in Estaciones}:
	S[j] = sum{i in Tareas} t[i] * X[i,j];
	
s.t. R6{j in Estaciones}:
	max_S >= S[j]; 
	
s.t. R7{j in Estaciones}:
	idle[j] = max_S - sum{i in Tareas} t[i] * X[i,j];
	
	
# Datos
data SALBP-1.dat;


# Configuraciones del solver
option solver highs;
expand;
solve;
option omit_zero_cols 1;
option omit_zero_rows 1;
printf "Cantidad de estaciones= %g\n", Z;
display X, Y, S, idle;
printf "Eficiencia= %g\n", (sum{i in Tareas} t[i] /(max_S*(sum{j in Estaciones} Y[j])))*100;

