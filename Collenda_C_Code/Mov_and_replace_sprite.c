/*
///////////////////////////////////////////////////////////////////////////////////
Author: Gabriel Sá Barreto Alves
Date: 16/07/2020
Description: This code performs a test of replace in screen background of the VGA monitor.
///////////////////////////////////////////////////////////////////////////////////
*/
#include "sys/alt_stdio.h"
#include "system.h"
#include <unistd.h>
#include "stdio.h"
#include "altera_avalon_pio_regs.h" //Libary to read values of input
#include <stdlib.h>
#include <string.h>
#include<math.h>

#define OPCODE 0x50  //Opcode of the instruction to change sprite coordenates
#define CHECK_PRINT_BASE 0x11050
#define BUTTONMOV_BASE 0x11030
#define SWITCHCOR_BASE 0x11040


/*

50 = 0000110010
430 = 0110101110
590 = 1001001110
320 = 0101000000
240 = 0011110000

*/

//coodenadas: x = 50, y = 50;     valor = 0x21906400 error
//coodenadas: x = 50, y = 430;    valor = 0x21935c00 error
//coodenadas: x = 590, y = 50;    valor = 0x32706400 error
//coodenadas: x = 590, y = 430;   valor = 0x32735c00
//coodenadas: x = 320, y = 240;   valor = 0x2a01e000 centro



unsigned long coordenatesFunction(int x, int y, char *offset);
char * DecimalToBinary(int number);
unsigned long BinaryToDec(char *valueBin);
//char * BinaryToHexa(char *valueBin);

int main(){
	alt_putstr("It's Working!!");
	//instruction that receive the binary or hexadeciamal code of the action that
	//need realize.
	//Refresh coordenate of a sprite:
	//Function Format:
		//Parameter A:
			//A[3:0]   = Opcode == 0000
			//A[8:4]   = register
		//Parameter B: = value to written (new coordenate)

	//Example:
		//Parameter A:  ==
		//Parameter B:
	//int coordenate_x = 0;
	//int coordenate_y = 0;
	int pushbutton   = 0;
	unsigned long result = 0;
	char *value = malloc(32*sizeof(char));
	value = "000000000";
	while(1){
		if(IORD(CHECK_PRINT_BASE,0) == 0 && result != 0){ //The screen doesn't been drawn.
			ALT_CI_VIDEO_PROCESSOR_0(OPCODE, result);
		}else{
			pushbutton = IORD(BUTTONMOV_BASE,0);
			usleep(1000);
			result = coordenatesFunction(300,300,value);
			printf("Result: %d", result);
		}
	}
}

unsigned long coordenatesFunction(int x, int y, char *offset){
	char *x_coordenate = DecimalToBinary(x);
	char *y_coordenate = DecimalToBinary(y);
	char *value = malloc(32*sizeof(char));

	//Joins the binary values.
	strcat(value, "0001"); //Bit to active sprite
	strcat(value, x_coordenate);
	strcat(value, y_coordenate);
	strcat(value, offset); //Offset's sprite

	//BinaryToHexa(value);
	return BinaryToDec(value);
}


char * DecimalToBinary(int number){
	char *result;
	result = malloc(10*sizeof(char));

	int index = 10; //Last Position
	while(number > 0){
		result[index] = number % 2;
		number = number / 2;
		if(index == 0){
			break;
		}
		index--;
	}
	return result;
}

unsigned long BinaryToDec(char *valueBin){
	char bin[32];
    unsigned long dec = 0;
    int i = 0;
    int s;
    s = strlen( valueBin );
    while( s-- ) {
        if( bin[s] == '0' || bin[s] == '1' ) {
            dec = dec + pow(2, i++) * (bin[s] - '0');
        }
    };
}
/*char * BinaryToHexa(char *valueBin){
	char *result = malloc(8*sizeof(char));
	char *hexa   = malloc(4*sizeof(char));
	result = "0x";
	int aux_add = 4;
	int counter = 0;
	for (int i = 0; i < 32; i = i + aux_add){
		for (int j = i; j < (i+aux_add) ; j++){
			hexa[counter] = valueBin[j];
		}
		counter = 0;
		if( strcpy(hexa,"0000") == 0)       strcat(result,"0")//0
		else if( strcmp(hexa,"0001") == 0); strcat(result,"1")//1
		else if( strcmp(hexa,"0010") == 0); strcat(result,"2")//2
		else if( strcmp(hexa,"0011") == 0); strcat(result,"3")//3
		else if( strcmp(hexa,"0100") == 0); strcat(result,"4")//4
		else if( strcmp(hexa,"0101") == 0); strcat(result,"5")//5
		else if( strcmp(hexa,"0110") == 0); strcat(result,"6")//6
		else if( strcmp(hexa,"0111") == 0); strcat(result,"7")//7
		else if( strcmp(hexa,"1000") == 0); strcat(result,"8")//8
		else if( strcmp(hexa,"1001") == 0); strcat(result,"9")//9
		else if( strcmp(hexa,"1010") == 0); strcat(result,"a")//A
		else if( strcmp(hexa,"1011") == 0); strcat(result,"b")//B
		else if( strcmp(hexa,"1100") == 0); strcat(result,"c")//C
		else if( strcmp(hexa,"1101") == 0); strcat(result,"d")//D
		else if( strcmp(hexa,"1110") == 0); strcat(result,"e")//E
		else if( strcmp(hexa,"1111") == 0); strcat(result,"f")//F
	}
	return result;
}
*/
