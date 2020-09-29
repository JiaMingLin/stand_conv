############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
set hls_dir [lindex $argv 2]

open_project -reset HLS_PROJ
set_top DoCompute
add_files ${hls_dir}/top.cpp
add_files ${hls_dir}/top.h
open_solution "solution1"
set_part {xczu3cg-sbva484-1-e} -tool vivado
create_clock -period 5 -name default
config_export -format ip_catalog -rtl verilog
#csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog
exit
