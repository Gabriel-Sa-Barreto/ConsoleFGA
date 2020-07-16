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

#define OPCODE 0x3fff1  //Opcode of the instruction to written in memory.
#define CHECK_PRINT_BASE 0x11030

void changeBackgroundColor(char dataA, char dataB); //Function to change background color

int main(){
	alt_putstr("It's Working!!");
	//instruction that receive the binary or hexadeciamal code of the action that 
	//need realize.  
	//Written in memory:
	//Function Format: 
		//Parameter A: 
			//A[3:0]   = Opcode == 0001
			//A[4:17]  = Address to written in memory
		//Parameter B: = value to written
		//Obs: Every word of memory support only 9 bits. Each address correspond to one word.  
	
	//The color that corresponds to background screen is located in position:
	//Decimal: 16383;
	//Binary:  11111111111111
	//Hexadecimal: 3fff

	//Example:
		//Parameter A: 111111111111110001 == 3fff1
		//Parameter B: 000111000  - Green
	while(1){
		usleep(3000000); // Wait for more than 1 second = 3x10⁶ microseconds
		changeBackgroundColor(OPCODE,0x38)
		usleep(3000000); // Wait for more than 1 second = 3x10⁶ microseconds
		changeBackgroundColor(OPCODE,0x45)
		usleep(3000000); // Wait for more than 1 second = 3x10⁶ microseconds
		changeBackgroundColor(OPCODE,0x24)
	}
}

void changeBackgroundColor(char dataA, char dataB){
	bool check = false;
	while(!check){
		if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
			ALT_CI_VIDEO_PROCESSOR_0(dataA, dataB);
			check = true;
		}
	}
}