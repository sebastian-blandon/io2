reset;
model;

# SETS
set Producto;
set Bodega;

# PARAMETROS
param C{Producto, Bodega} >=0 default 0;
param Dem{Producto} >=0;
param I{Producto, Bodega} >=0 default 0;
param I_max >=0;
param F{Producto, Bodega} >=0 default 0;
param F_max >=0;
param M14{Producto, Bodega} >=0 default 0;
param M14_max >=0;
param Disp{Producto, Bodega} >=0 default 0;

# VARIABLES
var X{Producto, Bodega} >=0;

# FUNCION OBJETIVO
minimize Costo:
	sum{i in Producto, j in Bodega} C[i,j]*X[i,j];

# RESTRICCIONES
s.t. Peso {i in Producto}:
	sum{j in Bodega} X[i,j] = Dem[i];
	
s.t. Req_Inertes {i in Producto: i="Cal"}:
	sum{j in Bodega} I[i,j]*X[i,j] <= I_max*Dem[i];
	
s.t. Req_Finos {i in Producto: i="Grava"}:
	sum{j in Bodega} F[i,j]*X[i,j] <= F_max*Dem[i];
	
s.t. Req_M14 {i in Producto: i="Grava"}:
	sum{j in Bodega} M14[i,j]*X[i,j] >= M14_max*Dem[i];
	
s.t. Disponibilidad {i in Producto, j in Bodega}:
	X[i,j] <= Disp[i,j];
	
s.t. R1:
	X['Grava','G1'] >= 4267;
	
s.t. R2:
	X['Grava', 'G2'] >= 1332;
	
s.t. R3:
	X['Grava', 'G4'] >= 2400;

# DATOS
data TAMPLEej7.dat;

# SOLVER
option presolve 0;
option solver highs;
option show_stats 1;
option omit_zero_rows 1;
expand;
solve;
display Costo, X, Disponibilidad.slack;

