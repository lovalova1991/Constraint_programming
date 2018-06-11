include "globals.mzn";

int: NumCars = 7;
int: r=1;
int: b=2;
int: g=3;
array[1..NumCars] of int: car = [r,b,g,r,g,b,r];
int: MaxD=2;

array[1..NumCars] of var 1..NumCars: p;
array[1..NumCars] if var 1..NumCars: swap;

constraint forall(i in 1..NumCars)(
    p[i]-i <= MaxD
);
constraint forall(i in 1..NumCars)(
    i-p[i] <= MaxD
);

constraint alldifferent(p);

solve minimize sum([p[i]=p[j]+1 | i in 1..NumCars, j in 1..NumCars where i!=j /\ car[i]!=car[j]]);