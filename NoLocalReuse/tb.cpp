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
/*

int main(){

	int Tr = 28, Tc = 28;
	int h=112,w=112,in=16, out=16;
	int ker_size = 3;
	int stride = 1;
	int out_h = divide_ceil(h, stride);
	int out_w = divide_ceil(w, stride);
	int out_Tr = divide_ceil(Tr, stride);
	int out_Tc = divide_ceil(Tc, stride);
	int padding = 1;
	data_t act[in][h][w];
	data_t weight[ker_size][ker_size][in][out];
	data_t ***output = newFMs(out, out_h, out_w);
	data_t ***hw_output = newFMs(out, out_h, out_w);

	// initialize activation
	for(int k = 0; k < in; k++){
		for(int i = 0; i < h; i++){
			for(int j = 0; j < w; j++){
				act[k][i][j] = i*w + j + 1;//;
			}
		}
	}

	// print activation
//	for(int k = 0; k < in; k++){
//		cout << "================ channel " << k+1 << " ===================" << endl;
//		for(int i = 0; i < h; i++){
//			for(int j = 0; j < w; j++){
//				cout << act[k][i][j] << ", ";
//			}
//			cout << endl;
//		}
//	}

	// initialize weight
	for(int k_in = 0; k_in < in; k_in++){
		for(int k_out = 0; k_out < out; k_out++){
			for(int i = 0; i < ker_size; i++){
				for(int j = 0 ; j < ker_size; j++){
					weight[i][j][k_in][k_out] = 1;//i * ker_size + j;
				}
			}
		}
	}

	// sw standard conv
	for(int i = 0; i < out_h; i++){
		for(int j = 0; j < out_w; j++){
			for(int k_out = 0; k_out < out; k_out++){
				psum_t partial_sum = 0;
				for(int k_in = 0; k_in < in; k_in++){
					for(int k_i = -1; k_i < ker_size-1; k_i++){
						for(int k_j = -1; k_j < ker_size-1; k_j++){
							if((i*stride+k_i >= 0 && j*stride+k_j >= 0) && (i*stride+k_i < h && j*stride+k_j < w)){
								partial_sum += weight[k_i+1][k_j+1][k_in][k_out]
											* act[k_in][i*stride+k_i][j*stride+k_j];
							}
						}
					}
				}
				output[i][j][k_out] = partial_sum;
//				cout << "i = " << i << ", j = " << j << ", k = " << k_out << endl;
			}
		}
	}

//	for(int k = 0; k < out; k++){
//		printf("================== channel %d ===============\n", (k+1));
//		for(int i = 0; i < out_h; i++){
//			for(int j = 0; j < out_w; j++){
//				cout << output[i][j][k] << ", ";
//			}
//			printf("\n");
//		}
//	}

	bool reset = false;
	int num_tile_c = divide_ceil(w, Tc);
	int num_tile_r = divide_ceil(h, Tr);
	int num_tile_in = divide_ceil(in, Ti);
	int num_tile_out = divide_ceil(out, To);

	// hardware buffer
	row_t<data_t, Ti> tile_wgt[KerSize][KerSize][To];
	row_t<data_t, Ti> tile_act[InSize][InSize];
	row_t<psum_t, To> tile_output[OutSize][OutSize];
	for(int i = 0; i < KerSize; i++){
		for(int j = 0; j < KerSize; j++){
			for(int k_out = 0; k_out < To; k_out++){
				row_t<data_t, Ti> word;
				for(int k_in = 0; k_in < Ti; k_in++){
					word.data[k_in] = 0;
				}
				tile_wgt[i][j][k_out] = word;
			}
		}
	}

	for(int i = 0; i < InSize; i++){
		for(int j = 0; j < InSize; j++){
			row_t<data_t, Ti> word;
			for(int k_in = 0; k_in < Ti; k_in++){
				word.data[k_in] = 0;
			}
			tile_act[i][j] = word;
		}
	}

	for(int i = 0; i < OutSize; i++){
		for(int j = 0; j < OutSize; j++){
			row_t<psum_t, To> word;
			for(int k_out = 0; k_out < To; k_out++){
				word.data[k_out] = 0;
			}
			tile_output[i][j] = word;
		}
	}

	// for the input FM, channel major
	// for the output FM, channel direction --> horizontal --> vertical
	for(int tile_r = 0; tile_r < num_tile_r; tile_r++){
		for(int tile_c = 0; tile_c < num_tile_c; tile_c++){
			cout << "=============== tile_r/num_tile_r = " << (tile_r+1) << "/" << num_tile_r << ", tile_c/num_tile_c = "<< (tile_c+1) << "/" << num_tile_c << " ============" << endl;
			int act_anchor_in_x = tile_c * stride * Tc - padding;
			int act_anchor_in_y = tile_r * stride * Tr - padding;
			for(int tile_out = 0; tile_out < num_tile_out; tile_out++){
				// compute for each output tile
				cout << "change tile: " << tile_out+1 << endl;
				int anchor_out = tile_out * To;
				for(int tile_in = 0; tile_in < num_tile_in; tile_in++){

					// load activation, channel major
					int anchor_in_z = tile_in * Ti;
					for(int i = 0; i < Tr+2*padding; i++){// tile spatial size with padding
						for(int j = 0; j < Tc+2*padding; j++){
							row_t<data_t, Ti> word;
							for(int k = 0; k < minimum(in, Ti); k++){
								if((act_anchor_in_x + j < 0 || act_anchor_in_y + i < 0) || (act_anchor_in_x + j >= w || act_anchor_in_y + i >= h)){
									word.data[k] = 0;
								}else{
									word.data[k] = act[anchor_in_z + k][act_anchor_in_y + i][act_anchor_in_x + j];
								}
							}
							tile_act[i][j] = word;
						}
					}

//					cout << " tile (" << tile_in << ", " << tile_r << ", " << tile_c << ")" << endl;
//					// print tile
//					for(int i = 0; i < Tr+2*padding; i++){
//						for(int j = 0; j < Tc+2*padding; j++){
//							cout << tile_act[i][j].data[0] << ", ";
//						}
//						cout << endl;
//					}

					// load weight, input channel major
					for(int too = 0; too < minimum(out,To); too++){
						for(int k1 = 0; k1 < ker_size; k1++){
							for(int k2 = 0; k2 < ker_size; k2++){
								row_t<data_t, Ti> wgt_word;
								for(int tii = 0; tii < minimum(in, Ti); tii++){
									wgt_word.data[tii] = weight[k1][k2][anchor_in_z+tii][anchor_out + too];
								}
								tile_wgt[k1][k2][too] = wgt_word;
							}
						}
					}

					DoCompute(tile_wgt, tile_act, tile_output,
							ker_size, ker_size, Tr, Tc, stride, reset);

				} // finish one output block

				// write output block to DRAM
				int act_anchor_out_x = tile_c * out_Tc;
				int act_anchor_our_y = tile_r * out_Tr;
				for(int i = 0; i < out_Tr; i++){
					for(int j = 0; j < out_Tc; j++){
						row_t<psum_t, To> out_word = tile_output[i][j];
						for(int too = 0; too < minimum(out,To); too++){
							hw_output[act_anchor_our_y + i][act_anchor_out_x + j][anchor_out + too] = out_word.data[too];
						}
					}
				}
				reset = true;
				// reset tile output buffer
				for(int i = 0; i < out_Tr; i++){
					for(int j = 0; j < out_Tc; j++){
						row_t<psum_t, To> out_word;
						for(int too = 0; too < minimum(out,To); too++){
							out_word.data[too] = 0;
						}
						tile_output[i][j] = out_word;
					}
				}
			}
		}
	}

	int err = 0;
	for(int k = 0; k < out; k++){
//		printf("================== channel %d ===============\n", (k+1));
		for(int i = 0; i < out_h; i++){
			for(int j = 0; j < out_w; j++){
				if(output[i][j][k] != hw_output[i][j][k]){
					err++;
				}
//				cout << output[i][j][k] << ":" << hw_output[i][j][k] << ", ";
//				cout << output[i][j][k] << ", ";
			}
//			printf("\n");
		}
	}
	return err;
}
*/


