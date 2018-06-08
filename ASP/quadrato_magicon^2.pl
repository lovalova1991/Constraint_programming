size(1..4).
values(1..16).

%per ogni riga e colonna esiste un solo valore
1{cella(X,Y,V):values(V)}1:-size(X),size(Y).

%i valori nel quadrato devono essere unici:>esiste un unico valore V per ogni cella
1{cella(X,Y,V):size(X),size(Y)}1:-values(V).

%non può essere che la differenza tra il valore di una cella e i suoi adiacenti sia minore di k

:-cella(X,Y,V1),cella(X,Y+1,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X+1,Y,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X,Y-1,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X-1,Y,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X+1,Y+1,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X+1,Y-1,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X-1,Y-1,V2),|V2-V1|<k.
:-cella(X,Y,V1),cella(X-1,Y+1,V2),|V2-V1|<k.

#show cella/3.