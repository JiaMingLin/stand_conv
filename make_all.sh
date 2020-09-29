#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Usage: ./make_all.sh </path/to/hls_file_dir> <SCALE=small/medium>"
	exit
fi

ROOT=$(pwd)
HLS_ROOT=$ROOT/$1
SCALE=$2

./make_ip.sh $HLS_ROOT $SCALE
./make_bitstream.sh $HLS_ROOT $SCALE

cp $HLS_ROOT/vivado_design_$SCALE/vivado_design.srcs/sources_1/bd/design_1/hw_handoff/design_1.hwh $HLS_ROOT/vivado_design_$SCALE
cp $HLS_ROOT/vivado_design_$SCALE/vivado_design.runs/impl_1/design_1_wrapper.bit $HLS_ROOT/vivado_design_$SCALE/design_1.bit