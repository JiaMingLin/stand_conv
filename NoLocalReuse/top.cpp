#include"top.h"

void DoCompute(
		row_t<data_t, Ti> *input,
		row_t<data_t, To> *output,
		row_t<data_t, Ti> raw_wgt[KerSize][KerSize][To],
		int Tr, int Tc){

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tr bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tc bundle=CTRL_BUS
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
	for(int i = 0; i < InSize; i++){
		for(int j = 0; j < InSize; j++){
#pragma HLS PIPELINE

			if(i != 0 && j != 0 && i != (InSize-1) && j != (InSize-1)){
				raw_word = input[(i-1)*Tr+(j-1)];
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = raw_word.data[k];
				}
			}else{
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = 0;
				}
			}
			act[i][j] = src_word;
		}
	}

	// load weight
	for(int h = 0; h < To; h++){
		for(int i = 0; i < KerSize; i++){
			for(int j = 0; j < KerSize; j++){
#pragma HLS PIPELINE
				raw_word = raw_wgt[i][j][h];
				for(int k = 0; k < Ti; k++){
					src_word.data[k] = raw_word.data[k];
				}
				wgt[i][j][h] = src_word;
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


	// output result
	row_t<data_t, To> dst_word;
	for(int i = 0; i < OutSize-2; i++){
		for(int j = 0; j < OutSize-2; j++){
#pragma HLS PIPELINE
			out_word = psum_output[i][j];
			for(int k = 0; k < To; k++){
				dst_word.data[k] = out_word.data[k];
			}
			output[i*(OutSize-2)+j] = dst_word;
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

void Conv(
		row_t<data_t, Ti> wgt[KerSize][KerSize][To],
		row_t<data_t, Ti> act[InSize][InSize],
		row_t<psum_t, To> psum_output[OutSize][OutSize],
		int k1, int k2, int Tr, int Tc, int stride, bool reset
){
//#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=wgt dim=3 complete
#pragma HLS DATA_PACK variable=wgt
#pragma HLS DATA_PACK variable=act
#pragma HLS DATA_PACK variable=psum_output

	psum_t rf_partial_sum[To];
	row_t<data_t, Ti> rf_wgt[To];
	data_t rf_act[Ti];

#pragma HLS ARRAY_PARTITION variable=rf_wgt dim=0 complete
#pragma HLS ARRAY_PARTITION variable=rf_act dim=0 complete
#pragma HLS ARRAY_PARTITION variable=rf_partial_sum dim=0 complete

	for(int ki = 0; ki < k1; ki++){
		for(int kj = 0; kj < k2; kj++){
			for(int r = 0; r < Tr; r++){
				for(int c = 0; c < Tc; c++){
#pragma HLS PIPELINE
					// load activation, TODO stride > 1
					for(int idx = 0; idx < Ti; idx++){
#pragma HLS UNROLL
						rf_act[idx] = 100;//act[r+ki][c+kj].data[idx];
					}

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						// load partial sum
						rf_partial_sum[o] = psum_output[r][c].data[o];
					}

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						// load weight
						for(int idx = 0; idx < Ti; idx++){
#pragma HLS UNROLL
							rf_wgt[o].data[idx] = 100;//wgt[ki][kj][o].data[idx]; //TODO
						}
					}

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						for(int idx = 0; idx < Ti; idx++){
#pragma HLS UNROLL
							rf_partial_sum[o] += rf_act[idx] * rf_wgt[o].data[idx];
						}
					}

#ifdef CSIM_FLAG
					cout << "r = " << r << ", c = " << c << ", ki = " << ki << ", kj = " << kj << endl;
					cout << "Act monitoring: " << endl;
					buff_monitor_1D<data_t, Ti>(rf_act);
					cout << endl;
//					cout << "Weight monitoring: " << endl;
//					buff_monitor_2D<data_t, Ti, To>(rf_wgt);
//					cout << endl;
#endif

					for(int o = 0; o < To; o++){
#pragma HLS UNROLL
						// store partial sum
						psum_output[r][c].data[o] = rf_partial_sum[o];
					}
#ifdef CSIM_FLAG
					cout << "Partial sum monitoring: " << endl; //psum_t rf_partial_sum[To];
					buff_monitor_1D<psum_t, To>(rf_partial_sum);
					cout << endl;
#endif
				}
			}
		}
	}
}
