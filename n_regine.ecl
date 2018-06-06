:-lib(fd).
:-lib(fd_global).

n_regine(L,N):-
    length(L,N),
    L::1..N,
    fd:alldifferent(L),
    diagonale(L),
    labeling(L).

diagonale([]).
diagonale([H|T]):-
    vincolo(H,T,1),
    diagonale(T).

vincolo(_,[],_).
vincolo(H,[X|T],C):-
    H#\=X+C,
    H#\=X-C,
    C1 is C+1,
    vincolo(H,T,C1).

    