#!/bin/bash

if [[ $# -ne 1 ]]; then 
	echo "Usage: ./make_all.sh </path/to/hls_file_dir>"
	exit
fi

ROOT=$(pwd)
HLS_ROOT=$ROOT/$1

./make_ip.sh $HLS_ROOT
./make_bitstream.sh $HLS_ROOT

cp $HLS_ROOT/vivado_design/vivado_design.srcs/sources_1/bd/design_1/hw_handoff/design_1.hwh $HLS_ROOT/vivado_design
cp $HLS_ROOT/vivado_design/vivado_design.runs/impl_1/design_1_wrapper.bit $HLS_ROOT/vivado_design/design_1.bit
