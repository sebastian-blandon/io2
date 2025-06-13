reset;
model;
#SALBP E

#conjuntos 
set Tareas;
#param N:= card(Tareas);
#set Estaciones:= 1..N;
param M > 0, integer; # Número de estaciones definido por el usuario
set Estaciones := 1..M;
set Precedencias within {Tareas,Tareas};

#parametros
 #Takt time 
param t{Tareas} > 0; #tiempo que se demora la tarea(task time)

#variables
var X {Tareas,Estaciones} binary;
var Y {Estaciones} binary;
var S {Estaciones} >=0;
var max_S >=0;
var Ocio {Estaciones} >=0;
var C >= 0, <= 100; #el 100 es por restriccion del ejercicio de diapositiva de salbp-E
#var C >= 0;


#Funcion objetivo 
minimize Z: C*sum{j in Estaciones} Y[j];

#restricciones 
s.t. R1 {j in Estaciones}: 
     sum{i in Tareas} t[i] * X[i,j] <= C*Y[j];
     
s.t. R2 {i in Tareas}:
     sum{j in Estaciones} X[i,j] =1; 
     
s.t. R3 {(k,i) in Precedencias}:
     sum{j in Estaciones} j * X[k,j] <= sum {j in Estaciones} j * X[i,j];
     
s.t. R4 {j in Estaciones: j<=(M-1)}:
	Y[j+1] <= Y[j];
	
#s.t. R5 {j in Estaciones}:							
#S[j] = sum {i in Tareas} t[i] * X[i,j];

#s.t. R6 {j in Estaciones}:
#max_S >= S[j];

#s.t. R7 {j in Estaciones}:
#Ocio [j] = max_S - sum {i in Tareas} t[i] * X[i,j];

	
#sum{i in Tareas} t[i] / max_S*Z;	


#datos 
data Camsalbp-E.dat;

# Solver
option solver bonmin;
option omit_zero_rows 1;
option omit_zero_cols 1;
solve ;
display Z, X, Y, C;
#printf "Eficiencia= %g\n", (sum{i in Tareas} t[i] /(max_S*(M)))*100;
 