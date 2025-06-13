reset;
model;

# SETS
param N integer >=0;
set Jabones:= {1..N};

# PARAMETROS
param H_max >=0;
param A_max >=0;
param S_max >=0;
param P{Jabones} >=0;
param H{Jabones} >=0;
param A{Jabones} >=0;
param S{Jabones} >=0;

# VARIABLES
var X{Jabones} integer >=0;

# FUNCION OBJETIVO
maximize Ingresos:
	sum{i in Jabones} P[i]*X[i];

# RESTRICCIONES
s.t. Horas_Maquina:
	sum{i in Jabones} H[i]*X[i] <= H_max;
	
s.t. Acido_Graso:
	sum{i in Jabones} A[i]*X[i] <= A_max;

s.t. Sosa_Caustica:
	sum{i in Jabones} S[i]*X[i] <= S_max;

# DATOS
data TAMPLEej1.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Ingresos, X, Horas_Maquina.body, Acido_Graso.body, Sosa_Caustica.body;

