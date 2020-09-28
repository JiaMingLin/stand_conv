#include<stdio.h>
#include<iostream>
#include<ap_int.h>
#include<ap_fixed.h>
#include<hls_stream.h>
#include <stdint.h>
#include <math.h>

using namespace std;
using namespace hls;

//#define CSIM_FLAG


#define DATAWIDTH 128
#define PRECISION 8
#define WORD_LENGTH DATAWIDTH/PRECISION

#ifdef CSIM_FLAG
#define MAX_TILE_OUT_HEIGHT 3
#define MAX_TILE_OUT_WIDTH 3

#else
#define MAX_TILE_OUT_HEIGHT 8
#define MAX_TILE_OUT_WIDTH 8
#endif

#define TEST_INDIM 12

#define MAX_STRIDE 2
#define MAX_KERNEL_SIZE 3
#define MAX_TILE_IN_HEIGHT MAX_TILE_OUT_HEIGHT*MAX_STRIDE + (MAX_KERNEL_SIZE-MAX_STRIDE)
#define MAX_TILE_IN_WIDTH MAX_TILE_OUT_WIDTH*MAX_STRIDE + (MAX_KERNEL_SIZE-MAX_STRIDE)
#define To 16 // output channel
#define Ti 16 // input channel

#define WGT_CHUNK_NUM 1
#define HARDCODE_VAL 1

typedef ap_uint<PRECISION> data_t;
typedef ap_uint<32> psum_t;
//typedef ap_fixed<PRECISION, 5> data_t;
//typedef ap_fixed<2*PRECISION, 8> psum_t;

//typedef float data_t;
//typedef float psum_t;

/*
 * block data
 */
template<typename T, unsigned WIDTH>
struct row_t{
	T data[WIDTH];
};

template<typename T, unsigned HEIGHT, unsigned WIDTH>
struct block_t{
	T data[HEIGHT][WIDTH];
};

void DoCompute(
		row_t<data_t, Ti> *input,
		row_t<data_t, To> *output,
		row_t<data_t, Ti> *raw_wgt,
		int inRow, int inCol,
		int Tr, int Tc, int ker_size, int stride, int test);

void Conv(
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		row_t<psum_t, To> output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH],
		int k1, int k2, int Tr, int Tc, int stride);

void LoadActivation(
		row_t<data_t, Ti> *input,
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		int inRow, int inCol,
		int Tr, int Tc, int tidY, int tidX,
		int inTr, int inTc,
		int padding);

void LoadWeight(
		row_t<data_t, Ti> *raw_wgt,
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		int ker_size,
		int test);

void WriteOutput(
		row_t<data_t, To> *output,
		row_t<data_t, Ti> wgt[MAX_KERNEL_SIZE][MAX_KERNEL_SIZE][To],
		row_t<data_t, Ti> act[MAX_TILE_IN_HEIGHT][MAX_TILE_IN_WIDTH],
		row_t<psum_t, To> psum_output[MAX_TILE_OUT_HEIGHT][MAX_TILE_OUT_WIDTH],
		int inRow, int inCol,
		int tidY, int tidX,
		int Tr, int Tc, int ker_size, int stride,
		int test);

inline
int divide_ceil(int divident, int divisor){
	if(divident < divisor){
		return 1;
	}
	return (divident%divisor == 0)?divident/divisor: (divident+1)/divisor;
}
inline
int minimum(int a, int b){
	if(a >= b){
		return b;
	}
	return a;
}


template<typename T, unsigned ker_size, unsigned ti, unsigned to>
void wgt_buff_monitor(row_t<T, ti> buff[ker_size][ker_size][to]){
	for(int o = 0; o < to; o++){
		cout << "filter id = " << o << endl;
		for(int kx = 0; kx < ker_size; kx++){
			for(int ky = 0; ky < ker_size; ky++){
				for(int i = 0; i < ti; i++){
					cout << buff[ky][kx][o].data[i] << ", ";
				}
				cout << endl;
			}
		}
	}

}


template<typename T, unsigned word_len, unsigned height, unsigned width>
void buff_monitor_3D(row_t<T, word_len> buff[height][width]){
	for(int k = 0; k < word_len; k++){
		cout << "========= channel: " << k+1 << " ============" << endl;
		for(int i = 0 ; i < height; i++){
			for(int j = 0; j < width; j++){
				cout << buff[i][j].data[k] << ", ";
			}
			cout << endl;
		}
	}
}

template<typename T, unsigned width, unsigned depth>
void buff_monitor_2D(row_t<T, width>buff[depth]){
	for(int i = 0; i < depth; i++){
		for(int j = 0; j < width; j++){
			cout << buff[i].data[j] << ", ";
		}
		cout << endl;
	}
}

template<typename T, unsigned depth>
void buff_monitor_1D(T buff[depth]){
	for(int i = 0; i < depth; i++){
		cout << buff[i] << ", ";
	}
	cout << endl;
}

template<typename T, unsigned H, unsigned W, unsigned C>
void InitTensor(row_t<T, C> tensor[H][W]){
	row_t<T, C> word;
	for(int k = 0; k < C; k++){
#pragma HLS UNROLL
		word.data[k] = 0;
	}

	for(int i = 0; i < H; i++){
		for(int j = 0; j < W; j++){
#pragma HLS PIPELINE
			tensor[i][j] = word;
		}
	}
}
