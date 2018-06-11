%Un neonato deve mangiare 10 volte al giorno, ad intervalli di 3 ore al massimo, comprese le ore della notte (anche quelle a cavallo della mezzanotte). 
%Il papà e la mamma hanno deciso di dividersi il compito di dare le poppate al figlio (5 il papà e 5 la mamma), in modo che ciascuno di loro abbia un 
%intervallo di ore in cui riesce a dormire che sia il più lungo possibile.
%Si scriva un programma CLP che stabilisce gli orari in cui il bambino riceverà le poppate. Si consideri come funzione obiettivo da massimizzare il 
%numero di ore in cui riesce a dormire il genitore che dorme di meno fra i due.
%Ad esempio, se la mamma dà le poppate delle ore 0, 4, 10, 14, 20, vuol dire che riuscirà a dormire 6 ore (dalle 4 alle 10). 
%Se il papà dà le poppate delle 3, 7, 12, 17, 23, vuol dire che ha a disposizione 5 ore di sonno consecutive (ad esempio, dalle 12 alle 17). 
%Il valore della funzione obiettivo è 5, in quanto il genitore che ha meno ore di sonno consecutive è il papà, che dorme 5 ore di seguito.

:-lib(fd).
:-lib(fd_global).

poppate(Lmamma,Lpapa,Lpoppate):-
    length(Lmamma, 5),
    length(Lpapa, 5),
    append(Lmamma, Lpapa, Lpoppate),
    Lpoppate::0..23,
    ordered(<,Lpoppate),
    fd_global:alldifferent(Lpoppate),
    max_ore(Lpoppate),
    %assumo che la prima poppata la fa la mamma all'ora 0
    first_poppata(Lmamma,Lpapa),
    intervalli(Lmamma,InterMamma),
    intervalli(Lpapa,InterPapa),
    maxlist(InterMamma,Oresonnomamma),
    maxlist(InterPapa,Oresonnopapa),
    minlist([Oresonnomamma,Oresonnopapa], Minoresonno),
    %nego per massimizzare
    Tomax #= -Minoresonno,
    minimize(labeling(Lpoppate),Tomax).


first_poppata([Mfirst|_],[Pfirst|_]):-Mfirst #= 0, Pfirst #\=0.

max_ore([_]).
max_ore([A,B|C]):-
    B-A #<= 3,
    max_ore([B|C]).


intervalli([_],[]).
intervalli([A,B|C],[Inter|Linter]):-
    B-A #= Inter,
    intervalli([B|C],Linter).
    