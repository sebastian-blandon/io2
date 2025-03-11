reset;
model;

# Conjuntos
set Medio;

# parametros
param Alcance{Medio} >=0;
param Costo{Medio} >=0;
param presupuesto_maximo >=0;

# Variables
var X{Medio} >=0 integer; # Cantidad a contratar de cada medio 

# Funcion objetivo
maximize Alcance_total:
	sum{i in Medio} Alcance[i] * X[i]; 

# Restricciones
s.t. Presupuesto:
	sum{i in Medio} Costo[i] * X[i] <= presupuesto_maximo;
	
# Datos
data 1-1a.dat;
	
# Opciones del solver
option solver highs;
expand;
solve;
display Alcance_total, X;

