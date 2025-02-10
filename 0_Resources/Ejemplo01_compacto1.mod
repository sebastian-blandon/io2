reset;
model;

# conjuntos
set Productos;

# parametros
param Utilidad{Productos} >=0;
param FG{Productos} >=0;
param TFG >=0; # Total Fichas Grandes
param FP{Productos} >=0; # Fichas Pequenas
param TFP >=0; # Total Fichas Pequeñas

# variables
var X{Productos} >=0 integer;

# funcion objetivo
maximize Ganancia:
	sum{i in Productos} Utilidad[i]*X[i];
	
# restricciones
s.t. Maximo_FG:
	sum{i in Productos} FG[i]*X[i] <= TFG;
	
s.t. Maximo_FP:
	sum{i in Productos} FP[i]*X[i] <= TFP;

data Ejemplo01_expandido.dat;

# opciones del solver
option solver highs;
expand;
solve;
display Ganancia, X, Maximo_FG.slack;
	