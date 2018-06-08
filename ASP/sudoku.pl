%scrivere risolutore ASP sudoku
% _,_,6, _,_,_, _,9,_,
% _,_,_, 5,_,1, 7,_,_,
% 2,_,_, 9,_,_, 3,_,_,
% _,7,_, _,3,_, _,5,_,
% _,2,_, _,9,_, _,6,_,
% _,4,_, _,8,_, _,2,_,
% _,_,1, _,_,3, _,_,4,
% _,_,5, 2,_,7, _,_,_,
% _,3,_, _,_,_, 8,_,_
x(1, 3, 6). x(1, 8, 9).
x(2, 4, 5). x(2, 6, 1). x(2, 7, 7).
x(3, 1, 2). x(3, 4, 9). x(3, 7, 3).
x(4, 2, 7). x(4, 5, 3). x(4, 8, 5).
x(5, 2, 2). x(5, 5, 9). x(5, 8, 6).
x(6, 2, 4). x(6, 5, 8). x(6, 8, 2).
x(7, 3, 1). x(7, 6, 3). x(7, 9, 4).
x(8, 3, 5). x(8, 4, 2). x(8, 6, 7).
x(9, 2, 3). x(9, 7, 8).

%definisco dominio coordinate
coord(1..9).
%definisco dominio valori
valori(1..9).

%per ogni cella posso dare esattamente un valore
1{x(X,Y,V):valori(V)}1:-coord(X),coord(Y).

%nel sudoku ho che la somma dei singoli sottoquadrati deve essere 9. Definisco un sottoquadrato:
quadrato(I,X,Y):-coord(X),coord(Y),I==(X-1)/3+3*((Y-1)/3)+1.

%nella colonna ci deve essere solo un valore tra 1 e 9
1{x(X,Y,V):coord(X)}1:-coord(Y),valori(V).
%nella riga ci deve essere un solo valore tra 1 e 9
1{x(X,Y,V):coord(Y)}1:-coord(X),valori(V).
%nel quadrato ci deve essere solo un valore tra 1 e 9
1{x(X,Y,V):quadrato(I,X,Y)}1:-coord(I),valori(V).