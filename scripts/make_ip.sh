#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Usage: ./make_ip.sh </path/to/hls_files_dir> PROJECT_NAME"
	exit
fi

HLS_ROOT=$1
PROJECT_NAME=$2
PROJECT_PATH=$HLS_ROOT/$PROJECT_NAME
if [ ! -d "$PROJECT_PATH" ]; then
        mkdir $PROJECT_PATH
fi

vivado_hls -f $HLS_ROOT/script.tcl

REPO_PATH=$PROJECT_PATH/repo
IP_PATH=$PROJECT_PATH/solution1/impl/ip/xilinx_com_hls_DoCompute_1_0.zip

if [ ! -d "$REPO_PATH" ]; then
	mkdir $REPO_PATH
fi

# unzip ip to repo
unzip $IP_PATH -d $REPO_PATH
