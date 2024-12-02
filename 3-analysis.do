**After uploading the cleaned BRFSS datafile, this code analyzes the primary design following the preregistered analysis plan & design.

clear all 

global outcomes current_cigsmoke started_final number_cigs quit_smoke_yr

global controls cat_age male cat_race marital school  

order perwt svywave fips month year cat_age male cat_race marital school  

global secondary current_ecig current_smokeless

sum $secondary $outcomes $controls perwt fips svywave
destring(year), force replace
gen late=0
replace late=1 if year>svywave

*plot means*

*ssc install schemepack, replace

gen new_wave=svywave
replace new_wave=2020 if late==1 & svywave>2020

gen group_20=1 if svywave<2021
gen group_21=1 if svywave<2020
gen group_22=1 if svywave<2020
replace group_21=1 if svywave==2020 & late==0
replace group_21=1 if svywave==2021 & late==1
replace group_22=1 if svywave==2020 & late==0
replace group_22=1 if svywave==2022 & late==1

gen post=0
replace post=1 if svywave>=2020

gen covid=post*late

estimates clear

foreach y in $outcomes {
	foreach n of numlist 20/22{
	eststo: reghdfe `y' 1.covid i.late i.($controls) [pw=perwt] if group_`n'==1, vce(cluster fips) absorb(new_wave fips)
}
}

esttab using reg_est.csv, replace b(3) se(3) keep(1.covid)

estimates clear 

foreach y in $secondary{
	foreach n of numlist 20/22{
	eststo: reghdfe `y' i.covid i.late i.($controls) [pw=perwt] if group_`n'==1, vce(cluster fips) absorb(new_wave fips)
}
}

esttab using secreg_est.csv, replace b(3) se(3) keep(1.covid)




estimates clear 

foreach y in number_cigs{
	foreach n of numlist 20/22{
	eststo: reghdfe `y' 1.late i.($controls) [pw=perwt] if group_`n'==1 & number_cigs>0, vce(cluster fips) absorb(new_wave fips)
}
}

esttab, keep(1.late) b(3) se(3)


estimates clear 

foreach y in number_cigs quit_smoke_yr{
	foreach n of numlist 20/22{
	eststo: reghdfe `y' i.covid i.late i.($controls) [pw=perwt] if group_`n'==1 & current_cigsmoke==1, vce(cluster fips) absorb(new_wave fips)
}
}

esttab, keep(1.covid) b(3) ci(3)

estimates clear

foreach y in number_cigs quit_smoke_yr{
	foreach n of numlist 20/22{
	eststo: reghdfe `y' i.covid i.late i.($controls) [pw=perwt] if group_`n'==1 & current_cigsmoke==0, vce(cluster fips) absorb(new_wave fips)
}
}

esttab, keep(1.covid) b(3) ci(3)

