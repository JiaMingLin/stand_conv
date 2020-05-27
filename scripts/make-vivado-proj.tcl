if {$argc != 4} {
  puts "Expected: <proj_name> <proj_dir> <xdc_dir> <ip_repo>"
  exit
}

# project name, target dir and FPGA part to use
set config_proj_name [lindex $argv 0]
set config_proj_dir [lindex $argv 1]
set config_proj_part "xczu3eg-sbva484-1-e"

# other project config

set xdc_dir [lindex $argv 2]
set ip_repo [lindex $argv 3]

puts "config_proj_name: ${config_proj_name}"
puts "config_proj_dir: ${config_proj_dir}"
puts "xdc_dir:  ${xdc_dir}"
puts "ip_repo: ${ip_repo}"

# set up project
create_project -force $config_proj_name $config_proj_dir -part $config_proj_part

# set_property board_part em.avnet.com:ultra96v2:part0:1.0 [current_project]

# Add PYNQ XDC
# add_files -fileset constrs_1 -norecurse "${xdc_dir}/PYNQ-Z1_C.xdc"

set_property  ip_repo_paths $ip_repo [current_project]
update_ip_catalog

source "${xdc_dir}/procsys.tcl"

save_bd_design

make_wrapper -files [get_files $config_proj_dir/$config_proj_name.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse $config_proj_dir/$config_proj_name.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
