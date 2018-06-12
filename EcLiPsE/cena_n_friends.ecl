%Una donna vuole invitare N amici a cena.
%Per N(N-1)/6 giorni vuole organizzare delle cene con esattamente 3 amici ciascuna,
%in modo tale che gli stessi 2 amici non si trovino due(o più) volte a ena insieme.
%In altre parole, in ciascuno dei giorni ci devono essere 3 invitati e l'intersezione degli invitati di due giorni diversi
%può essere al massimo di una persona.

:-lib(fd).
:-lib(fd_sets).

n_friends(L,N):-
    N1 is N*(N-1)/6,
    intsets(L,N1,1,N),
    vincolo_card(L),
    vincolo_intersezione(L),
    fine(L).

fine([]).
fine([A|B]):-
    insetdomain(A,_,_,_),
    fine(B).


vincolo_interesezione([]).
vincolo_interesezione([A|B]):-
    intersezione_loop(A,B),
    vincolo_interesezione(B).

intersezione_loop(_,[]).
intersezione_loop(A,[B|C]):-
    fd_sets:intersection(A,B,Inters),
    I::0..1,
    #(Inters,I),
    intersezione_loop(A,C).



vincolo_card([]).
vincolo_card([A|B]):-
    #(A,3),
    vincolo_card(B).
    