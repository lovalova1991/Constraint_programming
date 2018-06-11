%prendo la posizione della macchina
position(P):-car(P,_).
%ci può essere solo una macchina nella nuova posizione
1{pos(Old,New,Color):position(New)}1:-car(Old,Color).
%non può essere che lo spostamento sia in modulo maggiore di MaxD
:-pos(Old,New,_),|Old-New|>maxD,maxd(maxD).
%non può essere che ci siano due posizioni uguali
:-pos(Old1,New,_),pos(Old2,New,_), Old1!=Old2.
%definisco lo switch
switch(P):-pos(_,P,Color1), pos(_,P+1,Color2), Color1!=Color2.

#minimize{1,P:switch(P)}.
#show position(P).