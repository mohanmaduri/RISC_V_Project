
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

set timestamp [clock format [clock scan now] -format "%Y-%m-%d_%H-%M"]
set sh_output_log_file "${synopsys_program_name}.log.$timestamp"
set sh_command_log_file "${synopsys_program_name}.cmd.$timestamp"
set top_design ExampleRocketSystem
set my_mw_lib ${top_design}_lib.mw
set verilog_file ../../syn/outputs/Run1.dc.vg
set power                    "VDD"
set ground                   "VSS"
set powerPort                "VDD"
set groundPort               "VSS"
set core_util                "0.02"
set core_space               "50"
return 1
