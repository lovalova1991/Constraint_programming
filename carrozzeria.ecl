%Un robot deve verniciare le carrozzerie delle automobili.
%Le carrozzerie arrivano in una sequenza; per ogni carrozzeria viene indicato il colore di cui deve essere verniciata. 
%Ad esempio, una sequenza potrebbe essere 
%rosso, giallo, rosso, verde, giallo.
%All'interno della sequenza, è possibile fare dei piccoli spostamenti, fino ad un valore costante MaxD: 
%se un'auto arriva in posizione n, allora la si può spostare nelle posizioni da n−MaxD a n+MaxD.
%Se dopo aver verniciato una carrozzeria, il robot deve cambiare colore, allora deve effetturare una costosa operazione di 
%pulizia degli ugelli.
%Si trovi la sequenza ottima che soddisfa tutti i vincoli e che minimizza il numero di cambi di colore.
%Nell'esempio riportato sopra, con MaxD=1 si può tenere la prima auto in posizione 1, la seconda spostata in posizione 3, 
%la terza viene spostata in posizione 2 (in questo modo le due rosse sono vicine), la verde va in ultima posizione mentre 
%la quinta auto viene anticipata alla posizione 4 (in questo modo le due gialle sono vicine). Il costo di questa soluzione 
%è quindi 2 (un cambio di colore dal rosso al giallo ed uno dal giallo al verde).

:-lib(fd).

carrozzeria(Lin,MaxD,Lris):-
    length(Lin, N),
    length(Lris,N),
    Lris::[1..N],
    vincolo_spostamento(Lris,MaxD,1),   %mi serve un contatore per sapere a che punto della lista sono
    alldifferent(Lris),
    obiettivo(Lin,Lris,Tominimize),
    minimize(labeling(Lris),Tominimize).

obiettivo(_,[_],0):-!.
obiettivo([First|Tail],[Color|Coltail], Nmosse):-
    loop(First,Tail,Color,Coltail,Nmosse1),
    obiettivo(Tail,Coltail,Nmosse2),
    Nmosse#=Nmosse1+Nmosse2.

loop(_,[],_,[],0).
loop(First,[_|Tail], Color,[Color|Coltail],Nmosse):-!,
    loop(First,Tail,Color,Coltail,Nmosse).
loop(First,[P1|Ptail],Color,[Color1|Coltail],Nmosse):-!,
    Color\=Color1,
    First-P1#=1#<=>Bool1,
    P1-First#=1#<=>Bool2,
    Nmosse#=Nmosse+Bool1+Bool2,
    loop(First,Ptail,Color,Coltail,Nmosse).

vincolo_spostamento([],_,_).
vincolo_spostamento([A|B],MaxD,Count):-
    A-Count #<= MaxD,
    Count-A #<= MaxD,
    Count1 is Count+1,
    vincolo_spostamento(B,MaxD,Count1).
    