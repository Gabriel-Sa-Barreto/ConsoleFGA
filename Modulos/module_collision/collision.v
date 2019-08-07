module collision(
	input wire clk,
	input wire reset,

	input wire [10:0] main_x, //coordenada x do sprite principal
	input wire  [9:0] main_y, //coordenada y do sprite principal

	input wire [10:0] x1,
	input wire [9:0]  y1,

	input wire [10:0] x2,
	input wire [9:0]  y2,

	input wire [10:0] x3,
	input wire [9:0]  y3,

	input wire [10:0] x4,
	input wire [9:0]  y4,

	output wire collision,
	output wire [1:0] sprite_collision
);

/*parametro local que informa o tamanho dos sprites*/
localparam size = 25;

/*-----variaveis de armazenamento de coordenadas dos sprites-----------*/
reg [10:0]  main_x0;
reg [10:0]  s_x1;
reg [10:0]  s_x2;
reg [10:0]  s_x3;
reg [10:0]  s_x4;

reg [9:0]  main_y0;
reg [9:0]   s_y1;
reg [9:0]   s_y2;
reg [9:0]   s_y3;
reg [9:0]   s_y4;
/*----------------------------------------------------------------------*/

/*--------Variáveis que armazenam a saída do módulo---------------------*/
reg out_collision;
reg [1:0] out_sprite;
/*-----------------------------------------------------------------------*/


/*Entrada de seleçao do multiplexador*/
wire [1:0] selector;

wire [10:0]  wire_m_x0;
wire [10:0]  wire_m_y0;

/*------Fios que ligam os registradores ao multiplexador-------------*/
wire [10:0]  wire_s_x1;
wire [10:0]  wire_s_x2;
wire [10:0]  wire_s_x3;
wire [10:0]  wire_s_x4;

wire [9:0]   wire_s_y1;
wire [9:0]   wire_s_y2;
wire [9:0]   wire_s_y3;
wire [9:0]  wire_s_y4;
/*-------------------------------------------------------------------*/

/*-----Saída do multiplexador (coordenadas selecionadas para verificação de colisão)-------------*/
wire [10:0]  out_x;
wire [9:0]   out_y;
/*-----------------------------------------------------------------------------------------------*/


/*---Fio de sinal do clk para atualizar as coordenadas dos sprites---*/
wire clk_out_coord;

/*---Fio de sinal do clk para realizar contagem no modulo do contador---*/
wire clk_out_counter;

/*------Divisor de frequência para gerar clock de atualização das coordenadas dos sprites-------*/
/*Divisão por 2*/
frequency_divisor #(.WITDH(2), .N(2))
refresh_register(
	.clk(clk),
	.reset(reset),
	.out_clk(clk_out_coord)
);
/*---------------------------------------------------------------------------------------------*/

/*------Divisor de frequência para gerar clock de atualização da entrada seletora do multiplexador-------*/
/*Divisão por 4*/
frequency_divisor #(.WITDH(2), .N(3))
clk_divisor(
	.clk(clk),
	.reset(reset),
	.out_clk(clk_out_counter)
);
/*---------------------------------------------------------------------------------------------*/

/*------Contador para realizar a alternância da entrada de seleção do multiplexador------------*/
counter #(.WIDTH(2), .LIMITE(4))
counter_inst
(
	.clk(clk_out_counter) ,	    // input  clk_sig
	.reset(reset) ,				// input  reset_sig
	.out_counter(selector) 	    // output [WIDTH-1:0] out_counter_sig
);

multiplex multiplex_inst
(
	.x1(wire_s_x1) ,		// input [10:0] x1_sig
	.y1(wire_s_y1) ,		// input [9:0] y1_sig
	.x2(wire_s_x2) ,		// input [10:0] x2_sig
	.y2(wire_s_y2) ,		// input [9:0] y2_sig
	.x3(wire_s_x3) ,		// input [10:0] x3_sig
	.y3(wire_s_y3) ,		// input [9:0] y3_sig
	.x4(wire_s_x4) ,   		// input [10:0] x4_sig 
	.y4(wire_s_y4) ,   		// input [9:0]  y4_sig
	.selector(selector) ,	// input [1:0] selector_sig
	.out_x(out_x) ,			// output [10:0] out_x_sig
	.out_y(out_y) 			// output [9:0] out_y_sig
);


assign wire_m_x0 = main_x0;
assign wire_m_y0 = main_y0;

assign  wire_s_x1 = s_x1;
assign  wire_s_x2 = s_x2;
assign  wire_s_x3 = s_x3;
assign  wire_s_x4 = s_x4;

assign  wire_s_y1 = s_y1;
assign  wire_s_y2 = s_y2;
assign  wire_s_y3 = s_y3;
assign  wire_s_y4 = s_y4;

assign collision = out_collision;
assign sprite_collision = out_sprite;

/*
Bloco responsavel por atualizar os valores dos registradores que serao utilizados no calculo de colisao. 
*/
always @ (posedge clk_out_coord) begin
	main_x0 <= main_x;
	main_y0 <= main_y;
	s_x1 <= x1;
	s_x2 <= x2;
	s_x3 <= x3;
	s_x4 <= x4;
	s_y1 <= y1;
	s_y2 <= y2;
	s_y3 <= y3;
	s_y4 <= y4;
end

/*---------Bloco combinacional always responsavel por verificar se houve colisão----------------*/
/*----------------------Utilizando método de sobreposição de triângulos-------------------------*/
always @ (wire_m_x0 or wire_m_y0 or out_x or out_y) begin
	//realiza verificação da coordenada x.
	if( ( (wire_m_x0 + size) > out_x && wire_m_x0 < out_x) || ( (out_x + size) > wire_m_x0 && out_x < wire_m_x0) ) begin
		//realiza verificação da coordenada y.
		if( ((wire_m_y0 + size) > out_y && wire_m_y0 < out_y) || ( (out_y + size) > wire_m_y0 && out_y < wire_m_y0) ) begin
			out_collision = 1; //colisão detectada.
		end
		else begin 
			out_collision = 0;
		end
	end
	else begin
		out_collision = 0;
	end
	out_sprite = selector; //informa qual sprite foi selecionado para verificação.
end
/*-----------------------------------------------------------------------------------------------*/
endmodule