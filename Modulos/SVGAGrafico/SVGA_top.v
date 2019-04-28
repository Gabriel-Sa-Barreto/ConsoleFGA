`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: FEUP - Faculdade de Engenharia da Univeridade do Porto 
// Student: Ricardo Jorge dos Santos Machado (050503177)
// 
// Create Date:		11:06:17 06/16/2010
// Module Name:		SVGA_top
// Description:		Wrapper para os módulos SVGA_sync.v.
//					Inclui pequeno exemplo de aplicação para o módulo SVGA_sync.v.
//					Cor de fundo do monitor dividido em 4 partes, e controlavel 
//					pelos interruptores 1, 2 e 3.
//
// Version:			1.0			
//
// Additional Comments: hsync, vsync, R, G e B são sinais da porta VGA.
//						SW3, SW2, SW1 representam 3 interruptores da FPGA.
//
//////////////////////////////////////////////////////////////////////////////////
module SVGA_top(clock, clock_en, reset, hsync, vsync, R, G, B);

input		clock, clock_en, reset;
//input       [31:0] colorScreen;
output wire	hsync, vsync;
output reg	[2:0]R; 
output reg  [2:0]G; 
output reg  [2:0]B;


wire		video_enable;
wire [10:0]	pixel_x; 
wire [9:0]  pixel_y;

reg [2:0]screen_R;
reg [2:0]screen_G;
reg [2:0]screen_B;

SVGA_sync	SVGA(.clock(clock),
				 .reset(reset),
				 .hsync(hsync),
				 .vsync(vsync),
				 .video_enable(video_enable),
				 .pixel_x(pixel_x),
				 .pixel_y(pixel_y)
				);

initial begin
	screen_R = 0;
   screen_G = 1;
   screen_B = 1;
end
				
				
always @ (posedge clock)
begin
	if(video_enable)
		begin
			R[0] <= screen_R[0];
			R[1] <= screen_R[1];
			R[2] <= screen_R[2];
			
			G[0] <= screen_G[0];
			G[1] <= screen_G[1];
			G[2] <= screen_G[2];
			
			B[0] <= screen_B[0];
			B[1] <= screen_B[1];
			B[2] <= screen_B[2];
		end
	else
		begin
			R <= 1'b0;
			G <= 1'b0;
			B <= 1'b0;
		end
end

/*always @ (posedge clock)
begin
	screen_R = colorScreen[10:8];
	screen_G = colorScreen[6:4];
	screen_B = colorScreen[2:0];
end*/

endmodule




