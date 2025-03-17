reset;  # Elimina las variables, parámetros y soluciones previas
model;  # Indica el inicio del modelo

# Conjunto de artículos disponibles
set ITEMS;

# Parámetros
param value {ITEMS} >= 0;  # Valor de reventa de cada artículo
param weight {ITEMS} >= 0;  # Peso de cada artículo
param volume {ITEMS} >= 0;  # Volumen de cada artículo
param available {ITEMS} >= 0, integer;  # Cantidad disponible de cada artículo
param max_weight >= 0;  # Peso máximo permitido
param max_volume >= 0;  # Volumen máximo permitido

# Variables
var X {ITEMS} >= 0, integer;  # Cantidad de cada artículo a seleccionar

# Función objetivo (maximizar la ganancia total)
maximize Total_Profit:
    sum {i in ITEMS} value[i] * X[i];

# Restricciones
s.t. Weight_Constraint:
    sum {i in ITEMS} weight[i] * X[i] <= max_weight;

s.t. Volume_Constraint:
    sum {i in ITEMS} volume[i] * X[i] <= max_volume;

s.t. Availability_Constraint {i in ITEMS}:
    X[i] <= available[i];  # Restricción de disponibilidad de cada artículo

# Cargar los datos desde el archivo externo
data Ejercicio1.5.dat;

# Opciones del solver
option solver highs;
expand;  # Expande el modelo para verificarlo
solve;
display Total_Profit, X;
