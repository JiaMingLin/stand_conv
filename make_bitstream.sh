#!/bin/bash

if [[ $# -ne 1 ]]; then 
	echo "Usage: ./make_bitstream.sh </path/to/hls_file_dir>"
	exit
fi

HLS_ROOT=$1

if [ -n "$HLS_ROOT" ]; then
	echo "HLS_ROOT=$HLS_ROOT"

	SCRIPT_DIR="$HLS_ROOT/../scripts"
	IP_REPO="$HLS_ROOT/HLS_PROJ/repo"

	DESIGN_NAME=vivado_design
	VIVADO_OUT_DIR="$HLS_ROOT/vivado_design"
	VIVADO_SCRIPT=$SCRIPT_DIR/make-vivado-proj.tcl
	vivado -mode batch -notrace -source $VIVADO_SCRIPT -tclargs $DESIGN_NAME $VIVADO_OUT_DIR $SCRIPT_DIR $IP_REPO
else
	echo "HW_ROOT is NOT set!"
fi
