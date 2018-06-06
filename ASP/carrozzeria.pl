position(P):-car(P,_).

1{pos(Newpos,Oldpos,Col):position(Newpos)}1:-car(Oldpos,Col).

:-pos(Newpos,Oldpos,_),|Newpos-Oldpos|>MaxD,maxd(MaxD).

:-pos(Newpos,Oldpos1,_),pos(Newpos,Oldpos2,_), Oldpos1!=Oldpos2.

switch(P):-pos(P,_,Col1),pos(P+1,_,Col2),Col1!=Col2.

#minimize{1,P:switch(P)}.


