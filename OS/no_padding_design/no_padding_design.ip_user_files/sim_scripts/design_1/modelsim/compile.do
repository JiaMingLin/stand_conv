vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_7
vlib modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_7
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/lib_cdc_v1_0_2
vlib modelsim_lib/msim/proc_sys_reset_v5_0_13
vlib modelsim_lib/msim/generic_baseblocks_v2_1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_21
vlib modelsim_lib/msim/fifo_generator_v13_2_5
vlib modelsim_lib/msim/axi_data_fifo_v2_1_20
vlib modelsim_lib/msim/axi_crossbar_v2_1_22
vlib modelsim_lib/msim/axi_protocol_converter_v2_1_21
vlib modelsim_lib/msim/axi_clock_converter_v2_1_20
vlib modelsim_lib/msim/blk_mem_gen_v8_4_4
vlib modelsim_lib/msim/axi_dwidth_converter_v2_1_21
vlib modelsim_lib/msim/axi_mmu_v2_1_19

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_7 modelsim_lib/msim/axi_vip_v1_1_7
vmap zynq_ultra_ps_e_vip_v1_0_7 modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_7
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap lib_cdc_v1_0_2 modelsim_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 modelsim_lib/msim/proc_sys_reset_v5_0_13
vmap generic_baseblocks_v2_1_0 modelsim_lib/msim/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_21 modelsim_lib/msim/axi_register_slice_v2_1_21
vmap fifo_generator_v13_2_5 modelsim_lib/msim/fifo_generator_v13_2_5
vmap axi_data_fifo_v2_1_20 modelsim_lib/msim/axi_data_fifo_v2_1_20
vmap axi_crossbar_v2_1_22 modelsim_lib/msim/axi_crossbar_v2_1_22
vmap axi_protocol_converter_v2_1_21 modelsim_lib/msim/axi_protocol_converter_v2_1_21
vmap axi_clock_converter_v2_1_20 modelsim_lib/msim/axi_clock_converter_v2_1_20
vmap blk_mem_gen_v8_4_4 modelsim_lib/msim/blk_mem_gen_v8_4_4
vmap axi_dwidth_converter_v2_1_21 modelsim_lib/msim/axi_dwidth_converter_v2_1_21
vmap axi_mmu_v2_1_19 modelsim_lib/msim/axi_mmu_v2_1_19

vlog -work xilinx_vip -64 -incr -sv -L axi_vip_v1_1_7 -L zynq_ultra_ps_e_vip_v1_0_7 -L xilinx_vip "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -sv -L axi_vip_v1_1_7 -L zynq_ultra_ps_e_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_7 -64 -incr -sv -L axi_vip_v1_1_7 -L zynq_ultra_ps_e_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ce6c/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_7 -64 -incr -sv -L axi_vip_v1_1_7 -L zynq_ultra_ps_e_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_rst_ps8_0_100M_2/sim/design_1_rst_ps8_0_100M_2.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_21 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/2ef9/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_5 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -64 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_20 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/47c9/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_22 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/b68e/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xbar_2/sim/design_1_xbar_2.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute_act_bufbkb.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute_CTRL_BUS_s_axi.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute_INPUT_ACT_m_axi.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute_out_bufjbC.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute_OUTPUT_r_m_axi.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/LoadAct.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/WriteOutput.v" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8fd5/hdl/verilog/DoCompute.v" \
"../../../bd/design_1/ip/design_1_DoCompute_0_4/sim/design_1_DoCompute_0_4.v" \

vlog -work axi_protocol_converter_v2_1_21 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8dfa/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_20 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/7589/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_4 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_21 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/07be/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_ds_0/sim/design_1_auto_ds_0.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
"../../../bd/design_1/ip/design_1_auto_ds_1/sim/design_1_auto_ds_1.v" \
"../../../bd/design_1/ip/design_1_auto_ds_2/sim/design_1_auto_ds_2.v" \

vlog -work axi_mmu_v2_1_19 -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/45eb/hdl/axi_mmu_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_s00_mmu_0/sim/design_1_s00_mmu_0.v" \
"../../../bd/design_1/ip/design_1_s01_mmu_0/sim/design_1_s01_mmu_0.v" \
"../../../bd/design_1/ip/design_1_s02_mmu_0/sim/design_1_s02_mmu_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

