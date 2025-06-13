reset;
model;

# Conjuntos
param N >0 integer; # Cantidad de nodos
set Nodos:= 1..N;
set Arcos within {Nodos, Nodos};

# Parametros
param distancia{Arcos} >0;
param Nodo_inicio >0 integer;
param Nodo_fin >0 integer;

# Variables
var X{Arcos} binary;

# Funcion objetivo
minimize Z:
	sum{(i,j) in Arcos} distancia[i,j] * X[i,j];

# Restricciones
s.t. R1 {i in Nodos: i==Nodo_inicio}: # Inicio
	sum{j in Nodos: (i,j) in Arcos} X[i,j] = 1;
	
	
s.t. R2 {j in Nodos: j==Nodo_fin}:
	sum{i in Nodos: (i,j) in Arcos} X[i,j] = 1;
	

s.t. R3 {j in Nodos: j!=Nodo_inicio and j!=Nodo_fin}:
	sum{(i,j) in Arcos} X[i,j] - sum{(j,k) in Arcos} X[j,k] <= 0;	

	
data;
param N:= 8;

set Arcos:=
1 2
1 3
2 5
3 4
3 6
4 6
4 7
4 8
5 7
6 8
7 8;

param distancia:=
1 2 4
1 3 3
2 5 8
3 4 12
3 6 4
4 6 2
4 7 20
4 8 15
5 7 17
6 8 22
7 8 9;

param Nodo_inicio:= 1;

param Nodo_fin:= 1;


# Opciones del solver
option solver highs;
option show_stats 1;
option highs_options 'alg:parallel=on tech:threads=4 tech:outlev_mp=1 tech:outlev=1 tech:miploglev=2';
option omit_zero_rows 1;
expand;
solve;
display Z;
printf("La distancia más corta está dada por la ruta:\n");
display X;


