reset;
model;

# SETS
set Albaniles;

# PARAMETROS
param S{Albaniles} >=0; # Salario
param Cap{Albaniles} >=0;
param Q_Max{Albaniles} >=0;
param Lad_Req integer >=0;

# VARIABLES
var X{Albaniles} integer >=0; # Cantidad de albaniles

# FUNCION OBJETIVO
minimize Costo:
	sum{i in Albaniles} S[i]*X[i];

# RESTRICCIONES
s.t. Ladrillos:
	sum{i in Albaniles} Cap[i]*X[i] = Lad_Req;
	
s.t. Asigna {i in Albaniles}:
	X[i] <= Q_Max[i];
	
s.t. Asigna_Max:
	sum{i in Albaniles} X[i] <= 10;

# DATOS
data TAMPLEej5.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X, Asigna.body, Asigna.slack;

