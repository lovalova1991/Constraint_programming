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

    
    
    
    

    
    

    