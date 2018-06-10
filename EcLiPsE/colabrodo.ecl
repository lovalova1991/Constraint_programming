%L'azienda Colabrodo S.r.l. ha deciso di cambiare le politiche di sicurezza dei suoi server.
%Sono stati identificati un certo numero di tipologie di attacco che un hacker potrebbe tentare di effettuare; 
%per difendersi da questi attacchi, sono state identificate anche delle strategie di difesa. 
%Fortunatamente, alcune strategie di difesa sono in grado di proteggere da più tipologie di attacco.
%Un file attacchi.pl contiene i dati sui possibili attacchi e le possibili difese.
%L'elenco delle possibili strategie di difesa è riportato in un fatto 
%difesa(ListaDifese)
%che contiene una lista con gli identificatori delle possibili strategie di difesa.
%Si ha poi un predicato
%attacco(Tipologia,ListaContromisure)
%che, per ciascuna tipologia di attacco, lista le possibili difese. In particolare, la ListaContromisure ha la stessa lunghezza della ListaDifese. 
%L'elemento di indice i della ListaContromisure ha valore
%1, se la difesa di indice i nella ListaDifese è in grado di proteggere dall'attacco della data Tipologia
%0, altrimenti.
%Si scriva un programma CLP(FD) che trova il numero minimo di difese da implementare affinché i server siano protetti da tutte le tipologie di attacco.

:-lib(fd).
:-lib(fd_global).
:-[attacchi].


colabrodo(Booldif,Tosum, Costo):-
    findall(D,difese(D),Dif),
    flatten(Dif,Difese),
    findall([Contromis],attacco(_,Contromis),Listcontromisure),
    length(Difese,Ndif),
    length(Booldif,Ndif),
    Booldif::[0,1],
    get_lista(Listcontromisure,Booldif,Tosum),
    vincolo_somma(Tosum,Somme),
    sumlist(Somme,Costo),
    minimize(labeling(Booldif),Costo).


get_lista([],_,[]).
get_lista([[A]|At],Booldif,[[Tosum]|Tosumtail]):-
    difese(A,Booldif,Tosum),
    get_lista(At,Booldif,Tosumtail).

difese([],[],[]).
difese([A|At],[B|Bt],[C|Ct]):-
    C::[0,1],
    B#=1 #=> C#=A,
    B#=0 #=> C#=0,
    difese(At,Bt,Ct).    

vincolo_somma([],0).
vincolo_somma([A|At],[Sum|Sumt]):-
    sumlist(A,Sum),
    Sum#>=1,
    vincolo_somma(At,Sumt).