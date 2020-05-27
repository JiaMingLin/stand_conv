############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
open_project NoLocalReuse
set_top Conv
add_files ./top.cpp
add_files ./top.h
add_files -tb NoLocalReuse/tb.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xczu3cg-sbva484-1-e} -tool vivado
create_clock -period 5 -name default
config_export -format ip_catalog -rtl verilog
#source "./NoLocalReuse/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog
exit
