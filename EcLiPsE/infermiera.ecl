:-lib(fd).
:-lib(fd_global).
:-lib(propia).
:-[pazienti].

infermiera(Percorso):-
    findall([Id,Tstart,Tmax],paziente(Id,Tstart,Tmax),Listpazienti),
    length(Listpazienti, N),
    %aggiungo 2 alla lunghezza della lista pazienti per ottenere il percorso contando l'ospedale
    N1 is N+2,
    length(Percorso,N1),
    length(Times,N1),
    fd_global:alldifferent(Times),
    imposestart(Percorso,Times),
    imposelast(Percorso),
    differentiloop(Percorso),
    find_percorso(Percorso,Listpazienti,Times,Costo),
    minimize(labeling(Percorso),Costo).

differentiloop([_]).
differentiloop([A|Tail]):-
    loop(A,Tail),
    differentiloop(Tail).

loop(_,[B]):-B#=0.
loop(A,[B|Tail]):-
    A#\=B,
    loop(A,Tail).

imposestart([A|_],[Time|_]):-A#=0,Time#=0.

imposelast([A]):-A#=0.
imposelast([_|B]):-
    imposelast(B).

find_percorso([],_,[],0).
find_percorso([A|At],[[Id,Tmin,Tmax]|Ttail],[Time|Times],Costo):-
    distanza(A,Id,C) infers fd,
    Costo1 is Costo+C,
    (Time#>=Tmin) #\/ (Time#=<Tmax),
    find_percorso(At,Ttail,Times,Costo1).    

