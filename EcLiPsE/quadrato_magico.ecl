:-lib(fd).
:-lib(fd_global).
:-lib(matrix_util).


quadrato_magico(Result,N):-
    Max is N*N,
    matrix(N,N,R,C),
    R::[1..Max],
    C::[1..Max],
    somma(R,Value),
    somma(C,Value),
    rompi_simm(R),
    rompi_simm(C),
    flatten(R,Result),
    fd_global:alldifferent(Result),
    labeling(Result).

somma([],_).
somma([Riga|Tail],Value):-
    sumlist(Riga,Value),
    somma(Tail,Value).

rompi_simm([_]).
rompi_simm([A,B|C]):-
    %impone che le righe devono essere ordinate, in modo da eliminare tutte le simmetrie ed eliminare la complessità intrinseca
    lexico_le(A,B),
    rompi_simm([B|C]).
    