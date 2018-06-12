giorno(1..30).
opzione(1..4). %1 padre, 2 madre, 3 asilo, 4 baby

1{bambino(O,G):opzione(O)}1:-giorno(G).

%non può essere che il bambino sia con un genitore un giorno degli impegni
:-impegno(Genitore,Giorno),bambino(Genitore,Giorno).

%non può essere che il numero di giorni del padre sia >4 e della madre >6
:-#count{Giorno:bambino(1,Giorno)} > 4.
:-#count{Giorno:bambino(2,Giorno)} > 6.

%i giorni dell'asilo devono essere consecutivi
:-bambino(3,G1),bambino(3,G2),G2-G1>=7.

%se almeno un giorno va all'asilo allora pago l'asilo
pagare_asilo:-bambino(G,3).

%predicato di costo della tata
costo_tata(Costo):-#count{Giorno:bambino(4,Giorno)}=Giornitata, Costo=Giornitata*50.

%il costo totale è dato da pagare_asilo+costotata
costo_tot(C):-costo_tata(C),not pagare_asilo.
costo_tot(Cost):-costo_tata(C), pagare_asilo, Cost=C+100.

#minimize {C:costo_tot(C)}.