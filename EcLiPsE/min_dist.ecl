%Data una lista di interi L, è facile calcolare qual è la distanza minima fra due elementi di L. 
%Ad esempio, nella lista [3,8,1,5,11], la distanza minima è 2, che si ottiene con 3-1, oppure con 5-3.
%Dati in ingresso due naturali N e Num, si scriva un programma CLP(FD) che genera una lista di N numeri 
%compresi fra 1 e Num che massimizza la distanza minima fra gli elementi della lista (si supponga N≥Num).

:-lib(fd).

distanza(N,Num,L):-
    length(L,N),
    L::[1..Num],
    %trovo la minima distanza con un loop
    min_dist(L,Min),
    %se voglio massimizzare devo invertire il segno
    Tomax #= -Min,
    Min::0..Num,
    alldifferent(L),
    minimize(labeling([Min|L]),Tomax).


min_dist([],_).
min_dist([A|B],Min):-
    loop_min_dist(A,B,Min),
    min_dist(B,Min).

loop_min_dist(_,[],_).
loop_min_dist(A,[B|C],Min):-
    (A-B#=<Min #\/ B-A#>=Min),
    loop_min_dist(A,C,Min).