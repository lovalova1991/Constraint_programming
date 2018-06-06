%Un commerciante del 1850 pesava le sue merci con una bilancia a due piatti. Su uno dei piatti poneva le merci,
%mentre sull'altro metteva dei pesi di misura nota.
%Un giorno, un peso da 40 grammi gli cadde e si spezzò in quattro parti. Verificando il peso dei quattro pezzi, 
%constatò che ognuno dei pezzi pesava un numero intero di grammi. Inoltre, usando i pezzi come pesetti, 
%riusciva a pesare qualunque oggetto con un peso (intero) compreso fra 1 e 7 grammi.
%Si scriva un programma CLP(FD) che trova il peso dei quattro pezzi.


:-lib(fd).
:-lib(fd_global).

bilancia(L,Max):-
    length(L, 4),
    L::[1..40],
    sumlist(L,40),
    set_vincoli(L,Max),
    labeling(L).


set_vincoli([A,B,C|_],Max):-
    A#=1,
    Newmax is Max-1,
    [B,C]::[2..Newmax],
    fd_global:alldifferent([A,B,C]),
    sumlist([A,B,C],Max).

    