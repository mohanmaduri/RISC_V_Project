
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

source ../scripts/setup-new_after_dct.tcl

open_mw_lib $my_mw_lib
copy_mw_cel -from floorplan -to place_opt
open_mw_cel place_opt

set enable_recovery_removal_arcs true
set timing_enable_multiple_clocks_per_reg true
set timing_remove_clock_reconvergence_pessimism true

set physopt_enable_via_res_support true
set physopt_hard_keepout_distance 5

set_buffer_opt_strategy -effort high

set_host_options -max_cores 1 -num_processes 1 mo.ece.pdx.edu


place_opt -num_cpus 2 -continue_on_missing_scandef -effort high

legalize_placement	-effort high

verify_pg_nets

set_preferred_routing_direction -direction vertical -l {M2 M4}
set_preferred_routing_direction -direction horizontal -l {M3 M5}
set_ignored_layers  -min_routing_layer M2 -max_routing_layer M5


