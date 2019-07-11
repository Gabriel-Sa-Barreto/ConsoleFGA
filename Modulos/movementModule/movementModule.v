module movementModule
#(parameter ELEMENT = 0, QTD_MEMORY_ELEMENT = 0, ADDRESS_MEMORY = 0)
(
	input wire clk,
	input wire reset,
	input wire left,
	input wire right,
	input wire up,
	input wire down,
	input wire [10:0] pixel_x,
	input wire  [9:0] pixel_y,
	input wire videoEnable,
	output wire enable,
	output wire [ADDRESS_MEMORY-1:0] address,
	output wire [QTD_MEMORY_ELEMENT-1:0] element
);

wire [2:0] stateSprite;
wire enable_out;
wire [ADDRESS_MEMORY-1:0]      address_out;
wire [QTD_MEMORY_ELEMENT-1:0]element_out;

reg moveSprite;
reg [10:0] new_position_x;
reg  [9:0] new_position_y;

reg [10:0] position_x;
reg  [9:0] position_y;

localparam sizeSprite = 25;

initial begin
	new_position_x = 50;
	new_position_y = 300;
	position_x = 50;
	position_y = 300;
	moveSprite     = 0;
end

always @ (*) begin
	if(pixel_x < new_position_x || pixel_x > (new_position_x + sizeSprite) ) begin
		if(pixel_y < new_position_y || pixel_y > (new_position_y + sizeSprite)) begin
			if(up) begin
			  
			end
			else if(down) begin
				
			end
		end
	end
end

always @ (posedge clk) begin
	if(moveSprite) begin
		if(up)        new_position_y <= new_position_y + 1;
		else if(down) new_position_y <= new_position_y - 1;
	end
end

always @ (posedge moveSprite) begin
	position_x <= new_position_x;
	position_y <= new_position_y;
end

spriteMoveFSM spriteMoveFSM_inst
(
	.clk(clk) ,	        		// input  clk_sig
	.reset(reset) ,	  		// input  reset_sig
	.left(left) ,	     		// input  left_sig
	.right(right) ,	  		// input  right_sig
	.up(up) ,	        		// input  up_sig
	.down(down) ,	     		// input  down_sig
	.dataout(stateSprite)   // output [2:0] dataout_sig
);

printSprite 
#(.initialPosition_x(50),
  .initialPosition_y(300), 
  .amountMemoryElement(4), 
  .memoryElement(1),
  .addr_width(10),
  .width_x(6),
  .width_y(6),
  .sizeSprite_x(25),
  .sizeSprite_y(25))
spriteGeneric
(
	.clk(clk) ,								       // input  clk_sig
	.reset(reset) ,								// input  reset_sig
	.p_x(pixel_x) ,								// input [10:0] p_x_sig
	.p_y(pixel_y) ,								// input [9:0] p_y_sig
	.active(videoEnable) ,						// input  active_sig
	.offset_x(0) ,									// input [width_x-1:0] offset_x_sig
	.offset_y(0) ,									// input [width_y-1:0] offset_y_sig
	.new_position_x(position_x) ,		// input [10:0] new_position_x_sig
	.new_position_y(position_y) ,		// input [9:0] new_position_y_sig
	.moveSprite(moveSprite) ,					// input  moveSprite_sig
	.address(address) ,						   // output [addr_width-1:0] address_sig
	.element(element) ,						   // output [amountMemoryElement-1:0] element_sig
	.enable(enable) 							   // output  enable_sig
);

endmodule