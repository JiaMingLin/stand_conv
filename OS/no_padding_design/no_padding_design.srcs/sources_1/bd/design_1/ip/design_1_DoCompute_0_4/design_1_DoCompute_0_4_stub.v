// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed Mar 24 21:15:28 2021
// Host        : jiaming-Latitude-7400 running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_DoCompute_0_4 -prefix
//               design_1_DoCompute_0_4_ design_1_DoCompute_0_4_stub.v
// Design      : design_1_DoCompute_0_4
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu3eg-sbva484-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "DoCompute,Vivado 2020.1" *)
module design_1_DoCompute_0_4(s_axi_CTRL_BUS_AWADDR, 
  s_axi_CTRL_BUS_AWVALID, s_axi_CTRL_BUS_AWREADY, s_axi_CTRL_BUS_WDATA, 
  s_axi_CTRL_BUS_WSTRB, s_axi_CTRL_BUS_WVALID, s_axi_CTRL_BUS_WREADY, 
  s_axi_CTRL_BUS_BRESP, s_axi_CTRL_BUS_BVALID, s_axi_CTRL_BUS_BREADY, 
  s_axi_CTRL_BUS_ARADDR, s_axi_CTRL_BUS_ARVALID, s_axi_CTRL_BUS_ARREADY, 
  s_axi_CTRL_BUS_RDATA, s_axi_CTRL_BUS_RRESP, s_axi_CTRL_BUS_RVALID, 
  s_axi_CTRL_BUS_RREADY, ap_clk, ap_rst_n, interrupt, m_axi_INPUT_ACT_AWADDR, 
  m_axi_INPUT_ACT_AWLEN, m_axi_INPUT_ACT_AWSIZE, m_axi_INPUT_ACT_AWBURST, 
  m_axi_INPUT_ACT_AWLOCK, m_axi_INPUT_ACT_AWREGION, m_axi_INPUT_ACT_AWCACHE, 
  m_axi_INPUT_ACT_AWPROT, m_axi_INPUT_ACT_AWQOS, m_axi_INPUT_ACT_AWVALID, 
  m_axi_INPUT_ACT_AWREADY, m_axi_INPUT_ACT_WDATA, m_axi_INPUT_ACT_WSTRB, 
  m_axi_INPUT_ACT_WLAST, m_axi_INPUT_ACT_WVALID, m_axi_INPUT_ACT_WREADY, 
  m_axi_INPUT_ACT_BRESP, m_axi_INPUT_ACT_BVALID, m_axi_INPUT_ACT_BREADY, 
  m_axi_INPUT_ACT_ARADDR, m_axi_INPUT_ACT_ARLEN, m_axi_INPUT_ACT_ARSIZE, 
  m_axi_INPUT_ACT_ARBURST, m_axi_INPUT_ACT_ARLOCK, m_axi_INPUT_ACT_ARREGION, 
  m_axi_INPUT_ACT_ARCACHE, m_axi_INPUT_ACT_ARPROT, m_axi_INPUT_ACT_ARQOS, 
  m_axi_INPUT_ACT_ARVALID, m_axi_INPUT_ACT_ARREADY, m_axi_INPUT_ACT_RDATA, 
  m_axi_INPUT_ACT_RRESP, m_axi_INPUT_ACT_RLAST, m_axi_INPUT_ACT_RVALID, 
  m_axi_INPUT_ACT_RREADY, m_axi_INPUT_WGT_AWADDR, m_axi_INPUT_WGT_AWLEN, 
  m_axi_INPUT_WGT_AWSIZE, m_axi_INPUT_WGT_AWBURST, m_axi_INPUT_WGT_AWLOCK, 
  m_axi_INPUT_WGT_AWREGION, m_axi_INPUT_WGT_AWCACHE, m_axi_INPUT_WGT_AWPROT, 
  m_axi_INPUT_WGT_AWQOS, m_axi_INPUT_WGT_AWVALID, m_axi_INPUT_WGT_AWREADY, 
  m_axi_INPUT_WGT_WDATA, m_axi_INPUT_WGT_WSTRB, m_axi_INPUT_WGT_WLAST, 
  m_axi_INPUT_WGT_WVALID, m_axi_INPUT_WGT_WREADY, m_axi_INPUT_WGT_BRESP, 
  m_axi_INPUT_WGT_BVALID, m_axi_INPUT_WGT_BREADY, m_axi_INPUT_WGT_ARADDR, 
  m_axi_INPUT_WGT_ARLEN, m_axi_INPUT_WGT_ARSIZE, m_axi_INPUT_WGT_ARBURST, 
  m_axi_INPUT_WGT_ARLOCK, m_axi_INPUT_WGT_ARREGION, m_axi_INPUT_WGT_ARCACHE, 
  m_axi_INPUT_WGT_ARPROT, m_axi_INPUT_WGT_ARQOS, m_axi_INPUT_WGT_ARVALID, 
  m_axi_INPUT_WGT_ARREADY, m_axi_INPUT_WGT_RDATA, m_axi_INPUT_WGT_RRESP, 
  m_axi_INPUT_WGT_RLAST, m_axi_INPUT_WGT_RVALID, m_axi_INPUT_WGT_RREADY, 
  m_axi_OUTPUT_r_AWADDR, m_axi_OUTPUT_r_AWLEN, m_axi_OUTPUT_r_AWSIZE, 
  m_axi_OUTPUT_r_AWBURST, m_axi_OUTPUT_r_AWLOCK, m_axi_OUTPUT_r_AWREGION, 
  m_axi_OUTPUT_r_AWCACHE, m_axi_OUTPUT_r_AWPROT, m_axi_OUTPUT_r_AWQOS, 
  m_axi_OUTPUT_r_AWVALID, m_axi_OUTPUT_r_AWREADY, m_axi_OUTPUT_r_WDATA, 
  m_axi_OUTPUT_r_WSTRB, m_axi_OUTPUT_r_WLAST, m_axi_OUTPUT_r_WVALID, 
  m_axi_OUTPUT_r_WREADY, m_axi_OUTPUT_r_BRESP, m_axi_OUTPUT_r_BVALID, 
  m_axi_OUTPUT_r_BREADY, m_axi_OUTPUT_r_ARADDR, m_axi_OUTPUT_r_ARLEN, 
  m_axi_OUTPUT_r_ARSIZE, m_axi_OUTPUT_r_ARBURST, m_axi_OUTPUT_r_ARLOCK, 
  m_axi_OUTPUT_r_ARREGION, m_axi_OUTPUT_r_ARCACHE, m_axi_OUTPUT_r_ARPROT, 
  m_axi_OUTPUT_r_ARQOS, m_axi_OUTPUT_r_ARVALID, m_axi_OUTPUT_r_ARREADY, 
  m_axi_OUTPUT_r_RDATA, m_axi_OUTPUT_r_RRESP, m_axi_OUTPUT_r_RLAST, 
  m_axi_OUTPUT_r_RVALID, m_axi_OUTPUT_r_RREADY)
