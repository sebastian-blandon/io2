reset;
model;
# Modelo: SALBP-E
# Objetivo: max eficiencia y min estaciones

# Conjuntos 1
set Tareas;
set Precedencias within {Tareas, Tareas};

# Parametros
param t{Tareas} >0;
param Takt_Time >0;
param M:= ceil(sum{i in Tareas} t[i] / Takt_Time)+3;


# Conjuntos 2
set Estaciones:= 1..M; 

# Variables
var X{Tareas,Estaciones} binary;
var C >= 0; # Tiempo de ciclo
var Y{Estaciones} binary; # Decisión de abrir o no una estación


# Funcion objetivo
minimize Z: C*sum{j in Estaciones} Y[j];

# Restricciones
s.t. R1{j in Estaciones}:
	sum{i in Tareas} t[i]*X[i,j] <= C*Y[j];

s.t. R2{i in Tareas}:
	sum{j in Estaciones} X[i,j] = 1;
	
s.t. R3{(k,i) in Precedencias}:
	sum{j in Estaciones} j*X[k,j]  <= sum{j in Estaciones} j*X[i,j];
	
s.t. R41{j in Estaciones: j < M}:
	Y[j+1] <= Y[j];	
	
s.t. R42:
	sum{j in Estaciones} Y[j] <= M;
	

# Datos
data SALBP-EBase.dat;


# Opciones del solver
option solver highs;
option omit_zero_cols 1;
option omit_zero_rows 1;
expand;
solve;

printf "Cantidad de estaciones= %g\n", sum{j in Estaciones} Y[j];
display C, X;

# Cálculo de eficiencia fuera del modelo usando un ciclo for
param S{Estaciones} >=0; # Tiempo de ciclo de cada estación
param max_S >= 0; # Para almacenar el máximo de Sj
param idle{Estaciones} >=0; # Tiempo ocioso de cada estación
param efi{Estaciones} >=0, <=100; # Eficiencia de cada estación


# Calcular S[j], max_S, idle[j] y efi[j]
for {j in Estaciones} {
    let S[j] := sum{i in Tareas} t[i] * X[i,j];
}

let max_S := max{j in Estaciones} S[j];

for {j in Estaciones} {
    let idle[j] := max_S - S[j];
    let efi[j] := (S[j] / C) * 100;
}

# Mostrar los tiempos y las eficiencias calculadas redondeadas a 2 decimales
for {j in Estaciones} {
    printf "Estación %d: S = %.2f, Idle = %.2f, Eficiencia = %.2f%%\n", j, S[j], idle[j], efi[j];
}


printf "Eficiencia de la línea= %.2f%%\n", (sum{i in Tareas} t[i] /Z)*100;

