#include"top.h"



int main(){

	int in_x = 8, in_y = 8, in_z = 16;
	int out_x = 8, out_y = 8, out_z = 16;

	// init data
	data_t *in_act = InitArray(in_z, in_y, in_x);
	data_t *sw_out_act = InitArray(out_z, out_y, out_x);

	int input_depth = (in_x*in_y*in_z)/(WORD_WIDTH/DATA_PRECISION);
	word_t hw_input[input_depth], hw_output[input_depth];
	word_t in_wgt[input_depth];

	// convert to hardware input
	ConvertSW2HW(in_act, hw_input, (in_x*in_y*in_z));

	// apply hardware compute
	DoCompute(hw_input, in_wgt, hw_output, input_depth, 0, input_depth, 0, 1);

	// hw_output convert to sw_output
	ConvertHW2SW(hw_output, sw_out_act, input_depth);

	// validation
	MonitorACT_SW(sw_out_act, out_z, out_y, out_x);
}
