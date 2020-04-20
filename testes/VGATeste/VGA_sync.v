`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: FEUP - Faculdade de Engenharia da Univeridade do Porto 
// Student: Ricardo Jorge dos Santos Machado (050503177)
// 
// Create Date:		10:30:58 06/14/2010
// Module Name:		SVGA_sync 
// Description:		Módulo de sincronização para SVGA gráfico (800 x 600).
//
// Version:			1.0
//
// Additional Comments:	Destinado a funcionar com o clock interno de 50MHz.
//						hsync e vsync são linhas do conector VGA.
//						video_enable indica se estamos na parte visivel do monitor.
//						pixel_x e pixel_y indicam as coordenadas do pixel.
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_sync(clock, reset, hsync, vsync, video_enable, pixel_x, pixel_y);

input				clock, reset;

output reg			hsync, vsync;
output reg [9:0]	pixel_x;
output reg [9:0]	pixel_y;

output wire			video_enable;

parameter	HD = 480;   //total pixel horizontal
parameter	HF = 16;    //total front porch
parameter	HB = 56;    //total back porch
parameter	HR = 40;    //total sync
parameter	HT = 592;   //soma dos parametros horizontais
  
/*	Parâmetros Verticais */
parameter	VD = 320;   //total pixel horizontal
parameter	VF = 3;    //total front porch
parameter	VB = 3;    //total back porch
parameter	VR = 10;     //total sync
parameter	VT = 336;   //soma dos parametros horizontais

assign video_enable = ((pixel_x < HD) && (pixel_y < VD));


always @ (posedge clock or posedge reset)	// Processamento de pixel_x.
begin
	if (reset)
	begin
		pixel_x <= 0;
	end
	else
	begin
		if (pixel_x == (HT - 1))			// Ultimo pixel horizontal.
 		begin
			pixel_x <= 0;
		end
		else
		begin
			pixel_x <= pixel_x + 1;		
		end
	end
end

always @ (posedge clock or posedge reset)	// Processamento de pixel_y.
begin
	if (reset)
	begin
		pixel_y <= 0;
	end
	else
	begin
		if ((pixel_y == (VT - 1))&& (pixel_x == (HT - 1)))			// Ultimo pixel horizontal e vertical.
		begin
			pixel_y <= 0;
		end
		else
		begin
			if ((pixel_x == (HT - 1)))		// Ultimo pixel horizontal.
			begin
				pixel_y <= pixel_y + 1;
			end
		end
	end
end

always @ (posedge clock or posedge reset)	// Processamento de hsync.
begin
	if (reset)
	begin
		hsync <= 1'b0;
	end
	else
	begin
		if (pixel_x == (HD + HF - 1))		// Inicio de hsync.
	  	begin
			hsync <= 1'b1;
		end
		else 
		begin
			if (pixel_x == (HT - HB - 1))	// Fim de hsync.
			begin
				hsync <= 1'b0;
			end
		end
	end
end

always @ (posedge clock or posedge reset)	// Processamento de vsync.
begin
	if (reset)
	begin
		vsync = 1'b0;
	end
	else
	begin
		if ((pixel_y == (VD + VF - 1) && (pixel_x == HT - 1)))			// Inicio de vsync.
	  	begin
			vsync = 1'b1;
		end
		else
		begin
			if ((pixel_y == (VT - VB - 1)) && (pixel_x == (HT - 1)))	// Fim de vsync.
			begin
				vsync = 1'b0;
			end
		end
	end
end

endmodule