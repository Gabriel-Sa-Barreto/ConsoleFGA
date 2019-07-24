`timescale 1ns / 1ps
module top(
	  input wire     clk,        //clock da FPGA (50MHz)
	  input wire     up,         //yellow button (GPIO 117 PIN_K16)
	  input wire     down,       //black button   (GPIO 119 PIN_L15) 
	  input wire     right,      //red button    (GPIO 121 PIN_P16)
	  input wire     left,       //blue button  (GPIO 123 PIN_N16)
	  input wire     setSpeed,   //pushButton 0
	  input wire     reset,      //switch 00
	  input wire     startGame,  //switch 01
     input wire     pauseGame,  //switch 02
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

/*---PUSH BUTTONS and SWITCHES--*/
wire out_left;
wire out_right;
wire out_up;
wire out_down;
wire out_start;
wire out_pause;
wire out_reset;
wire out_speed;
/*-------------*/

wire [2:0] stateGame;

reg [2:0] elementMemory;
reg  enableMemory;

reg [9:0] addressMemory;
reg [8:0] colour;

initial begin
	enableMemory  = 0;
		  colour   = 0;
end

/*------------DEBOUNCES-------------*/
button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_setSpeed
(
	.clk(clk) ,	// input  clk_sig
	.data(~setSpeed) ,	// input  data_sig
	.out_state(out_speed) 	// output  out_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_left
(
	.clk(clk) ,	// input  clk_sig
	.data(left) ,	// input  data_sig
	.out_state(out_left) 	// output  out_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_right
(
	.clk(clk) ,	// input  clk_sig
	.data(right) ,	// input  data_sig
	.out_state(out_right) 	// output  out_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_reset
(
	.clk(clk) ,	// input  clk_sig
	.data(reset) ,	// input  data_sig
	.out_state(out_reset) 	// output  out_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_up
(
	.clk(clk) ,	// input  iclk_sig
	.data(up) ,	// input  in_bit_sig
	.out_state(out_up) 	// output  out_state_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_down
(
	.clk(clk) ,	// input  iclk_sig
	.data(down) ,	// input  in_bit_sig
	.out_state(out_down) 	// output  out_state_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_pause
(
	.clk(clk) ,	// input  iclk_sig
	.data(pauseGame) ,	// input  in_bit_sig
	.out_state(out_pause) 	// output  out_state_sig
);

button_Debounce #(.INTERVAL(20),.COUNTER_LIMITE(20'hfffff))
button_Debounce_start
(
	.clk(clk) ,	// input  iclk_sig
	.data(startGame) ,	// input  in_bit_sig
	.out_state(out_start) 	// output  out_state_sig
);
/*-----------------------------------*/
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
	.reset(reset) ,	     		  // input  reset_sig
	.active(video_enable),
	.setSpeed(out_speed),
	.left(out_left),
	.right(out_right),
	.up(out_up),
	.down(out_down),
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
	.reset(0) ,					// input  reset_sig
	.resetFSM(out_reset) ,	// input  resetFSM_sig
	.startGame(out_start) ,	// input  startGame_sig
	.pauseGame(out_pause) ,	// input  pauseGame_sig
	.dead(0) ,					// input  dead_sig
	.stateGame(stateGame) 	// output [2:0] stateGame_sig
);

always @ (*) begin
	if(video_enable) begin
		if(ready) begin
			elementMemory = element;
			addressMemory = address;
			enableMemory  = ready;
		end
	end
end

always @ (*) begin
	if(video_enable) begin
		if(ready) begin
			colour[8:6] = dataout[11:9];
			colour[5:3] = dataout[7:5]; 
			colour[2:0] = dataout[3:1];
		end
		else colour = 8'hff; //background on screen
	end
	else colour = 0; 
end

always @ (negedge clk) begin
	VGA_R <= colour[8:6];
	VGA_G <= colour[5:3];
	VGA_B <= colour[2:0];
end

assign leds = stateGame;

endmodule
