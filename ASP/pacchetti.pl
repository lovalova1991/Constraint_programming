{installabile(P)}:-package(P).
%non è possibile installare un pacchetto P se richiede un pacchetto P1
:-installabile(P),requires(P,P1),not installabile(P1).

%non è possibile installare un pacchetto P se ho un conflitto con un paccheto P1
:-installabile(P),installabile(P1),conflict(P,P1).

%non è possibile che ci sia un pacchetto P da installare non installato
installing(P):-package(P),installabile(P), not install(P).
%non è possibile che ci sia un pacchetto P non installato da installare
installing(P):-package(P), not installabile(P), install(P).

#minimize{1,P:installing(P)}.