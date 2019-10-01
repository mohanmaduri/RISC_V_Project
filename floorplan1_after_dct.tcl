
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

source ../scripts/setup-new_after_dct.tcl
set my_mw_lib ${top_design}_lib.mw
open_mw_lib $my_mw_lib
copy_mw_cel -from ${top_design} -to floorplan
open_mw_cel floorplan

puts "Putting Core Space: ...."

set pad_design 0 
if { $pad_design } {


foreach net {VDD} { derive_pg_connection -power_net $net -power_pin $net -create_ports top}
foreach net {VSS} { derive_pg_connection -ground_net $net -ground_pin $net -create_ports top}

if { [ sizeof_coll [ get_cell -quiet io_* ] ] == 0 } {
 source -echo -verbose ../scripts/add_ios.tcl
}

foreach i [get_attribute  [get_cells -all io_e_* ] full_name ] { set_pad_physical_constraints -side 3 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_n_* ] full_name ] { set_pad_physical_constraints -side 2 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_s_* ] full_name ] { set_pad_physical_constraints -side 4 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_w_* ] full_name ] { set_pad_physical_constraints -side 1 -pad_name $i }

foreach i [get_attribute  [get_cells -all io_r_* ] full_name ] { set_pad_physical_constraints -side 3 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_t_* ] full_name ] { set_pad_physical_constraints -side 2 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_b_* ] full_name ] { set_pad_physical_constraints -side 4 -pad_name $i }
foreach i [get_attribute  [get_cells -all io_l_* ] full_name ] { set_pad_physical_constraints -side 1 -pad_name $i }


create_floorplan -control_type width_and_height -core_width 560 -core_height 560 -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10

} else {
 foreach net {VDD} { derive_pg_connection -power_net $net -power_pin $net -create_ports top}
 foreach net {VSS} { derive_pg_connection -ground_net $net -ground_pin $net -create_ports top}
 create_floorplan -control_type width_and_height -core_width 1600 -core_height 1190 -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10
 
}

derive_pg_connection -tie

set ring_width 4
set offset 4
set hm M5
set vm M6

puts "Starting FP Placement: ..."

set_fp_rail_constraints -remove_all_layers

set_fp_rail_constraints -add_layer  -layer M7 -direction horizontal -max_strap 128 -min_strap 8 -min_width 0.608 -max_width 3 -spacing interleaving 

set_fp_rail_constraints -add_layer  -layer M8 -direction vertical -max_strap 128 -min_strap 8 -min_width 0.608 -spacing interleaving -max_width 3

set_fp_rail_constraints -set_global   -no_routing_over_hard_macros -no_routing_over_soft_macros

create_fp_virtual_pad -nets VDD -point { 10 0 }
create_fp_virtual_pad -nets VDD -point { 10 1000 }
create_fp_virtual_pad -nets VDD -point { 1000 10 }
create_fp_virtual_pad -nets VDD -point { 1000 1000 }
create_fp_virtual_pad -nets VDD -point { 500 500  }

create_fp_virtual_pad -nets VSS -point { 30 0 }
create_fp_virtual_pad -nets VSS -point { 30 980 }
create_fp_virtual_pad -nets VSS -point { 980 30 }
create_fp_virtual_pad -nets VSS -point { 980 980 }
create_fp_virtual_pad -nets VSS -point { 480 480 }

puts "Starting synthesize_fp_rail ..."
synthesize_fp_rail  -nets {VDD VSS} -voltage_supply 0.95 -power_budget 100 -target_voltage_drop 100 -lowest_voltage_drop -use_pins_as_pads

commit_fp_rail	

preroute_standard_cells

puts "preroute_instances ..."

set_fp_placement_strategy -auto_grouping medium
set_fp_placement_strategy -macro_orientation automatic
set_fp_placement_strategy -macros_on_edge on
set_pin_physical_constraints [get_ports -all] -side 1 
create_placement_blockage -no_hard_macro -bbox {10.0 10.0 30.00 1199.144}
set_fp_placement_strategy -auto_grouping_max_columns 2
set_fp_placement_strategy -auto_grouping_max_rows 2
set_fp_placement_strategy -min_distance_between_macros 1
set_fp_placement_strategy -sliver_size 50

create_fp_placement -timing_driven -optimize_pins
set_attribute [all_macro_cells] is_fixed true
set_fast_mode true

write_floorplan  -create_terminal -placement { io hard_macro } -row -track -no_placement_blockage -no_bound -no_plan_group -no_voltage_area -no_route_guide fp_after_dct.tcl

puts "Logfile message: writing def file now..."

write_def \
	-rows_tracks_gcells \
	-vias \
	-components \
	-macro \
	-pins \
	-blockages \
	-specialnets \
	-no_legalize \
	-output "../outputs/${top_design}.floorplan_after_dct.def"

puts "Logfile message: writing def file completed ..."

save_mw_cel -overwrite

copy_mw_cel -from ${top_design} -to as_floorplan_after_dct_tcl

