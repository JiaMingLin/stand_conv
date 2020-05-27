#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Usage: ./make_all.sh </path/to/hls_file_dir> PROJECT_NAME"
	exit
fi

HLS_ROOT=$1
PROJECT_NAME=$2

./make_ip.sh $HLS_ROOT $PROJECT_NAME
./make_bitstream.sh $HLS_ROOT $PROJECT_NAME

cp ../output/$PROJECT_NAME/$PROJECT_NAME.srcs/sources_1/bd/design_1/hw_handoff/design_1.hwh ../output/$PROJECT_NAME/
cp ../output/$PROJECT_NAME/$PROJECT_NAME.runs/impl_1/design_1_wrapper.bit ../output/$PROJECT_NAME/design_1.bit
