
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

set_propagated_clock [all_clocks]
set_clock_tree_options -gate_sizing true
set_clock_tree_options -buffer_relocation true
set_clock_tree_options -gate_relocation true
set_clock_tree_options -buffer_sizing true
clock_opt -only_cts
set_fix_hold_options -effort medium
set_fix_hold clock
psynopt
set_fix_hold_options -effort high
psynopt -only_hold_time
psynopt -continue_on_missing_scandef
clock_opt -clock_trees -only_psyn -only_cts
clock_opt -only_psyn
clock_opt -incremental_concurrent_clock_and_data 

#DO EVEN FURTHER ROUTE OPTIMIZATION LATER AND LOOK AT THE RESULTS GENERATED IN QOR 

route_opt
route_opt -effort high 
route_opt -concurrent_clock_and_data 