int main(){

	int Tr = InSize-2, Tc = InSize-2;
	int h=Tr,w=Tc,in=Ti, out=To;
	int ker_size = 3;
	int stride = 1;
	int out_h = divide_ceil(h, stride);
	int out_w = divide_ceil(w, stride);
	int out_Tr = divide_ceil(Tr, stride);
	int out_Tc = divide_ceil(Tc, stride);
	int padding = 1;
	data_t act[in][h][w];
	data_t weight[ker_size][ker_size][in][out];
	data_t ***sw_result = newFMs(out, out_h, out_w);
	data_t ***hw_result = newFMs(out, out_h, out_w);

	// initialize activation
	for(int k = 0; k < in; k++){
		for(int i = 0; i < h; i++){
			for(int j = 0; j < w; j++){
				act[k][i][j] = rand() % 256;//i*w + j + 1;//;
			}
		}
	}

	// print activation
//	for(int k = 0; k < in; k++){
//		cout << "================ channel " << k+1 << " ===================" << endl;
//		for(int i = 0; i < h; i++){
//			for(int j = 0; j < w; j++){
//				cout << act[k][i][j] << ", ";
//			}
//			cout << endl;
//		}
//	}

	// initialize weight
	for(int k_in = 0; k_in < in; k_in++){
		for(int k_out = 0; k_out < out; k_out++){
			for(int i = 0; i < ker_size; i++){
				for(int j = 0 ; j < ker_size; j++){
					weight[i][j][k_in][k_out] = rand() % 256;//i * ker_size + j;
				}
			}
		}
	}

	// sw standard conv
	for(int i = 0; i < out_h; i++){
		for(int j = 0; j < out_w; j++){
			for(int k_out = 0; k_out < out; k_out++){
				psum_t partial_sum = 0;
				for(int k_in = 0; k_in < in; k_in++){
					for(int k_i = -1; k_i < ker_size-1; k_i++){
						for(int k_j = -1; k_j < ker_size-1; k_j++){
							if((i*stride+k_i >= 0 && j*stride+k_j >= 0) && (i*stride+k_i < h && j*stride+k_j < w)){
								partial_sum += weight[k_i+1][k_j+1][k_in][k_out]
											* act[k_in][i*stride+k_i][j*stride+k_j];
							}
						}
					}
				}
				sw_result[i][j][k_out] = partial_sum;
//				cout << "i = " << i << ", j = " << j << ", k = " << k_out << endl;
			}
		}
	}

//	for(int k = 0; k < out; k++){
//		printf("================== channel %d ===============\n", (k+1));
//		for(int i = 0; i < out_h; i++){
//			for(int j = 0; j < out_w; j++){
//				cout << output[i][j][k] << ", ";
//			}
//			printf("\n");
//		}
//	}

	row_t<data_t, Ti> hw_input[h*w];
	row_t<data_t, Ti> hw_wgt[KerSize][KerSize][To];
	row_t<data_t, To> hw_output[out_h*out_w];

	for(int i = 0; i < h; i++){
		for(int j = 0; j < w; j++){
			for(int k = 0; k < Ti; k++){
				hw_input[i*w+j].data[k] = act[k][i][j];
			}
		}
	}

	for(int h = 0; h < To; h++){
		for(int i = 0; i < KerSize; i++){
			for(int j = 0; j < KerSize; j++){
				for(int k = 0; k < Ti; k++){
					hw_wgt[i][j][h].data[k] = weight[i][j][k][h];
				}
			}
		}
	}

	DoCompute(hw_input,hw_output,hw_wgt, Tr, Tc);

	row_t<data_t, To> out_word;
	for(int i = 0; i < out_h; i++){
		for(int j = 0; j < out_w; j++){
			out_word = hw_output[i*out_w + j];
			for(int k = 0; k < To; k++){
				hw_result[i][j][k] = out_word.data[k];
			}
		}
	}

	int err = 0;
	for(int k = 0; k < out; k++){
		printf("================== channel %d ===============\n", (k+1));
		for(int i = 0; i < out_h; i++){
			for(int j = 0; j < out_w; j++){
				if(sw_result[i][j][k] != hw_result[i][j][k]){
					err++;
				}
				cout << sw_result[i][j][k] << ":" << hw_result[i][j][k] << ", ";
//				cout << output[i][j][k] << ", ";
			}
			printf("\n");
		}
	}
	return err;

}
