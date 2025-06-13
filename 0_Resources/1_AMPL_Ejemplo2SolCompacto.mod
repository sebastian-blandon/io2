reset;
model;

# conjuntos
set Productos;
set Areas_trabajo;

# parametros
param Tiempo_Procesamiento{Productos, Areas_trabajo} >= 0;
param Capacidad{Areas_trabajo} >=0;
param Demanda{Productos} >=0;
param utilidad{Productos} >=0;
param penalidad{Productos} >=0;

# variables
var X{Productos} >=0;

# funcion objetivo
maximize Z:
	sum{i in Productos} utilidad[i] * X[i] - sum{i in Productos} penalidad[i] * max(Demanda[i] - X[i] , 0);

# restricciones
s.t. Capacidades {j in Areas_trabajo}:
	sum{i in Productos} Tiempo_Procesamiento[i,j] * X[i] <= Capacidad[j];
	
s.t. Demandas {i in Productos}:
	X[i] <= Demanda[i];
	
# datos
data 1_AMPL_Ejemplo2SolCompacto.dat;

# opciones del solver
expand;
option presolve 0;
option solver highs;
solve;
display Z, X, Capacidades.body, Capacidades.slack, Demandas.body, Demandas.slack;


