##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

create_clock -name "clock" -period 2 -waveform {0 1} -add clock

#constraints to use before CTS (comment commands below)

set_clock_latency -source 0.001 [get_clocks clock]
set_clock_transition 0.001 [get_clocks clock]
set_input_delay 0.0016 [all_inputs] -clock clock
set_output_delay 0.0016 [all_outputs] -clock clock
set_driving_cell -lib_cell NBUFFX8_LVT [all_inputs]
set_load 0.009 [all_outputs]
set_clock_uncertainty -hold 0.001 [get_clocks clock]
set_clock_uncertainty -setup 0.006 [get_clocks clock]

#constraints to use after CTS (comment above commands)

#set_clock_latency -source 0.001 [get_clocks clock]
#set_clock_uncertainty -hold 0.001 [get_clocks clock]
#set_clock_uncertainty -setup 0.002 [get_clocks clock]
#remove_clock_transition clock

#after this use commands from clock_optimization_commands.tcl
