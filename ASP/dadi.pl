n(1..6).
dadi(1..3).
lanci(1..n).
%ci può essere un solo valore V per il dado D al lancio L
1{res(L,D,V):n(V)}1:-lanci(L),dadi(D).

%non può essere che il dado X batta il dado Y al lancio L
batte(X,Y,L):-dadi(X),dadi(Y),lanci(L), res(L,X,V1), res(L,Y,V2), V1>V2.

%non può essere che un dado X batta Y se non lo batte almeno 3 volte
beats(X,Y):-#count{1:batte(X,Y,L)}>3,dadi(X),dadi(Y),lanci(L).

%non può essere che il dado 1 batta il dado 2
:-beats(1,2).
:-beats(2,3).
:-beats(3,1).

#show beats/n.