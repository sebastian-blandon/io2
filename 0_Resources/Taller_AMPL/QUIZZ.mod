reset;
model; 

set I;
set Precedencias within {I,I};

param N:=7;   
set J:= 1..N; 


param t{I}; 

var ti{J};
var Y{J} binary;
var X{I,J} binary; 
var C>=0; 

data;

set I:= A B C D E F G;

set Precedencias:=

B A
C B
D C
E D
F E
G F
;


param t:=
A 21	
B 30
C 15	
D 24	
E 36	
F 27	
G 12	
;


minimize Cj: 
	C; 



subject to R1{j in J}: 
	sum {i in I} t[i] * X[i,j] <= C ;

subject to R2{i in I}: 
	sum {j in J} X[i,j] =1; 
	
subject to R3 {(k,i) in Precedencias}:
	sum {j in J} j * X[k,j] <= sum {j in J} j* X[i,j];
	


option solver cplex;
solve Cj;
expand;
display Cj,X,C;