padre(alberto,bruno).
padre(alberto,camilla).
padre(alberto,dorothy).
padre(bruno,emma).
padre(bruno,francesco).
padre(francesco,giacomo).
padre(francesco,herbert).
madre(irene,bruno).
madre(irene,camilla).
madre(jennifer,dorothy).
madre(katya,emma).
madre(katya,francesco).
madre(laura,giacomo).
madre(maria,herbert).

%genitore(X,Y):-padre(X,Y).
%genitore(X,Y):-madre(X,Y).

%nonno(X,Y):-padre(X,X1),padre(X1,Y).        %posso anche scrivere padre(X,X1),genitore(X1,Y)
%nonna(X,Y):-madre(X,X1),madre(X1,Y).

fratello(X,Y):-padre(Z,X),madre(M,X),padre(Z,Y),madre(M,Y),X!=Y. %X è fratello di Y se hanno lo stesso padre, la stessa madre e ovviamente non è se stesso


%#show fratello/1.