
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

set top_design ExampleRocketSystem

lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/stdcell_hvt/db_nldm"
lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/io_std/db_nldm"
lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/sram/db_nldm"

set target_library "saed32hvt_ss0p95vn40c.db"
set link_library "* saed32hvt_ss0p95vn40c.db saed32io_wb_ss0p95vn40c_2p25v.db \
 saed32sram_ss0p95vn40c.db dw_foundation.sldb"

analyze -define SYNTHESIS -format sverilog ../rtl/ROCKET_CORE_AND_UNCORE.sv

elaborate ${top_design} 

source ../scripts/exp_sdc_syn.sdc

compile_ultra -scan -retime

echo check_timing command
check_timing -include {no_driving_cell no_input_delay partial_input_delay unconstrained_endpoints }
echo report_qor command
report_qor
report_power
echo report_constraint command (PWR-6, PWR-414, PWR-415 Warnings are ok)
report_constraint -all_violators -max_delay -max_cap -max_tran -max_fan
echo do a report_timing command on any violators to get details 
echo or do a report_constraint -all_violators -verbose

set timestamp [clock format [clock scan now] -format "%Y-%m-%d_%H-%M"]
set sh_output_log_file "${synopsys_program_name}.log.$timestamp"
set sh_command_log_file "${synopsys_program_name}.cmd.$timestamp"

set stage dc
report_qor > ../reports/${top_design}.$stage.qor.rpt
report_constraint -all_viol > ../reports/${top_design}.$stage.constraint.rpt
report_timing -delay max -input -tran -cross -sig 4 -derate -net -cap  -max_path 10000 > ../reports/${top_design}.$stage.timing.max.rpt
check_timing  > ../reports/${top_design}.$stage.check_timing.rpt
check_design > ../reports/${top_design}.$stage.check_design.rpt
check_mv_design  > ../reports/${top_design}.$stage.mvrc.rpt

write -hier -format verilog -output ../outputs/Run1.$stage.vg
