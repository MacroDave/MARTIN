' MARTIN_RDP_IRFS_PUBLIC.prg
'
' Produces IRF exercises to accompany public release of MARTIN.

' Last updated:
' 20/06/2019 - Daniel Rees
'
' ================================================================
' Set current eviews directory
close @wf
%path = @runpath
cd %path

' Load workfile
load martin_public.wf1'

' Define model name
string modelname = "m_martin"
%modelname = "m_martin"

' ================================================================
' Set simulation dates
%shock_start = "2019:1" 			' Start date of shocks
string sim1_start = "2019Q1"		' Start date of simulation
string sim1_end  = "2029Q4"		' End of simulation
%last_data = "2018Q2"

smpl @all

'====================================
' Set model baseline 
string baseline = "0"

'======================================================================

' Simulate model to compute baseline
smpl {sim1_start} {sim1_end}
{modelname}.scenario "baseline"
{modelname}.solve

' ================================================================
' Run Scenarios

%scn_num = "_s1 _s2 _s3 _s4 _s9" ' Label the suffixes for each of the scenarios

!shock_input = 1 		' Toggle. 1 = shock profile defined in Eviews, 0 = defined externally and imported

'Monetary Policy Shock - 4 quarter

%shock_title_s1    = "Monetary_Policy"			' Name the scenario
%shock_name_s1 = "ncr rstar gc gi"			' List of variables whose values you are fixing in the scenario
%shock_type_s1   ="ppt ppt pct pct"				' The units of the fix, ppt=percentage point / pct=per cent deviation 
%shock_length_s1 = "4 40 40 40" 				' Number of quarters to hold the fix for
%shock_size_s1   = "1 0 0 0"						' Size of the deviation from baseline
%shock_num_s1 = "1 2 3 4"						' Number of shocks

' Exchange Rate Shock - 4 quarter

%shock_title_s2   = "Exchange_Rate"
%shock_name_s2 = "rtwi rstar gc gi"
%shock_type_s2   ="pct ppt pct pct"
%shock_length_s2 = "4 40 40 40"
%shock_size_s2  = "-10 0 0 0"
%shock_num_s2 = "1 2 3 4"

'Monetary Policy Shock - 4 quarter - turn off exchange rate

%shock_title_s3    = "Monetary_Policy_No_ER"
%shock_name_s3 = "ncr rstar gc gi rtwi ntwi"
%shock_type_s3   ="ppt ppt pct pct ppt ppt"
%shock_length_s3 = "4 40 40 40 40 40"
%shock_size_s3   = "1 0 0 0 0 0"
%shock_num_s3 = "1 2 3 4 5 6"

'Monetary Policy Shock - 4 quarter - turn off exchange rate and asset price

%shock_title_s4    = "Monetary_Policy_No_ERAP"
%shock_name_s4 = "ncr rstar gc gi rtwi ntwi ph"
%shock_type_s4   ="ppt ppt pct pct ppt ppt ppt"
%shock_length_s4 = "4 40 40 40 40 40 40"
%shock_size_s4   = "1 0 0 0 0 0 0"
%shock_num_s4 = "1 2 3 4 5 6 7"

'Monetary Policy Shock - 4 quarter - turn off exchange rate and house prices

%shock_title_s9    = "Monetary_Policy_No_ERPH"
%shock_name_s9 = "ncr rstar gc gi rtwi ntwi ph"
%shock_type_s9  ="ppt ppt pct pct ppt ppt ppt ppt"
%shock_length_s9 = "4 40 40 40 40 40 40 40"
%shock_size_s9   = "1 0 0 0 0 0 0 0"
%shock_num_s9 = "1 2 3 4 5 6 7"

' ================================================================
' Solve model

string irfs_levels = ""
string irfs_rates = ""

include(quiet) "Subroutines\sub1_inputs"

include(quiet) "Subroutines\sub2_solve"

' ================================================================
' Run Scenarios with pre-specified path pulled from Eviews

%scn_num = "_s5 " ' Label the suffixes for each of the scenarios

import "Shock_profile.xlsx" range="Eviews"

!shock_input = 0 ' Toggle. 1 = shock profile defined in Eviews, 0 = defined externally and imported

%shock_title_s5 = "Housing Price fall - no ncr or rtwi"
%shock_name_s5 = "ph ncr rtwi "
%shock_type_s5 = "pct ppt pct"
%shock_length_s5 = "10 40 40"
%shock_size_s5 =  "0 0 0"	' Note values here are redundant when you import data from excel
%shock_num_s5	=  "1 2 3"

series import_shock1_s5 = import_ph		' Name of path of first variable
series import_shock2_s5 = import_zero	' Name of path of second variable
series import_shock3_s5 = import_zero	' Name of path of third variable

' ================================================================
' Solve model

string irfs_levels = ""
string irfs_rates = ""

include(quiet) "Subroutines\sub1_inputs"

include(quiet) "Subroutines\sub2_solve"

' ===============================================================
' Plot results

' Create IRF series
smpl @all
series irf_ncr_ncr = ncr_s1-ncr_0 
series irf_ncr_y = y_s1/y_0*100-100
series irf_ncr_u = lur_s1-lur_0
series irf_ncr_p = pi_ptm_s1-pi_ptm_0
series irf_ncr_w = pi_pw_s1-pi_pw_0
series irf_ncr_rtwi = rtwi_s1/rtwi_0*100-100

series irf_ncr_rc = rc_s1/rc_0*100-100
series irf_ncr_id = id_s1/id_0*100-100
series irf_ncr_ib = ib_s1/ib_0*100-100
series irf_ncr_xnre = (x_s1-xre_s1)/(x_0-xre_0)*100-100
series irf_ncr_xre = xre_s1/xre_0*100-100
series irf_ncr_m = m_s1/m_0*100-100

