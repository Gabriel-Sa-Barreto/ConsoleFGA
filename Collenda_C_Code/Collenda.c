#include "stdio.h"
#include <stdbool.h>
#include "io.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#define MASK_X 0b00000000000100000000000000000000
#define MASK_Y 0b00000000000000000000011000000000
#define DATA_B_BASE 0x11050
#define DATA_A_BASE 0x11060
#define PRINTTING_BASE 0x11040

int main(){
	//y = 50
	unsigned long dataB_sp_1 = 0b01100001000100000110010000000000;
	unsigned long dataA_sp_1 = 0b00000000000001000000000001010000;

	//y = 100
	unsigned long dataB_sp_2 = 0b01100001000100001100100000000000;
	unsigned long dataA_sp_2 = 0b00000000000001000000000001100000;

	//y = 200
	unsigned long dataB_sp_3 = 0b01100001000100011001000000000000;
	unsigned long dataA_sp_3 = 0b00000000000001000000000001110000;

	//y = 300
	unsigned long dataB_sp_4 = 0b01100001000100100101100000000000;
	unsigned long dataA_sp_4 = 0b00000000000001000000000010000000;

	//y = 400
	unsigned long dataB_sp_5 = 0b01100001000100110010000000000000;
	unsigned long dataA_sp_5 = 0b00000000000001000000000010010000;

	//unsigned long dataB_back = 0b01000000000000000000000101000111;
	//unsigned long dataA_back = 0b00000000000001111111111111110001;
	int counter = 0;
	bool refreshed = false;

	while(counter < 280)
	{
		if(IORD(PRINTTING_BASE,0) == 0)
		{
			if(refreshed == false)
			{
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_1);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_1);

				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_2);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_2);

				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_5);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_5);

				dataB_sp_1 = dataB_sp_1 + MASK_X;
				dataB_sp_2 = dataB_sp_2 + MASK_X;
				dataB_sp_5 = dataB_sp_5 + MASK_X;
				counter++;
				refreshed = true;
			}
		}else
		{
			refreshed = false;
		}
	}
	counter = 0;
	while(counter < 280)
	{
		if(IORD(PRINTTING_BASE,0) == 0)
		{
			if(refreshed == false)
			{
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_1);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_1);

				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_2);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_2);

				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE, dataA_sp_5);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE, dataB_sp_5);

				dataB_sp_1 = dataB_sp_1 - MASK_X;
				dataB_sp_2 = dataB_sp_2 - MASK_X;
				dataB_sp_5 = dataB_sp_5 - MASK_X;
				counter++;
				refreshed = true;
			}
		}else
		{
			refreshed = false;
		}
	}
}
