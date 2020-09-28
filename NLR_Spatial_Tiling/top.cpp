#include"top.h"

/*
 * inRow: number of input feature map rows
 * inCol: number of input feature map columns
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
		int inRow, int inCol,
		int Tr, int Tc, int ker_size, int stride,
		int test){

#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=inRow bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=inCol bundle=CTRL_BUS
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

	row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To];
	row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH];
	row_t<psum_t, To> psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH];

#pragma HLS DATA_PACK variable=wgt
#pragma HLS DATA_PACK variable=act
#pragma HLS DATA_PACK variable=psum_output

	row_t<data_t, Ti> raw_word;
	row_t<data_t, Ti> src_word;
	row_t<psum_t, To> out_word;

	int tileNumX = divide_ceil(inCol, Tc*stride);
	int tileNumY = divide_ceil(inRow, Tr*stride);
	int inTc = Tc * stride + (ker_size-stride);   // inTc = inTr = 5 while testing
	int inTr = Tr * stride + (ker_size-stride);
	int padding = (ker_size % 2 == 0)? ker_size/2: (ker_size-1)/2;

	for(int tidY = 0; tidY < tileNumY; tidY++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4
		for(int tidX = 0; tidX < tileNumX; tidX++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4

			// load activation
			LoadActivation(input, act, inRow, inCol, Tr, Tc, tidY, tidX, inTr, inTc, padding);

			// load weight
			LoadWeight(raw_wgt,wgt,ker_size,test);

//			wgt_buff_monitor<data_t, 3, Ti, To>(wgt);
//#ifdef CSIM_FLAG
//			cout << "===================================================" << endl;
//			cout << "tile index x = " << tidX << ", tile index y = " << tidY << endl;
//			cout << "===================================================" << endl;
//			buff_monitor_3D<data_t, Ti, MAX_TILE_IN_HEIGHT, MAX_TILE_IN_WIDTH>(act);
//#endif
			// operation
			Conv(wgt, act, psum_output,
				ker_size, ker_size, Tr, Tc, stride);

			// output result
			WriteOutput(output, wgt, act, psum_output,
					inRow, inCol,
					tidY, tidX,
					Tr, Tc,
					ker_size, stride,
					test);

		}
	}
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
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		row_t<psum_t, To> psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH],
		int k1, int k2, int Tr, int Tc, int stride
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

/*
 * inTr: input tile height
 * inTc: input tile width
 */
void LoadActivation(
		row_t<data_t, Ti> *input,
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		int inRow, int inCol,
		int Tr, int Tc, int tidY, int tidX,
		int inTr, int inTc,
		int padding){

	int anchorX = tidX * Tc - padding;
	int anchorY = tidY * Tr - padding;
	int ptrX, ptrY;
	int offset;
	row_t<data_t, Ti> zero_vector;

	for(int i = 0; i < inTr; i++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4
		for(int j = 0; j < inTc; j++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4
#pragma HLS PIPELINE
			ptrX = anchorX + j;
			ptrY = anchorY + i;

			if(ptrX >= 0 && ptrY >= 0 && ptrX < inCol && ptrY < inRow){
				offset = ptrY*inCol + ptrX;
				for(int k = 0; k < Ti; k++){
					act[i][j].data[k] = input[offset].data[k];
				}
			}else{
				for(int k = 0; k < Ti; k++){
					act[i][j].data[k] = 0;//zero_vector.data[k];
				}
			}
		}
	}
}

void LoadWeight(
		row_t<data_t, Ti> *raw_wgt, //row_t<data_t, Ti> hw_wgt[ker_size*ker_size*To];
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
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

/*
 * Tr: output # of tile row
 * Tc: output # of tile column
 */
void WriteOutput(
		row_t<data_t, To> *output,
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		row_t<psum_t, To> psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH],
		int inRow, int inCol,
		int tidY, int tidX,
		int Tr, int Tc, int ker_size, int stride,
		int test){
	row_t<data_t, Ti> test_word;

	int ptrX, ptrY, offset;
	// test == 4 output activation
	if(test == 4){

		for(int i = 0; i < Tr; i++){
			ptrY = tidY*Tr + i;
			for(int j = 0; j < Tc; j++){
#pragma HLS PIPELINE
				ptrX = tidX*Tc + j;
				offset = ptrY * inCol + ptrX;
				for(int k = 0; k < Ti; k++){
					output[offset].data[k] = act[i+1][j+1].data[k];
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
		for(int i = 0; i < Tr; i++){
			ptrY = tidY*Tr + i;
			for(int j = 0; j < Tc; j++){
#pragma HLS PIPELINE
				ptrX = tidX*Tc + j;
				offset = ptrY * inCol + ptrX;
				for(int k = 0; k < To; k++){
					output[offset].data[k] = psum_output[i][j].data[k];
				}
			}
		}

		// reset psum
		for(int i = 0; i < MAX_TILE_OUT_HEIGHT; i++){
			for(int j = 0; j < MAX_TILE_OUT_WIDTH; j++){
#pragma HLS PIPELINE
				for(int o = 0; o < To; o++){
					psum_output[i][j].data[o] = 0;
				}
			}
		}

	}
}
