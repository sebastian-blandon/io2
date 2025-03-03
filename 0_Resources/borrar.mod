reset; # Elimina las variables, parámetros y soluciones previas
model; # Indica el inicio del modelo

# Conjunto de medios de publicidad
set MEDIA;

# Parámetros
param cost {MEDIA} >= 0; # Costo por unidad de publicidad
param reach {MEDIA} >= 0; # Audiencia alcanzada por unidad
param min_tv >= 0; # Mínimos minutos requeridos en TV
param budget >= 0; # Presupuesto total disponible
param talent {MEDIA} >= 0; # Requerimiento de talento por unidad
param available_talent >= 0; # Disponibilidad total de talento

# Variables
var X {MEDIA} >= 0; # Cantidad de inversión en cada medio

# Función objetivo (maximizar la audiencia total)
maximize Audience:
sum {m in MEDIA} reach[m] * X[m];

# Restricciones
s.t. Budget_Limit:
sum {m in MEDIA} cost[m] * X[m] <= budget;

s.t. TV_Minimum:
X[&quot;TV&quot;] >= min_tv;

s.t. Talent_Constraint:
sum {m in MEDIA} talent[m] * X[m] <= available_talent;

# Cargar los datos desde el archivo externo
data borrar.dat;

# Opciones del solver
option solver highs;
expand; # Expande el modelo para verificarlo
solve;
display Audience, X;