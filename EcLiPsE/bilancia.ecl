:-lib(fd).
:-lib(fd_global).

bilancia(L,Max):-
    length(L, 4),
    L::[1..40],
    sumlist(L,40),
    set_vincoli(L,Max),
    labeling(L).


set_vincoli([A,B,C|_],Max):-
    A#=1,
    Newmax is Max-1,
    [B,C]::[2..Newmax],
    fd_global:alldifferent([A,B,C]),
    sumlist([A,B,C],Max).

    