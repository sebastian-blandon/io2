reset;
model;

# SETS
set Tareas;
set Precedencias within {Tareas,Tareas};

# PARAMETROS
param CH{Tareas} >=0 default 0; # Costo horario de la tarea i
param CN{Tareas} >=0 default 0; # Costo normal de la tarea i
param CA{Tareas} >=0 default 0; # Costo acelerado de la tarea i
param TN{Tareas} >=0 default 0; # Tiempo normal de la tarea i
param TA{Tareas} >=0 default 0; # Tiempo acelerado de la tarea i

# VARIABLES
var X{Tareas} integer >=0; # Tiempo de Procesamiento de la tarea i
var Y{Tareas} binary; # Ejecutar tarea i en modalidad TN
var Z{Tareas} binary; # Ejecutar tarea i en modalidad TA
var TFP{Tareas} integer >=0; # Tiempo de fin más próximo de la tarea i
var TIP{Tareas} integer >=0; # Tiempo de inicio más próximo de la tarea i
var TFL{Tareas} integer >=0; # Tiempo de finalización más lejano de la tarea i
var TIL{Tareas} integer >=0; # Tiempo de inicio más lejano de la tarea i
var H{Tareas} integer >=0; # Holgura de la tarea i 

# FUNCION OBJETIVO
minimize Costo_Total:
	#sum{i in Tareas} (CH[i]*X[i] + CN[i]*Y[i] + CA[i]*Z[i]); # Para calcular costo mínimo
	sum{i in Tareas} X[i]; # Para calcular duración

# RESTRICCIONES
s.t. Tiempo_Procesamiento {i in Tareas}: # El tiempo de procesamiento de la tarea i será el normal o el acelerado
	TN[i]*Y[i] + TA[i]*Z[i] = X[i];
	
s.t. Modalidad {i in Tareas}: # Cada tarea sólo se puede ejecutar en una modalidad
	Y[i] + Z[i] = 1;
	
s.t. Fin_Temprano {(j,i) in Precedencias}: # j precede i
	TFP[i] - TFP[j] >= X[i];
	



# DATOS
data CPM_Sofi.dat;

# OPCIONES DEL SOLVER
option solver highs;
option ommit_zero_rows 1;
expand;
solve;
display Costo_Total, Y, Z, X, TIP, TFP, TIL, TFL;
