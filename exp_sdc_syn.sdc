
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

create_clock -name "clock" -period 2 -waveform {0 1} -add clock
set_clock_latency -source 0.001 [get_clocks clock]
set_clock_transition 0.001 [get_clocks clock]
set_input_delay 0.0016 [all_inputs] -clock clock
set_output_delay 0.0016 [all_outputs] -clock clock
set_driving_cell -lib_cell NBUFFX8_HVT [all_inputs]
set_load 0.009 [all_outputs]
set_clock_uncertainty -hold 0.001 [get_clocks clock]
set_clock_uncertainty -setup 0.006 [get_clocks clock]
