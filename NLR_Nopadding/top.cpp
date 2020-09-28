#include"top.h"

/*
 * test == 1, test for hard coded act and wgt
 * test == 2, test for hard coded wgt
 * test == 3, test for hard coded act
 * test == 4, output weight value
 */

void DoCompute(
		row_t<data_t, Ti> *input,
		row_t<data_t, To> *output,
		row_t<data_t, Ti> *raw_wgt,
		int Tr, int Tc, int ker_size, int test){

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tr bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tc bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=ker_size bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=test bundle=CTRL_BUS
#pragma HLS INTERFACE m_axi port=input offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=raw_wgt offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=output offset=slave bundle=OUTPUT

#pragma HLS DATA_PACK variable=input
#pragma HLS DATA_PACK variable=output
#pragma HLS DATA_PACK variable=raw_wgt

	// No padding
	Tr = InSize; Tc = InSize;
	int outTr = Tr; int outTc = Tc;

	row_t<data_t, Ti> wgt[KerSize][KerSize][To];
	row_t<data_t, Ti> act[InSize][InSize];
	row_t<psum_t, To> psum_output[OutSize][OutSize];

	row_t<data_t, Ti> raw_word;
	row_t<data_t, Ti> src_word;
	row_t<data_t, Ti> dst_word;
	row_t<psum_t, To> out_word;

	// load activation
	if(test == 1 || test == 3){
		for(int i = 0; i < InSize; i++){
			for(int j = 0; j < InSize; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = 1;
				}
				act[i][j] = src_word;
			}
		}
	}else{
		for(int i = 0; i < InSize; i++){
			for(int j = 0; j < InSize; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = input[i * InSize + j].data[k];
				}
				act[i][j] = src_word;
			}
		}
	}


	if(test == 1 || test == 2){
		// load weight

		for(int i = 0; i < ker_size; i++){
			for(int j = 0; j < ker_size; j++){
				for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
					for(int k = 0; k < Ti; k++){
						src_word.data[k] = 1;
					}
					wgt[i][j][h] = src_word;
				}
			}
		}
	}else{
		// load weight
		for(int i = 0; i < ker_size; i++){
			for(int j = 0; j < ker_size; j++){
				for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
					for(int k = 0; k < Ti; k++){
						src_word.data[k] = raw_wgt[i*ker_size*To + j*To + h].data[k];
					}
					wgt[i][j][h] = src_word;
				}
			}
		}
	}

	// psum initialize
	for(int i = 0; i < OutSize; i++){
		for(int j = 0; j < OutSize; j++){
#pragma HLS PIPELINE
			for(int k = 0; k < To; k++){
				out_word.data[k] = 0;
			}
			psum_output[i][j] = out_word;
		}
	}

	Conv(wgt, act, psum_output, 3,3,Tr,Tc,1,0);

	if(test == 5){
		// output wgt
		for(int i = 0; i < ker_size; i++){
			for(int j = 0; j < ker_size; j++){
				for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
					for(int k = 0; k < Ti; k++){
						dst_word.data[k] = wgt[i][j][h].data[k];
					}
					output[i*ker_size*To + j*To + h] = dst_word;
				}
			}
		}

	}else{
	// output result
		row_t<data_t, To> dst_word;
		for(int i = 0; i < outTr; i++){
			for(int j = 0; j < outTc; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < To; k++){
					dst_word.data[k] = psum_output[i][j].data[k];//i*(OutSize-2)*To + j*To + k
				}
				output[i*outTc+j] = dst_word;
			}
		}
	}



//	row_t<data_t, To> dst_word;
//	for(int i = 0; i < OutSize; i++){
//		for(int j = 0; j < OutSize; j++){
//#pragma HLS PIPELINE
//			out_word = act[i][j];
//			for(int k = 0; k < To; k++){
//				dst_word.data[k] = out_word.data[k];
//			}
//			output[i*OutSize+j] = dst_word;
//		}
//	}

}

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

void Conv(
		row_t<data_t, Ti> wgt[KerSize][KerSize][To],
		row_t<data_t, Ti> act[InSize][InSize],
		row_t<psum_t, To> psum_output[OutSize][OutSize],
		int k1, int k2, int Tr, int Tc, int stride, bool reset
){
#pragma HLS ALLOCATION instances=PE limit=16 function

#pragma HLS ARRAY_PARTITION variable=wgt dim=3 complete
#pragma HLS DATA_PACK variable=wgt
#pragma HLS DATA_PACK variable=act
#pragma HLS DATA_PACK variable=psum_output

	LOOP_KI:for(int ki = 0; ki < k1; ki++){
#pragma HLS LOOP_TRIPCOUNT min=3 max=3 avg=3
		LOOP_KJ:for(int kj = 0; kj < k2; kj++){
#pragma HLS LOOP_TRIPCOUNT min=3 max=3 avg=3
			LOOP_TR:for(int r = 0; r < Tr; r++){
#pragma HLS LOOP_TRIPCOUNT min=30 max=30 avg=30
				LOOP_TC:for(int c = 0; c < Tc; c++){
#pragma HLS LOOP_TRIPCOUNT min=30 max=30 avg=30
#pragma HLS PIPELINE

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						psum_output[r][c].data[o] = PE(
							psum_output[r][c].data[o],
							act[r+ki][c+kj],
							wgt[ki][kj][o]
						);
					}
				}
			}
		}
	}
}
