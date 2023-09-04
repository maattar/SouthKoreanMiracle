version 17

clear
set more off

cd "C:\Users\maatt\Google Drive\STABLE WEB\Papers\202x-KoreanMiracle\NOVA KOREA\JOURNAL OF PRODUCTICITY - NEW\Replication\Capital"

import excel SK_Data_Capital.xls, sheet("Sheet1") firstrow

tsset year

gen At = (ell*rnna)/(1-ell)                               // A^tilde
gen y = rgdpna/pop                                        // GDP per capita
gen lada = 0.4
gen lada1 = 0.3                                              // capital share 1
gen lada2 = 0.5                                              // capital share 2
gen k = rnna/pop                                          // K per capita
gen At2L = At/pop                                         // A^tilde per capita
gen A = (y/((hc^(1-lada))*((k+At2L)^lada)))^(1/(1-lada))  // A
gen A1 = (y/((hc^(1-lada1))*((k+At2L)^lada1)))^(1/(1-lada1))  // A1
gen A2 = (y/((hc^(1-lada2))*((k+At2L)^lada2)))^(1/(1-lada2))  // A2

gen t = year - 1959

gen A0 = A[1]
gen Ab0 = A0/0.317
gen Ab = Ab0*((1.021)^(t-1))
gen a = A/Ab

gen A01 = A1[1]
gen Ab01 = A01/0.317
gen Ab1 = Ab01*((1.021)^(t-1))
gen a1 = A1/Ab1

gen A02 = A2[1]
gen Ab02 = A02/0.317
gen Ab2 = Ab02*((1.021)^(t-1))
gen a2 = A2/Ab2

export excel SK_Robust_a_lambda.xls, firstrow(variables)
