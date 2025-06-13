reset;

# variables
var X1 >=0; # Cantidad de mesas
var X2 >=0; # Cantidad de sillas

# funcion objetivo
maximize Ganancias: 16*X1+13*X2;

# restricciones
s.t. R1: X1+2*X2 <= 17; # Max fichas de 8 pines

s.t. R2: 
	3*X1+2*X2 <= 18; # Max fichas de 4 pines
	
# solver
option solver cplex;
solve;
display Ganancias, X1, X2;