
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

source -echo -verbose ../scripts/read_after_dct.tcl

source -echo -verbose ../scripts/floorplan1_after_dct.tcl

source -echo -verbose ../scripts/place.tcl

set_si_options -delta_delay true -static_noise true -timing_window true -min_delta_delay true -static_noise_threshold_above_low 0.35 -static_noise_threshold_below_high 0.35 -route_xtalk_prevention true -route_xtalk_prevention_threshold 0.45

extract_rc -coupling_cap
write_verilog ../outputs/${top_design}.route.vg
write_parasitics -output ../outputs/${top_design}.route.spf

set stage route
report_qor > ../reports/${top_design}.$stage.qor.rpt
report_constraint -all_viol > ../reports/${top_design}.$stage.constraint.rpt
report_timing -delay max -input -tran -cross -sig 4 -derate -net -cap  -path full_clock_expanded -max_path 10000 > ../reports/${top_design}.$stage.timing.max.full_clock.rpt
report_timing -delay max -input -tran -cross -sig 4 -derate -net -cap  -max_path 10000 > ../reports/${top_design}.$stage.timing.max.rpt
check_timing  > ../reports/${top_design}.$stage.check_timing.rpt
check_design > ../reports/${top_design}.$stage.check_design.rpt
check_mv_design  > ../reports/${top_design}.$stage.mvrc.rpt

