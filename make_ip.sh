#!/bin/bash
HLS_ROOT=$1
SCALE=$2
PROJECT_PATH=$HLS_ROOT/HLS_PROJ/

if [ ! -d "$HLS_ROOT" ]; then
	echo "HLS Project ${HLS_ROOT} not exist"
	exit
fi

PART="xczu3eg-sbva484-1-e"
if [ "$2" = "medium" ]; then
	PART="xczu7ev-ffvc1156-2-e"
fi

vivado_hls -f $HLS_ROOT/script.tcl $HLS_ROOT/ $SCALE $PART

REPO_PATH=$PROJECT_PATH/repo/$SCALE
IP_PATH=$PROJECT_PATH/$SCALE/impl/ip/xilinx_com_hls_DoCompute_1_0.zip

if [ ! -d "$REPO_PATH" ]; then
	mkdir $REPO_PATH
fi

# unzip ip to repo
unzip -o $IP_PATH -d $REPO_PATH