series irf_rtwi_ncr = ncr_s2-ncr_0 
series irf_rtwi_y = y_s2/y_0*100-100
series irf_rtwi_u = lur_s2-lur_0
series irf_rtwi_p = pi_ptm_s2-pi_ptm_0
series irf_rtwi_w = pi_pw_s2-pi_pw_0
series irf_rtwi_rtwi = rtwi_s2/rtwi_0*100-100

series irf_ncr_y_noer = y_s3/y_0*100-100
series irf_ncr_y_noap = y_s4/y_0*100-100
series irf_ncr_y_noph = y_s9/y_0*100-100

series irf_ph_ph = ph_s5/ph_0*100-100
series irf_ph_y    = y_s5/y_0*100 -100
series irf_ph_p    = pi_ptm_s5 - pi_ptm_0
series irf_ph_u    = lur_s5 - lur_0
series irf_ph_rc   = rc_s5/rc_0*100-100
series irf_ph_ncr = ncr_s5 - ncr_0

' ******** Monetary Policy Shock **********************

smpl 2019 2028

' Monetary policy shock - aggregate variables
graph g_ncr_r irf_ncr_ncr 0*ncr_0
graph g_ncr_y irf_ncr_y 0*y_0
graph g_ncr_u irf_ncr_u 0*lur_0
graph g_ncr_p irf_ncr_p 0*pi_ptm_0
graph g_ncr_w irf_ncr_w 0*pi_pw_0 
graph g_ncr_rtwi irf_ncr_rtwi 0*rtwi_0

g_ncr_r.addtext(t) "Cash Rate"
g_ncr_y.addtext(t) "GDP"
g_ncr_u.addtext(t) "Unemployment Rate"
g_ncr_p.addtext(t) "Trimmed Mean Inflation"
g_ncr_w.addtext(t) "Wages Growth"
g_ncr_rtwi.addtext(t) "Real TWI"

graph g_ncr_shock_1.merge g_ncr_r g_ncr_y g_ncr_u g_ncr_p g_ncr_w g_ncr_rtwi

show g_ncr_shock_1

' Monetary policy shock - expenditure components
graph g_ncr_rc irf_ncr_rc 0*rc_0
graph g_ncr_id irf_ncr_id 0*id_0
graph g_ncr_ib irf_ncr_ib 0*ib_0
graph g_ncr_xnre irf_ncr_xnre 0*g_0
graph g_ncr_xre irf_ncr_xre 0*rc_0
graph g_ncr_m irf_ncr_m 0*rc_0

g_ncr_rc.addtext(t) "Consumption"
g_ncr_id.addtext(t) "Dwelling Investment"
g_ncr_ib.addtext(t) "Business Investment"
g_ncr_xnre.addtext(t) "Non-resource exports"
g_ncr_xre.addtext(t) "Resource exports"
g_ncr_m.addtext(t) "Imports"

graph g_ncr_shock_2.merge g_ncr_rc g_ncr_id g_ncr_ib g_ncr_xnre g_ncr_xre g_ncr_m

show g_ncr_shock_2

' Alternative channels
graph g_ncr_y_alt irf_ncr_y irf_ncr_y_noer irf_ncr_y_noap irf_ncr_y_noph  0*y_0

g_ncr_y_alt.addtext(t) " Gross Domestic Product"
g_ncr_y_alt.setelem(1) legend("Baseline")
g_ncr_y_alt.setelem(2) legend("No exchange rate")
g_ncr_y_alt.setelem(3) legend("No exchange rate or asset price")
g_ncr_y_alt.setelem(4) legend("No exchange rate or house price")
g_ncr_y_alt.setelem(5) legend("") lcolor(black) lwidth(0.5)
g_ncr_y_alt.legend display

show g_ncr_y_alt

' ******** Exchange Rate Shock **********************

'Exchange rate shock - aggregate variables
graph g_rtwi_r irf_rtwi_ncr 0*ncr_0
graph g_rtwi_y irf_rtwi_y 0*y_0
graph g_rtwi_u irf_rtwi_u 0*lur_0
graph g_rtwi_p irf_rtwi_p 0*pi_ptm_0
graph g_rtwi_w irf_rtwi_w 0*pi_pw_0 
graph g_rtwi_rtwi irf_rtwi_rtwi 0*rtwi_0

g_rtwi_r.addtext(t) "Cash Rate"
g_rtwi_y.addtext(t) "GDP"
g_rtwi_u.addtext(t) "Unemployment Rate"
g_rtwi_p.addtext(t) "Trimmed Mean Inflation"
g_rtwi_w.addtext(t) "Wages Growth"
g_rtwi_rtwi.addtext(t) "Real TWI"

graph g_rtwi_shock_1.merge g_rtwi_rtwi g_rtwi_y g_rtwi_u g_rtwi_p g_rtwi_w g_rtwi_r

show g_rtwi_shock_1

' ******** Housing Price Shock **********************
graph g_ph_ph irf_ph_ph 0*ncr_0
graph g_ph_y irf_ph_y 0*ncr_0
graph g_ph_p irf_ph_p 0*ncr_0
graph g_ph_u irf_ph_u 0*ncr_0
graph g_ph_rc irf_ph_rc 0*ncr_0
graph g_ph_ncr irf_ph_ncr 0*ncr_0

graph g_ph_shock_1.merge g_ph_ph g_ph_y g_ph_p g_ph_u g_ph_rc g_ph_ncr

show g_ph_shock_1


