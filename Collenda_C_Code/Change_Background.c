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
#define CHECK_PRINT_BASE 0x11050
#define SWITCHCOR_BASE 0x11040

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
	int escolha = 0;
	char cor = 0x00;
	while(1){
		if(IORD(CHECK_PRINT_BASE,0) == 0){//The screen doen't been drawn
			ALT_CI_VIDEO_PROCESSOR_0(OPCODE, cor); //instruction to change the background color.
		}else{
			escolha = IORD(SWITCHCOR_BASE,0);
			usleep(1000);
			if(escolha == 0){ cor = 0x12; }
			else if(escolha == 1){ cor = 0x70; }
			else if(escolha == 2){ cor = 0x20; }
			else if(escolha == 3){ cor = 0x98; }
			else if(escolha == 4){ cor = 0x90; }
			else if(escolha == 5){ cor = 0x34; }
			else if(escolha == 6){ cor = 0x01; }
		}
	}
}
