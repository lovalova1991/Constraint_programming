:-lib(fd).

golomb(L,Ntacche, Max):-
    length(L, Ntacche),
    length(D,Max),
    L::0..Max,
    alldifferent(L),
    imposezero(L),
    imposeend(L,Max),
    ordered(<,L),
    vincolo(L,D),
    alldifferent(D),
    labeling(D).

imposezero([X|_]):-
    X#=0.

imposeend([X],Val):-
    X#=Val.
imposeend([_|T],Val):-
    imposeend(T,Val).

vincolo([],[]).
vincolo([H|T],D):-
    vincolo2(H,T,D,D1),
    vincolo(T,D1).

% mi fermo quando sono arrivato all'ultimo, quindi quando la distanza è uguale
vincolo2(_,[],D,D).
vincolo2(X,[Y|T],[D|D0],D1):-
    D#=(Y-X),
    vincolo2(X,T,D0,D1).

