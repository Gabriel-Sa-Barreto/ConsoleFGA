/*
////////////////////////////////////////////////////////////////////////////////
//AUTHOR: Gabriel Sa Barreto Alves
//DATE: June 21 2019
//DESCRIPTION: 
//	This module is responsable for print a sprite, determining as output, a signal enable, the memory
//element that want to use and what address will be search in memory.
// Inputs:
//		p_x: it consist in the current pixel x generated by module VGA.
//		p_y: it consist in the current pixel y generated by module VGA.
// offset_x, offset_y: 
//			 it consist in a value that will be added with the final address, according to
//memory position that want to access.  
//////////////////////////////////////////////////////////////////////////////////
*/
module printSprite #(parameter initialPosition_x = 0,
							          initialPosition_y = 0, 
                               amountMemoryElement = 0, 
                               memoryElement = 0,
                               addr_width = 0,
                               width_x = 0,
                               width_y = 0,
                               sizeSprite_x = 0,
                               sizeSprite_y = 0)
(
	 input wire clk,         //ok
	 input wire reset,       //ok
	 input wire [10:0] p_x,  //ok
	 input wire  [9:0] p_y,  //ok
	 input wire active,      //ok
	 input wire [width_x-1:0] offset_x, //ok
	 input wire [width_y-1:0] offset_y, //ok
	 input wire [10:0] new_position_x,  //ok
	 input wire [9:0]  new_position_y,  //ok
	 input wire        moveSprite,      //ok
	 output reg [addr_width-1:0] address, //ok
	 output reg [amountMemoryElement-1:0] element, //ok
	 output reg enable  //ok
);


reg [10:0] current_x; // the value of current x of position sprite on screen
reg  [9:0] current_y; // the value of current y of position sprite on screen

reg [10:0] new_current_x; // the value of current x of position sprite on screen
reg  [9:0] new_current_y; // the value of current y of position sprite on screen

reg [width_x-1:0] row;
reg [width_y-1:0] column;
reg [width_x-1:0] offsetSprite_x;
reg [width_y-1:0] offsetSprite_y;

initial begin
	offsetSprite_x = 0;
   offsetSprite_y = 0;
	current_x = initialPosition_x;
	current_y = initialPosition_y;
	new_current_x = initialPosition_x;
	new_current_y = initialPosition_y;
	  element = memoryElement;
	      row = 0;
	   column = 0;
end


always @ (*) begin
	  enable   = 0;
	  address  = 0;
	  if(active) begin
			if(!moveSprite) begin
			  if( (p_y >= new_current_y && p_y < new_current_y + sizeSprite_y) ) begin
					if(p_x >= new_current_x && p_x <= new_current_x + sizeSprite_x) begin			 
						 address = ( (row + offsetSprite_y) * sizeSprite_y) + (column + offsetSprite_x);
						 enable  = 1;
					end
			  end
		  end
	  end
end

always @ (*) begin
	 offsetSprite_x = offset_x;
    offsetSprite_y = offset_y;
end

always @ (posedge clk) begin
	if(reset) begin
		 new_current_x <= initialPosition_x;
	    new_current_y <= initialPosition_y;
	      element <= memoryElement;
	end
	else begin 
		new_current_x <= current_x;
		new_current_y <= current_y;
	end	
end

always @ (posedge clk) begin
	if(moveSprite) begin
		current_x <= new_position_x;
		current_y <= new_position_y;
	end
	else begin
		current_x <= current_x;
		current_y <= current_y;
	end
end

always @ (posedge clk) begin
	if(!moveSprite) begin
		if( p_y >= new_current_y && p_y < new_current_y + sizeSprite_y ) begin
			if(p_x >= new_current_x && p_x <= new_current_x + sizeSprite_x) begin
				row <= p_y - new_current_y;
				column <= p_x - new_current_x;
			end
		end
	end
end

endmodule