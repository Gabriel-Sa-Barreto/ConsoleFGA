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

#define SWITCH_BASE 0x11020
#define BUTTONS_BASE 0x11030
#define DATA_A_COLOR 0x3fff1
#define OPCODE_SPRITE 0x50
#define OPCODE_SCREEN_CODE 0x2


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
	int instruction[32];    			 //vetor com o valor em binario da instrucao a ser enviada ao processador de video
	int offset[9] = {0,0,0,0,0,0,0,0,0}; //vetor de offset de memoria do sprite que sera utilizado
	int activeSprite[3] = {0,0,1};		 //vetor com o codigo binario que informa se o sprite esta ativo ou nao.
	int color = 0;				//variavel que armazena o valor decimal das cores do background
	int escolhaDaCor = 0;   	//variavel que define qual cor ira ser impressa como background
	int movSprite_x = 10;   	//variavel que armazena a coordenada x do sprite
	int movSprite_y = 200;  	//variavel que armazena a coordenada y do sprite
	int vetor_x[10] = {0,0,0,0,0,0,0,0,0,0}; //vetor com o valor em binario da coordenada x
	int vetor_y[10] = {0,0,0,0,0,0,0,0,0,0}; //vetor com o valor em binario da coordenada y
	int aux_concatenate[19]; 	//vetor auxiliar para preenchimento do vetor de instrucao
	int aux_concatenate_2[29];	//vetor auxiliar para preenchimento do vetor de instrucao
	unsigned long result = 0;   //valor decimal que corresponde a conversao do codigo binario da instrucao
	int refreshCoord = 0;       //variavel que armazena o valor dos pushbuttons lidos
	int instructionResult = 0;
	int direction = 0;
	//inicializacao do vetor de instrucao
	for (int i = 0; i < 32; i++)
	{
		instruction[i] = 0;
	}
	
	//Transforma a coordenada y decimal em binario
	DecimalToBinary(movSprite_y, vetor_y);

	//Concatenacao dos vetores de offset e coordenada y
	joinVetor(vetor_y, offset, aux_concatenate, 10, 9);

	/*int escolhaDaCor = 0; 
	int color = 0;
	char result[5] = {
		0x2320c800,
		0x2320c800, 
		0x2320c800,
		0x2320c800,
		0x2320c800,
	};
	int index = 0;*/
	while (1)
	{
		currentCode = ALT_CI_VIDEO_PROCESSOR_0(OPCODE_SCREEN_CODE,0);
		if(currentCode == 900){
			/*------Nenhum instrucao pode ser executada --tela em impressao--------*/
			/*----------Conversao dos valores para serem passados para o processsador de video---------*/
			//Transformar as coordenadas x e y decimais em binario
			DecimalToBinary(movSprite_x, vetor_x);
				
			//Concatenacao do vetor de offset e coordenada y com o vetor de coordenada x
			joinVetor(vetor_x, aux_concatenate, aux_concatenate_2, 10, 19);
			
			//concatenacao final para informar se o sprite esta ativo ou nao.
			joinVetor(activeSprite, aux_concatenate_2, instruction, 3, 29);

			//conversao do codigo binario da instrucao em um valor decimal
			result = BinaryToDec(instruction, 32);
			/*------------------------------------------------------------------------------------------*/
			//refreshCoord = IORD(BUTTONS_BASE,0);
			//leitura dos dip switches para mundaca do background da tela 
			escolhaDaCor = IORD(SWITCH_BASE,0);
			//usleep(200);
			//if(refreshCoord == 1){
			//	movSprite_x = movSprite_x + 3;
			//}else if(refreshCoord == 2){
			//	movSprite_x = movSprite_x - 3;
			//}
			/*----------Definicao da cor de background------------------*/
			switch(escolhaDaCor){
				case 0:
					color = 0;
					break;
				case 1:
					color = 23;
					break;
				case 2:
					color = 45;
					break;
				case 3:
					color = 456;
					break;
				case 4:
					color = 123;
					break;
				case 5:
					color = 380;
					break;
				case 6:
					color = 234;
					break;
				case 7:
					color = 100;
					break;
				default:
					color = 0;
					break;
			}
			/*------------------------------------------------------------*/
		}else{
			//a tela nao esta sendo impressa
			if(currentCode != lastCode) 
			{
				lastCode = currentCode;
				//um nova tela foi impressa
				/*-----------------Envio das instrucao para o processador-----------------------------------*/
				
				int retorno = ALT_CI_VIDEO_PROCESSOR_0(OPCODE_SPRITE,result);
				ALT_CI_VIDEO_PROCESSOR_0(DATA_A_COLOR,color);
				if(retorno == 950){
					if(direction == 1){
						movSprite_x = movSprite_x - 10;
					}else{
						movSprite_x = movSprite_x + 10;
					}

					if(movSprite_x == 620){
						direction = 1;
					}else if(movSprite_x == 0){
						direction = 0;
					}
				}
			}

		}	
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
