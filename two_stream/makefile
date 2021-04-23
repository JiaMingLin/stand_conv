HLS_ROOT := /home/jiaming/workplace/stand_conv/NLR_Quantize_3

all: static
	@echo
	@tput setaf 2 ; echo "Built successfully!"; tput sgr0;
	@echo

static:
	vivado -mode batch -source design_1.tcl -notrace -tclargs $(HLS_ROOT)
	vivado -mode batch -source create_design.tcl -notrace

# # config partial region
# dynamic:
# 	vivado -mode batch -source create_pr.tcl -notrace

# bitstream:
# 	vivado -mode batch -source build_bitstream.tcl -notrace

# check_timing:
# 	vivado -mode batch -source check_$(overlay_name).tcl -notrace

clean:
	rm -rf hd_visual *.jou *.log NA *.hwh *.bit .Xil vivado_design
