%Un insieme di attività è definito tramite il predicato task/2 nel file task.pl . 
%Il predicato task è definito tramite alcuni fatti Prolog, con questa sintassi:
%task(ID,Durata). dove
%ID è un identificatore univoco dell'attività
%Durata è un intero che rappresenta la durata dell'attività
%Ciascuna attività deve essere eseguita su una macchina e, una volta iniziata, l'attività non può essere interrotta. 
%Ogni macchina può eseguire una sola attività alla volta.
%Poiché si vuole terminare tutte le attività entro un tempo dato Tmax, si desidera sapere qual è il numero minimo di macchine necessario.
%Si scriva un programma CLP(FD) che, preso in ingresso un parametro Tmax, fornisce il minimo numero di macchine necessario per eseguire 
%tutti i task e l'istante di tempo in cui ciascuna attività inizia.

:-lib(fd).
:-lib(cumulative).
:-[task].

machine(Lstart,Tmax):-
    findall(Dur,task(_,Dur),Durlist),
    length(Durlist,N),
    length(Lstart,N),
    %ricordarsi sempre di dare dei domini!!!
    Lstart::[0..Tmax],
    %impongo i vincoli: tutte le attività devono essere eseguite entro Tmax
    impose_vincoli(Lstart,Durlist,Tmax),
    %devo creare una lista di 1 per la cumulative
    ones(N,Lones),
    Freeres::0..N,
    % inserisco nella cumulative un'attività fittizia che occupa tutte le risorse in modo da minimizzare le altre   
    cumulative([0|Lstart],[Tmax|Durlist],[Freeres|Lones],N),
    Usedres#=N-Freeres,
    append(Lstart,[Usedres],Tomin),
    minimize(labeling(Tomin),Usedres).


impose_vincoli([],[],_).
impose_vincoli([Start|Lstart],[Dur|Ldur],Tmax):-
    Start+Dur#<Tmax,
    impose_vincoli(Lstart,Ldur,Tmax).


ones(0,[]):-!.
ones(N,[1|Lone]):-
    N1 is N-1,
    ones(N1,Lone).
