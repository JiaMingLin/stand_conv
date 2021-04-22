#include "top.h"


void DoCompute(word_t* in_act,
		word_t* in_wgt,
		word_t* out,
		int act_load_length, int act_offset,
		int out_write_length, int output_offset,
		int test_rounds
		){
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=act_load_length bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=act_offset bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=out_write_length bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=output_offset bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=test_rounds bundle=CTRL_BUS

#pragma HLS INTERFACE m_axi port=in_act offset=slave bundle=INPUT_ACT max_read_burst_length=256
#pragma HLS INTERFACE m_axi port=in_wgt offset=slave bundle=INPUT_WGT max_read_burst_length=256
#pragma HLS INTERFACE m_axi port=out offset=slave bundle=OUTPUT max_write_burst_length=256

	data_t act_buff[BUFFER_DEPTH][P_COL];
	data_t out_buff[BUFFER_DEPTH][WORD_WIDTH/DATA_PRECISION];
#pragma HLS ARRAY_PARTITION variable=act_buff complete dim=2
#pragma HLS ARRAY_PARTITION variable=out_buff complete dim=2

	for(int rnd = 0; rnd < test_rounds; rnd++){
#pragma HLS LOOP_TRIPCOUNT min=1000 max=1000 avg=1000
		LoadAct(in_act, act_buff, act_load_length, act_offset);

		CONVERT_LENGTH: for(int i = 0; i < out_write_length; i++){
#pragma HLS PIPELINE
#pragma HLS LOOP_TRIPCOUNT min=128 max=128 avg=128

			data_t temp[WORD_WIDTH/DATA_PRECISION];
			CONVERT_WIDTH_1: for(int j = 0; j < WORD_WIDTH/(DATA_PRECISION*P_COL); j++){
				CONVERT_WIDTH_2: for(int idx = 0; idx < P_COL; idx++){
//					temp[j*P_COL+idx] = act_buff[i*WORD_WIDTH/(DATA_PRECISION*P_COL) + j*P_COL][idx];
					out_buff[i][j*P_COL+idx] = act_buff[i*WORD_WIDTH/(DATA_PRECISION*P_COL) + j][idx];
				}
			}
		}

		MonitorACTBuffer<BUFFER_DEPTH, WORD_WIDTH/DATA_PRECISION>(out_buff);

		WriteOutput(out, out_buff, out_write_length, output_offset);
	}






	return;
}

void LoadAct(word_t* in_act, data_t act_buff[BUFFER_DEPTH][P_COL],
		int act_load_length, int act_offset){

	ACT_LOAD_LENGTH: for(int i = 0; i < act_load_length; i++){
#pragma HLS LOOP_TRIPCOUNT min=128 max=128 avg=128
#pragma HLS PIPELINE

		ACT_LOAD_WIDTH_1: for(int j = 0; j < WORD_WIDTH/(DATA_PRECISION*P_COL); j++){
			ap_uint<DATA_PRECISION*P_COL>
			temp = in_act[i].range((j+1)*DATA_PRECISION*P_COL-1, j*DATA_PRECISION*P_COL);

			ACT_LOAD_WIDTH_2: for(int k = 0; k < P_COL; k++){
				act_buff[i*(WORD_WIDTH/(DATA_PRECISION*P_COL)) + j][k]
						= temp.range((k+1)*DATA_PRECISION-1, k*DATA_PRECISION);
			}
		}
	}
}

void WriteOutput(word_t* out, data_t out_buff[BUFFER_DEPTH][WORD_WIDTH/DATA_PRECISION],
		int out_write_length, int output_offset){

	OUTPUT_WRITE_LENGTH: for(int i = 0; i < out_write_length; i++){
#pragma HLS LOOP_TRIPCOUNT min=128 max=128 avg=128
#pragma HLS PIPELINE

		OUTPUT_WRITE_WIDTH: for(int j = 0; j < WORD_WIDTH/DATA_PRECISION; j++){
			out[i].range((j+1)*DATA_PRECISION-1, j*DATA_PRECISION) = out_buff[i][j].range(DATA_PRECISION-1, 0);
		}

	}
}


