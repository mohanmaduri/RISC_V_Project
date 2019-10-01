
##### EDITED AND IMPROVED BY SHUBHAM MATHUR #####

source ../scripts/setup-new.tcl

lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/stdcell_hvt/db_nldm"
lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/stdcell_lvt/db_nldm"
lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/io_std/db_nldm"
lappend search_path "/pkgs/synopsys/32_28nm/SAED32_EDK/lib/sram/db_nldm"

set target_library "saed32hvt_ss0p95vn40c.db saed32lvt_ss0p95vn40c.db"
set link_library "* saed32lvt_ss0p95vn40c.db saed32hvt_ss0p95vn40c.db saed32io_wb_ss0p95vn40c_2p25v.db \
 saed32sram_ss0p95vn40c.db dw_foundation.sldb"

set mw_lib ""

lappend mw_lib /pkgs/synopsys/32_28nm/SAED32_EDK/lib/stdcell_lvt/milkyway/saed32nm_lvt_1p9m
lappend mw_lib /pkgs/synopsys/32_28nm/SAED32_EDK/lib/stdcell_hvt/milkyway/saed32nm_hvt_1p9m
lappend mw_lib /pkgs/synopsys/32_28nm/SAED32_EDK/lib/io_std/milkyway/saed32_io_wb
lappend mw_lib /pkgs/synopsys/32_28nm/SAED32_EDK/lib/sram/milkyway/SRAM32NM

set tf_dir "/pkgs/synopsys/32_28nm/SAED32_EDK/tech/milkyway"
set tlu_dir /pkgs/synopsys/32_28nm/SAED32_EDK/tech/star_rcxt
set_tlu_plus_files  -max_tluplus $tlu_dir/saed32nm_1p9m_Cmax.tluplus  \
                    -min_tluplus $tlu_dir/saed32nm_1p9m_Cmin.tluplus  \
                    -tech2itf_map  $tlu_dir/saed32nm_tf_itf_tluplus.map

file delete -force $my_mw_lib 
create_mw_lib $my_mw_lib -technology $tf_dir/saed32nm_1p9m_mw.tf  -mw_reference_library $mw_lib -open

import_designs $verilog_file \
	-format verilog \
	-cel $top_design \
	-top $top_design

set_operating_conditions ss0p95vn40c_2p25v
set_max_area 0

source ../scripts/exp_sdc.sdc

save_mw_cel -overwrite

