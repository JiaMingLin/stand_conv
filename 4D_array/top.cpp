#include"top.h"

void DoCompute(
		row_t<data_t, Ti> *output,
		row_t<data_t, Ti> *raw_wgt // [KerSize][KerSize][To]
		){

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE m_axi port=raw_wgt offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=output offset=slave bundle=OUTPUT

#pragma HLS DATA_PACK variable=output
#pragma HLS DATA_PACK variable=raw_wgt

	// No padding
	row_t<data_t, Ti> wgt[KerSize][KerSize][To];

	row_t<data_t, Ti> raw_word;
	row_t<data_t, Ti> src_word;
	row_t<data_t, Ti> out_word;

	// load weight
	for(int i = 0; i < KerSize; i++){
		for(int j = 0; j < KerSize; j++){
			for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = raw_wgt[i*KerSize*To + j*To + h].data[k];
				}
				wgt[i][j][h] = src_word;
			}
		}
	}

	for(int i = 0; i < KerSize; i++){
		for(int j = 0; j < KerSize; j++){
			for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					out_word.data[k] = wgt[i][j][h].data[k];
				}
				output[i*KerSize*To + j*To + h] = out_word;
			}
		}
	}
}
