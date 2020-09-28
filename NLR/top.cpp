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
 * type:
 *     0. convolution only
 *     1. convolution + pooling
 */
void DoCompute(
		uint128 *ifm,
		uint128 *ofm,
		uint128 *raw_wgt,
		int inRow, int inCol, int inChannel, int outChannel,
		int Tr, int Tc, int kerSize, int stride){

#pragma HLS INTERFACE m_axi depth=4096 port=ifm offset=slave bundle=INPUT
#pragma HLS INTERFACE m_axi depth=2304 port=raw_wgt offset=slave  bundle=INPUT
#pragma HLS INTERFACE m_axi depth=4096 port=ofm offset=slave  bundle=OUTPUT
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=inRow bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=inCol bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=inChannel bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=outChannel bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tr bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=Tc bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=ker_size bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=stride bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=type bundle=CTRL_BUS

	uintTi act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH];
	uintAcc psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH];
	uintTi wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To];

	int tileNumX = divide_ceil(inCol, Tc*stride);
	int tileNumY = divide_ceil(inRow, Tr*stride);
	int tileNumIn = divide_ceil(inChannel, Ti);
	int tileNumOut = divide_ceil(outChannel, To);

	int inTc = Tc * stride + (kerSize-stride);   // inTc = inTr = 5 while testing
	int inTr = Tr * stride + (kerSize-stride);
	int padding = (kerSize % 2 == 0)? kerSize/2: (kerSize-1)/2;

	// TODO: change for stride > 1
	int outRow = inRow;
	int outCol = inCol;

	// loop order at tile level: row major
	// TODO: comparing with channel major on tile ordering level
	for(int tidOut = 0; tidOut < tileNumOut; tidOut++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4
		for(int tidY = 0; tidY < tileNumY; tidY++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4
			for(int tidX = 0; tidX < tileNumX; tidX++){
#pragma HLS LOOP_TRIPCOUNT min=4 max=4 avg=4

				// psum initialize
				InitPSUM<uintAcc>(psum_output);

				for(int tidIn = 0; tidIn < tileNumIn; tidIn++){
#pragma HLS LOOP_TRIPCOUNT min=2 max=2 avg=2
					// load activation

					LoadActivation(
						ifm, act,
						inRow, inCol, Tr, Tc,
						tidY, tidX, tidIn,
						inTr, inTc, padding);

//					IFMMonitorTile(act, tidY, tidX, tidIn, inTr, inTc);

					 //load weightf
					LoadWeight(
					 	raw_wgt,wgt,
					 	tidIn, tidOut, tileNumIn,
						kerSize);

//					WGTMonitorTile(wgt,tidOut, tidIn,kerSize);

					 // operation
					HWConv<To>(wgt, act, psum_output,
							kerSize, kerSize, Tr, Tc, stride);
				}

//				OFMMonitorTile<data_t>(psum_output, Tr, Tc);
				// output result
				WriteOutput(ofm, psum_output,
					tidY, tidX, tidOut,
					Tr, Tc,
					outRow, outCol);

			}
		}
	}

	return;
}



bool notBoundary(int i, int j, int anchorX, int anchorY, int inRow, int inCol){
	int ptrX = anchorX + j;
	int ptrY = anchorY + i;
	return ptrX >= 0 && ptrY >= 0 && ptrX < inCol && ptrY < inRow;
}

/*
 * inTr: input tile height
 * inTc: input tile width
 */
void LoadActivation(
		uint128 *ifm,
		uintTi act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		int inRow, int inCol,
		int Tr, int Tc, int tidY, int tidX, int tidIn,
		int inTr, int inTc,
		int padding){

	// anchor on the feature map plane
	int anchorX = tidX * Tc - padding;
	int anchorY = tidY * Tr - padding;

	// position in the tile plane
	int offset = anchorY*inCol + anchorX + tidIn*inRow*inCol;

	uintTi buffer;

	for(int i = 0; i < inTr; i++){
#pragma HLS LOOP_TRIPCOUNT min=10 max=10 avg=10
		for(int j = 0; j < inTc; j++){
#pragma HLS LOOP_TRIPCOUNT min=10 max=10 avg=10
#pragma HLS PIPELINE II = 2
			int lineOffset = (offset + j)*WORDS_PER_LINE;
			if(notBoundary(i,j,anchorX,anchorY,inRow,inCol)){
#ifdef ULTRA96
				for(int k = 0; k < WORD_LENGTH; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = ifm[lineOffset].range((k+1)*PREC-1, k*PREC);
//					buffer.data[k] = 1;
				}
#else
				for(int k = 0; k < WORD_LENGTH; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = ifm[lineOffset].range((k+1)*PREC-1, k*PREC);
//					buffer.data[k] = 1;
				}
				buffer >> DATAWIDTH;

				for(int k = 0; k < WORD_LENGTH; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = ifm[lineOffset+1].range((k+1)*PREC-1, k*PREC);
//					buffer.data[k] = 1;
				}
#endif
			}else{
				for(int k = 0; k < Ti; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = 0;//zero_vector.data[k];
				}
			}

			act[i][j] = buffer;
		}
		offset += (inCol);
	}
}

