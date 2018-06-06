%Esercizio TSP
%Un commesso viaggiatore deve passare per un insieme di città e poi tornare alla città iniziale, 
%percorrendo meno chilometri possibile.
%Le distanze fra le città sono riportate in un file distanze.pl,in un insieme di fatti dista/3 , 
%dove i primi due parametri rappresentano due città, mentre il terzo è la distanza fra le due in km. 
%Le città sono rappresentate da dei numeri interi positivi. La città iniziale è indicata con 1. 
%Nello stesso file distanze.pl è anche definito un fatto ncitta/1 che contiene il numero di città.
%Si scriva un programma ECLiPSe che calcola il percorso di lunghezza minima. 
%Si consiglia di generare una lista in cui il primo elemento è la prima città da visitare, 
%il secondo è la seconda città visitata, ..., l'ultima è l'ultima città da visitare (ovvero di nuovo la 1).
%Suggerimento Per calcolare la distanza fra le città può essere utile la libreria propia.
:-lib(fd).
:-[distanze].
:-lib(propia).
:-lib(fd_global).

commesso(Percorso):-
    %prendo il numero di città
    findall(N,ncitta(N),[N]),
    %creo lista di città da visitare + ultima che deve essere uguale alla prima
    M is N+1,
    length(Percorso, M),
    Percorso::[0..N],
    %creo lista di distanze per ogni città, in modo che poi possa minimizzare la somma delle distanze
    length(Distanze,N),
    Distanze::[0..100],

    %impongo lo start
    imposestart(Percorso),
    %impongo la fine uguale allo start
    imposefinish(Percorso),
    %vincolo che ovviamente non visito la stessa città due volte. Alldifferent non funziona perchè ho appena imposto che
    %il primo e l'ultimo elemento siano uguali!!
    %alldifferent(Percorso),
    diversi(Percorso),
    %calcolo distanza
    distanza(Percorso,L),
    %sommo lista per minimizzare
    sumlist(L,Sum),
    min_max(labeling(Percorso),Sum).


imposestart([First|_]):-First#=1.

imposefinish([Last]):-Last#=1.
imposefinish([_|L]):-imposefinish(L).

distanza([P1,P2],[L]):-
    dista(P1,P2,Dist) infers fd,
    L#=Dist.
distanza([P1,P2|Rest],[L|Lrest]):-
    dista(P1,P2,Dist) infers fd,
    L#=Dist,
    distanza([P2|Rest], Lrest).
    
diversi([_]).
diversi([A|Resto]):-
    vincolodiv(A,Resto),
    diversi(Resto).

vincolodiv(_,[C]).
vincolodiv(A,[B|C]):-
    A#\=B,
    vincolodiv(A,C).

