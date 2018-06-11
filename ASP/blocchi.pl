blocchi(1..8).
values(1..4).

%per ogni posizione ci può essere un solo valore
1{bloc(P,V):values(V)}1:-blocchi(P).

:-bloc(P,V),bloc(P+V+1,V1),V!=V1.