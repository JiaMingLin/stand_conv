-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed Mar 24 21:15:28 2021
-- Host        : jiaming-Latitude-7400 running 64-bit Ubuntu 18.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_DoCompute_0_4 -prefix
--               design_1_DoCompute_0_4_ design_1_DoCompute_0_4_stub.vhdl
-- Design      : design_1_DoCompute_0_4
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu3eg-sbva484-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_DoCompute_0_4 is
  Port ( 
    s_axi_CTRL_BUS_AWADDR : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_CTRL_BUS_AWVALID : in STD_LOGIC;
    s_axi_CTRL_BUS_AWREADY : out STD_LOGIC;
    s_axi_CTRL_BUS_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_CTRL_BUS_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_CTRL_BUS_WVALID : in STD_LOGIC;
    s_axi_CTRL_BUS_WREADY : out STD_LOGIC;
    s_axi_CTRL_BUS_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_CTRL_BUS_BVALID : out STD_LOGIC;
    s_axi_CTRL_BUS_BREADY : in STD_LOGIC;
    s_axi_CTRL_BUS_ARADDR : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_CTRL_BUS_ARVALID : in STD_LOGIC;
    s_axi_CTRL_BUS_ARREADY : out STD_LOGIC;
    s_axi_CTRL_BUS_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_CTRL_BUS_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_CTRL_BUS_RVALID : out STD_LOGIC;
    s_axi_CTRL_BUS_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    m_axi_INPUT_ACT_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_INPUT_ACT_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_INPUT_ACT_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_ACT_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_ACT_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_AWVALID : out STD_LOGIC;
    m_axi_INPUT_ACT_AWREADY : in STD_LOGIC;
    m_axi_INPUT_ACT_WDATA : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_INPUT_ACT_WSTRB : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_INPUT_ACT_WLAST : out STD_LOGIC;
    m_axi_INPUT_ACT_WVALID : out STD_LOGIC;
    m_axi_INPUT_ACT_WREADY : in STD_LOGIC;
    m_axi_INPUT_ACT_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_BVALID : in STD_LOGIC;
    m_axi_INPUT_ACT_BREADY : out STD_LOGIC;
    m_axi_INPUT_ACT_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_INPUT_ACT_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_INPUT_ACT_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_ACT_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_ACT_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_ACT_ARVALID : out STD_LOGIC;
    m_axi_INPUT_ACT_ARREADY : in STD_LOGIC;
    m_axi_INPUT_ACT_RDATA : in STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_INPUT_ACT_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_ACT_RLAST : in STD_LOGIC;
    m_axi_INPUT_ACT_RVALID : in STD_LOGIC;
    m_axi_INPUT_ACT_RREADY : out STD_LOGIC;
    m_axi_INPUT_WGT_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_INPUT_WGT_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_INPUT_WGT_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_WGT_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_WGT_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_AWVALID : out STD_LOGIC;
    m_axi_INPUT_WGT_AWREADY : in STD_LOGIC;
    m_axi_INPUT_WGT_WDATA : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_INPUT_WGT_WSTRB : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_INPUT_WGT_WLAST : out STD_LOGIC;
    m_axi_INPUT_WGT_WVALID : out STD_LOGIC;
    m_axi_INPUT_WGT_WREADY : in STD_LOGIC;
    m_axi_INPUT_WGT_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_BVALID : in STD_LOGIC;
    m_axi_INPUT_WGT_BREADY : out STD_LOGIC;
    m_axi_INPUT_WGT_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_INPUT_WGT_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_INPUT_WGT_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_WGT_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_INPUT_WGT_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_INPUT_WGT_ARVALID : out STD_LOGIC;
    m_axi_INPUT_WGT_ARREADY : in STD_LOGIC;
    m_axi_INPUT_WGT_RDATA : in STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_INPUT_WGT_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_INPUT_WGT_RLAST : in STD_LOGIC;
    m_axi_INPUT_WGT_RVALID : in STD_LOGIC;
    m_axi_INPUT_WGT_RREADY : out STD_LOGIC;
    m_axi_OUTPUT_r_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_OUTPUT_r_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_OUTPUT_r_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_OUTPUT_r_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_OUTPUT_r_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_AWVALID : out STD_LOGIC;
    m_axi_OUTPUT_r_AWREADY : in STD_LOGIC;
    m_axi_OUTPUT_r_WDATA : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_OUTPUT_r_WSTRB : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_OUTPUT_r_WLAST : out STD_LOGIC;
    m_axi_OUTPUT_r_WVALID : out STD_LOGIC;
    m_axi_OUTPUT_r_WREADY : in STD_LOGIC;
    m_axi_OUTPUT_r_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_BVALID : in STD_LOGIC;
    m_axi_OUTPUT_r_BREADY : out STD_LOGIC;
    m_axi_OUTPUT_r_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_OUTPUT_r_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_OUTPUT_r_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_OUTPUT_r_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_OUTPUT_r_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_OUTPUT_r_ARVALID : out STD_LOGIC;
    m_axi_OUTPUT_r_ARREADY : in STD_LOGIC;
    m_axi_OUTPUT_r_RDATA : in STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axi_OUTPUT_r_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_OUTPUT_r_RLAST : in STD_LOGIC;
    m_axi_OUTPUT_r_RVALID : in STD_LOGIC;
    m_axi_OUTPUT_r_RREADY : out STD_LOGIC
  );

