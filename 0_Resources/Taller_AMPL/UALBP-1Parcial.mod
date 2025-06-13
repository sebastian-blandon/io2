reset;
model;

# Conjuntos
set Tareas;
set Estaciones:= 1..card(Tareas);
set Precedencias within {Tareas, Tareas};

# Parametros
param t{Tareas} > 0;
param C >0; # Takt Time

# Variables
var Z{Estaciones} binary;
var X{Tareas, Estaciones} binary; # Red original
var Y{Tareas, Estaciones} binary; # Red fantasma

# Funcion objetivo
minimize z: sum{j in Estaciones} Z[j];

# Restricciones
s.t. R1{j in Estaciones}:
	sum{i in Tareas} t[i] * (X[i,j] + Y[i,j]) <= C * Z[j];
	
s.t. R2{i in Tareas}:
	sum{j in Estaciones} (X[i,j] + Y[i,j]) = 1;

s.t. R3{(k,i) in Precedencias}:
	sum{j in Estaciones} j * X[k,j] <= sum{j in Estaciones} j * X[i,j];
	
s.t. R4{(k,i) in Precedencias}:
	sum{j in Estaciones} j * Y[k,j] <= sum{j in Estaciones} j * Y[i,j];
	
s.t. R5{j in Estaciones: j < card(Tareas)}:
	Z[j+1] <= Z[j];

# Datos
data Parcial3Balanceo.dat;

# Restricciones adicionales
s.t. R6{j in Estaciones}:
	X[1,j] + Y[1,j] + X[3,j] + Y[3,j] <= 1;
	
s.t. R7{j in Estaciones}:
	X[1,j] + Y[1,j] + X[4,j] + Y[4,j] <= 1;
	
s.t. R8{j in Estaciones}:
	X[14,j] + Y[14,j] + X[12,j] + Y[12,j] <= 1;
	

# Opciones solver
option solver highs;
option omit_zero_cols 1;
option omit_zero_rows 1;
expand;
solve;
option show_stats 1;
display z, C, X, Y;


# Cálculo de eficiencia fuera del modelo usando un ciclo for
param S{Estaciones} >=0; # Tiempo de ciclo de cada estación
param max_S >= 0; # Para almacenar el máximo de Sj
param idle{Estaciones} >=0; # Tiempo ocioso de cada estación
param efi{Estaciones} >=0, <=100; # Eficiencia de cada estación

# Calcular S[j], max_S, idle[j] y efi[j]
for {j in Estaciones} {
    let S[j] := sum{i in Tareas} (t[i] * X[i,j] + t[i] * Y[i,j]);
}

let max_S := max{j in Estaciones} S[j];

for {j in Estaciones} {
    let idle[j] := max_S - S[j];
    let efi[j] := (S[j] / max_S) * 100;
}

# Mostrar los tiempos y las eficiencias calculadas redondeadas a 2 decimales
for {j in Estaciones: Z[j] = 1} {
    printf "Estación %d: S = %.2f, Idle = %.2f, Eficiencia = %.2f%%\n", j, S[j], idle[j], efi[j];
}


printf "Eficiencia de la línea= %.2f%%\n", (sum{i in Tareas} t[i] /(max_S*z))*100;


