%Il file tessere.pl contiene dei fatti 
%tessera(A,B).
%che rappresentano le tessere di un domino.
%Si desidera creare una sequenza di tessere, tali che due tessere contigue hanno lo stesso numero nel lato comune.
%Le tessere sono tutte diverse, tutte le tessere devono essere usate e ogni tessera può essere usata una sola volta. Le tessere possono essere ribaltate. 
%Ad esempio, date le tessere 
%tessera(1,3).
%tessera(1,4).
%tessera(2,3).	
%si può costruire la sequenza [[4,1],[1,3],[3,2]].
%Si scriva un programma CLP(FD) che risolve questo problema.

:-lib(fd).
:-lib(propia).
:-[tessere].

domino(L):-
    findall((A,B),tessera(A,B),Tessere),
    %devo creare una lista d'uscita con dominio qualsiasi cosa, poi uso propia
    create_tessere(Tessere,L),
    esistono(L),
    diverse(L),
    consecutive(L),
    labeling(flatten(L)).

consecutive([_]).
consecutive([[_,B],[C,D]|Tail]):-
    B#=C,
    consecutive([[C,D]|Tail]).    

diverse([]).
diverse([[A,B],[C,D]|Tail]):-
    loop([A,B],[[C,D]|Tail]),
    diverse([[C,D]|Tail]).

loop([_,_],[]).
loop([A,B],[[C,D]|Tail]):-
    (A#\=C #\/ B#\=D) #/\ (A#\=D #\/ B#\=C),
    loop([A,B],Tail).

create_tessere([],[]).
create_tessere([_|Ltess],[[_,_]|Lvar]):-
    create_tessere(Ltess,Lvar).

esistono([]).
esistono([H|T]):-
    tessera_orientata(H) infers fd,
    esistono(T).

tessera_orientata([A,B]):-tessera(A,B).
tessera_orientata([A,B]):-tessera(B,A).