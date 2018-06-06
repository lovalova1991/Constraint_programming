%In molti sistemi operativi (ad es. le distribuzioni Debian di Linux) i software installabili sono suddivisi in pacchetti. 
%Ogni pacchetto disponibile può essere installato o non installato nel sistema.
%Le informazioni sui pacchetti sono riportate in un file pack_inst.ecl (per ECLiPSe) 
%e in un file pack_inst.asp (per ASP); ciascun pacchetto è rappresentato con un identificatore numerico.
%Esistono pacchetti che sono in conflitto con altri pacchetti; due pacchetti in conflitto non possono essere 
%installati entrambi. Nei file pack_inst.ecl e pack_inst.asp sono riportati dei fatti conflict(X,Y), 
%che indicano che i pacchetti X e Y sono in conflitto. Ad esempio, se è presente il fatto conflict(2,4) 
%significa che il pacchetto con identificatore 2 ed il pacchetto con identificatore 4 non possono essere entrambi installati: 
%se ne può installare uno dei due o nessuno, ma non entrambi.
%Alcuni pacchetti dipendono da altri pacchetti e quindi ne richiedono l'installazione. 
%Un fatto requires(X,Y) indica che se viene installato il pacchetto X, allora si deve installare anche il pacchetto Y 
%(mentre non è detto che installando Y si debba installare anche X).
%Nel momento in cui l'utente richiede l'installazione di un pacchetto, è quindi possibile che debbano essere installati 
%alcuni pacchetti e disinstallati altri. L'utente ha richiesto l'installazione dei pacchetti indicati dai fatti install(X).
%Si desidera trovare il numero minimo di installazioni e disinstallazioni di pacchetti in modo che tutti i vincoli 
%(conflitti e dipendenze) siano rispettati.
%Si risolva il problema usando ECLiPSe. Nel file pack_inst.ecl sono riportati:
%un fatto package(Pacchetti), dove Pacchetti è una lista che contiene tutti gli identificativi di pacchetti che possono 
%essere installati un fatto installed(Installati), dove Installati è una lista della stessa lunghezza della lista Pacchetti; 
%l'N-esimo elemento della lista Installati è un valore 0 o 1; 1 indica che il pacchetto nell'N-esimo elemento della lista 
%Pacchetti è iniziamente installato 0 indica che non è inizialmente installato

:-lib(fd).
:-lib(fd_global).
:-[pack_inst].

pacchetti(Linstalled,Lres):-
    findall([A,B],conflict(A,B),Lconflict),
    findall([A,B],requires(A,B),Lrequires),
    findall(A,install(A),Linstall),
    installed(Linstalled),
    package(Lpackage),
    length(Linstalled, Npacchetti),
    length(Lres,Npacchetti),
    Lres::0..1,
    install_constraint(Linstall,Lres),
    require_constraint(Lrequires,Lres),
    conflict_constraint(Lconflict,Lres),
    objective(Linstalled,Lres,Lcost),
    fd_global:sumlist(Lcost,C),
    minimize(labeling(Lres),C).

objective([],[],[]).
objective([A|B],[C|D],[E|F]):-
    A#\=C#<=>E,
    objective(B,D,F).    


conflict_constraint([],_).
conflict_constraint([[A,B]|C],Lres):-
    nth1(A,Lres,Va),
    nth1(B,Lres,Vb),
    Va+Vb#=<1,
    conflict_constraint(C,Lres).


install_constraint([],_).
install_constraint([A|B],Lres):-
    nth1(A,Lres,1),
    install_constraint(B,Lres).
    
require_constraint([],_).
require_constraint([[A,B]|C],Lres):-
    nth1(A,Lres,Va),
    nth1(B,Lres,Vb),
    Va#=<Vb,
    require_constraint(C,Lres).    
    
