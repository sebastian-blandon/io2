reset;
model;

# Conjuntos
set Medio;

# parametros
param Alcance{Medio} >=0;
param Costo{Medio} >=0;
param presupuesto_maximo >=0;
param personwk{Medio} >=0; # Cantidad de tiempo requerido en cada medio
param personwk_max >=0;

# Variables
var X{Medio} >=0 integer; # Cantidad a contratar de cada medio 

# Funcion objetivo
maximize Alcance_total:
	sum{i in Medio} Alcance[i] * X[i]; 

# Restricciones
s.t. Presupuesto:
	sum{i in Medio} Costo[i] * X[i] <= presupuesto_maximo;
	
s.t. Person_week:
	sum{i in Medio} personwk[i] * X[i] <= personwk_max;
	
s.t. Magazine_pages_min:
	X['Magazine'] >= 2;
	
s.t. Radio_max:
	X['Radio'] <= 120;
	
# Datos
data 1-1d.dat;
	
# Opciones del solver
option solver highs;
expand;
solve;
display Alcance_total, X;