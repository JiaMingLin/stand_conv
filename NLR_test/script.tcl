############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################

set pwd [pwd]

open_project $pwd/NLR_HLS
set_top DoCompute
add_files $pwd/top.cpp
add_files $pwd/top.h
open_solution "solution1"
set_part {xczu3cg-sbva484-1-e} -tool vivado
create_clock -period 5 -name default
config_export -format ip_catalog -rtl verilog
#csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog
exit
