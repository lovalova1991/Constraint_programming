file(1,2).
file(2,4).
file(3,5).
file(4,1).
file(5,2).
file(6,3).
file(7,4).
file(8,7).
file(9,3).
file(10,4).
file(11,7).
file(12,3).
file(13,4).
file(14,7).
file(15,3).
file(16,4).
file(17,7).
file(18,3).
file(19,4).
file(20,7).

{cd(X,Dim)}:-file(X,Dim).
%non è possibile che scrivo file con somma superiore a 60
:-#sum{S,X:cd(X,S)}=Somma,Somma>60.
%massimizzo
#maximize{Dim,X:cd(X,Dim)}.