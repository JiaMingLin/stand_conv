#include"top.h"

void LoadActivation(
		row_t<data_t, Ti> *input,
		row_t<data_t, Ti> act[InSize][InSize],
		int Tr, int Tc, int stride, int ker_size,
		int test){
	row_t<data_t, Ti> src_word;

	int inRow = Tr*stride + (ker_size-stride);
	int inCol = Tc*stride + (ker_size-stride);

	if(test == 1 || test == 3){
		for(int i = 0; i < inRow; i++){
			for(int j = 0; j < inCol; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = 0;
				}
				if(i != 0 && j != 0 && i != (inRow-1) && j != (inCol-1)){
					for(int k = 0; k < Ti; k++){
						src_word.data[k] = HARDCODE_VAL;
					}
				}
				act[i][j] = src_word;
			}
		}

	}else{
		for(int i = 0; i < inRow; i++){
			for(int j = 0; j < inCol; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = 0;
				}
				if(i != 0 && j != 0 && i != (inRow-1) && j != (inCol-1)){
					for(int k = 0; k < Ti; k++){
						src_word.data[k] = input[(i-1)*Tr+(j-1)].data[k];
					}
				}
				act[i][j] = src_word;
			}
		}
	}
}

void LoadWeight(
		row_t<data_t, Ti> *raw_wgt,
		row_t<data_t, Ti> wgt[KerSize][KerSize][To],
		int ker_size,
		int test){

	row_t<data_t, Ti> src_word;
	if(test == 1 || test == 2){
		// load weight

		for(int i = 0; i < ker_size; i++){
			for(int j = 0; j < ker_size; j++){
				for(int h = 0; h < To; h++){
#pragma HLS PIPELINE
					for(int k = 0; k < Ti; k++){
						src_word.data[k] = HARDCODE_VAL;
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
}

void WriteOutput(
		row_t<data_t, To> *output,
		row_t<data_t, Ti> wgt[KerSize][KerSize][To],
		row_t<data_t, Ti> act[InSize][InSize],
		row_t<psum_t, To> psum_output[OutSize][OutSize],
		int Tr, int Tc, int ker_size, int stride,
		int test){
	row_t<data_t, Ti> test_word;

	// test == 4 output activation
	if(test == 4){
		for(int i = 0; i < InSize; i++){
			for(int j = 0; j < InSize; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < Ti; k++){
					output[i*InSize+j].data[k] = act[i][j].data[k];
				}
			}
		}
	// test == 5 output weight
	}else if(test == 5){
		for(int i = 0; i < ker_size; i++){
			for(int j = 0; j < ker_size; j++){
				for(int too = 0; too < To; too++){
#pragma HLS PIPELINE
					for(int tii = 0; tii < Ti; tii++){
						output[i*ker_size*To + j*To + too].data[tii] = wgt[i][j][too].data[tii];
					}
				}
			}
		}
	}else{

		// output result
		row_t<data_t, To> dst_word;
		for(int i = 0; i < Tr; i++){
			for(int j = 0; j < Tc; j++){
#pragma HLS PIPELINE
				for(int k = 0; k < To; k++){
					dst_word.data[k] = psum_output[i][j].data[k];
				}
				output[i*Tc + j] = dst_word;
			}
		}
	}
}


/*
 * Tr: output rows
 * Tc: output columns
 * test
 *     1: hard coded activation and weight
 *     2: hard coded weight
 *     3: hard coded activation
 *     4: output activation
 *     5: output weight
 */
void DoCompute(
		row_t<data_t, Ti> *input,
		row_t<data_t, To> *output,
		row_t<data_t, Ti> *raw_wgt,
		int Tr, int Tc, int ker_size, int stride,
		int test){

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tr bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tc bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=ker_size bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=stride bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=test bundle=CTRL_BUS
#pragma HLS INTERFACE m_axi port=input offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=raw_wgt offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi port=output offset=slave bundle=OUTPUT

#pragma HLS DATA_PACK variable=input
#pragma HLS DATA_PACK variable=output
#pragma HLS DATA_PACK variable=raw_wgt

	row_t<data_t, Ti> wgt[KerSize][KerSize][To];
	row_t<data_t, Ti> act[InSize][InSize];
	row_t<psum_t, To> psum_output[OutSize][OutSize];

	row_t<data_t, Ti> raw_word;
	row_t<data_t, Ti> src_word;
	row_t<psum_t, To> out_word;

	// load activation
	LoadActivation(input, act, Tr, Tc, stride, ker_size, test);

	// load weight
	LoadWeight(raw_wgt, wgt, ker_size, test);

	// psum initialize
	InitTensor<psum_t, OutSize, OutSize>(psum_output);

	// do Conv
	Conv(wgt, act, psum_output, ker_size, ker_size, Tr, Tc, stride,0);

	// output result
	WriteOutput(output, wgt, act, psum_output,
			Tr, Tc, ker_size, stride,
			test);

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
#pragma HLS ALLOCATION instances=PE limit=32 function

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
