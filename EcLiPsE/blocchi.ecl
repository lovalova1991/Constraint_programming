%Un bambino ha due collezioni di N blocchi numerati da 1 a N e vuole mettere i blocchi in sequenza in modo che:
%i due blocchi '1' abbiano 1 blocco che li separa
%i due blocchi '2' abbiano 2 blocchi che li separano
%...
%i due blocchi 'N' abbiano N blocchi che li separano.
%Ad esempio, una soluzione per N=4 è la seguente:
%4	1	3	1	2	4	3	2
%Si scriva un programma CLP per ECLiPSe che, dato un numero N, risolve questo problema.
%Suggerimento: Si noti che non è richiesto che l'output sia fornito nello stesso formato indicato in precedenza: 
%lo studente è libero di mostrare l'output come preferisce.

:-lib(fd).
:-lib(fd_global).

blocchi(N,L):-
    %dato che abbiamo due blocchi, creo una lista di dimensioni doppie rispetto a N
    N2 is N*2,
    length(L, N2),
    L::1..N2,
    fd_global:alldifferent(L),
    vincoli(L,1),
    labeling(L).
    
vincoli([],_).
vincoli([A,B|C],Count):-
    A-B #= Count+1,
    Count1 is Count+1,
    vincoli(C,Count1).
%il risultato che esce
%L = [4, 2, 8, 5, 7, 3, 6, 1]
%vuol dire:
%L = [4, 1, 3, 1, 2, 4, 3, 2]
