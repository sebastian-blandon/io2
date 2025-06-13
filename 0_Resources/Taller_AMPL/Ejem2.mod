# CONTADORES, INDICES
param N integer >=0; # Cantidad de tareas
param M integer >=0; # Cantidad de personas
set Tareas:= {1..N}; # Conjunto de tareas
set Personas:= {1..M}; # Conjunto de personas

# PARAMETROS
param U{Tareas, Personas} >=0; # Utilidad de asignar la tarea i a la persona j

# VARIABLES
var X{Tareas, Personas} binary; # Variable de decision

# FUNCION OBJETIVO
maximize Utilidad:
	sum{i in Tareas, j in Personas} U[i,j]*X[i,j];

# RESTRICCIONES
s.t. Tarea{i in Tareas}: # Una persona por tarea
	sum{j in Personas} X[i,j] = 1;
	
s.t. Persona{j in Personas}: # Maximo una tarea por persona
	sum{i in Tareas} X[i,j] <= 1;

# CONFIGURACIONES DEL SOLVER
option solver scip; # scip es otro solver, al igual que cbc