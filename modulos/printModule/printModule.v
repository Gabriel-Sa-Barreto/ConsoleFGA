/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: modulo responsavel por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	data_reg:    valor recebido do banco de registradores.
	data_memory: valor lido da memoria.
	active_area: sinal que informa se o monitor esta na area ativa ou nao.
	pixel_x:     coordenada x atual do monitor.
	pixel_y:     coordenada y atual do monitor.
SAIDAS:		 
	R, G e B:         saida das cores de um pixel a ser desenhado na tela.
	address_memory:   endereço a ser acessado na memoria.
	n_register:       numero do registrador a ser acessado no banco de registradores. 
   printtingScreeen: sinal de status do modulo de impressao. (1-imprimindo, 0-nao imprimindo)     
//////////////////////////////////////////////////////////////////////////
**/
module printModule(
	input wire clk,
	input wire [29:0] data_reg,
	input wire data_memory,
	input wire active_area,
	input wire [10:0] pixel_x,
	input wire  [9:0] pixel_y,
	
	output wire address_memory,
	output wire n_register,
	output reg [2:0] R,
	output reg [2:0] G,
	output reg [2:0] B,
	output reg printtingScreen
);

/*Registradores intermediarios*/
reg screen;
reg [2:0] colourR;
reg [2:0] colourG;
reg [2:0] colourB;

always @(posedge clk) begin
	if(pixel_x == 640 && pixel_y == 480 && !active_area) begin
		screen <= 0;   //nao esta mais imprimindo.
	end
	else screen <= 1; //esta imprimindo.
end

/*always no qual transfere os novos valores dos registradores
intermediarios para os registradores de saida.*/ 
always @(posedge clk) begin
	printtingScreen <= screen;
	        colourR <= R;
	        colourG <= G;
	        colourB <= B;
end







endmodule