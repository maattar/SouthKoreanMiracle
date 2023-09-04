version 17

clear
set more off

cd "C:\Users\maatt\Google Drive\STABLE WEB\Papers\202x-KoreanMiracle\NOVA KOREA\JOURNAL OF PRODUCTICITY - NEW\Replication\Capital"

import excel SK_Capital_a.xls, sheet("Sheet1") firstrow

keep a hc A year 

tsset year

gen h = hc
drop hc

gen g = (A[_n+1]-A[_n])/A[_n]
gen G = 1 + g

gen D = 0 
replace D = 1 if G < 0.95

// Theta Model without Crisis Dummies: G_{t} = phi*h_{t}*a_{t}^{-theta}

nl (G = {beta}*D + ({phi}*(h))/(a^{theta})), vce(robust)

generate PHIM = _b[/phi]
generate PHIL = _b[/phi] - invttail(e(df_r),0.025)*_se[/phi]
generate PHIU = _b[/phi] + invttail(e(df_r),0.025)*_se[/phi]

generate THEM = _b[/theta]
generate THEL = _b[/theta] - invttail(e(df_r),0.025)*_se[/theta]
generate THEU = _b[/theta] + invttail(e(df_r),0.025)*_se[/theta]

// Decomposition
 
generate asM = (-1)*THEM*(log(a)/(log(G)-log(PHIM)))
generate asL = (-1)*THEL*(log(a)/(log(G)-log(PHIL)))
generate asU = (-1)*THEU*(log(a)/(log(G)-log(PHIU)))

generate fsM = asM
generate fsL = asL
generate fsU = asU

replace fsM = 0 if a < 1
replace fsL = 0 if a < 1
replace fsU = 0 if a < 1

replace asM = 0 if a > 1
replace asL = 0 if a > 1
replace asU = 0 if a > 1

generate hsM = 1 - asM - fsM
generate hsL = 1 - asL - fsL
generate hsU = 1 - asU - fsU

export excel SK_Capital_Dec.xls, replace firstrow(variables)

replace asM = 100*asM
replace asL = 100*asL
replace asU = 100*asU

replace hsM = 100*hsM
replace hsL = 100*hsL
replace hsU = 100*hsU

replace fsM = 100*fsM
replace fsL = 100*fsL
replace fsU = 100*fsU





twoway (rarea fsL fsU year, fcolor(green%50) lwidth(none)) (line fsM year, lcolor(green))
twoway (rarea asL asU year, fcolor(blue%50) lwidth(none)) (line asM year, lcolor(blue)) 
twoway (rarea hsL hsU year, fcolor(red%50) lwidth(none)) (line hsM year, lcolor(red)) 