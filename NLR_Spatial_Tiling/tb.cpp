#include"top.h"

data_t ***newFMs(int channel, int height, int width){
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

void ReadRandIFM(data_t arr[TEST_INDIM][TEST_INDIM][Ti], bool dbg){

  char buff[2304];
  FILE *latfile;


  sprintf(buff,"%s","random_ifm.dat");
  latfile=fopen(buff,"r");
  fread(&(arr[0][0][0]),sizeof(uint8_t),2304,latfile);
  fclose(latfile);
  if(dbg){
		for(int k = 0; k < Ti; k++){
			cout << "ifm channel index = " << k << endl;
			for(int i = 0; i < TEST_INDIM; i++){
				for(int j = 0; j < TEST_INDIM; j++){
					cout << arr[i][j][k] << ", ";
				}
				cout << endl;
			}
			cout << endl;
		}
  }

}

void ReadRandWGT(data_t wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To][Ti], bool dbg){
  char buff[2304];
  FILE *latfile;

  sprintf(buff,"%s","random_wgt.dat");
  latfile=fopen(buff,"r");
  fread(&(wgt[0][0][0][0]),sizeof(data_t),2304,latfile);
  fclose(latfile);

  if(dbg){
	  for(int k_out = 0; k_out < To; k_out++){
	  		cout << "filter index = " << k_out <<endl;
	  		for(int i = 0; i < MAX_KERNEL_SIZE; i++){
	  			for(int j = 0; j < MAX_KERNEL_SIZE; j++){
	  				for(int k_in = 0; k_in < Ti; k_in++){
	  					cout << wgt[i][j][k_out][k_in] << ", ";
	  				}
	  				cout << endl;
	  			}
	  		}
	  		cout <<endl;
	  	}
  }

}

int main(){

	int inRow = TEST_INDIM, inCol = TEST_INDIM;
	int Tr = 3, Tc = 3;
	int in=Ti, out=To;
	int ker_size = 3;
	int stride = 1;
	int outRow = divide_ceil(inRow, stride);
	int outCol = divide_ceil(inCol, stride);
	data_t act[TEST_INDIM][TEST_INDIM][Ti];
	data_t weight[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To][Ti];
	data_t ***sw_result = newFMs(out, outRow, outCol);
	data_t ***hw_result = newFMs(out, outRow, outCol);

	// convert to hardware data format
	row_t<data_t, Ti> hw_input[inRow*inCol];
	row_t<data_t, Ti> hw_wgt[ker_size*ker_size*To];
	row_t<data_t, To> hw_output[outRow*outCol];

	// initialize activation
//	for(int i = 0; i < inRow; i++){
//		for(int j = 0; j < inCol; j++){
//			for(int k = 0; k < in; k++){
//				act[i][j][k] = rand() % 256;//i * inCol * in + j * in + k;
//			}
//		}
//	}
//
//	// initialize weight
//	for(int k_out = 0; k_out < out; k_out++){
//		for(int i = 0; i < ker_size; i++){
//			for(int j = 0 ; j < ker_size; j++){
//				for(int k_in = 0; k_in < in; k_in++){
//					weight[i][j][k_out][k_in] =
//							rand() % 256;//k_out * ker_size * ker_size * in + i * ker_size * in + j * in + k_in;
//				}
//			}
//		}
//	}

	ReadRandIFM(act, false);
	ReadRandWGT(weight, false);

	// sw standard conv
	for(int i = 0; i < outRow; i++){
		for(int j = 0; j < outCol; j++){
			for(int k_out = 0; k_out < out; k_out++){
				psum_t partial_sum = 0;
				for(int k_in = 0; k_in < in; k_in++){
					for(int k_i = -1; k_i < ker_size-1; k_i++){
						for(int k_j = -1; k_j < ker_size-1; k_j++){
							if((i*stride+k_i >= 0 && j*stride+k_j >= 0) && (i*stride+k_i < inRow && j*stride+k_j < inCol)){
								partial_sum += weight[k_i+1][k_j+1][k_out][k_in]
											* act[i*stride+k_i][j*stride+k_j][k_in];
							}
						}
					}
				}
				sw_result[i][j][k_out] = partial_sum;
//				cout << "i = " << i << ", j = " << j << ", k = " << k_out << endl;
			}
		}
	}

	for(int i = 0; i < inRow; i++){
		for(int j = 0; j < inCol; j++){
			for(int k = 0; k < Ti; k++){
				hw_input[i*inRow+j].data[k] = act[i][j][k];
			}
		}
	}

	for(int i = 0; i < ker_size; i++){
		for(int j = 0; j < ker_size; j++){
			for(int h = 0; h < To; h++){
				for(int k = 0; k < Ti; k++){
					hw_wgt[i*ker_size*To + j*To + h].data[k] = weight[i][j][h][k];
//					hw_wgt[i][j][h].data[k] = weight[i][j][k][h];
				}
			}
		}
	}

	DoCompute(hw_input, hw_output, hw_wgt,
			inRow, inCol,
			Tr, Tc, ker_size, stride, 0);

	int tileNumX = divide_ceil(inCol, Tc*stride);
	int tileNumY = divide_ceil(inRow, Tr*stride);
	int anchorX, anchorY, offset;

	for(int tidY = 0; tidY < tileNumY; tidY++){
		for(int tidX = 0; tidX < tileNumX; tidX++){
			anchorX = tidX * Tc;
			anchorY = tidY * Tr;
			for(int i = 0; i < Tr; i++){
				for(int j = 0; j < Tc; j++){
					offset = (anchorY+i) * inCol + (anchorX+j);
					for(int k = 0; k < To; k++){
						hw_result[anchorY+i][anchorX+j][k] = hw_output[offset].data[k];
					}
				}
			}
		}
	}

//	for(int k = 0; k < To; k++){
//		cout << "============= channel = " << k << "==============" << endl;
//		for(int i = 0; i < outRow; i++){
//			for(int j = 0; j < outCol; j++){
//				cout << sw_result[i][j][k] << ", ";
//			}
//			cout << endl;
//		}
//
//	}


	int err = 0;
	for(int k = 0; k < out; k++){
//		printf("================== channel %d ===============\n", (k+1));
		for(int i = 0; i < outRow; i++){
			for(int j = 0; j < outCol; j++){
				if(sw_result[i][j][k] != hw_result[i][j][k]){
					err++;
				}
//				cout << sw_result[i][j][k] << ":" << hw_result[i][j][k] << ", ";
			}
//			printf("\n");
		}
	}
	return 0;

}
