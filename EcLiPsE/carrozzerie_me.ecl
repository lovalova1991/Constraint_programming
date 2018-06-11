%Un robot deve verniciare le carrozzerie delle automobili.
%Le carrozzerie arrivano in una sequenza; per ogni carrozzeria viene indicato il colore di cui deve essere verniciata. Ad esempio, una sequenza potrebbe essere 
%rosso, giallo, rosso, verde, giallo.
%All'interno della sequenza, è possibile fare dei piccoli spostamenti, fino ad un valore costante MaxD: se un'auto arriva in posizione n, 
%allora la si può spostare nelle posizioni da n−MaxD a n+MaxD.
%Se dopo aver verniciato una carrozzeria, il robot deve cambiare colore, allora deve effetturare una costosa operazione di pulizia degli ugelli.
%Si trovi la sequenza ottima che soddisfa tutti i vincoli e che minimizza il numero di cambi di colore.
%Nell'esempio riportato sopra, con MaxD=1 si può tenere la prima auto in posizione 1, la seconda spostata in posizione 3, 
%la terza viene spostata in posizione 2 (in questo modo le due rosse sono vicine), la verde va in ultima posizione mentre la quinta auto viene anticipata 
%alla posizione 4 (in questo modo le due gialle sono vicine). Il costo di questa soluzione è quindi 2 (un cambio di colore dal rosso al giallo ed uno dal 
%giallo al verde).
%Si risolva il problema usando ECLiPSe, scrivendo un predicato che prende almeno due parametri:
%Sequenza: è la sequenza di ingresso; ad es Sequenza=[rosso, giallo, rosso, verde, giallo]
%MaxD: (ad es. MaxD =2)
%e fornisce il risultato nel formato che si ritiene più opportuno.

:-lib(fd).
:-lib(fd_global).

robot(Sequenza,MaxD,Ris):-
    length(Sequenza,N),
    length(Ris,N),
    %color_count(Sequenza,Ncolor), %Potrei contare quanti colori diversi ci sono per creare il dominio della variabile, ma mi accontento di creare un dominio che può avere tutti i colori diversi
    Ris::1..N,
    vincolo_spostamento(Ris,1,MaxD),
    fd_global:alldifferent(Ris),
    spostamenti(Ris,Sequenza,Nspostamenti),
    minimize(labeling(Ris),Nspostamenti).


vincolo_spostamento([],_,_).
vincolo_spostamento([A|B],Index,MaxD):-
    A-Index #=< MaxD,
    A+Index #>= MaxD,
    Index1 is Index+1,
    vincolo_spostamento(B,Index1,MaxD).


spostamenti([],_,0):-!.
spostamenti([A|B],[Color|Lcolor],Nspost):-
    loop(A,B,Color,Lcolor,Nspost1),
    spostamenti(B,Lcolor,Nspost2),
    Nspost #= Nspost1+Nspost2.

% se ho dei colori diversi allora conto, altrimenti non conto
loop(_,[],_,[],0):-!.
%se ho colori uguali
loop(A,[_|Lout],B,[B|Colors],Nspost):-!,
    loop(A,Lout,B,Colors,Nspost).
loop(A,[A1|Lout],B,[C|Colors],Nspost):-!,
    B#\=C,
    A-A1 #=1 #=> Bool1,
    A1-A #=1 #=> Bool2,
    Nspost #= Nspost1+Bool1+Bool2,
    loop(A,Lout,B,Colors,Nspost1).
    
