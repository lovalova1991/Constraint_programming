%Due genitori devono organizzare il mese di giugno per il loro figlio infante, e decidere con chi starà il bimbo 
%ogni giorno del mese. Hanno la possibilità di mandarlo ad un asilo estivo. L'asilo va prenotato, lo si può prenotare 
%per un periodo costituito al massimo da 7 giorni; i giorni devono essere consecutivi. Al momento della prenotazione, 
%si paga il costo per tutti i 7 giorni; il costo dell'asilo è di 100€. (Chiaramente, possono anche pagare i 100€ e non 
%mandare il bambino all'asilo estivo). Ad esempio, se i genitori prenotano l'asilo per il periodo dal 4 al 10 giugno, 
%poi possono mandare il bambino in quei giorni all'asilo. Potrebbero anche decidere di mandarlo per solo alcuni giorni 
%in quell'intervallo; ad esempio il 7 e il 10; non potranno mandarlo all'asilo fuori da quell'intervallo. 
%Come altro esempio, non è possibile mandare il bimbo il 5 e il 28 giugno, perché l'asilo può essere prenotato solo 
%per un periodo di 7 giorni consecutivi.
%Ciascuno dei genitori può prendersi dei giorni di ferie per stare con il bambino; il padre può prendersi fino a 4 giorni, 
%mentre la madre può prendersi fino a 6 giorni. I genitori però non possono prendere le ferie in giorni in cui hanno appuntamenti 
%o impegni lavorativi importanti. Gli impegli lavorativi dei genitori sono riportati in un file impegni.pl; sono indicati con dei 
%fatti
%impegno(Genitore,Giorno)
%dove Genitore può essere 1 (per rappresentare il padre) o 2 (per rappresentare la madre) Giorno è un numero da 1 a 30 
%(i giorni del mese di giugno).Infine, i genitori possono decidere di lasciare il bambino con una baby-sitter, al costo di 50€ 
%al giorno. Si trovi un'organizzazione in cui il bambino è ogni giorno con qualcuno e che minimizza il costo per i genitori.
:-lib(fd).
:-lib(fd_global).
:-[impegni].
% impongo 1 papà, 2 mamma, 3 asilo, 4 babysitter

asilo(L):-
    length(L, 30),
    L::1..4,
    impegno_genit(L,1),
    %conto quanti giorni ha occupati il padre
    occurrences(1,L,Giornipadre),
    Giornipadre::0..4,
    occurrences(2,L,Giornimadre),
    Giornimadre::0..6,
    occurrences(4,L,Giornibaby),
    asilo(L,1,Firstday,Lastday,Boolasilo),
    Lastday-Firstday#<7,
    Costo#=100*Boolasilo+50*Giornibaby,
    min_max(labeling(L),Costo).

asilo([],_,_,_,_).
asilo([A|B],Giorno,Firstday,Lastday,Boolasilo):-
    A#=3#=>Boolasilo,
    A#=3#=>Firstday#=<Giorno,
    A#=3#=>Lastday#>=Giorno,
    Giorno1 is Giorno+1,
    asilo(B,Giorno1,Firstday,Lastday,Boolasilo).



impegno_genit([],_).
impegno_genit([A|T],Contagiorno):-
    findall(G,impegno(G,Contagiorno),Impegni),
    elimina_giorno(A,Impegni),
    Contagiorno1 is Contagiorno+1,
    impegno_genit(T,Contagiorno1).


elimina_giorno(_,[]).
elimina_giorno(A,[B|T]):-
    B#\=A,
    elimina_giorno(A,T).
    