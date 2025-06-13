reset;
model;

# Conjuntos
param N integer >0; # Cantidad de nodos
set Nodos:= 1..N;
param Nodo_Inicio integer >=1 <=N;

# Parametros
param distancia{Nodos, Nodos} >0 default Infinity;

# Conjuntos
set Arcos within {Nodos, Nodos}:= {i in Nodos, j in Nodos: distancia[i,j] < Infinity};

# Variables
var X{Arcos} binary;
var u{Nodos} integer >=1 <=N;


# Funcion objetivo
minimize Z: 
	sum{(i,j) in Arcos} distancia[i,j]*X[i,j];

# Restricciones
s.t. Inicio:
	u[Nodo_Inicio] = 1;
	
s.t. Salidas {i in Nodos}:
	sum{j in Nodos: (i,j) in Arcos} X[i,j] = 1;
	
s.t. Entradas {j in Nodos}:
	sum{i in Nodos:(i,j) in Arcos} X[i,j] = 1;

s.t. Subtours {(i,j) in Arcos: i!=j}:
	u[i] - u[j] + N*X[i,j] <= N-1;

# Datos
data 3_TSP.dat;

# Configuraciones del solver
option solver cplex;
display Arcos;
expand;
solve;
display Z, u, X;


