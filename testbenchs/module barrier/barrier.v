`timescale 1ns / 1ps
module barrier(
			input  wire clk,
			input  wire reset, 
			input  wire active,
			input  wire   [10:0] pixel_x, //current pixel from VGA h_sync 
			input  wire    [9:0] pixel_y, //curent pixel from VGA  v_sync
			output  reg          enable,  //signal for active a pixel's barrier on VGA
			output  reg    [9:0] addressBarrier //address of the currrent pixel of barrier
);
		
//block sprite is: 25x25
reg [4:0] barrier_x;
reg [4:0] barrier_y;

initial begin
	barrier_x = 0;
	barrier_y = 0;
	enable    = 0;
end


localparam column = 800;
localparam countLimiter = 25;
localparam blockSize    = 25; //size's sprite block applicated on barrier.

always @ (negedge clk) 
begin
	if(active) begin
			if(pixel_y <= 24 || pixel_y >= 575) begin
				addressBarrier <= (blockSize * barrier_y) + barrier_x;
				enable         <= 1;
			end
			else enable        <= 0;
	end	
end	

always @ (posedge clk) begin
	if(reset) begin
		barrier_x <= 0;
		barrier_y <= 0;
	end

	if(pixel_x == column-1) begin
		if(pixel_y == 574) barrier_y <= 0;
		else barrier_y <= barrier_y + 1;
	end

	if(barrier_y == 25) barrier_y <= 0; //after to passed the last row, go back to the zero.

	if(pixel_y <= 24 || pixel_y >= 575) begin
		barrier_x <= barrier_x + 1;
		if(barrier_x == 24) barrier_x <= 0; 
	end
end

endmodule