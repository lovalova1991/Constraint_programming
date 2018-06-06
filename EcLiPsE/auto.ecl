%Un'azienda che produce automobili ha tre linee di montaggio per inserire i tre possibili optional: cerchi in lega, 
%aria condizionata e navigatore satellitare. Si ha una sequenza di richieste, memorizzate nel file automobili.pl; 
%ciascuna richiesta è strutturata come segue:
%rich(Num,Consegna,CerchiLega,AriaCondizionata,Satellitare).
%dove
%Num è un identificatore univoco della richiesta
%Consegna è l'orario massimo di consegna (in minuti)
%CerchiLega, AriaCondizionata e Satellitare sono i possibili optional: essi valgono 1 se l'optional è stato richiesto, 0 altrimenti.
%Si hanno i seguenti vincoli:
%ciascuna automobile può essere mandata in una delle 3 linee di montaggio degli optional (non può essere contemporaneamente in due linee)
%ciascuna linea di montaggio può lavorare su un'automobile alla volta
%l'installazione degli optional ha i seguenti tempi
%cerchi in lega: 20 minuti
%aria condizionata: 80 minuti
%navigatore satellitare: 50 minuti
%Si scriva un programma CLP che stabilisca l'orario in cui vengono montati gli optional sulle auto rispettando tutti i vincoli e minimizzando il tempo totale.

:-lib(fd).
:-lib(edge_finder).
:-[automobili].

auto(Lc,La,Ls):-
    %così leggo il file
    findall([N,Tcons,C,A,S],rich(N,Tcons,C,A,S),Readed),
    %ottengo lunghezza lista
    length(Readed,N),
    %assegno lunghezza agli start
    length(Lc,N),
    length(La,N),
    length(Ls,N),
    %assegno lunghezza delle durate
    length(Ldc,N),
    length(Lda,N),
    length(Lds,N),
    %creo lista tempi massimi di consegna
    length(Tmax,N),
    %lista di zero e uno per cerchi, aria, sat
    length(Cerchi,N),
    length(Aria,N),
    length(Sat,N),
    % lista di durate con domini
    Durate=[Dc,Da,Ds],
    Dc#=20,
    Da#=80,
    Ds#=50,
    %creo domini per tutte le liste di variabili
    domini(Lc,La,Ls,Tmax,Cerchi,Aria,Sat,Readed),
    %ora faccio le durate
    durate(Ldc,Dc),
    durate(Lda,Da),
    durate(Lds,Ds),
    %creo una lista per calcolare il costo e poi minimizzarlo
    N3 is N*3,
    length(Totlist,N3),

    %impongo che le macchine possono andare in una sola catena di montaggio alla volta
    imposemachine(Lc,La,Ls,Tmax,Durate,Cerchi,Aria,Sat),
    %impongo vincolo occupazione risorsa, ovvero che nelle catene ci può essere una sola macchina
    cumulative(Lc,Ldc,Cerchi,1),
    cumulative(La,Lda,Aria,1),
    cumulative(Ls,Lds,Sat,1),
    %aggiungo alla lista Totlist tutti i numeri trovati in modo da poi fare la somma 
    createfine(Lc,La,Ls,Durate,Totlist),
    flatten([Lc,La,Ls],Start),
    maxlist(Totlist,Tominimize),

    minmax(labeling(Start),Tominimize).


    
domini([],[],[],[],[],[],[],[]).
domini([Lc|Lcrest],[La|Larest],[Ls|Lsrest],[Tmax|Tmaxrest],[Cer|Cerrest],[Ar|Arest],[Sat|Satrest],[[_,Maxcons,C,A,S]|Rest]):-
    Lc::[-1,0..Maxcons],
    La::[-1,0..Maxcons],
    Ls::[-1,0..Maxcons],
    Tmax#=Maxcons,
    Cer#=C,
    Ar#=A,
    Sat#=S,
    imposedomini(Lcrest,Larest,Lsrest,Tmaxrest,Cerrest,Arest,Satrest,Rest).
    
durate([],_).
durate([A|Rest], D):-
    A#=D,
    durate(Rest,D).
    

imposemachine([],[],[],[],_,[],[],[]).
imposemachine([C|Crest],[A|Arest],[S|Srest],[Tmax|Tmaxrest],[Dc,Da,Ds],[Cerchio|Cerest],[Aria|Arirest],[Sat|Satrest]):-
    (C+Dc)*Cerchio#=<Tmax,
    (A+Da)*Aria#=<Tmax,
    (S+Ds)*Sat#=<Tmax,
    (	Cerchio is 0
            -> C #= -1, Dcc = 0
            ; Dcc = Dc,C #\= -1
        ),
        (	Aria is 0
            -> A #= -1, Acc = 0 
            ; Acc = Da,A #\= -1
        ),
        (	Sat is 0
            -> S #= -1, Scc = 0
            ; Scc = Ds,S #\= -1
        ),
    cumulative([C,A,S],[Dcc,Acc,Scc],[Cerchio,Aria,Sat],1),
    imposemachine(Crest,Arest,Srest,Tmaxrest,[Dc,Da,Ds],Cerest,Arirest,Satrest).

createfine([],[],[],_,[]).
createfine([Sc|Screst],[Sa|Sarest],[Ss|Ssrest],[Dc,Da,Ds],[Fc,Fa,Fs|Frest]):-
    Fc#=(Sc+Dc),
    Fa#=(Sa+Da),
    Fs#=(Ss+Ds),
    createfine(Screst,Sarest,Ssrest,[Dc,Da,Ds],Frest).
    
