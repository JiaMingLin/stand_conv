#include"top.h"

data_t ***newFMs(int height, int width, int channel){
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
	const int inRow = TEST_INDIM, inCol = TEST_INDIM;
	const int Tr = 8, Tc = 8;
	const int inChannel=64, outChannel=64;
	const int kerSize = 3;
	const int stride = 1;
	int inTiles = divide_ceil(inChannel, Ti);
	int outTiles = divide_ceil(outChannel, To);
	int outRow = divide_ceil(inRow, stride);
	int outCol = divide_ceil(inCol, stride);

	char* dataMode = (char*)"all";
	data_t act[TEST_INDIM][TEST_INDIM][inChannel];
	data_t weight[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][outChannel][inChannel];
	data_t ***sw_result = newFMs(outRow, outCol, outChannel);
	data_t ***hw_result = newFMs(outRow, outCol, outChannel);

	// convert to hardware data format
	uint128 *hw_input = new uint128[inRow*inCol*inChannel];
	uint128 *hw_wgt = new uint128[kerSize*kerSize*outChannel*inChannel];
	uint128 *hw_output = new uint128[outRow*outCol*outChannel];

	// initialize activation
	IFMInit<inRow, inCol, inChannel>(act, dataMode);
	IFMConvert<inRow, inCol, inChannel>(hw_input, act, inTiles);
	IFMMonitor<inChannel>(act, 0);
	IFMMonitorLinear<inRow, inCol, inChannel>(hw_input, inRow, inCol, inTiles, 0);
//
//	// initialize weight
	WGTInit<kerSize, outChannel, inChannel>(weight, (char*)"channel", dataMode);
	WGTConvert<kerSize, outChannel, inChannel>(hw_wgt, weight, outTiles, inTiles);
	WGTMonitor<kerSize, outChannel, inChannel>(weight, 0);
	WGTMonitorLinear<kerSize, outChannel, inChannel>(hw_wgt,outTiles, inTiles, 0);

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
 				sw_result[i][j][k_out] = partial_sum;
 //
 			}
 		}
 	}
	
	// hardware conv
	DoCompute(hw_input, hw_output, hw_wgt,
	 		inRow, inCol, inChannel, outChannel,
	 		Tr, Tc, kerSize, stride);
	
	OFMConvert<outChannel>(hw_result, hw_output, outRow, outCol);
//	OFMMonitor<outChannel>(hw_result, outRow, outCol);


	int err = 0;
 	for(int k = 0; k < outChannel; k++){
 		printf("================== channel %d ===============\n", (k+1));
 		for(int i = 0; i < outRow; i++){
 			for(int j = 0; j < outCol; j++){
 				if(sw_result[i][j][k] != hw_result[i][j][k]){
 					err++;
 				}
 				cout << sw_result[i][j][k] << ":" << hw_result[i][j][k] << ", ";
// 				cout << sw_result[i][j][k] << ", ";
 			}
 			printf("\n");
 		}
 	}
 	printf("==================== errors = %d ===========================\n", err);
	return err;

}
