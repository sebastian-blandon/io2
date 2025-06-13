reset;
model;

# SETS
param N integer >=0;
set MateriaPrima:= {1..N};

# PARAMETROS
param V_min >=0;
param M_min >=0;
param P_min >=0;
param C{MateriaPrima} >=0;
param V{MateriaPrima} >=0;
param M{MateriaPrima} >=0;
param P{MateriaPrima} >=0;

# VARIABLES
var X{MateriaPrima} >=0;

# FUNCION OBJETIVO
minimize Costo:
	sum{i in MateriaPrima} C[i]*X[i];

# RESTRICCIONES
s.t. Vitaminas:
	sum{i in MateriaPrima} V[i]*X[i] >= V_min;
	
s.t. Minerales:
	sum{i in MateriaPrima} M[i]*X[i] >= M_min;
	
s.t. Proteinas:
	sum{i in MateriaPrima} P[i]*X[i] >= P_min;
	
s.t. Cantidad:
	sum{i in MateriaPrima} X[i] = 1;

# DATOS
data TAMPLEej2.dat;

# SOLVER
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X, Vitaminas.body, Minerales.body, Proteinas.body;

