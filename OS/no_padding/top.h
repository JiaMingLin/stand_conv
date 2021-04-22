#include<iostream>
#include<ap_fixed.h>
#include<ap_int.h>

using namespace std;

#define WORD_WIDTH 512

#define DATA_PRECISION 8
#define ACC_PRECISION 32

#define P_COL 8
#define P_CH 16

#define BUFFER_DEPTH 4096

typedef ap_uint<DATA_PRECISION> data_t;
typedef ap_uint<ACC_PRECISION> acc_t;
typedef ap_uint<WORD_WIDTH> word_t;

void DoCompute(
		word_t* in_act,
		word_t* in_wgt,
		word_t* out,
		int act_load_length, int act_offset,
		int out_write_length, int output_offset,
		int test_rounds);

void LoadAct(word_t* in_act, data_t act_buff[BUFFER_DEPTH][P_COL],
		int act_load_length, int act_offset);

void WriteOutput(word_t* out, data_t out_buff[BUFFER_DEPTH][WORD_WIDTH/DATA_PRECISION],
		int out_write_length, int output_offset);

inline
data_t *InitArray(int channel, int height, int width){

	int length = channel*height*width;
	data_t* arr = new data_t[length];
	for(int i = 0; i < length; i++){
		arr[i] = i;
	}

	return arr;
}

inline
void MonitorACT_SW(data_t *ACT, int channel, int height, int width){

	int channel_idx = 0;
	for(int z = 0; z < channel*height*width; z+=height*width){
		channel_idx++;
		cout << "============== channel = " << channel_idx << " ================= " << endl;
		for(int i = 0; i < height*width; i+=width){
			int offset = z+i;
			for(int j = 0; j < width; j++){
				cout << ACT[offset+j] << ", ";
			}
			cout << endl;
		}
	}
}

inline
void MonitorACT_HW(word_t* hw_inout, int depth){
#ifndef __SYNTHESIS__
	for(int i = 0; i < depth; i++){
		word_t word = hw_inout[i];
		for(int idx = 0; idx < (WORD_WIDTH/DATA_PRECISION); idx++){
			cout << (int)word.range((idx+1)*DATA_PRECISION-1, idx*DATA_PRECISION) << ", ";
		}
		cout << endl;
	}
#endif
}

template<unsigned DEPTH, unsigned WIDTH>
void MonitorACTBuffer(data_t buff[DEPTH][WIDTH]){

	for(int i = 0; i < DEPTH; i++){
		for(int j = 0; j < WIDTH; j++){
			cout << buff[i][j] << ", ";
		}
		cout << endl;
	}
}

inline
void ConvertSW2HW(data_t* sw_input, word_t* hw_input, int sw_length){
	int input_depth = sw_length/(WORD_WIDTH/DATA_PRECISION);
	for(int i = 0; i < input_depth; i++){
		int offset = (WORD_WIDTH/DATA_PRECISION)*i;
		word_t temp;
		for(int j = 0; j < (WORD_WIDTH/DATA_PRECISION); j++){
			temp.range((j+1)*DATA_PRECISION-1, j*DATA_PRECISION) = sw_input[offset+j];
		}
		hw_input[i] = temp;
	}
}

inline
void ConvertHW2SW(word_t* hw_output, data_t* sw_output, int hw_length){
	for(int i = 0; i < hw_length; i++){
		word_t temp = hw_output[i];
		int offset = (WORD_WIDTH/DATA_PRECISION)*i;
		for(int j = 0; j < (WORD_WIDTH/DATA_PRECISION); j++){
			sw_output[offset + j] = temp.range((j+1)*DATA_PRECISION-1, j*DATA_PRECISION);
		}
	}
}
