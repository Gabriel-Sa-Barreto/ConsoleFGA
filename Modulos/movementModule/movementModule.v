module movementModule
#(parameter ELEMENT = 0, QTD_MEMORY_ELEMENT = 0, ADDRESS_MEMORY = 0)
(
	input wire clk,
	input wire reset,
	input wire left,
	input wire right,
	input wire up,
	input wire down,
	input wire pixel_x,
	input wire pixel_y,
	input wire videoEnable,
	output reg enable,
	output reg [ADDRESS_MEMORY:0] address,
	output reg [QTD_MEMORY_ELEMENT-1:0] element
);

wire [2:0] stateSprite;
wire enable_out;
wire [ADDRESS_MEMORY:0]      address_out;
wire [QTD_MEMORY_ELEMENT-1:0]element_out;

reg moveSprite;
reg [10:0] new_position_x;
reg  [9:0] new_position_y;

always @ (*) begin
	if(pixel_x == 799 && pixel_y == 599) begin
		moveSprite = 1;
	end
	else moveSprite = 0;
end

always @ (up or down) begin
	if(up && stateSprite == 3'b011) begin
		if(moveSprite) new_position_y = new_position_y + 1; 
	end
	else if(down && stateSprite == 3'b100) begin
		if(moveSprite) new_position_y = new_position_y - 1;
	end
end

always @ (*) begin
	enable  = enable_out;
   address = address_out;
   element = element_out;
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
	.clk(clk) ,								// input  clk_sig
	.reset(reset) ,							// input  reset_sig
	.p_x(pixel_x) ,								// input [10:0] p_x_sig
	.p_y(pixel_y) ,								// input [9:0] p_y_sig
	.active(videoEnable) ,						// input  active_sig
	.offset_x(0) ,					// input [width_x-1:0] offset_x_sig
	.offset_y(0) ,					// input [width_y-1:0] offset_y_sig
	.new_position_x(new_position_x) ,	// input [10:0] new_position_x_sig
	.new_position_y(new_position_y) ,	// input [9:0] new_position_y_sig
	.moveSprite(moveSprite) ,				// input  moveSprite_sig
	.address(address_out) ,						// output [addr_width-1:0] address_sig
	.element(element_out) ,						// output [amountMemoryElement-1:0] element_sig
	.enable(enable_out) 							// output  enable_sig
);

endmodule