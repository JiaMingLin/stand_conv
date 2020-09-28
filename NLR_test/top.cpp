#include"top.h"


psum_t PE(psum_t psum,
		row_t<data_t, Ti> act,
		row_t<data_t, Ti> wgt){
#pragma HLS INLINE off
	for(int i = 0; i < Ti; i++){
#pragma HLS UNROLL
		psum += act.data[i]*wgt.data[i];
	}
	return psum;
}

void DoCompute(
		row_t<data_t, Ti> act[InSize][InSize],
		row_t<data_t, Ti> raw_wgt[KerSize][KerSize][To],
		row_t<psum_t, To> psum_output[OutSize][OutSize],
		int k1, int k2, int Tr, int Tc
){

#pragma HLS ALLOCATION instances=PE limit=16 function

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE m_axi port=act offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=raw_wgt offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=psum_output offset=slave bundle=OUTPUT
//#pragma HLS INLINE
#pragma HLS DATA_PACK variable=act
#pragma HLS DATA_PACK variable=raw_wgt
#pragma HLS DATA_PACK variable=psum_output

	row_t<data_t, Ti> wgt[KerSize][KerSize][To];
#pragma HLS DATA_PACK variable=wgt
#pragma HLS ARRAY_PARTITION variable=wgt complete dim=3


	row_t<data_t, Ti> read_word;
	for(int h = 0; h < To; h++){
		for(int i = 0; i < KerSize; i++){
			for(int j = 0; j < KerSize; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					wgt[i][j][h].data[k] = 1;//raw_wgt[i][j][h].data[k];
				}

			}
		}
	}

	k1 = 3;
	k2 = 3;
	Tr = 28;
	Tc = 28;

	LOOP_KI:for(int ki = 0; ki < k1; ki++){
		LOOP_KJ:for(int kj = 0; kj < k2; kj++){
			LOOP_TR:for(int r = 0; r < Tr; r++){
				LOOP_TC:for(int c = 0; c < Tc; c++){
#pragma HLS PIPELINE

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						psum_output[r][c].data[o] = PE(
								psum_output[r][c].data[o],
								act[r+ki][c+kj],
								wgt[ki][kj][o]
								);

						// load weight
//						for(int idx = 0; idx < Ti; idx++){
//#pragma HLS UNROLL
//							rf_wgt[o].data[idx] = 1;//wgt[ki][kj][o].data[idx]; //TODO
//							psum_output[r][c].data[o] += act[r+ki][c+kj].data[idx] * rf_wgt[o].data[idx];
//						}
					}

//					for(int i = 0; i < To; i++){
//						psum_output[r][c].data[i] = act[r][c].data[i];
//					}
				}
			}
		}
	}
}
