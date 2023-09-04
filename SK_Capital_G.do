version 17

clear
set more off

cd "C:\Users\maatt\Google Drive\STABLE WEB\Papers\202x-KoreanMiracle\NOVA KOREA\JOURNAL OF PRODUCTICITY - NEW\Replication\Capital"

import excel SK_Capital_a.xls, sheet("Sheet1") firstrow

keep a hc A year t ell 

tsset year

gen z = 1-ell
drop ell

gen h = hc
drop hc

gen g = (A[_n+1]-A[_n])/A[_n]
gen G = 1 + g

gen D = 0 
replace D = 1 if G < 0.95

// Zeta Model without Crisis Dummies: G_{t} = phi*h_{t}*z_{t}^{zeta}

nl (G = {phi}*(h)*(z^{zeta})), vce(robust)

estimates stats

predict u, residuals
predict GhZ

sktest u

dfgls u, notrend 
dfuller u, noconstant lags(2)
pperron u, noconstant lags(2)

// Zeta Model with Crisis Dummies: G_{t} = beta*D_{t} + phi*h_{t}*z_{t}^{zeta}

drop u

nl (G = {beta}*D + {phi}*(h)*(z^{zeta})), vce(robust)

estimates stats

predict u, residuals
predict GhZD

sktest u

dfgls u, notrend  
dfuller u, noconstant lags(5)
pperron u, noconstant lags(5)

// Theta Model without Crisis Dummies: G_{t} = phi*h_{t}*a_{t}^{-theta}

drop u

nl (G = ({phi}*(h))/(a^{theta})), vce(robust)

estimates stats

predict u, residuals
predict GhT

sktest u

dfgls u, notrend 
dfuller u, noconstant lags(1)
pperron u, noconstant lags(1)

// Theta Model with Crisis Dummies: G_{t} = beta*D_{t} + phi*h_{t}*a_{t}^{-theta}

drop u

nl (G = {beta}*D + ({phi}*(h))/(a^{theta})), vce(robust)

estimates stats

predict u, residuals
predict GhTD

sktest u

dfgls u, notrend 
dfuller u, noconstant lags(5)
pperron u, noconstant lags(5)

// Theta-Zeta Model without Crisis Dummies: G_{t} = phi*h_{t}*a_{t}^{-theta}*z_{t}^{zeta}

drop u

nl (G = (({phi}*(h))/(a^{theta}))*(z^{zeta})), vce(robust)

estimates stats

predict u, residuals
predict GhTZ

sktest u

dfgls u, notrend  
dfuller u, noconstant lags(0)
pperron u, noconstant lags(0)

// Theta-Zeta Model with Crisis Dummies: G_{t} = beta*D_{t} + phi*h_{t}*a_{t}^{-theta}*z_{t}^{zeta}

drop u

nl (G = {beta}*D + (({phi}*(h))/(a^{theta}))*(z^{zeta})), vce(robust)

estimates stats

predict u, residuals
predict GhTZD

sktest u

dfgls u, notrend 
dfuller u, noconstant lags(0)
pperron u, noconstant lags(0)
