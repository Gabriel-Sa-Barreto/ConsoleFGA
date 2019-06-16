module fruits(
		 input wire        clk,
		 input wire        reset,
		 input wire [10:0] p_x,
		 input wire  [9:0] p_y,
		 input wire        active,
		 input wire        nextFruit,
		 output reg        enable ,
		 output reg  [9:0] address
);

reg [10:0] current_x; // the value of the current x position of fruit on screen
reg  [9:0] current_y; // the value of the current y position of fruit on screen

reg [4:0] row;
reg [4:0] column;

localparam sizeFruit = 25; //25x25
initial begin
	current_x = 400;
	current_y = 300;
	column    = 0;
	row       = 0;
end

always @ (*) begin
	  enable   = 0;
	  address  = 0;
	  if(active) begin
		  if( (p_y >= current_y && p_y < current_y + sizeFruit) ) begin
				if(p_x >= current_x && p_x <= current_x + sizeFruit) begin			 
					 address = (row * sizeFruit) + column;
					 enable  = 1;
				end
		  end
	  end
end

always @ (posedge clk) begin
	if( (p_y >= current_y && p_y < current_y + sizeFruit) ) begin
		if(p_x >= current_x && p_x <= current_x + sizeFruit) begin
			   row <= p_y - current_y;
			column <= p_x - current_x;
		end
	end
end
endmodule