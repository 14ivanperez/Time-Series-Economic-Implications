//Exercise 2 commands

sort daten
gen t=_n
tsset t, monthly

drop if e==.
drop if pus==.
drop if puk==.
 // drop missing values:in this case isn't necessary

//a)
ac e
pac e
ac pus 
pac pus 
ac puk
pac puk
dfuller e, regress trend
dfuller pus, regress trend
dfuller puk, regress trend
dfuller d.e
dfuller d.puk

//c)
varsoc e pus puk//look better lag lenght
var e pus puk
predict u, res
tsline u
dfuller u, notrend lags(2) regress //test of no cointegration

//d)
reg d.e l(1/2).d.e l(1/2).d.pus l(1/2).d.puk l1.u
reg d.pus l(1/2).d.e l(1/2).d.pus l(1/2).d.puk l1.u
reg d.puk l(1/2).d.e l(1/2).d.pus l(1/2).d.puk l1.u
//3 different regressions to see ECM on each one

//e)
varsoc d.e d.pus d.puk//look better lag lenght with BIC 
var d.e d.pus d.puk
predict u1, res
tsline u1
dfuller u1, notrend lags(1) regress //test of no cointegration

//f)
reg d.d.e l1.d.d.e l1.d.d.pus l1.d.d.puk l1.u1
reg d.d.pus l1.d.d.e l1.d.d.pus l1.d.d.puk l1.u1
reg d.d.puk l1.d.d.e l1.d.d.pus l1.d.d.puk l1.u1
//3 different regressions to see ECM on each one