param n; #Numero di valori distinti che G può assumere
param N; #Dimensione degli insiemi su cui sono definite F e G

 
set T:= 1..N; #Insieme su cui vengono definite F e G
set R:= 2..N; #Insieme su cui vengono definiti i vincoli
set A:= 1..n; #Insieme per l' approssimazione 

param y_i{T}; #Valore che assume la funzione F
param F{i in T} = y_i[i]; #Assegnazione dei valori di y a F


var G{T} <= 1 >= 0; #Definizione della variabile G 
var y_r{T}; #Variabile per l' obiettivo
var salto{i in T} binary; # variabile binaria per la posizione del salto

subject to vincolo_FS {i in R} : F[i] >= F[i-1]; #vincolo di continuità del lim dell' intorno destro della funzione F
subject to vincolo_GS {i in R} : G[i] >= G[i-1]; #vincolo di continuità del lim dell' intorno destro della funzione G


subject to valSalto : sum{i in T} (salto[i]) = n-1; #vincolo che assegna il numero di salti da fare
subject to vincoloBinZero{i in T : i > 1} : G[i] <= G[i-1] + salto[i]; #vincolo secondo cui nel caso in cui salto[i] è 1 allora G[i]<=1 
                                                                       #e nel caso in cui sia uguale a zero G[i]<= G[i-1] 

# Vincoli che permettono di rendere la funzione obiettivo lineare
subject to abs1 {i in T} : y_r[i] >= (F[i] - G[i]); #Vincolo che impone che y_r sia maggiore o uguale della differenza
subject to abs2 {i in T} : y_r[i] >= -(F[i] - G[i]); #Vincolo che impone che y_r sia maggiore o uguale della differenza negata

#minimize minimo_salto : 
minimize errore_totale : sum{i in T} (y_r[i]);   



