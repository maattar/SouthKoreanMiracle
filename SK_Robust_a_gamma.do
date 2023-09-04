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

gen t = year - 1959

gen A0 = A[1]
gen Ab0 = A0/0.317
gen Ab  = Ab0*((1.021)^(t-1))
gen Ab1 = Ab0*((1.027)^(t-1))
gen Ab2 = Ab0*((1.033)^(t-1))

gen a  = A/Ab
gen a1 = A/Ab1
gen a2 = A/Ab2

export excel SK_Robust_a_gamma.xls, firstrow(variables)
