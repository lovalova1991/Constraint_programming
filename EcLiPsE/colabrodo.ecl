:-lib(fd).
:-lib(fd_global).
:-[attacchi].


colabrodo(Booldif,Tosum, Costo):-
    findall(D,difese(D),Dif),
    flatten(Dif,Difese),
    findall([Contromis],attacco(_,Contromis),Listcontromisure),
    length(Difese,Ndif),
    length(Booldif,Ndif),
    Booldif::[0,1],
    get_lista(Listcontromisure,Booldif,Tosum),
    vincolo_somma(Tosum,Somme),
    sumlist(Somme,Costo),
    minimize(labeling(Booldif),Costo).


get_lista([],_,[]).
get_lista([[A]|At],Booldif,[[Tosum]|Tosumtail]):-
    difese(A,Booldif,Tosum),
    get_lista(At,Booldif,Tosumtail).

difese([],[],[]).
difese([A|At],[B|Bt],[C|Ct]):-
    C::[0,1],
    B#=1 #=> C#=A,
    B#=0 #=> C#=0,
    difese(At,Bt,Ct).    

vincolo_somma([],0).
vincolo_somma([A|At],[Sum|Sumt]):-
    sumlist(A,Sum),
    Sum#>=1,
    vincolo_somma(At,Sumt).