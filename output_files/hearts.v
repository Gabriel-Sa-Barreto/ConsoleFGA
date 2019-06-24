module hearts(
		input  wire     clk,
		input  wire     reset,
		input  wire     active,
		input
		input  wire     hit,
		output  reg[9:0]address,
      output  reg     enable,
		output  reg[3:0]element
);



printSprite 
#(.initialPosition_x(400),
  .initialPosition_y(400), 
  .amountMemoryElement(4), 
  .memoryElement(1),
  .addr_width(10),
  .width_x(6),
  .width_y(6),
  .sizeSprite_x(25),
  .sizeSprite_y(25))
spriteFruit
(
	.clk(clk) ,	         // input  clk_sig
	.reset(reset) ,	   // input  reset_sig
	.p_x(pixel_x) ,	   // input [10:0] p_x_sig
	.p_y(pixel_y) ,	   // input [9:0] p_y_sig
	.active(active) ,	   // input  active_sig
	.offset_x(0) ,	      // input [width_x-1:0] offset_x_sig
	.offset_y(0) ,	      // input [width_y-1:0] offset_y_sig
	.new_position_x(0) ,	// input [10:0] new_position_x_sig
	.new_position_y(0) ,	// input [9:0] new_position_y_sig
	.moveSprite(0) ,	   // input  moveSprite_sig
	.address(addressFruit) ,	// output [addr_width-1:0] address_sig
	.element(elementFruit) ,	// output [amountMemoryElement-1:0] element_sig
	.enable(enableFruit) 	   // output  enable_sig
);




endmodule