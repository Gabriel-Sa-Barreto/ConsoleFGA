module barrier(
			input  wire clk,
			input  wire reset, 
			input  wire active,
			input  wire   [10:0] p_x, //current pixel from VGA h_sync 
			input  wire    [9:0] p_y, //curent pixel from VGA  v_sync
			output  reg          enable,  //signal for active a pixel's barrier on VGA
			output  reg    [9:0] address  //address of the currrent pixel of barrier
);
		
reg [4:0] row;
reg [4:0] column;		
		
reg [5:0] counter_BarrierUp;
reg [5:0] counter_BarrierDown;
reg [5:0] counter_BarrierLeft;
reg [5:0] counter_BarrierRight;		
localparam offset_barrierUp    = 25;
localparam offset_barrierDown  = 575;
localparam offset_barrierRight = 775;
localparam sizeBlock           = 25;

always @ (*) 
begin
	//default value
	row     = 0;
   column  = 0;
	address = 0;
	enable  = 0;
	if(active) begin //if is on screen active area. 
			//barrier up
			if( p_y <= 24 ) begin
				row    = (p_y + offset_barrierUp) - offset_barrierUp;
				column = counter_BarrierUp;
				enable = 1;
				address = (row * sizeBlock) + column;
			end
			
			//barrier down
			if( p_y >= 575 ) begin
				row = (p_y - offset_barrierDown);
				column = counter_BarrierDown;
				enable = 1;
				address = (row * sizeBlock) + column;
			end
			
			//barrier left
			if( p_y >= 25 && p_y <= 574 && p_x <= 24) begin
				row = counter_BarrierLeft;
				column  = p_x; 
				enable  = 1;
				address = (row * sizeBlock) + column;
			end
			
			//barrier right
			if( p_y >= 25 && p_y <= 574 && p_x >= 775) begin
				row = counter_BarrierRight;
				column  = p_x - offset_barrierRight; 
				enable  = 1;
				address = (row * sizeBlock) + column;
			end
	end
end

always @ (posedge clk) begin
	//barrier up
	if( p_y <= 24 ) begin
		if(counter_BarrierUp == 25) counter_BarrierUp <= 0;
		else counter_BarrierUp <= counter_BarrierUp + 1;
	end
	else counter_BarrierUp <= counter_BarrierUp;
	
	//barrier down
	if( p_y >= 575 ) begin
		if(counter_BarrierDown == 25) counter_BarrierDown <= 0;
		else counter_BarrierDown <= counter_BarrierDown + 1;
	end
	else counter_BarrierDown <= counter_BarrierDown;
	
	//barrier left
	if( p_y >= 25 && p_y <= 574 && p_x <= 25) begin
		if(counter_BarrierLeft == 25) counter_BarrierLeft <= 0;
		else begin
			if(p_x == 25) begin
				counter_BarrierLeft <= counter_BarrierLeft + 1;	
			end
			else counter_BarrierLeft <= counter_BarrierLeft;
		end 
	end
	else counter_BarrierLeft <= counter_BarrierLeft;
	
	//barrier right
	if( p_y >= 25 && p_y <= 574 && p_x >= 775) begin
		if(counter_BarrierRight == 25) counter_BarrierRight <= 0;
		else begin
			if(p_x == 799) begin
				counter_BarrierRight <= counter_BarrierRight + 1;
			end
			else counter_BarrierRight <= counter_BarrierRight;
		end
	end
	else counter_BarrierRight <= counter_BarrierRight;
end
endmodule