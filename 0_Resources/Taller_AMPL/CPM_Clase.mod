reset;
model;

# CONJUNTOS
set Actividades;
set Precedencias within {Actividades,Actividades};

# PARAMETROS
param CN{Actividades} >=0; # Costo Normal de cada tarea i
param CA{Actividades} >=0; # Costo Acelerado de cada tarea i
param CM{Actividades} >=0; # Costo Marginal de cada tarea i
param TN{Actividades} >=0; # Tiempo Normal de cada tarea i
param TA{Actividades} >=0; # Tiempo Acelerado de cada tarea i

# VARIABLES
var Y{Actividades} binary; # Decisión de ejecutar cada actividad i bajo modalidad normal
var Z{Actividades} binary; # Decisión de ejecutar cada actividad i bajo modalidad acelerada
var X{Actividades} >=0; # Tiempo de terminación de la tarea i
var T{Actividades} >=0; # Tiempo de procesamiento de la tarea i
var DP >=0; # Duración del proyecto

# FUNCION OBJETIVO
minimize Costo_Total:
	sum{i in Actividades} (CN[i]*Y[i] + CA[i]*Z[i] + CM[i]*DP);
	#sum{i in Actividades} (CN[i]*Y[i] + CA[i]*Z[i]) + 14*DP;

# RESTRICCIONES
s.t. Precedencia {(j,i) in Precedencias}: # Garantiza el orden de las tareas
	X[i] - X[j] >= T[i];

s.t. Modalidad {i in Actividades}: # Ejecutar cada actividad sólo bajo una modalidad
	Y[i] + Z[i] = 1;
	
s.t. Tiempo_Procesamiento {i in Actividades}: # Asigna un valor a tiempo de procesamiento de cada actividad 
	TN[i]*Y[i] + TA[i]*Z[i] = T[i];

s.t. R4 {i in Actividades: i = "Fin"}: # Define que la duración del proyecto corresponde al momento de terminación de la actividad "Fin"
	DP = X[i];

	
# DATOS
data CPM_Parcial.dat;

# CONFIGURACIONES DEL SOLVER
option solver highs;
option omit_zero_rows 1;
expand;
solve;
display Costo_Total;
printf "La duración del proyecto es de: %g unidades temporales\n", DP; # Esto muestra un mensaje personalizado
display Y, Z, T, X, DP;
