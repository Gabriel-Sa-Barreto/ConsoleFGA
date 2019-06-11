module barrier(
			input  wire clk,
			input  wire reset, 
			input  wire   [10:0] pixel_x, //current pixel from VGA h_sync 
			input  wire    [9:0] pixel_y, //curent pixel from VGA  v_sync
			output  reg          enable,  //signal for active a pixel's barrier on VGA
			output  reg    [9:0] addressBarrier //address of the currrent pixel of barrier
);

initial begin
	barrier_x = 0;
	barrier_y = 0;
	enable    = 0;
end
		
//block sprite is: 25x25
reg [4:0] barrier_x;
reg [4:0] barrier_y;

localparam column = 800;
localparam countLimiter = 24;
localparam blockSize    = 25; //size's sprite block applicated on barrier.

always @ (posedge clk) //The every new pixel 
begin
	if(reset) begin
		barrier_x <= 0;
		   enable <= 0;
	end
	//check if the pixel x is in the position wish
	if(barrier_x >= countLimiter) barrier_x <= 0; //refresh the value for the next clock pulse
	
	
	if(pixel_y <= 24 || pixel_y >= 576) begin
		//print the whole row.
		addressBarrier <= (blockSize * barrier_y) + barrier_x;
		enable <= 1;
		barrier_x <= barrier_x + 1;
	end
	else if(pixel_y > 24 || pixel_y < 576) begin
		//print just until 25 columns. 
		if(pixel_x <= 24 || pixel_x >= 776) begin //if the pixel is on position to print only a one block of the barrier.
			addressBarrier <= (blockSize * barrier_y) + barrier_x;
			enable <= 1;
			barrier_x <= barrier_x + 1;
		end
		else enable <= 0;
	end
	
end	

always @ (posedge clk) 
begin
	if(reset) begin
		barrier_y <= 0;
	end
	if(barrier_y >= countLimiter) barrier_y <= 0; //refresh the value for the next clock pulse
	
	if(pixel_x == column-1) barrier_y <= barrier_y + 1; //refresh the counter y of the sprite block	
end


endmodule