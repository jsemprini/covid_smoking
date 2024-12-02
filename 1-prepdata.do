*This code loads all the BRFSS datafiles and keeps the relevant variables. 
clear all

*2000/2009

foreach n of numlist 2010/2022{
cd "D:\BRFSS-raw"

use "BRFSS`n'.dta"

local vars_to_keep ""
local keywords "smoking smoke cigarette vape ecig e-cig tobacco"

foreach keyword in `keywords' {
    quietly lookfor `keyword'
    local vars_to_keep `vars_to_keep' `r(varlist)'
}

keep _state imonth iyear marital *educa*  *wt* *race* *sex* _ageg5yr   `vars_to_keep'


destring(imonth), force replace

rename imonth month
rename iyear year

gen svywave=`n'

describe

save "C:\Users\jsemprini\OneDrive - Des Moines University\1-UI-Research\c-Smoking2\ii-raw\brfss`n'.dta", replace

*clear all

}


