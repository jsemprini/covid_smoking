***keep only early and late waves

clear all
 cd "C:\Users\jsemprini\OneDrive - Des Moines University\1-UI-Research\c-Smoking2\ii-raw"
foreach n of numlist 2000/2022{
	
	use brfss`n'.dta
	
	drop if month>3 
	
	save brfss`n'.dta, replace
	
	clear all
	
	
}

clear all

use brfss2000.dta

append using "C:\Users\jsemprini\OneDrive - Des Moines University\1-UI-Research\c-Smoking2\ii-raw\brfss2001.dta"

foreach n of numlist 2002/2022{
	
	append using brfss`n'.dta , force

}

drop losewt orace wtdesire smkdete2 smkpublc smkwork smkrest smkschls smkdaycr smkindor _sexg_ _denwt _geowt _wt1 cigar2 cigarnow pipesmk pipenow bidismk bidinow mraceorg mraceasc _prace _strwt _wt2 _cnrace _cnracec wtkg _mrace atksmok atknsmok smkdete3 hewtrsrc hewtrdrk _race_g wtkg2 gp3dywtr craceorg craceasc _crace _craceg_ _wt2ch _childwt _wt2hh _housewt wtyrago wtchgint miswtles _wt2q1 _wt2q2 _wt2ch1 _wt2ch2 shsinwrk shsinhom houssmk1 shsalowb shsalowr shsaloww acehvsex _sexg1_ _sexg2_ _sexg3_ _raceg31 _raceg32 _raceg33 _csexg1_ _crace1_ _csexg2_ _crace2_ _csexg3_ _crace3_ _csexg_ shsnwrk1 shsnhom1 shshomes shsvhicl shsalow1 _wt2rake _cllcpwt wtkg3 wtchsalt longwtch _crace1 _impcsex _llcpwt2 _prace1 _mrace1 _raceg21 _racegr3 _race_g1 rcsrace1 orace3 _m_race _cprace marjsmok marjvape mentcigs mentecig heattbco hadsex _crace2 _cprace2 _prace2 _mrace2 _race1 _raceg22 _racepr1

