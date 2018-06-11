%Si vuole generare una matrice binaria (cioè i cui elementi sono 0 o 1) N ×M tale che:
%le righe siano ordinate in ordine lessicografico (ovvero secondo l'ordine alfabetico, supponendo che 0 venga prima di 1);
%si vuole massimizzare la minima distanza di Hamming fra righe consecutive.
%La distanza di Hamming fra due sequenze di bit è il numero di bit diversi nella stessa posizione. Ad esempio, le due sequenze
%1	0	0	1	0
%1	1	0	0	0
%sono a distanza 2 (hanno 2 bit diversi).
%Ad esempio, dati N=4 e M=3 una soluzione ottima è data dalla matrice:
%0	0	0
%0	1	1
%1	0	0
%1	1	1 
%Si scriva un programma ECLiPSe che genera tale matrice.
%Suggerimento   Si vedano sul manuale di ECLiPSe la libreria matrix_util ed il vincolo lexico_le della libreria fd_global.


%NON SI SA PERCHE' NON FUNZIONA

:-lib(fd).
:-lib(fd_global).
:-lib(matrix_util).

matrice(N,M):-
    matrix(N,M,Matrix),
    flatten(Matrix,Flat),
    Flat::0..1,
    distanza(Matrix,Lresult),
    minlist(Lresult,Min),
    Tomax #= -Min,
    minimize(labeling(Flat),Tomax).
    

distanza([],[]).
distanza([A,B|C],[Res|Lres]):-
    distanza_loop(A,B,Res),
    lexico_le(A,B),
    distanza([B|C],Lres).


distanza_loop([],[],0).
distanza_loop([A|B],[C,D],Res):-
    A#\=C #=> Bool,
    distanza_loop(B,D,Res1),
    Res #= Res1+Bool.

