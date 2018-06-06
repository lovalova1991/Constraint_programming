:- lib(fd).
:- lib(fd_global).

dice(LA,LB,LC,N):-
	length(LA,N),
	N>0,
	length(LB,N),
	length(LC,N),
	flatten([LA,LB,LC],All),
	All :: 1..6,
	beats(LA,LB),
	beats(LB,LC),
	beats(LC,LA),
	occ(4,All,Nocc),
	minimize(labeling(All),Nocc).

beats(LA,LB):-
	count_beats(LA,LB,Nb),
	length(LA,N),
	Nb*2 #> N.

count_beats([],[],0).
count_beats([A|LA],[B|LB],N):-
	A #> B #<=> C,
	count_beats(LA,LB,N1),
	N #= N1+C.

occ(0,_,0):- !.
occ(K,L,N):-
	occurrences(K,L,N1),
	K1 is K-1,
	occ(K1,L,N2),
	N #= N1+N2.