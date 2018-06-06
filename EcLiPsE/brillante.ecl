%I coniugi Brillante hanno cinque figli, che tengono fede al loro nome. 
%Alle età di 4, 5, 6, 7 e 8 anni, Anna e i suoi fratelli mostrano un buon talento ciascuno in un campo diverso da quello degli altri.
%Determinare l'età e il talento di ognuno dei figli, sapendo che:
%Uno di loro suona bene il piano
%Carla ha 4 anni e non è la Brillante matematica
%Il mago del computer è di un anno più vecchio di Stefano
%Il violinista ha 7 anni
%Giovanna non è quella di 8 anni
%All'età di 5 anni, Roberto è più giovane del Brillante bravo nel nuoto.

:-lib(fd).
:-lib(fd_global).

brillante(Nomi,Talenti):-
    Nomi=[Anna,Carla,Stefano,Roberto,Giovanna],
    Talenti=[Tp,Tn,Tc,Tm,Tv],
    Nomi::[4..8],
    Talenti::[4..8],
    fd_global:alldifferent(Nomi),
    fd_global:alldifferent(Talenti),
    Carla#=4,
    Giovanna#\=8,
    Roberto#=5,
    Carla#\=Tm,
    Roberto#<Tn,
    Tv#=7,
    Tc#=Stefano+1,
    flatten([Nomi,Talenti], Total),
    labeling(Total).


 %Soluzione
 %Anna 8 anni=>Computer
 %Carla 4 anni=>Piano
 %Stefano 7 anni=>Violino
 %Roberto 5 anni=>Matematica
 %Giovanna 6 anni=>Nuoto

    
    
    
    

    
    

    