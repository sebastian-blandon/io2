reset;
model;

# Conjuntos
set Act; #actividades
set P within {Act,Act}; #precedentes

# Parametros
param CN{Act} >=0;
param CA{Act} >=0;
param CM{Act} >=0;
param TN{Act} >=0;
param TA{Act} >=0;

# Variables
var Y{Act} binary; #Decision de inicio inmediato
var Z{Act} binary; #Decision de inicio diferido
var DP >=0; #Duracion del proyecto CAMBIO
var X{Act} >= 0; #Tiempo de inicio
var T{Act} >=0; # CAMBIO

# Funcion objetivo
minimize z:
	sum{i in Act} (CN[i]*Y[i]+CA[i]*Z[i]+CM[i]*DP);

# Restricciones
s.t. R1{(j,i) in P}:
	X[i]-X[j]>=T[i];

s.t. R2{i in Act}:
	Y[i]+Z[i]=1;
	
s.t. R3{i in Act}:
	TN[i]*Y[i]+TA[i]*Z[i]=T[i];

s.t. R4{i in Act:i="Fin"}:
	DP=X[i];

# Datos
data BORRAR.dat;

# Opciones del solver
option solver highs;
solve;
display z, X, Y, Z, DP;
