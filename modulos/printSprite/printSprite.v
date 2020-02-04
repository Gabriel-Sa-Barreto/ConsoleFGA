
/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: modulo responsável por gerenciar o cálculo de endereço de acesso à memória para determinação
das cores de cada pixel da área ativa do vídeo.
--------------------------------------------------------------------------
ENTRADAS: 
    clk------------------Pulso de clock da FPGA (50 MHz)
	dataReg--------------valores de offset de sprites vindos do banco de registradores.
	x--------------------valor de coordenada x atual do monitor de vídeo.
	y--------------------valor de coordenada y atual do monitor de vídeo.
	active_area----------sinal de área ativa do monitor.	 		 

SAIDAS:		 
    checkValue-----------x e y a ser comparado com valores armazenados no banco de registradores. 
	printtingScreen------registro do status do módulo (ocioso, imprimindo).
	addressMemory--------endereço de acesso à memória de sprites.
//////////////////////////////////////////////////////////////////////////
**/

module printSprite(
	input  wire        clk,                     
	input  wire        dataReg,     
	input  wire        x,                        
	input  wire        y, 
	input  wire        active_area,                       
	output wire [19:0] checkValue,         
	output wire [16:0] addressMemory,
	output  reg        printtingScreen,

);

parameter [16:0] addressBackground = 17'd115200;

always @(active_area) begin
	if(active_area) begin
		//redireciona as coordenadas x e y para comparação.
		checkValue[9:0]   = y;
		checkValue[19:10] = x; 
	end
end



























endmodule