reset; # limpiar las variables, parametros y soluciones previas
model;

# conjuntos
set Productos;
set Tipo_ficha;

# parametros
param Utilidad{Productos} >0;
param Fichas_req{Tipo_ficha,Productos} >=0;
param TF{Tipo_ficha} >=0; # Total de Fichas disponibles

# variables
var X{Productos} >=0 integer; # Cantidad a fabricar del producto j

# funcion objetivo
maximize Ganancias:
	sum{j in Productos} Utilidad[j]*X[j];
	
# restricciones
s.t. Fichas_maximas{i in Tipo_ficha}:
	sum{j in Productos} Fichas_req[i,j]*X[j] <= TF[i];
	
# datos
data Ejemplo01_compacto2.dat;

# opciones del solver
option solver highs;
expand;
solve;
display Ganancias, X, Fichas_maximas.body, Fichas_maximas.slack;

