%genera tutte le possibili permutazioni di una lista
:-lib(fd).

permutations(L,Lres):-
    length(L, N),
    fattoriale(N,Fattor),
    length(Lres,Fattor),
    perm(Lres,N).

perm([A|B],N):-
    %definisco il dominio
    A::1..N,
    %è un bel casino XD
    


fattoriale(0,1).
fattoriale(N,Fatt):-
    N1#=N-1,
    fattoriale(N1,Fatt1),
    Fatt#=N*Fatt1.

    


    