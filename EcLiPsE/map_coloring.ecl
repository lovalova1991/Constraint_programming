:-lib(fd).

map_coloring(L):-
    L=[L1,L2,L3,L4,L5],
    L::[r,g,b,y,p],
    alldifferent(L),
    labeling(L).