/* synthesis syn_black_box black_box_pad_pin="s_axi_CTRL_BUS_AWADDR[6:0],s_axi_CTRL_BUS_AWVALID,s_axi_CTRL_BUS_AWREADY,s_axi_CTRL_BUS_WDATA[31:0],s_axi_CTRL_BUS_WSTRB[3:0],s_axi_CTRL_BUS_WVALID,s_axi_CTRL_BUS_WREADY,s_axi_CTRL_BUS_BRESP[1:0],s_axi_CTRL_BUS_BVALID,s_axi_CTRL_BUS_BREADY,s_axi_CTRL_BUS_ARADDR[6:0],s_axi_CTRL_BUS_ARVALID,s_axi_CTRL_BUS_ARREADY,s_axi_CTRL_BUS_RDATA[31:0],s_axi_CTRL_BUS_RRESP[1:0],s_axi_CTRL_BUS_RVALID,s_axi_CTRL_BUS_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_INPUT_ACT_AWADDR[31:0],m_axi_INPUT_ACT_AWLEN[7:0],m_axi_INPUT_ACT_AWSIZE[2:0],m_axi_INPUT_ACT_AWBURST[1:0],m_axi_INPUT_ACT_AWLOCK[1:0],m_axi_INPUT_ACT_AWREGION[3:0],m_axi_INPUT_ACT_AWCACHE[3:0],m_axi_INPUT_ACT_AWPROT[2:0],m_axi_INPUT_ACT_AWQOS[3:0],m_axi_INPUT_ACT_AWVALID,m_axi_INPUT_ACT_AWREADY,m_axi_INPUT_ACT_WDATA[511:0],m_axi_INPUT_ACT_WSTRB[63:0],m_axi_INPUT_ACT_WLAST,m_axi_INPUT_ACT_WVALID,m_axi_INPUT_ACT_WREADY,m_axi_INPUT_ACT_BRESP[1:0],m_axi_INPUT_ACT_BVALID,m_axi_INPUT_ACT_BREADY,m_axi_INPUT_ACT_ARADDR[31:0],m_axi_INPUT_ACT_ARLEN[7:0],m_axi_INPUT_ACT_ARSIZE[2:0],m_axi_INPUT_ACT_ARBURST[1:0],m_axi_INPUT_ACT_ARLOCK[1:0],m_axi_INPUT_ACT_ARREGION[3:0],m_axi_INPUT_ACT_ARCACHE[3:0],m_axi_INPUT_ACT_ARPROT[2:0],m_axi_INPUT_ACT_ARQOS[3:0],m_axi_INPUT_ACT_ARVALID,m_axi_INPUT_ACT_ARREADY,m_axi_INPUT_ACT_RDATA[511:0],m_axi_INPUT_ACT_RRESP[1:0],m_axi_INPUT_ACT_RLAST,m_axi_INPUT_ACT_RVALID,m_axi_INPUT_ACT_RREADY,m_axi_INPUT_WGT_AWADDR[31:0],m_axi_INPUT_WGT_AWLEN[7:0],m_axi_INPUT_WGT_AWSIZE[2:0],m_axi_INPUT_WGT_AWBURST[1:0],m_axi_INPUT_WGT_AWLOCK[1:0],m_axi_INPUT_WGT_AWREGION[3:0],m_axi_INPUT_WGT_AWCACHE[3:0],m_axi_INPUT_WGT_AWPROT[2:0],m_axi_INPUT_WGT_AWQOS[3:0],m_axi_INPUT_WGT_AWVALID,m_axi_INPUT_WGT_AWREADY,m_axi_INPUT_WGT_WDATA[511:0],m_axi_INPUT_WGT_WSTRB[63:0],m_axi_INPUT_WGT_WLAST,m_axi_INPUT_WGT_WVALID,m_axi_INPUT_WGT_WREADY,m_axi_INPUT_WGT_BRESP[1:0],m_axi_INPUT_WGT_BVALID,m_axi_INPUT_WGT_BREADY,m_axi_INPUT_WGT_ARADDR[31:0],m_axi_INPUT_WGT_ARLEN[7:0],m_axi_INPUT_WGT_ARSIZE[2:0],m_axi_INPUT_WGT_ARBURST[1:0],m_axi_INPUT_WGT_ARLOCK[1:0],m_axi_INPUT_WGT_ARREGION[3:0],m_axi_INPUT_WGT_ARCACHE[3:0],m_axi_INPUT_WGT_ARPROT[2:0],m_axi_INPUT_WGT_ARQOS[3:0],m_axi_INPUT_WGT_ARVALID,m_axi_INPUT_WGT_ARREADY,m_axi_INPUT_WGT_RDATA[511:0],m_axi_INPUT_WGT_RRESP[1:0],m_axi_INPUT_WGT_RLAST,m_axi_INPUT_WGT_RVALID,m_axi_INPUT_WGT_RREADY,m_axi_OUTPUT_r_AWADDR[31:0],m_axi_OUTPUT_r_AWLEN[7:0],m_axi_OUTPUT_r_AWSIZE[2:0],m_axi_OUTPUT_r_AWBURST[1:0],m_axi_OUTPUT_r_AWLOCK[1:0],m_axi_OUTPUT_r_AWREGION[3:0],m_axi_OUTPUT_r_AWCACHE[3:0],m_axi_OUTPUT_r_AWPROT[2:0],m_axi_OUTPUT_r_AWQOS[3:0],m_axi_OUTPUT_r_AWVALID,m_axi_OUTPUT_r_AWREADY,m_axi_OUTPUT_r_WDATA[511:0],m_axi_OUTPUT_r_WSTRB[63:0],m_axi_OUTPUT_r_WLAST,m_axi_OUTPUT_r_WVALID,m_axi_OUTPUT_r_WREADY,m_axi_OUTPUT_r_BRESP[1:0],m_axi_OUTPUT_r_BVALID,m_axi_OUTPUT_r_BREADY,m_axi_OUTPUT_r_ARADDR[31:0],m_axi_OUTPUT_r_ARLEN[7:0],m_axi_OUTPUT_r_ARSIZE[2:0],m_axi_OUTPUT_r_ARBURST[1:0],m_axi_OUTPUT_r_ARLOCK[1:0],m_axi_OUTPUT_r_ARREGION[3:0],m_axi_OUTPUT_r_ARCACHE[3:0],m_axi_OUTPUT_r_ARPROT[2:0],m_axi_OUTPUT_r_ARQOS[3:0],m_axi_OUTPUT_r_ARVALID,m_axi_OUTPUT_r_ARREADY,m_axi_OUTPUT_r_RDATA[511:0],m_axi_OUTPUT_r_RRESP[1:0],m_axi_OUTPUT_r_RLAST,m_axi_OUTPUT_r_RVALID,m_axi_OUTPUT_r_RREADY" */;
  input [6:0]s_axi_CTRL_BUS_AWADDR;
  input s_axi_CTRL_BUS_AWVALID;
  output s_axi_CTRL_BUS_AWREADY;
  input [31:0]s_axi_CTRL_BUS_WDATA;
  input [3:0]s_axi_CTRL_BUS_WSTRB;
  input s_axi_CTRL_BUS_WVALID;
  output s_axi_CTRL_BUS_WREADY;
  output [1:0]s_axi_CTRL_BUS_BRESP;
  output s_axi_CTRL_BUS_BVALID;
  input s_axi_CTRL_BUS_BREADY;
  input [6:0]s_axi_CTRL_BUS_ARADDR;
  input s_axi_CTRL_BUS_ARVALID;
  output s_axi_CTRL_BUS_ARREADY;
  output [31:0]s_axi_CTRL_BUS_RDATA;
  output [1:0]s_axi_CTRL_BUS_RRESP;
  output s_axi_CTRL_BUS_RVALID;
  input s_axi_CTRL_BUS_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  output [31:0]m_axi_INPUT_ACT_AWADDR;
  output [7:0]m_axi_INPUT_ACT_AWLEN;
  output [2:0]m_axi_INPUT_ACT_AWSIZE;
  output [1:0]m_axi_INPUT_ACT_AWBURST;
  output [1:0]m_axi_INPUT_ACT_AWLOCK;
  output [3:0]m_axi_INPUT_ACT_AWREGION;
  output [3:0]m_axi_INPUT_ACT_AWCACHE;
  output [2:0]m_axi_INPUT_ACT_AWPROT;
  output [3:0]m_axi_INPUT_ACT_AWQOS;
  output m_axi_INPUT_ACT_AWVALID;
  input m_axi_INPUT_ACT_AWREADY;
  output [511:0]m_axi_INPUT_ACT_WDATA;
  output [63:0]m_axi_INPUT_ACT_WSTRB;
  output m_axi_INPUT_ACT_WLAST;
  output m_axi_INPUT_ACT_WVALID;
  input m_axi_INPUT_ACT_WREADY;
  input [1:0]m_axi_INPUT_ACT_BRESP;
  input m_axi_INPUT_ACT_BVALID;
  output m_axi_INPUT_ACT_BREADY;
  output [31:0]m_axi_INPUT_ACT_ARADDR;
  output [7:0]m_axi_INPUT_ACT_ARLEN;
  output [2:0]m_axi_INPUT_ACT_ARSIZE;
  output [1:0]m_axi_INPUT_ACT_ARBURST;
  output [1:0]m_axi_INPUT_ACT_ARLOCK;
  output [3:0]m_axi_INPUT_ACT_ARREGION;
  output [3:0]m_axi_INPUT_ACT_ARCACHE;
  output [2:0]m_axi_INPUT_ACT_ARPROT;
  output [3:0]m_axi_INPUT_ACT_ARQOS;
  output m_axi_INPUT_ACT_ARVALID;
  input m_axi_INPUT_ACT_ARREADY;
  input [511:0]m_axi_INPUT_ACT_RDATA;
  input [1:0]m_axi_INPUT_ACT_RRESP;
  input m_axi_INPUT_ACT_RLAST;
  input m_axi_INPUT_ACT_RVALID;
  output m_axi_INPUT_ACT_RREADY;
  output [31:0]m_axi_INPUT_WGT_AWADDR;
  output [7:0]m_axi_INPUT_WGT_AWLEN;
  output [2:0]m_axi_INPUT_WGT_AWSIZE;
  output [1:0]m_axi_INPUT_WGT_AWBURST;
  output [1:0]m_axi_INPUT_WGT_AWLOCK;
  output [3:0]m_axi_INPUT_WGT_AWREGION;
  output [3:0]m_axi_INPUT_WGT_AWCACHE;
  output [2:0]m_axi_INPUT_WGT_AWPROT;
  output [3:0]m_axi_INPUT_WGT_AWQOS;
  output m_axi_INPUT_WGT_AWVALID;
  input m_axi_INPUT_WGT_AWREADY;
  output [511:0]m_axi_INPUT_WGT_WDATA;
  output [63:0]m_axi_INPUT_WGT_WSTRB;
  output m_axi_INPUT_WGT_WLAST;
  output m_axi_INPUT_WGT_WVALID;
  input m_axi_INPUT_WGT_WREADY;
  input [1:0]m_axi_INPUT_WGT_BRESP;
  input m_axi_INPUT_WGT_BVALID;
  output m_axi_INPUT_WGT_BREADY;
  output [31:0]m_axi_INPUT_WGT_ARADDR;
  output [7:0]m_axi_INPUT_WGT_ARLEN;
  output [2:0]m_axi_INPUT_WGT_ARSIZE;
  output [1:0]m_axi_INPUT_WGT_ARBURST;
  output [1:0]m_axi_INPUT_WGT_ARLOCK;
  output [3:0]m_axi_INPUT_WGT_ARREGION;
  output [3:0]m_axi_INPUT_WGT_ARCACHE;
  output [2:0]m_axi_INPUT_WGT_ARPROT;
  output [3:0]m_axi_INPUT_WGT_ARQOS;
  output m_axi_INPUT_WGT_ARVALID;
  input m_axi_INPUT_WGT_ARREADY;
  input [511:0]m_axi_INPUT_WGT_RDATA;
  input [1:0]m_axi_INPUT_WGT_RRESP;
  input m_axi_INPUT_WGT_RLAST;
  input m_axi_INPUT_WGT_RVALID;
  output m_axi_INPUT_WGT_RREADY;
  output [31:0]m_axi_OUTPUT_r_AWADDR;
  output [7:0]m_axi_OUTPUT_r_AWLEN;
  output [2:0]m_axi_OUTPUT_r_AWSIZE;
  output [1:0]m_axi_OUTPUT_r_AWBURST;
  output [1:0]m_axi_OUTPUT_r_AWLOCK;
  output [3:0]m_axi_OUTPUT_r_AWREGION;
  output [3:0]m_axi_OUTPUT_r_AWCACHE;
  output [2:0]m_axi_OUTPUT_r_AWPROT;
  output [3:0]m_axi_OUTPUT_r_AWQOS;
  output m_axi_OUTPUT_r_AWVALID;
  input m_axi_OUTPUT_r_AWREADY;
  output [511:0]m_axi_OUTPUT_r_WDATA;
  output [63:0]m_axi_OUTPUT_r_WSTRB;
  output m_axi_OUTPUT_r_WLAST;
  output m_axi_OUTPUT_r_WVALID;
  input m_axi_OUTPUT_r_WREADY;
  input [1:0]m_axi_OUTPUT_r_BRESP;
  input m_axi_OUTPUT_r_BVALID;
  output m_axi_OUTPUT_r_BREADY;
  output [31:0]m_axi_OUTPUT_r_ARADDR;
  output [7:0]m_axi_OUTPUT_r_ARLEN;
  output [2:0]m_axi_OUTPUT_r_ARSIZE;
  output [1:0]m_axi_OUTPUT_r_ARBURST;
  output [1:0]m_axi_OUTPUT_r_ARLOCK;
  output [3:0]m_axi_OUTPUT_r_ARREGION;
  output [3:0]m_axi_OUTPUT_r_ARCACHE;
  output [2:0]m_axi_OUTPUT_r_ARPROT;
  output [3:0]m_axi_OUTPUT_r_ARQOS;
  output m_axi_OUTPUT_r_ARVALID;
  input m_axi_OUTPUT_r_ARREADY;
  input [511:0]m_axi_OUTPUT_r_RDATA;
  input [1:0]m_axi_OUTPUT_r_RRESP;
  input m_axi_OUTPUT_r_RLAST;
  input m_axi_OUTPUT_r_RVALID;
  output m_axi_OUTPUT_r_RREADY;
endmodule
