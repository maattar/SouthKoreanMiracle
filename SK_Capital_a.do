version 17

clear
set more off

cd "C:\Users\maatt\Google Drive\STABLE WEB\Papers\202x-KoreanMiracle\NOVA KOREA\JOURNAL OF PRODUCTICITY - NEW\Replication\Capital"

import excel SK_Data_Capital.xls, sheet("Sheet1") firstrow

tsset year

gen At = (ell*rnna)/(1-ell)                               // A^tilde
gen y = rgdpna/pop                                        // GDP per capita
gen lada = 0.4                                            // capital share
gen k = rnna/pop                                          // K per capita
gen At2L = At/pop                                         // A^tilde per capita
gen A = (y/((hc^(1-lada))*((k+At2L)^lada)))^(1/(1-lada))  // A

gen lAt = log(At)
gen lA = log(A)
newey lAt lA, lag(10)

predict u, residuals

predict lAth
corr lAt lAth
di r(rho)^2

gen mu = exp(lada*_b[_cons])
gen xi = lada*(_b[lA]) + 1 - lada

nlcom exp((0.4)*_b[_cons])
lincom (0.6 + (0.4)*(_b[lA]))

sktest u

dfgls u, notrend 
dfuller u, noconstant lags(1)
pperron u, noconstant lags(1)

gen t = year - 1959

gen A0 = A[1]
gen Ab0 = A0/0.317
gen Ab = Ab0*((1.021)^(t-1))

gen a = A/Ab
gen lAb = log(Ab)

export excel SK_Capital_a.xls, replace firstrow(variables)



twoway (line lA year) (line lAb year) 