:-lib(fd).

gedeone(G,D,U):-
    [G,D,U,DF,UF]::0..120,
    G#>D,
    G#>U,
    DF#=D+11,
    GF#=G+11,
    DF#=G,
    (GF-DF)#=G-D,
    G#=6*D,
    U#=D+3,
    U#=(G-D)-3,
    labeling([G,D,U,DF,UF]).

    % perchè non va na sega così?


    
    

