`timescale 1ns / 1ps
module top(
	  input wire     clk,        //clock da FPGA (50MHz)
	  input wire     reset,      //signal for restart the system
	  input wire     resetFSM,   //signal for restart the game FSM
	  input wire     dead,
	  input wire     startGame,  //Pino: GPIO_19  (PIN_K16) Blue_button
     input wire     pauseGame,  //Pino: GPIO_111 (PIN_L15) Red_button
	  output reg  [2:0] VGA_R,   //intensidade de vermelho
	  output reg  [2:0] VGA_G,   //intensidade de verde
	  output reg  [2:0] VGA_B,   //intensidade do azul
	  output wire hsync,         //sinal de sincronizaçao horizontal
	  output wire vsync,          //sinal de sincronizaçao vertical
	  output [2:0]leds
);

localparam QTD_ELEMENTS = 3;

wire	 video_enable;    //sinal de area ativa da tela para impressao
wire [10:0]	pixel_x;    //coordenada x do pixel atual da tela 
wire [9:0]  pixel_y;    //coordenada y do pixel atual da tela
wire [11:0] dataout;    //color RGB to the current pixel
wire        ready;
wire [QTD_ELEMENTS:0]  element;
wire [9:0]  address;

wire [2:0] stateGame;

reg [2:0] elementMemory;
reg  enableMemory;

reg [9:0] addressMemory;
reg [8:0] colour;

//////////////PHRASES///////////////////////////////
//PRESS START TO BEGIN
//GAME OVER
//GAME PAUSED
//GAME RESET
reg [7:0] phraseSTART [16:0];
reg [7:0] phraseGAMEOVER [7:0];
reg [7:0] phrasePAUSE [9:0];
reg [7:0] phraseRESET [8:0];
////////////////////////////////////////////////////
initial begin
	enableMemory = 0;
		  colour  = 0;
	/////////////////////////////////////////////////
	$readmemh("/home/gabriel/Documentos/ConsoleFPGA/Modulos/phraseSTART.txt",    phraseSTART);
	$readmemh("/home/gabriel/Documentos/ConsoleFPGA/Modulos/phraseGAMEOVER.txt", phraseGAMEOVER);
	$readmemh("/home/gabriel/Documentos/ConsoleFPGA/Modulos/phrasePAUSE.txt",    phrasePAUSE);
	$readmemh("/home/gabriel/Documentos/ConsoleFPGA/Modulos/phraseRESET.txt",    phraseRESET);		  
end

SVGA_sync	SVGA(.clock(clk),
				 .reset(),
				 .hsync(hsync),
				 .vsync(vsync),
				 .video_enable(video_enable),
				 .pixel_x(pixel_x),
				 .pixel_y(pixel_y)
				);

memorySprites #(.ELEMENTS(QTD_ELEMENTS))
memorySprites_inst
(
	.clk(clk) ,								// input  clk_sig
	.read_enable(enableMemory) ,		// input  read_enable_sig
	.address_sprite(addressMemory) ,	// input [9:0] address_sprite_sig
	.element(elementMemory) ,			// input  element_sig
	.dataout(dataout) 					// output [11:0] dataout_sig
);

printRGB #(.ELEMENT(3))
printRGB_inst
(
	.clk(clk) ,	        	  // input  clk_sig
	.reset(0) ,	     		  // input  reset_sig
	.active(video_enable),
	.pixel_x(pixel_x) ,	  // input [10:0] pixel_x_sig
	.pixel_y(pixel_y) ,	  // input [9:0] pixel_y_sig
	.stateGame(stateGame), // input [2:0] gameState_sig
	.ready(ready) ,	     // output  ready_sig
	.element(element) ,	  // output [ELEMENT-1:0] element_sig
	.address(address) 	  // output [9:0] address_sig
);


gameFSM gameFSM_inst
(
	.clk(clk) ,					// input  clk_sig
	.reset(~reset) ,			// input  reset_sig
	.resetFSM(0) ,				// input  resetFSM_sig
	.startGame(startGame) ,	// input  startGame_sig
	.pauseGame(pauseGame) ,	// input  pauseGame_sig
	.dead(~dead) ,				// input  dead_sig
	.stateGame(stateGame) 		// output [2:0] stateGame_sig
);

assign leds = stateGame;

always @ (*) begin
	if(video_enable) begin
		colour[8:6] = dataout[11:9];
		colour[5:3] = dataout[7:5]; 
		colour[2:0] = dataout[3:1];
		if(ready) begin
			elementMemory = element;
			addressMemory = address;
			enableMemory  = ready;
		end 
		else colour = 0;
	end
	else colour = 0;
end

always @ (negedge clk) begin
	VGA_R <= colour[8:6];
	VGA_G <= colour[5:3];
	VGA_B <= colour[2:0];
end
endmodule