void LoadWeight(
		uint128 *raw_wgt, //row_t<data_t, WORD_LENGTH> hw_wgt[ker_size*ker_size*To];
		uintTi wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		int tidIn, int tidOut, int tileNumIn,
		int kerSize){

	// load weight
	// TODO: currently kernel row major, compare with output channel major
	// to the one tiled kernel spatial level
	int offset = tidOut*tileNumIn*To*kerSize*kerSize*WORDS_PER_LINE + tidIn*To*kerSize*kerSize*WORDS_PER_LINE; 
	uintTi buffer;
	for(int o = 0; o < To; o++){
		for(int ky = 0; ky < kerSize; ky++){
			for(int kx = 0; kx < kerSize; kx++){
#ifdef ULTRA96
#pragma HLS PIPELINE II = 1
				for(int i = 0; i < WORD_LENGTH; i++){
					buffer.range((i+1)*PREC-1, i*PREC) = raw_wgt[offset].range((i+1)*PREC-1, i*PREC);
				}
#else
#pragma HLS PIPELINE II = 2
				for(int i = 0; i < WORD_LENGTH; i++){
					buffer.range((i+1)*PREC-1, i*PREC) = raw_wgt[offset].range((i+1)*PREC-1, i*PREC);
				}
				buffer >> DATAWIDTH;
				for(int i = 0; i < WORD_LENGTH; i++){
					buffer.range((i+1)*PREC-1, i*PREC) = raw_wgt[offset+1].range((i+1)*PREC-1, i*PREC);
				}
#endif
				wgt[ky][kx][o] = buffer;
				offset += WORDS_PER_LINE;
			}
		}
	}
}

/*
 * Tr: output # of tile row
 * Tc: output # of tile column
 */
void WriteOutput(
		uint128 *ofm,
		uintAcc psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH],
		int tidY, int tidX, int tidOut,
		int Tr, int Tc,
		int outRow, int outCol){

	// output tile: row major
	// TODO: output to channel major
	int offset = tidOut*outRow*outCol*WORDS_PER_LINE // plane level
			+ tidY*Tr*outCol*WORDS_PER_LINE // in a plane, row level
			+ tidX*Tc*WORDS_PER_LINE; // in a row, column level

	int wordOffset = offset;
	uintTo buffer;
#pragma HLS DATA_PACK variable=buffer
	// for the current tile
	for(int y = 0; y < Tr; y++){
		wordOffset = offset;

		for(int x = 0; x < Tc; x++){

#ifdef ULTRA96
#pragma HLS PIPELINE ii = 1
			for(int o = 0; o < To; o++){
				buffer.range((o+1)*PREC-1, o*PREC) = (data_t)psum_output[y][x].range((o+1)*ACC_PREC-1, o*ACC_PREC);
			}
			for(int i = 0; i < WORD_LENGTH; i++){
				ofm[wordOffset].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
			}
#else
#pragma HLS PIPELINE ii = 2
			for(int o = 0; o < To; o++){
				buffer.range((o+1)*PREC-1, o*PREC) = (data_t)psum_output[y][x].range((o+1)*ACC_PREC-1, o*ACC_PREC);
			}
			for(int i = 0; i < WORD_LENGTH; i++){
				ofm[wordOffset].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
			}
			buffer << DATAWIDTH;
			for(int i = 0; i < WORD_LENGTH; i++){
				ofm[wordOffset+1].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
			}
#endif
			wordOffset += WORDS_PER_LINE;
		}
		offset += outCol*WORDS_PER_LINE;
	} 
}
