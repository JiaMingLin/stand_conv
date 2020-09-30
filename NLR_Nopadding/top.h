#include<stdio.h>
#include<iostream>
#include<ap_int.h>
#include<ap_fixed.h>
#include<hls_stream.h>

using namespace std;
using namespace hls;

#define CSIM_FLAG


#define DATAWIDTH 128
#define PRECISION 8
#define WORD_LENGTH DATAWIDTH/PRECISION

#ifdef CSIM_FLAG
#define InSize 6
#define OutSize 6
#define To 64 // output channel
#define Ti 64 // input channel
#else

#define InSize 30
#define OutSize 30
#define To 16 // output channel
#define Ti 16 // input channel
#endif


#define KerSize 7
#define WGT_CHUNK_NUM 1

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
		int Tr, int Tc, int ker_size, int test);

void Conv(
		row_t<data_t, Ti> wgt[KerSize][KerSize][To],
		row_t<data_t, Ti> act[InSize][InSize],
		row_t<psum_t, To> output[OutSize][OutSize],
		int k1, int k2, int Tr, int Tc, int stride, bool reset
);

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