end design_1_DoCompute_0_4;

architecture stub of design_1_DoCompute_0_4 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_CTRL_BUS_AWADDR[6:0],s_axi_CTRL_BUS_AWVALID,s_axi_CTRL_BUS_AWREADY,s_axi_CTRL_BUS_WDATA[31:0],s_axi_CTRL_BUS_WSTRB[3:0],s_axi_CTRL_BUS_WVALID,s_axi_CTRL_BUS_WREADY,s_axi_CTRL_BUS_BRESP[1:0],s_axi_CTRL_BUS_BVALID,s_axi_CTRL_BUS_BREADY,s_axi_CTRL_BUS_ARADDR[6:0],s_axi_CTRL_BUS_ARVALID,s_axi_CTRL_BUS_ARREADY,s_axi_CTRL_BUS_RDATA[31:0],s_axi_CTRL_BUS_RRESP[1:0],s_axi_CTRL_BUS_RVALID,s_axi_CTRL_BUS_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_INPUT_ACT_AWADDR[31:0],m_axi_INPUT_ACT_AWLEN[7:0],m_axi_INPUT_ACT_AWSIZE[2:0],m_axi_INPUT_ACT_AWBURST[1:0],m_axi_INPUT_ACT_AWLOCK[1:0],m_axi_INPUT_ACT_AWREGION[3:0],m_axi_INPUT_ACT_AWCACHE[3:0],m_axi_INPUT_ACT_AWPROT[2:0],m_axi_INPUT_ACT_AWQOS[3:0],m_axi_INPUT_ACT_AWVALID,m_axi_INPUT_ACT_AWREADY,m_axi_INPUT_ACT_WDATA[511:0],m_axi_INPUT_ACT_WSTRB[63:0],m_axi_INPUT_ACT_WLAST,m_axi_INPUT_ACT_WVALID,m_axi_INPUT_ACT_WREADY,m_axi_INPUT_ACT_BRESP[1:0],m_axi_INPUT_ACT_BVALID,m_axi_INPUT_ACT_BREADY,m_axi_INPUT_ACT_ARADDR[31:0],m_axi_INPUT_ACT_ARLEN[7:0],m_axi_INPUT_ACT_ARSIZE[2:0],m_axi_INPUT_ACT_ARBURST[1:0],m_axi_INPUT_ACT_ARLOCK[1:0],m_axi_INPUT_ACT_ARREGION[3:0],m_axi_INPUT_ACT_ARCACHE[3:0],m_axi_INPUT_ACT_ARPROT[2:0],m_axi_INPUT_ACT_ARQOS[3:0],m_axi_INPUT_ACT_ARVALID,m_axi_INPUT_ACT_ARREADY,m_axi_INPUT_ACT_RDATA[511:0],m_axi_INPUT_ACT_RRESP[1:0],m_axi_INPUT_ACT_RLAST,m_axi_INPUT_ACT_RVALID,m_axi_INPUT_ACT_RREADY,m_axi_INPUT_WGT_AWADDR[31:0],m_axi_INPUT_WGT_AWLEN[7:0],m_axi_INPUT_WGT_AWSIZE[2:0],m_axi_INPUT_WGT_AWBURST[1:0],m_axi_INPUT_WGT_AWLOCK[1:0],m_axi_INPUT_WGT_AWREGION[3:0],m_axi_INPUT_WGT_AWCACHE[3:0],m_axi_INPUT_WGT_AWPROT[2:0],m_axi_INPUT_WGT_AWQOS[3:0],m_axi_INPUT_WGT_AWVALID,m_axi_INPUT_WGT_AWREADY,m_axi_INPUT_WGT_WDATA[511:0],m_axi_INPUT_WGT_WSTRB[63:0],m_axi_INPUT_WGT_WLAST,m_axi_INPUT_WGT_WVALID,m_axi_INPUT_WGT_WREADY,m_axi_INPUT_WGT_BRESP[1:0],m_axi_INPUT_WGT_BVALID,m_axi_INPUT_WGT_BREADY,m_axi_INPUT_WGT_ARADDR[31:0],m_axi_INPUT_WGT_ARLEN[7:0],m_axi_INPUT_WGT_ARSIZE[2:0],m_axi_INPUT_WGT_ARBURST[1:0],m_axi_INPUT_WGT_ARLOCK[1:0],m_axi_INPUT_WGT_ARREGION[3:0],m_axi_INPUT_WGT_ARCACHE[3:0],m_axi_INPUT_WGT_ARPROT[2:0],m_axi_INPUT_WGT_ARQOS[3:0],m_axi_INPUT_WGT_ARVALID,m_axi_INPUT_WGT_ARREADY,m_axi_INPUT_WGT_RDATA[511:0],m_axi_INPUT_WGT_RRESP[1:0],m_axi_INPUT_WGT_RLAST,m_axi_INPUT_WGT_RVALID,m_axi_INPUT_WGT_RREADY,m_axi_OUTPUT_r_AWADDR[31:0],m_axi_OUTPUT_r_AWLEN[7:0],m_axi_OUTPUT_r_AWSIZE[2:0],m_axi_OUTPUT_r_AWBURST[1:0],m_axi_OUTPUT_r_AWLOCK[1:0],m_axi_OUTPUT_r_AWREGION[3:0],m_axi_OUTPUT_r_AWCACHE[3:0],m_axi_OUTPUT_r_AWPROT[2:0],m_axi_OUTPUT_r_AWQOS[3:0],m_axi_OUTPUT_r_AWVALID,m_axi_OUTPUT_r_AWREADY,m_axi_OUTPUT_r_WDATA[511:0],m_axi_OUTPUT_r_WSTRB[63:0],m_axi_OUTPUT_r_WLAST,m_axi_OUTPUT_r_WVALID,m_axi_OUTPUT_r_WREADY,m_axi_OUTPUT_r_BRESP[1:0],m_axi_OUTPUT_r_BVALID,m_axi_OUTPUT_r_BREADY,m_axi_OUTPUT_r_ARADDR[31:0],m_axi_OUTPUT_r_ARLEN[7:0],m_axi_OUTPUT_r_ARSIZE[2:0],m_axi_OUTPUT_r_ARBURST[1:0],m_axi_OUTPUT_r_ARLOCK[1:0],m_axi_OUTPUT_r_ARREGION[3:0],m_axi_OUTPUT_r_ARCACHE[3:0],m_axi_OUTPUT_r_ARPROT[2:0],m_axi_OUTPUT_r_ARQOS[3:0],m_axi_OUTPUT_r_ARVALID,m_axi_OUTPUT_r_ARREADY,m_axi_OUTPUT_r_RDATA[511:0],m_axi_OUTPUT_r_RRESP[1:0],m_axi_OUTPUT_r_RLAST,m_axi_OUTPUT_r_RVALID,m_axi_OUTPUT_r_RREADY";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "DoCompute,Vivado 2020.1";
begin
end;
