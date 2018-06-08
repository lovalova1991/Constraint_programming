%definisco il dominio del quadrato

lato(1..3).
valore(1..9).
diag(1..2). %non capisco perchè

%devo assegnare esattamente un valore alla cella X,Y.
1{cella(X,Y,Val):valore(Val)}1:-lato(X),lato(Y).

%somma_colonna
somma_col(X,S):-S=#sum{Val:cella(X,L,Val),lato(L)},lato(X).
somma_riga(Y,S):-S=#sum{Val:cella(L,Y,Val),lato(L)},lato(Y).
%ovviamente ci sono due diagonali
somma_diag(1,S):-S=#sum{Val:cella(L,L,Val),lato(L)}. %somma cella (1,1),(2,2),(3,3)...
somma_diag(2,S):-S=#sum{Val:cella(L,3-L+1,Val),lato(L)}.

%vincoli
%non può essere che ci siano le colonne con la somma diversa
diff:-lato(X1),lato(X2),X1<X2,somma_col(X1,S1),somma_col(X2,S2), S1!=S2.
%non può essere che ci siano righe con somma diversa
diff:-lato(Y1),lato(Y2),Y1<Y2,somma_riga(Y1,S1),somma_riga(Y2,S2), S1!=S2.
%non può essere che ci siano diagonali con somma diversa
diff:-somma_diag(1,S1),somma_diag(2,S2), S1!=S2.
%non può essere che la somma di una riga sia diversa dalla somma di una colonna (basta solo la prima)
diff:-somma_col(1,Scol),somma_riga(1,Srig), Scol!=Srig.
%non può essere che la somma di una riga sia diversa dalla somma di una diagonale
diff:-somma_riga(1,Srig),somma_diag(1,Sdiag), Srig!=Sdiag.
%non può essere che la somma di una colonna sia diversa dalla somma di una diagonale
diff:-somma_col(1,Scol),somma_diag(1,Sdiag), Scol!=Sdiag.

%nego tutti i vincoli precedenti
:-diff.
%impongo tutti i valori diversi
:-lato(X1),lato(X2),lato(Y),X1<X2,valore(V),cella(X1,Y,V),cella(X2,Y,V).
:-lato(X),lato(Y1),lato(Y2),Y1<Y2,valore(V),cella(X,Y1,V),cella(X,Y2,V).
#show cella.