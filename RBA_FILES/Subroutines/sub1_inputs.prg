
'2. Create the inputs on the different shocks in each scenario to feed into the code that runs the scenarios below

for %scn {%scn_num}

	scalar shock_count = 0
	for %s {%shock_name{%scn}}
		shock_count = shock_count+1
		%str_count = @str(shock_count)
		string shock{%str_count}{%scn} = %s
	next

	scalar shock_count =0 
	for %s {%shock_type{%scn}}
		shock_count = shock_count+1
		%str_count = @str(shock_count)
		string shock{%str_count}_type{%scn} = %s
	next

	scalar shock_count =0 
	for %s {%shock_length{%scn}}
		shock_count = shock_count+1
		%str_count = @str(shock_count)
		!shock{%str_count}_length{%scn} = @val(%s)
	next

	if !shock_input = 1 then
		scalar shock_count =0 
		for %s {%shock_size{%scn}}
			shock_count = shock_count+1
			%str_count = @str(shock_count)
			!shock{%str_count}_size{%scn} = @val(%s)
		next
	else
		scalar shock_count =0 
		for %s {%shock_num{%scn}}
			shock_count = shock_count+1
			%str_count = @str(shock_count)
			series shock{%str_count}_size{%scn} = import_shock{%s}{%scn}
		next
	endif

	for %s {%shock_num{%scn}}
		'Creates a string corresponding to end of shock
		!shock{%s}_obs{%scn}=@dtoo(%shock_start)
		!shock{%s}_end{%scn} = !shock{%s}_obs{%scn}+!shock{%s}_length{%scn}-1  'subtract one as already including initial quarter
		%shock{%s}_end{%scn} = @otod(!shock{%s}_end{%scn})
	next

next



