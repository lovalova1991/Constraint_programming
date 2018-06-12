orario(0..23).
gnre(m;p).
npopp(1..10).


1{poppata(G,N,H):npopp(N)}1:-gnre(G),orario(H).

%non può essere che tra una poppata e la successiva passino più di tre ore

:-poppata(_,N,H), poppata(_,N+1,H1), H1-H<=3.

%non può essere che il padre o la madre facciano più di 5 poppate
:- #sum{1:poppata(m,_,_)} > 5.
:- #sum{1:poppata(p,_,_)} > 5.






