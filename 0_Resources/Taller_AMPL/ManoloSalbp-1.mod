reset;
model;
#SALBP 1

#conjuntos 
set Tareas;
param N:= card(Tareas);
set Estaciones:= 1..N;
set Precedencias within {Tareas,Tareas};

#parametros
param C > 0; #Takt time 
param t{Tareas} > 0; #tiempo que se demora la tarea(task time)

#variables
var X {Tareas,Estaciones} binary;
var Y {Estaciones} binary;
#var S {Estaciones} >=0;
#var max_S >=0;
#var Ocio {Estaciones} >=0;



#Funcion objetivo 
minimize Z: sum{j in Estaciones} Y[j];

#restricciones 
s.t. R1 {j in Estaciones}: 
     sum{i in Tareas} t[i] * X[i,j] <= C*Y[j];
     
s.t. R2 {i in Tareas}:
     sum{j in Estaciones} X[i,j] =1;
     
s.t. R3 {(k,i) in Precedencias}:
     sum{j in Estaciones} j * X[k,j] <= sum {j in Estaciones} j * X[i,j];
     
s.t. R4 {j in Estaciones: j<=(N-1)}:
	Y[j+1] <= Y[j];
	
s.t. R5 {j in Estaciones}:
S[j] = sum {i in Tareas} t[i] * X[i,j];

s.t. R6 {j in Estaciones}:
max_S >= S[j];

s.t. R7 {j in Estaciones}:
Ocio [j] = max_S - sum {i in Tareas} t[i] * X[i,j];

s.t. R8 {j in Estaciones}:
max_S/S[j]*4;


#datos 
data ManoloSalbp-1.dat;

# Solver
option solver highs;
option omit_zero_rows 1;
option omit_zero_cols 1;
solve ;
display Z, X, Y;