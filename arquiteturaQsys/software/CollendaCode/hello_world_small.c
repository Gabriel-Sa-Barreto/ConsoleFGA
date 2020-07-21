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
#define SWITCHCOR_BASE 0x11030

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
	while(1){
		escolha = IORD(SWITCHCOR_BASE,0);
		usleep(10000);
		if(escolha == 0){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x12);
			}
		}else if(escolha == 1){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x80);
			}
		}else if(escolha == 2){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x30);
			}
		}else if(escolha == 3){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x45);
			}
		}else if(escolha == 4){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x00);
			}
		}else if(escolha == 5){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x10);
			}
		}else if(escolha == 6){
			if(IORD(CHECK_PRINT_BASE,0) == 0){ //The screen doesn't been drawn.
				ALT_CI_VIDEO_PROCESSOR_0(0x3fff1, 0x78);
			}
		}
	}
}
