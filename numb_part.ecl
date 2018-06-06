%Un problema di number partitioning è definito come segue.
%Il problema consiste nel partizionare i numeri da 1 a N in due insiemi A e B tali che
%A e B hanno la stessa cardinalità
%la somma dei numeri in A è uguale alla somma dei numeri in B
%la somma dei quadrati in A è uguale alla somma dei quadrati in B
%Si scriva un programma CLP(FD) che risolve il problema, dato il valore N.
%Nota Il problema ha soluzione solo per alcuni valori di N.

numb_part(L,N):-
    length(L, N),
    
    