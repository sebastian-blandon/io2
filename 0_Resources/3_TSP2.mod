reset;
model;

# --- Parámetros y conjuntos básicos ---
param N integer > 0;                        # número de nodos
param Nodo_Inicio integer >= 1 <= N;        # nodo donde arranca la ruta
set Nodos := 1..N;

# Distancias: por omisión Infinity, deben ser >= 0
param distancia {i in Nodos, j in Nodos}
    default Infinity
    >= 0;

# Arcos (i≠j) con coste finito
set Arcos within {Nodos, Nodos} :=
    { i in Nodos, j in Nodos :
        i <> j
        and distancia[i,j] < Infinity
    };

# --- Variables de decisión ---
var X { (i,j) in Arcos } binary;            # selecciona arco i→j
var u { i in Nodos } integer >= 1 <= N;     # orden en la ruta (MTZ)

# --- Fijar el nodo de inicio y dar orden mínimo a los demás ---
s.t. FixStart:
    u[Nodo_Inicio] = 1;

s.t. MinOrder { i in Nodos : i <> Nodo_Inicio }:
    u[i] >= 2;

# --- Función objetivo ---
minimize TotalCost:
    sum { (i,j) in Arcos } distancia[i,j] * X[i,j];

# --- Grado de salida = 1 ---
s.t. Out { i in Nodos }:
    sum { (i,j) in Arcos } X[i,j] = 1;

# --- Grado de entrada = 1 ---
s.t. In { j in Nodos }:
    sum { (i,j) in Arcos } X[i,j] = 1;

# --- Eliminación de subtours (MTZ) ---
s.t. MTZ { (i,j) in Arcos }:
    u[i] - u[j] + N * X[i,j] <= N - 1;

# --- Datos y solver ---
data 3_TSP.dat;
option solver cplex;

solve;

display TotalCost, u, X;