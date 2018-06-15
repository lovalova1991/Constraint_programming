:-lib(fd).
:-lib(fd_global).
:-lib(edge_finder).

colf(Lstart):-
    Lstart=[Sa,Sb,Sc,Sd,Se1,Se2,Se3,Se4,Sf],
    Lstart::0..199,
    Pmax=30,
    Tmax=200,
    Ldur=[Da,Db,Dc,Dd,De1,De2,De3,De4,Df],
    Lpow=[Pa,Pb,Pc,Pd,Pe1,Pe2,Pe3,Pe4,Pf],

    %impongo domini delle durate
    Da#=45,
    Db#=60,
    Dc#=60,
    Dd#=40,
    De1#=15,
    De2::60..120,
    De3#=5,
    De4#=15,
    Df#=120,

    %impongo domini potenze

    Pa#=17,
    Pb#=10,
    Pc#=20,
    Pd#=18,
    Pe1#=0,
    Pe2#=0,
    Pe3#=20,
    Pe4#=20,
    Pf#=0,

    fd_global:alldifferent(Lstart),
    %ovviamente prima lavo, poi asciugo, poi stiro
    imposeorder(Sa,Da,Sb),
    imposeorder(Sb,Db,Sc),
    %ordine preparare pizza
    imposeorder(Se1,De1,Se2),
    imposeorder(Se2,De2,Se3),
    imposeorder(Se3,De3,Se4),
    %impongo vincoli di durata max
    imposeorder(Sc,Dc,Tmax),
    imposeorder(Sd,Dd,Tmax),
    imposeorder(Se4,De4,Tmax),
    imposeorder(Sf,Df,Tmax),

    cumulative(Lstart,Ldur,Lpow,Pmax),
    cumulative([Sc,Se1,Sf],[Dc,De1,Df],[1,1,1],1),
    labeling(Lstart).


imposeorder(Start1,Durata1,Start2):-
    Start2#>Start1+Durata1.


