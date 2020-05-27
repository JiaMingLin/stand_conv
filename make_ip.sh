#!/bin/bash
HLS_ROOT=$1
PROJECT_PATH=$HLS_ROOT/HLS_PROJ/

if [ ! -d "$HLS_ROOT" ]; then
	echo "HLS Project ${HLS_ROOT} not exist"
	exit
fi

cd $HLS_ROOT
vivado_hls -f $HLS_ROOT/script.tcl $HLS_ROOT/

REPO_PATH=$PROJECT_PATH/repo
IP_PATH=$PROJECT_PATH/solution1/impl/ip/xilinx_com_hls_DoCompute_1_0.zip

if [ ! -d "$REPO_PATH" ]; then
	mkdir $REPO_PATH
fi

# unzip ip to repo
unzip -o $IP_PATH -d $REPO_PATH