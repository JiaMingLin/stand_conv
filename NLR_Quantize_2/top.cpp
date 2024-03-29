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
		int Tr, int Tc, int kerSize, int stride, int poolWin,
		float multiplier, data_t zpX, data_t zpW, data_t zpXNext){

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
#pragma HLS INTERFACE s_axilite port=poolWin bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=multiplier bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=zpW bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=zpX bundle=CTRL_BUS
#pragma HLS INTERFACE s_axilite port=zpXNext bundle=CTRL_BUS

	uintTi act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH];
	uintTi wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To];

	psum_t psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH][To];
#pragma HLS ARRAY_RESHAPE variable=psum_output complete dim=3

	int tileNumX = divide_ceil(inCol, Tc*stride);
	int tileNumY = divide_ceil(inRow, Tr*stride);
	int tileNumIn = divide_ceil(inChannel, Ti);
	int tileNumOut = divide_ceil(outChannel, To);

	int inTc = Tc * stride + (kerSize-stride);   // inTc = inTr = 5 while testing
	int inTr = Tr * stride + (kerSize-stride);
	int outTc = Tc;
	int outTr = Tr;
	int padding = (kerSize % 2 == 0)? kerSize/2: (kerSize-1)/2;
	int maskBit = 0;

	// loop order at tile level: row major
	// TODO: comparing with channel major on tile ordering level
	for(int tidOut = 0; tidOut < tileNumOut; tidOut++){
		for(int tidY = 0; tidY < tileNumY; tidY++){
			for(int tidX = 0; tidX < tileNumX; tidX++){
				// psum initialize
				InitPSUM<psum_t>(psum_output);
				for(int tidIn = 0; tidIn < tileNumIn; tidIn++){
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

					maskBit = inChannel - (tidIn*Ti);
					maskBit = (maskBit > 0)? maskBit:(-1)*maskBit;
					maskBit = maskBit % Ti;
					 // operation
					HWConv<To>(wgt, act, psum_output, zpX, zpW,
							kerSize, kerSize, Tr, Tc, stride, inRow, inCol, maskBit);
				}

				OFMMonitorTile<psum_t>(psum_output, Tr, Tc);
				// output result
				WriteOutput(ofm, psum_output,
					multiplier, zpXNext,
					tidY, tidX, tidOut,
					Tr, Tc, inRow, inCol,
					poolWin);

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
					buffer.range((k+1)*PREC-1, k*PREC) = (data_t)(ifm[lineOffset].range((k+1)*PREC-1, k*PREC));
//					buffer.data[k] = 1;
				}
#else
				for(int k = 0; k < WORD_LENGTH; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = ifm[lineOffset].range((k+1)*PREC-1, k*PREC)-currFMZP;
//					buffer.data[k] = 1;
				}
				buffer >> DATAWIDTH;

				for(int k = 0; k < WORD_LENGTH; k++){
					buffer.range((k+1)*PREC-1, k*PREC) = ifm[lineOffset+1].range((k+1)*PREC-1, k*PREC)-currFMZP;
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
					buffer.range((i+1)*PREC-1, i*PREC) = (data_t)(raw_wgt[offset].range((i+1)*PREC-1, i*PREC));
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

//data_t rescale(psum_t ofmData, float multiplier, int nextFMZP){
//#pragma HLS INLINE
//	return (data_t)multiplier*ofmData + nextFMZP;
//}

data_t ReluMAX(data_t a, data_t b, data_t c, data_t d){
	data_t t1; data_t t2;

	t1 = (a>b)?a:b;
	t2 = (c>d)?c:d;

	return (t1 > t2)?t1:t2;
}

data_t scale(psum_t result, float multiplier, data_t zpXNext){
#pragma HLS INLINE

	return (clamp_round_t)((result*multiplier) + zpXNext);
//	return (clamp_round_t)result;
}

/*
 * Tr: output # of tile row
 * Tc: output # of tile column
 */
void WriteOutput(
		uint128 *ofm,
		psum_t psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH][To],
		float multiplier, data_t zpXNext,
		int tidY, int tidX, int tidOut,
		int Tr, int Tc, int row, int column,
		int poolWin
		){

	int outRow = divide_ceil(row, poolWin);
	int outCol = divide_ceil(column, poolWin);

	int outTr = divide_ceil(Tr, poolWin);
	int outTc = divide_ceil(Tc, poolWin);

	// output tile: row major
	int offset = tidOut*outRow*outCol*WORDS_PER_LINE // plane level
			+ tidY*outTr*outCol*WORDS_PER_LINE // in a plane, row level
			+ tidX*outTc*WORDS_PER_LINE; // in a row, column level

	int wordOffset = offset;
	uintTo buffer;

	if(poolWin == 1){
		// for the current tile
		for(int y = 0; y < Tr; y++){
			wordOffset = offset;
			for(int x = 0; x < Tc; x++){
#pragma HLS PIPELINE ii = 1
				for(int o = 0; o < To; o++){
					buffer.range((o+1)*PREC-1, o*PREC) =
							scale(psum_output[y][x][o], multiplier, zpXNext);
				}
				// write to output
				WriteDRAM(ofm, buffer, wordOffset);
				// offset on x direction
				wordOffset += WORDS_PER_LINE;
			}
			offset += outCol*WORDS_PER_LINE;
		}
	}else if(poolWin != 1){

		for(int y = 0; y < Tr; y+=poolWin){
			wordOffset = offset;
			for(int x = 0; x < Tc; x+=poolWin){
#pragma HLS PIPELINE
				
				for(int o = 0; o < To; o++){
#pragma UNROLL
					// re-scale then pooling
					data_t xx = scale(psum_output[y][x][o], multiplier, zpXNext);
					data_t xy = scale(psum_output[y+1][x][o], multiplier, zpXNext);
					data_t yx = scale(psum_output[y][x+1][o], multiplier, zpXNext);
					data_t yy = scale(psum_output[y+1][x+1][o], multiplier, zpXNext);
					data_t d = ReluMAX(xx, xy, yx, yy);
					buffer.range((o+1)*PREC-1, o*PREC) = d.range(PREC-1,0);
				}

				// write to output
				WriteDRAM(ofm, buffer, wordOffset);

				// offset on x direction
				wordOffset += WORDS_PER_LINE;
			}
			offset += outCol*WORDS_PER_LINE;
		}
	}
}

void WriteDRAM(
	uint128 *ofm, uintTo buffer,
	int ptr){
#pragma HLS INLINE

#ifdef ULTRA96
	for(int i = 0; i < WORD_LENGTH; i++){
#pragma HLS UNROLL
		ofm[ptr].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
	}
#else

	for(int i = 0; i < WORD_LENGTH; i++){
#pragma HLS UNROLL
		ofm[wordOffset].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
	}
	buffer << DATAWIDTH;
	for(int i = 0; i < WORD_LENGTH; i++){
#pragma HLS UNROLL
		ofm[wordOffset+1].range((i+1)*PREC-1, i*PREC) = buffer.range((i+1)*PREC-1, i*PREC);
	}
#endif

}
