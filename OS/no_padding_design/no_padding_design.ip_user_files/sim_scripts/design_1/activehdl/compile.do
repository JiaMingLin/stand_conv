vlib work
vlib activehdl

vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_7
vlib activehdl/zynq_ultra_ps_e_vip_v1_0_7
vlib activehdl/xil_defaultlib
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/proc_sys_reset_v5_0_13
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/axi_register_slice_v2_1_21
vlib activehdl/fifo_generator_v13_2_5
vlib activehdl/axi_data_fifo_v2_1_20
vlib activehdl/axi_crossbar_v2_1_22
vlib activehdl/axi_protocol_converter_v2_1_21
vlib activehdl/axi_clock_converter_v2_1_20
vlib activehdl/blk_mem_gen_v8_4_4
vlib activehdl/axi_dwidth_converter_v2_1_21
vlib activehdl/axi_mmu_v2_1_19

vmap xilinx_vip activehdl/xilinx_vip
vmap xpm activehdl/xpm
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_7 activehdl/axi_vip_v1_1_7
vmap zynq_ultra_ps_e_vip_v1_0_7 activehdl/zynq_ultra_ps_e_vip_v1_0_7
vmap xil_defaultlib activehdl/xil_defaultlib
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 activehdl/proc_sys_reset_v5_0_13
vmap generic_baseblocks_v2_1_0 activehdl/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_21 activehdl/axi_register_slice_v2_1_21
vmap fifo_generator_v13_2_5 activehdl/fifo_generator_v13_2_5
vmap axi_data_fifo_v2_1_20 activehdl/axi_data_fifo_v2_1_20
vmap axi_crossbar_v2_1_22 activehdl/axi_crossbar_v2_1_22
vmap axi_protocol_converter_v2_1_21 activehdl/axi_protocol_converter_v2_1_21
vmap axi_clock_converter_v2_1_20 activehdl/axi_clock_converter_v2_1_20
vmap blk_mem_gen_v8_4_4 activehdl/blk_mem_gen_v8_4_4
vmap axi_dwidth_converter_v2_1_21 activehdl/axi_dwidth_converter_v2_1_21
vmap axi_mmu_v2_1_19 activehdl/axi_mmu_v2_1_19

vlog -work xilinx_vip  -sv2k12 "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/jiaming/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_7  -sv2k12 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ce6c/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_7  -sv2k12 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_rst_ps8_0_100M_2/sim/design_1_rst_ps8_0_100M_2.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_21  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/2ef9/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_5  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -93 \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_20  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/47c9/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_22  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/b68e/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
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

vlog -work axi_protocol_converter_v2_1_21  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/8dfa/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_20  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/7589/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_4  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_21  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/07be/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_ds_0/sim/design_1_auto_ds_0.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
"../../../bd/design_1/ip/design_1_auto_ds_1/sim/design_1_auto_ds_1.v" \
"../../../bd/design_1/ip/design_1_auto_ds_2/sim/design_1_auto_ds_2.v" \

vlog -work axi_mmu_v2_1_19  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/45eb/hdl/axi_mmu_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../no_padding_design.srcs/sources_1/bd/design_1/ipshared/e257/hdl" "+incdir+/home/jiaming/Xilinx/Vivado/2020.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_s00_mmu_0/sim/design_1_s00_mmu_0.v" \
"../../../bd/design_1/ip/design_1_s01_mmu_0/sim/design_1_s01_mmu_0.v" \
"../../../bd/design_1/ip/design_1_s02_mmu_0/sim/design_1_s02_mmu_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

