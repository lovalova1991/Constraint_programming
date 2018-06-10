%Un gruppo di adolescenti va a mangiare in un fast-food e ciascuno di loro decide di acquistare alcuni prodotti fra quelli disponibili 
%(ad esempio, uno potrebbe volere un MaxiBurger, una porzione piccola di patatine e un'aranciata grande).
%Nel fast-food, oltre ai singoli prodotti, si possono acquistare delle combinazioni, dette `menù', che sono più convenienti rispetto 
%al costo dei singoli prodotti. Ad esempio, un MaxiBurger + patatine medie + aranciata media + dessert costa meno della somma dei singoli prodotti. 
%I menù disponibili sono riportati nel file menu.pl; esso contiene dei fatti
%menu(ListaProdotti,Costo).
%dove ListaProdotti è una lista di lunghezza pari ai prodotti disponibili nel fast-food; contiene valori 0 o 1 che rappresentano se il corrispondente 
%prodotto è contenuto nel menù. Costo è il costo del menù.
%Gli amici decidono di mettere insieme tutte le loro richieste e di acquistare combinazioni di menù in modo da minimizzare la spesa totale.
%Si scriva un programma CLP che risolve il problema; il predicato principale dovrà prendere in ingresso una lista di richieste, 
%che si suppone abbia lunghezza pari al numero di prodotti in vendita nel fast-food, e dovrà fornire la combinazione ottima.

:-lib(fd).
:-[menu].

fast_food(Lrich,Lout):-
    findall([Menu],menu(Menu,_),Matricemenu),
    findall(C,menu(_,C),Costi),
    length(Lrich, N),
    length(Costi,M),
    N#=M,   %vincolo non obbligatorio ma per fare in modo che la lunghezza in ingresso sia giusta
    length(Lout,Matricemenu),
    sumlist(Lrich,Nmax),
    Lout::0..Nmax,


    %non capisco neanche la soluzione, lui calcola la trasposta e poi fa il prodotto scalare, non so perchè

    
    

