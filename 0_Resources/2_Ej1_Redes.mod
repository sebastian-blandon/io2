reset;
model;

# Variables
var X12 binary;
var X13 binary;
var X25 binary;
var X34 binary;
var X36 binary;
var X47 binary;
var X46 binary;
var X48 binary;
var X57 binary;
var X68 binary;
var X78 binary;


# Funcion objetivo
minimize Distancia_total:
4*X12+3*X13+8*X25+12*X34+4*X36+20*X47+2*X46+15*X48+17*X57+22*X68+9*X78;

# Restricciones
s.t. R1:
	X12+X13 = 1;
	
s.t. R2:
	X48+X68+X78 = 1;
	
s.t. R3:
	X12-X25<=0;
	
s.t. R4:
	X25-X57<=0;
	
s.t. R5:
	X57-X78<=0;
	
s.t. R6:
	X13-X34-X36<=0;
	
s.t. R7:
	X34-X46-X47-X48<=0;
	
s.t. R8:
	X46+X36-X68<=0;
	
	
option solver cplex;
solve;
display Distancia_total, X12, X13, X25, X34, X36, X47, X46, X48, X57, X68, X78;	
	
