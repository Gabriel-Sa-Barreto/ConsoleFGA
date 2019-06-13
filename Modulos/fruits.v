module fruits(
		 input wire        clk,
		 input wire        reset,
		 input wire [10:0] pixel_x,
		 input wire  [9:0] pixel_y,
		 input wire        nextFruit,
		 output reg        enable ,
		 output reg  [9:0] addressFruit
);

reg [10:0] current_x; // the value of the current x position of fruit on screen
reg  [9:0] current_y; // the value of the current y position of fruit on screen

reg [4:0] fruits_x; 
reg [4:0] fruits_y;

localparam sizeFruits = 25; //25x25

initial begin
	fruits_y  = 0;
	fruits_x  = 0;
	current_x = 600;
	current_y = 300;
end


always @ (posedge clk) begin
	if(reset) begin
		fruits_y  <= 0;
		fruits_x  <= 0;
		current_x <= 600;
		current_y <= 300;
	end
	
	//the code that check if the pixels are in right position and calculates the next address of memmory.
	if( (current_x >= pixel_x) && (current_x <= pixel_x + sizeFruits) ) begin
		if( (current_y >= pixel_y) && (current_y <= pixel_y + sizeFruits)) begin
			addressFruit <= (sizeFruits * fruits_y) + fruits_x;
			      enable <= 1;
			if(fruits_y > sizeFruits) begin
					fruits_y <= 0;
					fruits_x <= 0;
			end
			if(fruits_x > sizeFruits-1) begin
					fruits_x <= 0;
					fruits_y <= fruits_y + 1;
			end
			else fruits_x <= fruits_x + 1;	
		end
		else enable <= 0;
	end
	else enable <= 0;
	/////////////////////////////////////////////////////////////////////////////////////////////////////
end 

/*
always @ (nextFruit) begin
	current_x <= 0;//$urandom$750;
	current_y <= 0;//$urandom$550;
end 
*/
endmodule