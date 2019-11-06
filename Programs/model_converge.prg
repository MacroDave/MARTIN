'Convergence Charts
smpl %nataccs_end+1 %solve_end

'GDP growth and Supply Side Growth
graph __gap.line DLOG(Y_2)*100 (TY_POT_2)*100

'Real GDP components
group __cvm dlog(Y_2)*100 dlog(RC_2)*100 dlog(id_2)*100 dlog(ib_2)*100 dlog(g_2)*100 dlog(otc_2)*100 dlog(x_2)*100 dlog(m_2)*100 TY_POT_2*100

'Consumption
group __cons dlog(hdy_2)*100 dlog(hnw_2)*100 rcr_2 dlog(hcoe_2)*100 dlog(hoy_2)*100 ty_pot_2*100

'Household Wealth
group __wealth dlog(hnw_2)*100 dlog(nha_2/pc_2)*100 dlog(nhl_2/pc_2)*100 ty_pot_2*100

'Household Assets
group __assets dlog(nha_2/pc_2)*100 dlog(nhnfa_2/pc_2)*100 dlog(nhfa_2/pc_2)*100 ty_pot_2*100

'Hhold Liabilities
group __liab dlog(nhl_2)*100 dlog(ph_2*kid_2)*100 (TY_POT_2*100 + PI_TARGET/4)

'Investments
group __inv dlog(IB_2)*100 dlog(ID_2)*100 dlog(IBN_2)*100 dlog(IBRE_2)*100 dlog(KV_2)*100

'Public Demand
group __pubd dlog(GC_2)*100 dlog(GI_2)*100 TY_POT_2*100

'Real Exports
group __xps dlog(X_2)*100 dlog(XAG_2)*100 dlog(XM_2)*100 dlog(XO_2)*100 dlog(XRE_2)*100 dlog(XS_2)*100 TY_POT_2*100

'Prices and Wages
group __pwage dlog(PTM_2)*100 (dlog(PAE_2)*100-TDLLA_2*100) dlog(PEX_2)*100 dlog(PMCG_2)*100  pi_target/4

'National Account Deflators
group __priceNA dlog(PM_2)*100 dlog(PTM_2)*100 dlog(POIL_2)*100 dlog(PC_2)*100 dlog(PID_2)*100 dlog(PIBN_2)*100 dlog(PIBRE_2)*100 dlog(PIBRE_2)*100 dlog(PG_2)*100 dlog(PX_2)*100 dlog(PIB_2)*100 dlog(PDFD_2)*100 dlog(PDPFD_2)*100 dlog(PGNE_2)*100 dlog(PY_2)*100 dlog(POTC_2)*100 

'Export Deflators
group __pricex dlog(PXRE_2)*100 dlog(PXM_2)*100 dlog(PXS_2)*100 dlog(PXO_2)*100 dlog(PXAG_2)*100 pi_target/4

'World Price Vars
group __worldp dlog(wp_2)*100 dlog(wpx_2)*100 dlog(wpag_2)*100 dlog(wpcom_2)*100 dlog(wpoil_2)*100 pi_target/4 

'World Volume Measures
group __worldv dlog(WY_2)*100 TY_POT_2*100

'World Interest Rates
group __worldr (wrr_2-wrr_target) (wr2r_2-_wr2r.@coef(1))

'Exchange Rates
graph __er dlog(rtwi_2)*100

'Import Adjusted Demand
group __iad (dlog(iad_2)*100) (dlog(rc_2)*100) (dlog(ib_2)*100) (dlog(gi_2)*100) (dlog(gc_2)*100) (dlog(x_2)*100)

'PMCG
group __pmcg dlog(PMCG_2)*100 dlog(pm_2)*100 dlog(poil_2)*100 dlog(poil_2)*100 pi_target/4 

'Import Price
group __pm dlog(pm_2)*100 dlog(wpx_2)*100 dlog(ntwi_2)*100 dlog(wpoil_2)*100 dlog(poil_2)*100

'Nominal TWI
group __ntwi dlog(ntwi_2)*100 dlog(rtwi_2)*100 dlog(wp_2)*100 dlog(ptm_2)*100



