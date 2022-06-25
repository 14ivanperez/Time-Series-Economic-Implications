cd "$home"  // the path to whatever directory the datafile is in

use "C:\Users\ivvan\Downloads\cons.dta", // load the file cons.dta 

drop if c==.
drop if y==. // drop missing values:in this case isn't necessary

tsset time, quarterly // tell stata time index is quarterly

// a)
dfuller c, regress trend
dfuller y, regress trend //test if there's unit root
dfuller d.c, regress
dfuller d.y, regress // test unit root for the 1st differences

// b)
reg c y

// c)
ac pac d.c
ac pac d.y//to see number of lags
reg d.c l(0/3).d.y //we want to see how many lags are significant
di 0.75*(_N^(1/3))// it equals 4.3, we will take 4 lags
newey d.c l(0/3).d.y, lag(4)

// e)
ac pac c
ac pac y//to see number of lags
reg c l(0/4) y
