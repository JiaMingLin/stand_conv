#include <stdio.h>
#include <stdint.h>
#include <math.h>

typedef uint8_t data_t;


void ReadRandIFM(){
  
  data_t arr[12][12][16];
  char buff[2304];
  FILE *latfile;

  sprintf(buff,"%s","random_ifm.dat");
  latfile=fopen(buff,"r");
  fread(&(arr[0][0][0]),sizeof(data_t),2304,latfile);
  fclose(latfile);

  for(int k = 0; k < 16; k++){
    printf("Channel index = %d \n", k);
    for(int i = 0; i < 12; i++){
      for(int j = 0; j < 12; j++){
        printf("%d, ", arr[i][j][k]);
      }
      printf("\n");
    }
    printf("\n"); 
  }
}

void ReadRandWGT(){
  data_t arr[3][3][16][16];
  char buff[2304];
  FILE *latfile;

  sprintf(buff,"%s","random_wgt.dat");
  latfile=fopen(buff,"r");
  fread(&(arr[0][0][0][0]),sizeof(data_t),2304,latfile);
  fclose(latfile);

  for(int o = 0; o < 16; o++){
    printf("filter index = %d \n", o);
    for(int ky = 0; ky < 3; ky++){
      for(int kx = 0; kx < 3; kx++){
        for(int i = 0; i < 16; i++){
          printf("%d, ", arr[ky][kx][o][i]);
        }
        printf("\n");
      }
    }
    printf("\n");
  }
}

int main()
{
  /* later changed 'double' to 'int', but that still had issues */
  ReadRandIFM();
  ReadRandWGT();
  return 0;
}