#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Usage: ./make_bitstream.sh </path/to/hls_file_dir> <scale>"
	exit
fi

HLS_ROOT=$1
SCALE=$2

PART="xczu3eg-sbva484-1-e"
if [ "$2" = "medium" ]; then
        PART="xczu7ev-ffvc1156-2-e"
elif [ "$2" = "large" ]; then
        PART="xczu9eg-ffvb1156-2-e"
fi

if [ -n "$HLS_ROOT" ]; then
	echo "HLS_ROOT=$HLS_ROOT"

	SCRIPT_DIR="$HLS_ROOT/../scripts"
	IP_REPO="$HLS_ROOT/HLS_PROJ/repo/$SCALE"

	DESIGN_NAME=vivado_design
	VIVADO_OUT_DIR="$HLS_ROOT/vivado_design_$SCALE"
	SYSTEM_SCRIPT_DIR="$HLS_ROOT/../scripts/$SCALE"
	VIVADO_SCRIPT=$SCRIPT_DIR/make-vivado-proj.tcl
	vivado -mode batch -notrace -source $VIVADO_SCRIPT -tclargs $DESIGN_NAME $VIVADO_OUT_DIR $PART $SYSTEM_SCRIPT_DIR $IP_REPO
else
	echo "HW_ROOT is NOT set!"
fi