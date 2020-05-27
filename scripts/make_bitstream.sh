#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Usage: ./make_bitstream.sh </path/to/hls_file_dir> PROJECT_NAME"
	exit
fi

HLS_ROOT=$1
PROJECT_NAME=$2

if [ -n "$HLS_ROOT" ]; then
	echo "HW_ROOT=$HLS_ROOT"

	SCRIPT_DIR="$HLS_ROOT/../scripts"
	IP_REPO="$HLS_ROOT/$PROJECT_NAME/repo"
        PATH_TO_OUTPUT=$HLS_ROOT/../output/

	if [ ! -d "$PATH_TO_OUTPUT" ]; then
	    mkdir $PATH_TO_OUTPUT
        fi
	VIVADO_OUT_DIR="$HLS_ROOT/../output/$PROJECT_NAME"
	VIVADO_SCRIPT=$SCRIPT_DIR/make-vivado-proj.tcl
	vivado -mode batch -notrace -source $VIVADO_SCRIPT -tclargs $DESIGN_NAME $VIVADO_OUT_DIR $SCRIPT_DIR $IP_REPO
else
	echo "HW_ROOT is NOT set!"
fi
