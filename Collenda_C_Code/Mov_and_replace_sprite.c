/*
///////////////////////////////////////////////////////////////////////////////////
Author: Gabriel Sá Barreto Alves
Date: 16/07/2020
Description:
///////////////////////////////////////////////////////////////////////////////////
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#include "io.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"

#define CHECK_PRINT_BASE 0x11050



/*

50 = 0000110010
430 = 0110101110
590 = 1001001110
320 = 0101000000
240 = 0011110000
100 = 0001100100

*/
//Teste com NIOS:
//coodenadas: x = 50, y = 50;     valor = 0x21906400        - ok
//coodenadas: x = 50, y = 430;    valor = 0x21935c00        - ok 
//coodenadas: x = 590, y = 50;    valor = 0x32706400        - ok
//coodenadas: x = 590, y = 430;   valor = 0x32735c00        - ok  
//coodenadas: x = 320, y = 240;   valor = 0x2a01e000 centro - ok  

//Teste Sem NIOS:
//coodenadas: x = 50, y = 50;     valor = 0x21906400        -  OK
//coodenadas: x = 50, y = 430;    valor = 0x21935c00        -  OK
//coodenadas: x = 590, y = 50;    valor = 0x32706400        -  OK  
//coodenadas: x = 590, y = 430;   valor = 0x32735c00        -  OK
//coodenadas: x = 320, y = 240;   valor = 0x2a01e000 centro -  OK
//coodenadas: x = 100, y = 100;   valor = 0x2320c800        -  OK





int activeSprite[3] = {0,0,1};
//unsigned long coordenatesFunction(int x, int y, char *offset);

//Procedimento que transforma um valor decimal em binário
void DecimalToBinary(int, int[]);

//Procedimento que concatena dois vetores de inteiros
void joinVetor(int[], int[], int[], int, int);

//Função que converte um vetor binario em um valor decimnal
unsigned long BinaryToDec( int[], int);


int main(){
	int offset[9] = {0,0,0,0,0,0,0,0,0};

	//vetor com o binário da instrução a ser executada no processador de video.
	int instruction[32];

	//inicializar o vetor de instrução
	for (int i = 0; i < 32; i++)
	{
		instruction[i] = 0;
	}

	//vetor com opcode da instrução e numero do registrador em que o sprite se encontra.
	//int opcode_and_register[9] = {0,0,1,0,1,0,0,0,0};

	//variável para valor da coordenada x do sprite
	int x_coordenate = 320;

	//variável para valor da coordenada y do sprite
	int y_coordenate = 240;

	//vetor com o valor em binario da coordenada x
	int vetor_x[10] = {0,0,0,0,0,0,0,0,0,0};

	//vetor com o valor em binario da coordenada y
	int vetor_y[10] = {0,0,0,0,0,0,0,0,0,0};

	//Transformar as coordenadas x e y decimais em binário
	DecimalToBinary(x_coordenate, vetor_x);
	DecimalToBinary(y_coordenate, vetor_y);
	//----------------------------------------------------
	printf("Active/Disable:");
	for (int i = 0; i < 3; i++)
	{
		printf("%d", activeSprite[i]);
	}
	printf("\n");

	printf("Offset:");
	for (int i = 0; i < 9; i++)
	{
		printf("%d", offset[i]);
	}
	printf("\n");

	printf("Y:");
	for (int i = 0; i < 10; i++)
	{
		printf("%d", vetor_y[i]);
	}
	printf("\n");

	printf("X:");
	for (int i = 0; i < 10; i++)
	{
		printf("%d", vetor_x[i]);
	}
	printf("\n");

	int aux_concatenate[19];
	//Concatenação dos vetores de offset e coordenada y
	joinVetor(vetor_y, offset, aux_concatenate, 10, 9);

	int aux_concatenate_2[29];
	//Concatenação do vetor de offset e coordenada y com o vetor de coordenada x
	joinVetor(vetor_x, aux_concatenate, aux_concatenate_2, 10, 19);

	//concatenação final para informar se o sprite está ativo ou não.
	joinVetor(activeSprite, aux_concatenate_2, instruction, 3, 29);

	printf("Concatenacao:");
	for (int i = 0; i < 32; i++)
	{
		printf("%d", instruction[i]);
	}
	printf("\n");

	unsigned long result = BinaryToDec(instruction, 32);
	printf("Result: %lu\n", result);

	while(1){
		if(IORD(CHECK_PRINT_BASE,0) == 0){
			ALT_CI_VIDEO_PROCESSOR_0(0x50, result );
		}
		usleep(200);
	}

}

/*
Procedimento que concatena dois vetores de inteiros.
PARAMETROS:
	* vetor_1 e vetor_2: vetores a serem concatenados.
	* vetor_3: vetor no qual a concatenação será realizada.
	* size_1:  valor máximo de posições do vetor 1
	* size_2:  valor máximo de posições do vetor 2
*/
void joinVetor(int vetor_1[], int vetor_2[], int vetor_3[], int size_1, int size_2)
{
	//Variável de posição do vetor que armazena o valor da concatenação.
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
Procedimento que transforma um valor decimal em binário.
PARAMETROS:
	* number: valor a ser convertido
	* values: vetor no qual os valores de 0 e 1 serão inseridos
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
