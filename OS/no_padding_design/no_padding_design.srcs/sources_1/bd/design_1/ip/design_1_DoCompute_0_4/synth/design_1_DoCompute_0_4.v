// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:DoCompute:1.0
// IP Revision: 2103242111

(* X_CORE_INFO = "DoCompute,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "design_1_DoCompute_0_4,DoCompute,{}" *)
(* CORE_GENERATION_INFO = "design_1_DoCompute_0_4,DoCompute,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=DoCompute,x_ipVersion=1.0,x_ipCoreRevision=2103242111,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_S_AXI_CTRL_BUS_ADDR_WIDTH=7,C_S_AXI_CTRL_BUS_DATA_WIDTH=32,C_M_AXI_INPUT_ACT_ID_WIDTH=1,C_M_AXI_INPUT_ACT_ADDR_WIDTH=32,C_M_AXI_INPUT_ACT_DATA_WIDTH=512,C_M_AXI_INPUT_ACT_AWUSER_WIDTH=1,C_M_AXI_INPUT_ACT_ARUSER_WIDTH=1,C_M_AXI_INPUT_ACT_WUSER_WIDTH=1,C_M_AXI_INPUT_ACT_RUSER_WIDTH=1,C_M_AXI_INP\
UT_ACT_BUSER_WIDTH=1,C_M_AXI_INPUT_ACT_USER_VALUE=0x00000000,C_M_AXI_INPUT_ACT_PROT_VALUE=000,C_M_AXI_INPUT_ACT_CACHE_VALUE=0011,C_M_AXI_INPUT_WGT_ID_WIDTH=1,C_M_AXI_INPUT_WGT_ADDR_WIDTH=32,C_M_AXI_INPUT_WGT_DATA_WIDTH=512,C_M_AXI_INPUT_WGT_AWUSER_WIDTH=1,C_M_AXI_INPUT_WGT_ARUSER_WIDTH=1,C_M_AXI_INPUT_WGT_WUSER_WIDTH=1,C_M_AXI_INPUT_WGT_RUSER_WIDTH=1,C_M_AXI_INPUT_WGT_BUSER_WIDTH=1,C_M_AXI_INPUT_WGT_USER_VALUE=0x00000000,C_M_AXI_INPUT_WGT_PROT_VALUE=000,C_M_AXI_INPUT_WGT_CACHE_VALUE=0011,C_M_AXI\
_OUTPUT_R_ID_WIDTH=1,C_M_AXI_OUTPUT_R_ADDR_WIDTH=32,C_M_AXI_OUTPUT_R_DATA_WIDTH=512,C_M_AXI_OUTPUT_R_AWUSER_WIDTH=1,C_M_AXI_OUTPUT_R_ARUSER_WIDTH=1,C_M_AXI_OUTPUT_R_WUSER_WIDTH=1,C_M_AXI_OUTPUT_R_RUSER_WIDTH=1,C_M_AXI_OUTPUT_R_BUSER_WIDTH=1,C_M_AXI_OUTPUT_R_USER_VALUE=0x00000000,C_M_AXI_OUTPUT_R_PROT_VALUE=000,C_M_AXI_OUTPUT_R_CACHE_VALUE=0011}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_DoCompute_0_4 (
  s_axi_CTRL_BUS_AWADDR,
  s_axi_CTRL_BUS_AWVALID,
  s_axi_CTRL_BUS_AWREADY,
  s_axi_CTRL_BUS_WDATA,
  s_axi_CTRL_BUS_WSTRB,
  s_axi_CTRL_BUS_WVALID,
  s_axi_CTRL_BUS_WREADY,
  s_axi_CTRL_BUS_BRESP,
  s_axi_CTRL_BUS_BVALID,
  s_axi_CTRL_BUS_BREADY,
  s_axi_CTRL_BUS_ARADDR,
  s_axi_CTRL_BUS_ARVALID,
  s_axi_CTRL_BUS_ARREADY,
  s_axi_CTRL_BUS_RDATA,
  s_axi_CTRL_BUS_RRESP,
  s_axi_CTRL_BUS_RVALID,
  s_axi_CTRL_BUS_RREADY,
  ap_clk,
  ap_rst_n,
  interrupt,
  m_axi_INPUT_ACT_AWADDR,
  m_axi_INPUT_ACT_AWLEN,
  m_axi_INPUT_ACT_AWSIZE,
  m_axi_INPUT_ACT_AWBURST,
  m_axi_INPUT_ACT_AWLOCK,
  m_axi_INPUT_ACT_AWREGION,
  m_axi_INPUT_ACT_AWCACHE,
  m_axi_INPUT_ACT_AWPROT,
  m_axi_INPUT_ACT_AWQOS,
  m_axi_INPUT_ACT_AWVALID,
  m_axi_INPUT_ACT_AWREADY,
  m_axi_INPUT_ACT_WDATA,
  m_axi_INPUT_ACT_WSTRB,
  m_axi_INPUT_ACT_WLAST,
  m_axi_INPUT_ACT_WVALID,
  m_axi_INPUT_ACT_WREADY,
  m_axi_INPUT_ACT_BRESP,
  m_axi_INPUT_ACT_BVALID,
  m_axi_INPUT_ACT_BREADY,
  m_axi_INPUT_ACT_ARADDR,
  m_axi_INPUT_ACT_ARLEN,
  m_axi_INPUT_ACT_ARSIZE,
  m_axi_INPUT_ACT_ARBURST,
  m_axi_INPUT_ACT_ARLOCK,
  m_axi_INPUT_ACT_ARREGION,
  m_axi_INPUT_ACT_ARCACHE,
  m_axi_INPUT_ACT_ARPROT,
  m_axi_INPUT_ACT_ARQOS,
  m_axi_INPUT_ACT_ARVALID,
  m_axi_INPUT_ACT_ARREADY,
  m_axi_INPUT_ACT_RDATA,
  m_axi_INPUT_ACT_RRESP,
  m_axi_INPUT_ACT_RLAST,
  m_axi_INPUT_ACT_RVALID,
  m_axi_INPUT_ACT_RREADY,
  m_axi_INPUT_WGT_AWADDR,
  m_axi_INPUT_WGT_AWLEN,
  m_axi_INPUT_WGT_AWSIZE,
  m_axi_INPUT_WGT_AWBURST,
  m_axi_INPUT_WGT_AWLOCK,
  m_axi_INPUT_WGT_AWREGION,
  m_axi_INPUT_WGT_AWCACHE,
  m_axi_INPUT_WGT_AWPROT,
  m_axi_INPUT_WGT_AWQOS,
  m_axi_INPUT_WGT_AWVALID,
  m_axi_INPUT_WGT_AWREADY,
  m_axi_INPUT_WGT_WDATA,
  m_axi_INPUT_WGT_WSTRB,
  m_axi_INPUT_WGT_WLAST,
  m_axi_INPUT_WGT_WVALID,
  m_axi_INPUT_WGT_WREADY,
  m_axi_INPUT_WGT_BRESP,
  m_axi_INPUT_WGT_BVALID,
  m_axi_INPUT_WGT_BREADY,
  m_axi_INPUT_WGT_ARADDR,
  m_axi_INPUT_WGT_ARLEN,
  m_axi_INPUT_WGT_ARSIZE,
  m_axi_INPUT_WGT_ARBURST,
  m_axi_INPUT_WGT_ARLOCK,
  m_axi_INPUT_WGT_ARREGION,
  m_axi_INPUT_WGT_ARCACHE,
  m_axi_INPUT_WGT_ARPROT,
  m_axi_INPUT_WGT_ARQOS,
  m_axi_INPUT_WGT_ARVALID,
  m_axi_INPUT_WGT_ARREADY,
  m_axi_INPUT_WGT_RDATA,
  m_axi_INPUT_WGT_RRESP,
  m_axi_INPUT_WGT_RLAST,
  m_axi_INPUT_WGT_RVALID,
  m_axi_INPUT_WGT_RREADY,
  m_axi_OUTPUT_r_AWADDR,
  m_axi_OUTPUT_r_AWLEN,
  m_axi_OUTPUT_r_AWSIZE,
  m_axi_OUTPUT_r_AWBURST,
  m_axi_OUTPUT_r_AWLOCK,
  m_axi_OUTPUT_r_AWREGION,
  m_axi_OUTPUT_r_AWCACHE,
  m_axi_OUTPUT_r_AWPROT,
  m_axi_OUTPUT_r_AWQOS,
  m_axi_OUTPUT_r_AWVALID,
  m_axi_OUTPUT_r_AWREADY,
  m_axi_OUTPUT_r_WDATA,
  m_axi_OUTPUT_r_WSTRB,
  m_axi_OUTPUT_r_WLAST,
  m_axi_OUTPUT_r_WVALID,
  m_axi_OUTPUT_r_WREADY,
  m_axi_OUTPUT_r_BRESP,
  m_axi_OUTPUT_r_BVALID,
  m_axi_OUTPUT_r_BREADY,
  m_axi_OUTPUT_r_ARADDR,
  m_axi_OUTPUT_r_ARLEN,
  m_axi_OUTPUT_r_ARSIZE,
  m_axi_OUTPUT_r_ARBURST,
  m_axi_OUTPUT_r_ARLOCK,
  m_axi_OUTPUT_r_ARREGION,
  m_axi_OUTPUT_r_ARCACHE,
  m_axi_OUTPUT_r_ARPROT,
  m_axi_OUTPUT_r_ARQOS,
  m_axi_OUTPUT_r_ARVALID,
  m_axi_OUTPUT_r_ARREADY,
  m_axi_OUTPUT_r_RDATA,
  m_axi_OUTPUT_r_RRESP,
  m_axi_OUTPUT_r_RLAST,
  m_axi_OUTPUT_r_RVALID,
  m_axi_OUTPUT_r_RREADY
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS AWADDR" *)
input wire [6 : 0] s_axi_CTRL_BUS_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS AWVALID" *)
input wire s_axi_CTRL_BUS_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS AWREADY" *)
output wire s_axi_CTRL_BUS_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS WDATA" *)
input wire [31 : 0] s_axi_CTRL_BUS_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS WSTRB" *)
input wire [3 : 0] s_axi_CTRL_BUS_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS WVALID" *)
input wire s_axi_CTRL_BUS_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS WREADY" *)
output wire s_axi_CTRL_BUS_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS BRESP" *)
output wire [1 : 0] s_axi_CTRL_BUS_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS BVALID" *)
output wire s_axi_CTRL_BUS_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS BREADY" *)
input wire s_axi_CTRL_BUS_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS ARADDR" *)
input wire [6 : 0] s_axi_CTRL_BUS_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS ARVALID" *)
input wire s_axi_CTRL_BUS_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS ARREADY" *)
output wire s_axi_CTRL_BUS_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS RDATA" *)
output wire [31 : 0] s_axi_CTRL_BUS_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS RRESP" *)
output wire [1 : 0] s_axi_CTRL_BUS_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS RVALID" *)
output wire s_axi_CTRL_BUS_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_CTRL_BUS, ADDR_WIDTH 7, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE \
0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_CTRL_BUS RREADY" *)
input wire s_axi_CTRL_BUS_RREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_CTRL_BUS:m_axi_INPUT_ACT:m_axi_INPUT_WGT:m_axi_OUTPUT_r, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWADDR" *)
output wire [31 : 0] m_axi_INPUT_ACT_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWLEN" *)
output wire [7 : 0] m_axi_INPUT_ACT_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWSIZE" *)
output wire [2 : 0] m_axi_INPUT_ACT_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWBURST" *)
output wire [1 : 0] m_axi_INPUT_ACT_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWLOCK" *)
output wire [1 : 0] m_axi_INPUT_ACT_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWREGION" *)
output wire [3 : 0] m_axi_INPUT_ACT_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWCACHE" *)
output wire [3 : 0] m_axi_INPUT_ACT_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWPROT" *)
output wire [2 : 0] m_axi_INPUT_ACT_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWQOS" *)
output wire [3 : 0] m_axi_INPUT_ACT_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWVALID" *)
output wire m_axi_INPUT_ACT_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT AWREADY" *)
input wire m_axi_INPUT_ACT_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT WDATA" *)
output wire [511 : 0] m_axi_INPUT_ACT_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT WSTRB" *)
output wire [63 : 0] m_axi_INPUT_ACT_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT WLAST" *)
output wire m_axi_INPUT_ACT_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT WVALID" *)
output wire m_axi_INPUT_ACT_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT WREADY" *)
input wire m_axi_INPUT_ACT_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT BRESP" *)
input wire [1 : 0] m_axi_INPUT_ACT_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT BVALID" *)
input wire m_axi_INPUT_ACT_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT BREADY" *)
output wire m_axi_INPUT_ACT_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARADDR" *)
output wire [31 : 0] m_axi_INPUT_ACT_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARLEN" *)
output wire [7 : 0] m_axi_INPUT_ACT_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARSIZE" *)
output wire [2 : 0] m_axi_INPUT_ACT_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARBURST" *)
output wire [1 : 0] m_axi_INPUT_ACT_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARLOCK" *)
output wire [1 : 0] m_axi_INPUT_ACT_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARREGION" *)
output wire [3 : 0] m_axi_INPUT_ACT_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARCACHE" *)
output wire [3 : 0] m_axi_INPUT_ACT_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARPROT" *)
output wire [2 : 0] m_axi_INPUT_ACT_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARQOS" *)
output wire [3 : 0] m_axi_INPUT_ACT_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARVALID" *)
output wire m_axi_INPUT_ACT_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT ARREADY" *)
input wire m_axi_INPUT_ACT_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT RDATA" *)
input wire [511 : 0] m_axi_INPUT_ACT_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT RRESP" *)
input wire [1 : 0] m_axi_INPUT_ACT_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT RLAST" *)
input wire m_axi_INPUT_ACT_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT RVALID" *)
input wire m_axi_INPUT_ACT_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_INPUT_ACT, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 256, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 512, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, NUM_\
READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_ACT RREADY" *)
output wire m_axi_INPUT_ACT_RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWADDR" *)
output wire [31 : 0] m_axi_INPUT_WGT_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWLEN" *)
output wire [7 : 0] m_axi_INPUT_WGT_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWSIZE" *)
output wire [2 : 0] m_axi_INPUT_WGT_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWBURST" *)
output wire [1 : 0] m_axi_INPUT_WGT_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWLOCK" *)
output wire [1 : 0] m_axi_INPUT_WGT_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWREGION" *)
output wire [3 : 0] m_axi_INPUT_WGT_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWCACHE" *)
output wire [3 : 0] m_axi_INPUT_WGT_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWPROT" *)
output wire [2 : 0] m_axi_INPUT_WGT_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWQOS" *)
output wire [3 : 0] m_axi_INPUT_WGT_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWVALID" *)
output wire m_axi_INPUT_WGT_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT AWREADY" *)
input wire m_axi_INPUT_WGT_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT WDATA" *)
output wire [511 : 0] m_axi_INPUT_WGT_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT WSTRB" *)
output wire [63 : 0] m_axi_INPUT_WGT_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT WLAST" *)
output wire m_axi_INPUT_WGT_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT WVALID" *)
output wire m_axi_INPUT_WGT_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT WREADY" *)
input wire m_axi_INPUT_WGT_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT BRESP" *)
input wire [1 : 0] m_axi_INPUT_WGT_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT BVALID" *)
input wire m_axi_INPUT_WGT_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT BREADY" *)
output wire m_axi_INPUT_WGT_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARADDR" *)
output wire [31 : 0] m_axi_INPUT_WGT_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARLEN" *)
output wire [7 : 0] m_axi_INPUT_WGT_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARSIZE" *)
output wire [2 : 0] m_axi_INPUT_WGT_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARBURST" *)
output wire [1 : 0] m_axi_INPUT_WGT_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARLOCK" *)
output wire [1 : 0] m_axi_INPUT_WGT_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARREGION" *)
output wire [3 : 0] m_axi_INPUT_WGT_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARCACHE" *)
output wire [3 : 0] m_axi_INPUT_WGT_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARPROT" *)
output wire [2 : 0] m_axi_INPUT_WGT_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARQOS" *)
output wire [3 : 0] m_axi_INPUT_WGT_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARVALID" *)
output wire m_axi_INPUT_WGT_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT ARREADY" *)
input wire m_axi_INPUT_WGT_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT RDATA" *)
input wire [511 : 0] m_axi_INPUT_WGT_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT RRESP" *)
input wire [1 : 0] m_axi_INPUT_WGT_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT RLAST" *)
input wire m_axi_INPUT_WGT_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT RVALID" *)
input wire m_axi_INPUT_WGT_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_INPUT_WGT, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 256, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 512, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, NUM_\
READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_INPUT_WGT RREADY" *)
output wire m_axi_INPUT_WGT_RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWADDR" *)
output wire [31 : 0] m_axi_OUTPUT_r_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWLEN" *)
output wire [7 : 0] m_axi_OUTPUT_r_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWSIZE" *)
output wire [2 : 0] m_axi_OUTPUT_r_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWBURST" *)
output wire [1 : 0] m_axi_OUTPUT_r_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWLOCK" *)
output wire [1 : 0] m_axi_OUTPUT_r_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWREGION" *)
output wire [3 : 0] m_axi_OUTPUT_r_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWCACHE" *)
output wire [3 : 0] m_axi_OUTPUT_r_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWPROT" *)
output wire [2 : 0] m_axi_OUTPUT_r_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWQOS" *)
output wire [3 : 0] m_axi_OUTPUT_r_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWVALID" *)
output wire m_axi_OUTPUT_r_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r AWREADY" *)
input wire m_axi_OUTPUT_r_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r WDATA" *)
output wire [511 : 0] m_axi_OUTPUT_r_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r WSTRB" *)
output wire [63 : 0] m_axi_OUTPUT_r_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r WLAST" *)
output wire m_axi_OUTPUT_r_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r WVALID" *)
output wire m_axi_OUTPUT_r_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r WREADY" *)
input wire m_axi_OUTPUT_r_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r BRESP" *)
input wire [1 : 0] m_axi_OUTPUT_r_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r BVALID" *)
input wire m_axi_OUTPUT_r_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r BREADY" *)
output wire m_axi_OUTPUT_r_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARADDR" *)
output wire [31 : 0] m_axi_OUTPUT_r_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARLEN" *)
output wire [7 : 0] m_axi_OUTPUT_r_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARSIZE" *)
output wire [2 : 0] m_axi_OUTPUT_r_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARBURST" *)
output wire [1 : 0] m_axi_OUTPUT_r_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARLOCK" *)
output wire [1 : 0] m_axi_OUTPUT_r_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARREGION" *)
output wire [3 : 0] m_axi_OUTPUT_r_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARCACHE" *)
output wire [3 : 0] m_axi_OUTPUT_r_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARPROT" *)
output wire [2 : 0] m_axi_OUTPUT_r_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARQOS" *)
output wire [3 : 0] m_axi_OUTPUT_r_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARVALID" *)
output wire m_axi_OUTPUT_r_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r ARREADY" *)
input wire m_axi_OUTPUT_r_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r RDATA" *)
input wire [511 : 0] m_axi_OUTPUT_r_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r RRESP" *)
input wire [1 : 0] m_axi_OUTPUT_r_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r RLAST" *)
input wire m_axi_OUTPUT_r_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r RVALID" *)
input wire m_axi_OUTPUT_r_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_OUTPUT_r, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 512, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, NUM_R\
EAD_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_OUTPUT_r RREADY" *)
output wire m_axi_OUTPUT_r_RREADY;

  DoCompute #(
    .C_S_AXI_CTRL_BUS_ADDR_WIDTH(7),
    .C_S_AXI_CTRL_BUS_DATA_WIDTH(32),
    .C_M_AXI_INPUT_ACT_ID_WIDTH(1),
    .C_M_AXI_INPUT_ACT_ADDR_WIDTH(32),
    .C_M_AXI_INPUT_ACT_DATA_WIDTH(512),
    .C_M_AXI_INPUT_ACT_AWUSER_WIDTH(1),
    .C_M_AXI_INPUT_ACT_ARUSER_WIDTH(1),
    .C_M_AXI_INPUT_ACT_WUSER_WIDTH(1),
    .C_M_AXI_INPUT_ACT_RUSER_WIDTH(1),
    .C_M_AXI_INPUT_ACT_BUSER_WIDTH(1),
    .C_M_AXI_INPUT_ACT_USER_VALUE('H00000000),
    .C_M_AXI_INPUT_ACT_PROT_VALUE('B000),
    .C_M_AXI_INPUT_ACT_CACHE_VALUE('B0011),
    .C_M_AXI_INPUT_WGT_ID_WIDTH(1),
    .C_M_AXI_INPUT_WGT_ADDR_WIDTH(32),
    .C_M_AXI_INPUT_WGT_DATA_WIDTH(512),
    .C_M_AXI_INPUT_WGT_AWUSER_WIDTH(1),
    .C_M_AXI_INPUT_WGT_ARUSER_WIDTH(1),
    .C_M_AXI_INPUT_WGT_WUSER_WIDTH(1),
    .C_M_AXI_INPUT_WGT_RUSER_WIDTH(1),
    .C_M_AXI_INPUT_WGT_BUSER_WIDTH(1),
    .C_M_AXI_INPUT_WGT_USER_VALUE('H00000000),
    .C_M_AXI_INPUT_WGT_PROT_VALUE('B000),
    .C_M_AXI_INPUT_WGT_CACHE_VALUE('B0011),
    .C_M_AXI_OUTPUT_R_ID_WIDTH(1),
    .C_M_AXI_OUTPUT_R_ADDR_WIDTH(32),
    .C_M_AXI_OUTPUT_R_DATA_WIDTH(512),
    .C_M_AXI_OUTPUT_R_AWUSER_WIDTH(1),
    .C_M_AXI_OUTPUT_R_ARUSER_WIDTH(1),
    .C_M_AXI_OUTPUT_R_WUSER_WIDTH(1),
    .C_M_AXI_OUTPUT_R_RUSER_WIDTH(1),
    .C_M_AXI_OUTPUT_R_BUSER_WIDTH(1),
    .C_M_AXI_OUTPUT_R_USER_VALUE('H00000000),
    .C_M_AXI_OUTPUT_R_PROT_VALUE('B000),
    .C_M_AXI_OUTPUT_R_CACHE_VALUE('B0011)
  ) inst (
    .s_axi_CTRL_BUS_AWADDR(s_axi_CTRL_BUS_AWADDR),
    .s_axi_CTRL_BUS_AWVALID(s_axi_CTRL_BUS_AWVALID),
    .s_axi_CTRL_BUS_AWREADY(s_axi_CTRL_BUS_AWREADY),
    .s_axi_CTRL_BUS_WDATA(s_axi_CTRL_BUS_WDATA),
    .s_axi_CTRL_BUS_WSTRB(s_axi_CTRL_BUS_WSTRB),
    .s_axi_CTRL_BUS_WVALID(s_axi_CTRL_BUS_WVALID),
    .s_axi_CTRL_BUS_WREADY(s_axi_CTRL_BUS_WREADY),
    .s_axi_CTRL_BUS_BRESP(s_axi_CTRL_BUS_BRESP),
    .s_axi_CTRL_BUS_BVALID(s_axi_CTRL_BUS_BVALID),
    .s_axi_CTRL_BUS_BREADY(s_axi_CTRL_BUS_BREADY),
    .s_axi_CTRL_BUS_ARADDR(s_axi_CTRL_BUS_ARADDR),
    .s_axi_CTRL_BUS_ARVALID(s_axi_CTRL_BUS_ARVALID),
    .s_axi_CTRL_BUS_ARREADY(s_axi_CTRL_BUS_ARREADY),
    .s_axi_CTRL_BUS_RDATA(s_axi_CTRL_BUS_RDATA),
    .s_axi_CTRL_BUS_RRESP(s_axi_CTRL_BUS_RRESP),
    .s_axi_CTRL_BUS_RVALID(s_axi_CTRL_BUS_RVALID),
    .s_axi_CTRL_BUS_RREADY(s_axi_CTRL_BUS_RREADY),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .m_axi_INPUT_ACT_AWID(),
    .m_axi_INPUT_ACT_AWADDR(m_axi_INPUT_ACT_AWADDR),
    .m_axi_INPUT_ACT_AWLEN(m_axi_INPUT_ACT_AWLEN),
    .m_axi_INPUT_ACT_AWSIZE(m_axi_INPUT_ACT_AWSIZE),
    .m_axi_INPUT_ACT_AWBURST(m_axi_INPUT_ACT_AWBURST),
    .m_axi_INPUT_ACT_AWLOCK(m_axi_INPUT_ACT_AWLOCK),
    .m_axi_INPUT_ACT_AWREGION(m_axi_INPUT_ACT_AWREGION),
    .m_axi_INPUT_ACT_AWCACHE(m_axi_INPUT_ACT_AWCACHE),
    .m_axi_INPUT_ACT_AWPROT(m_axi_INPUT_ACT_AWPROT),
    .m_axi_INPUT_ACT_AWQOS(m_axi_INPUT_ACT_AWQOS),
    .m_axi_INPUT_ACT_AWUSER(),
    .m_axi_INPUT_ACT_AWVALID(m_axi_INPUT_ACT_AWVALID),
    .m_axi_INPUT_ACT_AWREADY(m_axi_INPUT_ACT_AWREADY),
    .m_axi_INPUT_ACT_WID(),
    .m_axi_INPUT_ACT_WDATA(m_axi_INPUT_ACT_WDATA),
    .m_axi_INPUT_ACT_WSTRB(m_axi_INPUT_ACT_WSTRB),
    .m_axi_INPUT_ACT_WLAST(m_axi_INPUT_ACT_WLAST),
    .m_axi_INPUT_ACT_WUSER(),
    .m_axi_INPUT_ACT_WVALID(m_axi_INPUT_ACT_WVALID),
    .m_axi_INPUT_ACT_WREADY(m_axi_INPUT_ACT_WREADY),
    .m_axi_INPUT_ACT_BID(1'B0),
    .m_axi_INPUT_ACT_BRESP(m_axi_INPUT_ACT_BRESP),
    .m_axi_INPUT_ACT_BUSER(1'B0),
    .m_axi_INPUT_ACT_BVALID(m_axi_INPUT_ACT_BVALID),
    .m_axi_INPUT_ACT_BREADY(m_axi_INPUT_ACT_BREADY),
    .m_axi_INPUT_ACT_ARID(),
    .m_axi_INPUT_ACT_ARADDR(m_axi_INPUT_ACT_ARADDR),
    .m_axi_INPUT_ACT_ARLEN(m_axi_INPUT_ACT_ARLEN),
    .m_axi_INPUT_ACT_ARSIZE(m_axi_INPUT_ACT_ARSIZE),
    .m_axi_INPUT_ACT_ARBURST(m_axi_INPUT_ACT_ARBURST),
    .m_axi_INPUT_ACT_ARLOCK(m_axi_INPUT_ACT_ARLOCK),
    .m_axi_INPUT_ACT_ARREGION(m_axi_INPUT_ACT_ARREGION),
    .m_axi_INPUT_ACT_ARCACHE(m_axi_INPUT_ACT_ARCACHE),
    .m_axi_INPUT_ACT_ARPROT(m_axi_INPUT_ACT_ARPROT),
    .m_axi_INPUT_ACT_ARQOS(m_axi_INPUT_ACT_ARQOS),
    .m_axi_INPUT_ACT_ARUSER(),
    .m_axi_INPUT_ACT_ARVALID(m_axi_INPUT_ACT_ARVALID),
    .m_axi_INPUT_ACT_ARREADY(m_axi_INPUT_ACT_ARREADY),
    .m_axi_INPUT_ACT_RID(1'B0),
    .m_axi_INPUT_ACT_RDATA(m_axi_INPUT_ACT_RDATA),
    .m_axi_INPUT_ACT_RRESP(m_axi_INPUT_ACT_RRESP),
    .m_axi_INPUT_ACT_RLAST(m_axi_INPUT_ACT_RLAST),
    .m_axi_INPUT_ACT_RUSER(1'B0),
    .m_axi_INPUT_ACT_RVALID(m_axi_INPUT_ACT_RVALID),
    .m_axi_INPUT_ACT_RREADY(m_axi_INPUT_ACT_RREADY),
    .m_axi_INPUT_WGT_AWID(),
    .m_axi_INPUT_WGT_AWADDR(m_axi_INPUT_WGT_AWADDR),
    .m_axi_INPUT_WGT_AWLEN(m_axi_INPUT_WGT_AWLEN),
    .m_axi_INPUT_WGT_AWSIZE(m_axi_INPUT_WGT_AWSIZE),
    .m_axi_INPUT_WGT_AWBURST(m_axi_INPUT_WGT_AWBURST),
    .m_axi_INPUT_WGT_AWLOCK(m_axi_INPUT_WGT_AWLOCK),
    .m_axi_INPUT_WGT_AWREGION(m_axi_INPUT_WGT_AWREGION),
    .m_axi_INPUT_WGT_AWCACHE(m_axi_INPUT_WGT_AWCACHE),
    .m_axi_INPUT_WGT_AWPROT(m_axi_INPUT_WGT_AWPROT),
    .m_axi_INPUT_WGT_AWQOS(m_axi_INPUT_WGT_AWQOS),
    .m_axi_INPUT_WGT_AWUSER(),
    .m_axi_INPUT_WGT_AWVALID(m_axi_INPUT_WGT_AWVALID),
    .m_axi_INPUT_WGT_AWREADY(m_axi_INPUT_WGT_AWREADY),
    .m_axi_INPUT_WGT_WID(),
    .m_axi_INPUT_WGT_WDATA(m_axi_INPUT_WGT_WDATA),
    .m_axi_INPUT_WGT_WSTRB(m_axi_INPUT_WGT_WSTRB),
    .m_axi_INPUT_WGT_WLAST(m_axi_INPUT_WGT_WLAST),
    .m_axi_INPUT_WGT_WUSER(),
    .m_axi_INPUT_WGT_WVALID(m_axi_INPUT_WGT_WVALID),
    .m_axi_INPUT_WGT_WREADY(m_axi_INPUT_WGT_WREADY),
    .m_axi_INPUT_WGT_BID(1'B0),
    .m_axi_INPUT_WGT_BRESP(m_axi_INPUT_WGT_BRESP),
    .m_axi_INPUT_WGT_BUSER(1'B0),
    .m_axi_INPUT_WGT_BVALID(m_axi_INPUT_WGT_BVALID),
    .m_axi_INPUT_WGT_BREADY(m_axi_INPUT_WGT_BREADY),
    .m_axi_INPUT_WGT_ARID(),
    .m_axi_INPUT_WGT_ARADDR(m_axi_INPUT_WGT_ARADDR),
    .m_axi_INPUT_WGT_ARLEN(m_axi_INPUT_WGT_ARLEN),
    .m_axi_INPUT_WGT_ARSIZE(m_axi_INPUT_WGT_ARSIZE),
    .m_axi_INPUT_WGT_ARBURST(m_axi_INPUT_WGT_ARBURST),
    .m_axi_INPUT_WGT_ARLOCK(m_axi_INPUT_WGT_ARLOCK),
    .m_axi_INPUT_WGT_ARREGION(m_axi_INPUT_WGT_ARREGION),
    .m_axi_INPUT_WGT_ARCACHE(m_axi_INPUT_WGT_ARCACHE),
    .m_axi_INPUT_WGT_ARPROT(m_axi_INPUT_WGT_ARPROT),
    .m_axi_INPUT_WGT_ARQOS(m_axi_INPUT_WGT_ARQOS),
    .m_axi_INPUT_WGT_ARUSER(),
    .m_axi_INPUT_WGT_ARVALID(m_axi_INPUT_WGT_ARVALID),
    .m_axi_INPUT_WGT_ARREADY(m_axi_INPUT_WGT_ARREADY),
    .m_axi_INPUT_WGT_RID(1'B0),
    .m_axi_INPUT_WGT_RDATA(m_axi_INPUT_WGT_RDATA),
    .m_axi_INPUT_WGT_RRESP(m_axi_INPUT_WGT_RRESP),
    .m_axi_INPUT_WGT_RLAST(m_axi_INPUT_WGT_RLAST),
    .m_axi_INPUT_WGT_RUSER(1'B0),
    .m_axi_INPUT_WGT_RVALID(m_axi_INPUT_WGT_RVALID),
    .m_axi_INPUT_WGT_RREADY(m_axi_INPUT_WGT_RREADY),
    .m_axi_OUTPUT_r_AWID(),
    .m_axi_OUTPUT_r_AWADDR(m_axi_OUTPUT_r_AWADDR),
    .m_axi_OUTPUT_r_AWLEN(m_axi_OUTPUT_r_AWLEN),
    .m_axi_OUTPUT_r_AWSIZE(m_axi_OUTPUT_r_AWSIZE),
    .m_axi_OUTPUT_r_AWBURST(m_axi_OUTPUT_r_AWBURST),
    .m_axi_OUTPUT_r_AWLOCK(m_axi_OUTPUT_r_AWLOCK),
    .m_axi_OUTPUT_r_AWREGION(m_axi_OUTPUT_r_AWREGION),
    .m_axi_OUTPUT_r_AWCACHE(m_axi_OUTPUT_r_AWCACHE),
    .m_axi_OUTPUT_r_AWPROT(m_axi_OUTPUT_r_AWPROT),
    .m_axi_OUTPUT_r_AWQOS(m_axi_OUTPUT_r_AWQOS),
    .m_axi_OUTPUT_r_AWUSER(),
    .m_axi_OUTPUT_r_AWVALID(m_axi_OUTPUT_r_AWVALID),
    .m_axi_OUTPUT_r_AWREADY(m_axi_OUTPUT_r_AWREADY),
    .m_axi_OUTPUT_r_WID(),
    .m_axi_OUTPUT_r_WDATA(m_axi_OUTPUT_r_WDATA),
    .m_axi_OUTPUT_r_WSTRB(m_axi_OUTPUT_r_WSTRB),
    .m_axi_OUTPUT_r_WLAST(m_axi_OUTPUT_r_WLAST),
    .m_axi_OUTPUT_r_WUSER(),
    .m_axi_OUTPUT_r_WVALID(m_axi_OUTPUT_r_WVALID),
    .m_axi_OUTPUT_r_WREADY(m_axi_OUTPUT_r_WREADY),
    .m_axi_OUTPUT_r_BID(1'B0),
    .m_axi_OUTPUT_r_BRESP(m_axi_OUTPUT_r_BRESP),
    .m_axi_OUTPUT_r_BUSER(1'B0),
    .m_axi_OUTPUT_r_BVALID(m_axi_OUTPUT_r_BVALID),
    .m_axi_OUTPUT_r_BREADY(m_axi_OUTPUT_r_BREADY),
    .m_axi_OUTPUT_r_ARID(),
    .m_axi_OUTPUT_r_ARADDR(m_axi_OUTPUT_r_ARADDR),
    .m_axi_OUTPUT_r_ARLEN(m_axi_OUTPUT_r_ARLEN),
    .m_axi_OUTPUT_r_ARSIZE(m_axi_OUTPUT_r_ARSIZE),
    .m_axi_OUTPUT_r_ARBURST(m_axi_OUTPUT_r_ARBURST),
    .m_axi_OUTPUT_r_ARLOCK(m_axi_OUTPUT_r_ARLOCK),
    .m_axi_OUTPUT_r_ARREGION(m_axi_OUTPUT_r_ARREGION),
    .m_axi_OUTPUT_r_ARCACHE(m_axi_OUTPUT_r_ARCACHE),
    .m_axi_OUTPUT_r_ARPROT(m_axi_OUTPUT_r_ARPROT),
    .m_axi_OUTPUT_r_ARQOS(m_axi_OUTPUT_r_ARQOS),
    .m_axi_OUTPUT_r_ARUSER(),
    .m_axi_OUTPUT_r_ARVALID(m_axi_OUTPUT_r_ARVALID),
    .m_axi_OUTPUT_r_ARREADY(m_axi_OUTPUT_r_ARREADY),
    .m_axi_OUTPUT_r_RID(1'B0),
    .m_axi_OUTPUT_r_RDATA(m_axi_OUTPUT_r_RDATA),
    .m_axi_OUTPUT_r_RRESP(m_axi_OUTPUT_r_RRESP),
    .m_axi_OUTPUT_r_RLAST(m_axi_OUTPUT_r_RLAST),
    .m_axi_OUTPUT_r_RUSER(1'B0),
    .m_axi_OUTPUT_r_RVALID(m_axi_OUTPUT_r_RVALID),
    .m_axi_OUTPUT_r_RREADY(m_axi_OUTPUT_r_RREADY)
  );
endmodule
