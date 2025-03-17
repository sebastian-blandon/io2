reset;
model;

# Variables
var X1 >=0 integer;
var X2 >=0 integer;

# FO
maximize Z:
	21000*X1 + 20000*X2;
	
# Restricciones
s.t. R1:
	35*X1 + 40*X2 <= 200;
	
s.t. R2:
	12*X1 + 10*X2 <= 60;
	

# Solver
option solver highs;
option presolve 0;
solve;
display Z, X1, X2;

