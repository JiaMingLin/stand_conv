#include"top.h"

data_t ***Init3DArray(int height, int width, int channel){
	data_t*** fm = new data_t**[height];
	for(int i = 0; i < height; i++){
		fm[i] = new data_t*[width];
		for(int j = 0; j < width; j++){
			fm[i][j] = new data_t[channel];
		}
	}

	for(int i = 0; i < height; i++){
		for(int j = 0; j < width; j++){
			for(int k = 0; k < channel; k++){
				fm[i][j][k] = 0;
			}
		}
	}

	return fm;
}



int main(){

	srand(30);
	const int inRow = 32, inCol = 32;
	const int Tr = 16, Tc = 16;
	const int inChannel=3, outChannel=96;
	const int kerSize = 7;
	const int stride = 2;
	const int poolWin = 1;
	int inTiles = divide_ceil(inChannel, Ti);
	int outTiles = divide_ceil(outChannel, To);
	int outRow = inRow;
	int outCol = inCol;

	bool isFCN = (inRow == 1 && inCol == 1)? true:false;

	if(stride > 1){
		outRow = divide_ceil(inRow, stride);
		outCol = divide_ceil(inCol, stride);
	}

	char* dataMode = (char*)"rand";
//	data_t act[inRow][inCol][inChannel];
	data_t ***act = Init3DArray(inRow, inCol, (inChannel>16)?16:inChannel);
	data_t weight[kerSize][kerSize][outChannel][inChannel];
	data_t ***sw_conv_result = Init3DArray(outRow, outCol, outChannel);
	data_t ***sw_result = Init3DArray(outRow, outCol, outChannel);
	data_t ***hw_result = Init3DArray(outRow, outCol, outChannel);

	// convert to hardware data format
	uint128 *hw_input = new uint128[inRow*inCol*inChannel];
	uint128 *hw_wgt = new uint128[kerSize*kerSize*outChannel*inChannel];
	uint128 *hw_output = new uint128[outRow*outCol*outChannel];

	// initialize activation
	IFMInit<inRow, inCol, inChannel>(act, dataMode);
	IFMConvert<inRow, inCol, inChannel>(hw_input, act, inTiles);
	IFMMonitor<inRow, inCol, inChannel>(act, 0);
	IFMMonitorLinear<inRow, inCol, inChannel>(hw_input, inRow, inCol, inTiles, 0);
//
//	// initialize weight
	WGTInit<kerSize, outChannel, inChannel>(weight, (char*)"channel", dataMode);
	WGTConvert<kerSize, outChannel, inChannel>(hw_wgt, weight, outTiles, inTiles);
	WGTMonitor<kerSize, outChannel, inChannel>(weight, 0);
	WGTMonitorLinear<kerSize, outChannel, inChannel>(hw_wgt,outTiles, inTiles, 0);

	if(!isFCN){
		// sw standard conv
		for(int i = 0; i < outRow; i++){
			for(int j = 0; j < outCol; j++){
				for(int k_out = 0; k_out < outChannel; k_out++){
		 			psum_t partial_sum = 0;
		 			for(int k_in = 0; k_in < inChannel; k_in++){
		 				for(int k_i = -1; k_i < kerSize-1; k_i++){
		 					for(int k_j = -1; k_j < kerSize-1; k_j++){
		 						if((i*stride+k_i >= 0 && j*stride+k_j >= 0) && (i*stride+k_i < inRow && j*stride+k_j < inCol)){
		 							partial_sum += weight[k_i+1][k_j+1][k_out][k_in]
		 										* act[i*stride+k_i][j*stride+k_j][k_in];
		 						}
		 					}
		 				}
		 			}
		 			sw_conv_result[i][j][k_out] = partial_sum;
		 		}
		 	}
		 }


		 SW_Pooling(sw_result, sw_conv_result, outRow, outCol, outChannel, poolWin);

	}else{
		SW_FCN<inRow, inCol, inChannel, outChannel, kerSize>(sw_result,act,weight);
	}


	if(poolWin > 1){
		outRow = divide_ceil(inRow, poolWin);
		outCol = divide_ceil(inCol, poolWin);
	}
	// hardware conv
	DoCompute(hw_input, hw_output, hw_wgt,
	 		inRow, inCol, inChannel, outChannel,
	 		Tr, Tc, kerSize, stride, poolWin);
//	OFMMonitorLinear(hw_output, outRow, outCol, outChannel);

	OFMConvert<outChannel>(hw_result, hw_output, outRow, outCol);

//	OFMMonitor<outChannel>(hw_result, outRow, outCol);

	int err = 0;
 	for(int k = 0; k < outChannel; k++){
// 		printf("================== channel = %d ===============\n", (k+1));
 		for(int i = 0; i < outRow; i++){
 			for(int j = 0; j < outCol; j++){
 				if(sw_result[i][j][k] != hw_result[i][j][k]){
 					err++;
 				}
// 				cout << sw_result[i][j][k] << ":" << hw_result[i][j][k] << ", ";
// 				cout << sw_result[i][j][k] << ", ";
 			}
// 			printf("\n");
 		}
 	}
 	printf("==================== errors = %d ===========================\n", err);
	return err;

}
