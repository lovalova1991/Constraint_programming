coord(1..n).

%metto una sola regina per colonna
1{regina(X,Y):coord(X)}1:-coord(Y).
%non ci possono essere regine sulla stessa riga
:-coord(X),coord(Y1),coord(Y2),regina(X,Y1),regina(X,Y2),Y1!=Y2.
%non è possibile che ci siano due regine nella stessa diagonale
:-coord(X1),coord(X2),coord(Y1),coord(Y2),regina(X1,Y1),regina(X2,Y2),X1!=X2,|X2-X1|=|Y2-Y1|.

#show regina/2.