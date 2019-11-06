
'3. Solve a baseline scenario 
smpl {sim1_start} {sim1_end}
{modelname}.scenario "baseline"
{modelname}.solve

'4. Solve shock scenarios

for %scn {%scn_num}

'Create group for shocks
group scn_shocks{%scn}

	for %s {%shock_num{%scn}}
		'create back up series of shock variable
		smpl @all
		series {shock{%s}{%scn}}_bac = {shock{%s}{%scn}}

		'Add relevant shocks to group to run through scenario
		scn_shocks{%scn}.add {shock{%s}{%scn}}
	next

	smpl {sim1_start} {sim1_end}
	{modelname}.scenario(n,a={%scn}) %shock_title{%scn}

	for %s {%shock_num{%scn}}
		if !shock_input = 1 then
			if shock{%s}_type{%scn} = "ppt" then
				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}+{!shock{%s}_size{%scn}} 'add the shock size to the baseline shock variable to create a new series
			else
			if shock{%s}_type{%scn} = "pct" then
     				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}*(1+{!shock{%s}_size{%scn}}/100)
			else
			if shock{%s}_type{%scn} = "pcy" then
				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}+{!shock{%s}_size{%scn}}*y_{baseline}/(100)	
			else
				@uiprompt(shock{%s}+"error in type of shock, adjust and try again", "O")
			endif
			endif
			endif
		else
			if shock{%s}_type{%scn} = "ppt" then
				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}+shock{%s}_size{%scn} 'add the shock size to the baseline shock variable to create a new series
			else
			if shock{%s}_type{%scn} = "pct" then
     				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}*(1+shock{%s}_size{%scn}/100)
			else
			if shock{%s}_type{%scn} = "pcy" then
				series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}+shock{%s}_size{%scn}*y_{baseline}/(100)	
			else
				@uiprompt(shock{%s}+"error in type of shock, adjust and try again", "O")
			endif
			endif
			endif
		endif

		'Set shock back to baseline after shock is over (this only matters if you solve and exclude the series beyond the duration of shock)
'		smpl {%shock{%s}_end{%scn}}+1 {sim1_end}
'		series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}

		smpl {sim1_start} {sim1_end}
		'Hold shock variable equal to baseline until end of shock duration - model will solve for shock variable endogenously after shock duration
		{modelname}.exclude(m) {shock{%s}{%scn}}({%shock_start} {%shock{%s}_end{%scn}})
		'Hold shock variable equal to baseline until sim end - do this if you want to snap the shock variable back to its baseline level after the shock's duration
		'{modelname.exclude {shock{%s}}({%shock{%s}_start} {sim1_end})
	next 

{modelname}.solve


'----

'Produce some basic IRFs 

if @isempty(irfs_levels) = 0 then

'make spool with graphs of shock IRFs

{modelname}.makegraph(n,r) irf_levels{%scn} {irfs_levels}
{modelname}.makegraph(d,n) irf_rates{%scn} {irfs_rates}
irf_rates{%scn}.addtext(t) {irfs_rates} (level deviation)

graph irf{%scn}.merge irf_levels{%scn} irf_rates{%scn}

irf{%scn}.addtext(t,font(20)) %shock_title{%scn}

	for %s {%shock_num{%scn}} 'this sets all of the shocked varaibles in the scenario back to baseline before the following scenario is run - this is important for add factor shocks 

		series {shock{%s}{%scn}}={shock{%s}{%scn}}_{baseline}

	next

'next

endif
next


