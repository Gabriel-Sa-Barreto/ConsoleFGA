 /*
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#include "io.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"

#define PRINTTING_BASE 0x11040
#define SWITCH_BASE 0x11070
#define DATA_B_BASE 0x11050
#define DATA_A_BASE 0x11060

#define DATA_A_COLOR 0x7fff1
#define OPCODE_SPRITE 0x40050

//Procedimento que transforma um valor decimal em binario
void DecimalToBinary(int, int[]);

//Procedimento que concatena dois vetores de inteiros
void joinVetor(int[], int[], int[], int, int);

//Funcao que converte um vetor binario em um valor decimnal
unsigned long BinaryToDec( int[], int);

int lastCode    = 0;
int currentCode = 0;

int main()
{ 
	alt_putstr("Hello From Collenda!\n");
	/*int instruction[32];    			 	 //vetor com o valor em binario da instrucao a ser enviada ao processador de video
	int offset[9] = {0,0,0,0,0,0,0,0,0}; 	 //vetor de offset de memoria do sprite que sera utilizado
	int activeSprite[3] = {0,1,1};		 	 //vetor com o codigo binario que informa se o sprite esta ativo ou nao.
	long color = 0;							 //variavel que armazena o valor decimal das cores do background
	int escolhaDaCor = 00;   				 //variavel que define qual cor ira ser impressa como background
	int movSprite_x = 50;   				 //variavel que armazena a coordenada x do sprite
	int movSprite_y = 200;  				 //variavel que armazena a coordenada y do sprite
	int vetor_x[10] = {0,0,0,0,0,0,0,0,0,0}; //vetor com o valor em binario da coordenada x
	int vetor_y[10] = {0,0,0,0,0,0,0,0,0,0}; //vetor com o valor em binario da coordenada y
	int aux_concatenate[19]; 				 //vetor auxiliar para preenchimento do vetor de instrucao
	int aux_concatenate_2[29];				 //vetor auxiliar para preenchimento do vetor de instrucao
	unsigned long result = 0;   			 //valor decimal que corresponde a conversao do codigo binario da instrucao
	//int refreshCoord = 0;       			//variavel que armazena o valor dos pushbuttons lidos
	int instructionResult = 0;
	int direction = 1;
	//inicializacao do vetor de instrucao
	for (int i = 0; i < 32; i++)
	{
		instruction[i] = 0;
	}
	
	//Transforma a coordenada y decimal em binario
	DecimalToBinary(movSprite_y, vetor_y);

	//Concatenacao dos vetores de offset e coordenada y
	joinVetor(vetor_y, offset, aux_concatenate, 10, 9);

	//Transformar as coordenadas x e y decimais em binario
	DecimalToBinary(movSprite_x, vetor_x);
				
	//Concatenacao do vetor de offset e coordenada y com o vetor de coordenada x
	joinVetor(vetor_x, aux_concatenate, aux_concatenate_2, 10, 19);
			
	//concatenacao final para informar se o sprite esta ativo ou nao.
	joinVetor(activeSprite, aux_concatenate_2, instruction, 3, 29);
			
	//conversao do codigo binario da instrucao em um valor decimal
	result = BinaryToDec(instruction, 32);
	*/
	char color = 0;
	int escolhaDaCor = 0;  
	int contagem = 0;
	int index = 0;
	while (1)
	{
		//leitura dos dip switches para mundaca do background da tela 
		escolhaDaCor = IORD(SWITCH_BASE,0);
		/*----------Definicao da cor de background------------------*/
		switch(escolhaDaCor)
		{
			case 0:
				color = 0x40000155;
				break;
			case 1:
				color = 0x40000155;
				break;
			case 2:
				color = 0x400001d7;
				break;
			default:
				color = 0x40000000;
				break;
		}

			//definicao da direcao do movimento do sprite e mudanca no valor da coordenada x.
			
			/*----------Conversao dos valores para serem passados para o processsador de video---------*/
			//Transformar as coordenadas x e y decimais em binario
			//DecimalToBinary(movSprite_x, vetor_x);
				
			//Concatenacao do vetor de offset e coordenada y com o vetor de coordenada x
			//joinVetor(vetor_x, aux_concatenate, aux_concatenate_2, 10, 19);
			
			//concatenacao final para informar se o sprite esta ativo ou nao.
			//joinVetor(activeSprite, aux_concatenate_2, instruction, 3, 29);
			
			//conversao do codigo binario da instrucao em um valor decimal
			//result = BinaryToDec(instruction, 32);
			/*------------------------------------------------------------------------------------------*/
			/*---------Atualizacao da coordenada do sprite em uso---------*/
			if( IORD(PRINTTING_BASE,0) == 0) 
			{
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE,DATA_A_COLOR);
				IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE,color);
			}
			/*------------------------------------------------------*/

		/*---------Mudanca na cor de background da tela---------*/
		//IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE,DATA_A_COLOR);
		//usleep(20);
		//IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE,color);
		//usleep(40);
		/*------------------------------------------------------*/
	}
	return 0;
}

/*
Procedimento que concatena dois vetores de inteiros.
PARAMETROS:
	* vetor_1 e vetor_2: vetores a serem concatenados.
	* vetor_3: vetor no qual a concatenacao sera realizada.
	* size_1:  valor maximo de posicoes do vetor 1
	* size_2:  valor maximo de posicoes do vetor 2
*/
void joinVetor(int vetor_1[], int vetor_2[], int vetor_3[], int size_1, int size_2)
{
	//Variavel de posicao do vetor que armazena o valor da concatenacao.
	int i = 0;
	//Loop para copiar o primeiro vetor.
	for (i = 0; i < size_1; i++)
	{
		vetor_3[i] = vetor_1[i];
	}

	//Loop para copiar o segundo vetor.
	for (int index = 0; index < size_2; index++)
	{
		vetor_3[i] = vetor_2[index];
		i++;
	}
}


/*
Procedimento que transforma um valor decimal em binario.
PARAMETROS:
	* number: valor a ser convertido
	* values: vetor no qual os valores de 0 e 1 serao inseridos
*/
void DecimalToBinary(int number, int values[])
{
	int index = 9;
	while(number > 0)
	{
		values[index] = number % 2;
		number = number/2;
		if(number == 0 || number == 1)
		{
			values[index - 1] = number;
			break;
		}
		index--;
	}
}

unsigned long BinaryToDec(int valueBin[], int sizeBin){
    unsigned long dec = 0;
    int i = 0;
    int s;
    s = sizeBin;
    while( s-- ) {
        if( valueBin[s] == 0 || valueBin[s] == 1 ) {
            dec = dec + pow(2, i++) * (valueBin[s] - 0);
        }
        if(s == 0){
        	break;
        }
    };

    return dec;
}
