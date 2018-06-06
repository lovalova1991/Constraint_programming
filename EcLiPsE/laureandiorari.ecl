%Si deve stabilire l'orario delle discussioni di laurea. Nello stesso giorno, si discutono due corsi di laurea diversi, 
%in due aule diverse.
%Il file laureandi.pl contiene i dati sui laureandi; per ogni laureando si ha un fatto Prolog
%laureando(Nome,Docente,CdL).
%in cui
%Nome è un identificativo del laureando
%Docente è un identificativo del relatore di tesi
%CdL è l'identificativo del Corso di Laurea
%Per ogni laureando si deve stabilire l'orario di inizio, partendo dall'istante 1, considerando durata 1 per la discussione 
%di ogni tesi.
%Naturalmente, i laureandi nella stessa aula (ovvero, stesso CdL), non possono sovrapporsi. 
%Inoltre, ciascun relatore deve essere presente alla discussione dei laureandi che ha seguito, quindi laureandi con lo 
%stesso relatore non possono essere allo stesso orario.

:-lib(fd).
:-[laureandi].

lauree(Orario1,Orario2):-
    findall([Id,Prof],laureando(Id,Prof,1),Laureando1),
    findall([Id,Prof],laureando(Id,Prof,2),Laureando2),
    length(Laureando1,N1),
    length(Laureando2,N2),
    length(Orario1,N1),
    length(Orario2,N2),
    %gli orari non si possono sovrapporre
    alldifferent(Orario1),
    alldifferent(Orario2),
    Orario1::0..N1,
    Orario2::0..N2,
    append(Laureando1,Laureando2,Alllaureandi),
    append(Orario1,Orario2,Allorari),
    vincolo_docente(Alllaureandi,Allorari),
    labeling(Allorari).

vincolo_docente([],[]).
vincolo_docente([[_|Docente]|Laureanditail],[Start|Startail]):-
    loop_docente(Docente,Laureanditail,Start,Startail),
    vincolo_docente(Laureanditail,Startail).

loop_docente(_,[],_,[]).
loop_docente(Docente,[[_,Docente]|Laureanditail],Start,[Ss|Startail]):-!,
    Start#\=Ss,
    loop_docente(Docente,Laureanditail,Start,Startail).
loop_docente(Docente,[_|Laureanditail],Start,[_|Startail]):-
    loop_docente(Docente,Laureanditail,Start,Startail).