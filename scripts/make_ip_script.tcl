############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################

# project name, target dir and FPGA part to use
#set config_proj_name [lindex $argv 0]
#set config_proj_dir [lindex $argv 1]
#set config_proj_part "xczu3eg-sbva484-1-e"

# other project config

#set xdc_dir [lindex $argv 2]
#set ip_repo [lindex $argv 3]

#puts "config_proj_name: ${config_proj_name}"
#puts "config_proj_dir: ${config_proj_dir}"
#puts "xdc_dir:  ${xdc_dir}"
#puts "ip_repo: ${ip_repo}"

set hls_dir [lindex $argv 0]
set project_name [lindex $argv 1]

open_project ${hls_dir}/${project_name}/
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
