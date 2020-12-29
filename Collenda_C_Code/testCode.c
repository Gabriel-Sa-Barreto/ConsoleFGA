#include "stdio.h"
#define MASK_X 0b0000000000110000000000000000000
#define MASK_Y 0b0000000000000000000011000000000

int main(){
	unsigned long dataB = 0b01100000000000001100100000000000;
	unsigned long dataA = 0b00000000000001000000000001010000;
	int counter = 0;
	while(counter < 500)
	{
		printf("%d - Value: %lu\n",counter,dataB);
		dataB+= MASK_X;
		counter++;
	}
}
