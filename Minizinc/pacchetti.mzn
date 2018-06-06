int: n=10;
int: Nreq=3;
int: Nconf=3;
array[1..n] of int: package = [1,2,3,4,5,6,7,8,9,10];
array[1..n] of int: installed = [1,0,0,0,1,1,0,1,0,0];

array[1..Nreq,1..2] of int: requires = [|1,2|3,4|5,6|];

array[1..Nconf,1..2] of int: conflict = [|4,2|5,4|5,7|];

array[1..n] of int: install = [0,0,1,0,0,0,0,0,0,0];

array[1..n] of var 0..1: res;

constraint forall(i in 1..Nconf)
(
    res[conflict[i,1] + conflict[i,2]] <= 2
);

constraint forall(i in 1..Nreq)
(
    res[requires[i,1]] <= res[requires[i,2]] 
);

solve minimize sum([abs(res[i])-installed[i]|i in 1..n]);