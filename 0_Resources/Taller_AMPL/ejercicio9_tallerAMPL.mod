reset;
model;

# CONJUNTOS
set Fabricas;
set Distribuidores;

# Parámetros
param Produccion{Fabricas};  # Producción mensual de cada fábrica
param Demanda{Distribuidores};  # Demanda mensual de cada distribuidor
param Costo{Fabricas, Distribuidores};  # Costo de transporte desde cada fábrica a cada distribuidor

# Variables
var CantidadEnviada{Fabricas, Distribuidores} >= 0;  # Cantidad enviada desde cada fábrica a cada distribuidor

# Función Objetivo
minimize CostoTotal: sum{i in Fabricas, j in Distribuidores} Costo[i,j] * CantidadEnviada[i,j];

# Restricciones
subject to ProduccionMaxima{i in Fabricas}: sum{j in Distribuidores} CantidadEnviada[i,j] <= Produccion[i];
subject to DemandaSatisfecha{j in Distribuidores}: sum{i in Fabricas} CantidadEnviada[i,j] >= Demanda[j];


# DATOS
data ejercicio9_tallerAMPL.dat;

# CONFIGURACIONES DEL SOLVER
option solver cplex;
expand;# Muestra la notacion expandida del problema
option show_stats 1; # Muestra estadisticas del problema, como la cantidad de variables y restricciones
option omit_zero_rows 1; # No muestra las filas cuyo valor sea 0
solve;
display CostoTotal;

# Mostrar resultados
printf {i in Fabricas, j in Distribuidores} "Cantidad enviada desde fábrica %s a distribuidor %s: %g\n", i, j, CantidadEnviada[i,j];
printf "Costo total de transporte: %g\n", CostoTotal;
