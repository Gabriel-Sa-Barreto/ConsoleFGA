module printRGB #(parameter ELEMENT = 5)(
		input  wire         clk,
		input  wire         reset,
		input  wire         active,
		input  wire [10:0]  pixel_x, //current pixel from VGA h_sync 
		input  wire [9:0]   pixel_y, //curent pixel from VGA  v_sync
		output  reg         ready,
		output  reg [ELEMENT-1:0] element,
		output  reg [9:0]   address
);

//wire       nextFruit;  //the signal that report for generate a new coordinate to fruit sprite 
wire [4:0] elementFruit;
wire [9:0] addressFruit;
wire       enableFruit;

wire [4:0] elementHeart1;
wire [9:0] addressHeart1;
wire       enableHeart1;

wire [4:0] elementHeart2;
wire [9:0] addressHeart2;
wire       enableHeart2;

wire [4:0] elementHeart3;
wire [9:0] addressHeart3;
wire       enableHeart3;

wire [9:0] addressBarrier;
wire       enableBarrier;

barrier barrier_inst //The barrier consist in the fifth element on sprites memory
(
	.clk(clk) ,	            		// input  clk_sig
	.reset(reset),
	.active(active),
	.p_x(pixel_x) ,	   			// input [10:0] pixel_x_sig
	.p_y(pixel_y) ,	   			// input [9:0] pixel_y_sig
	.enable(enableBarrier) ,		// output  enable_sig
	.address(addressBarrier)      // output [9:0] addressBarrier_sig
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

printSprite 
#(.initialPosition_x(717),
  .initialPosition_y(30), 
  .amountMemoryElement(4), 
  .memoryElement(2),
  .addr_width(10),
  .width_x(4),
  .width_y(4),
  .sizeSprite_x(16),
  .sizeSprite_y(16))
spriteHeart1
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
	.address(addressHeart1) ,	// output [addr_width-1:0] address_sig
	.element(elementHeart1) ,	// output [amountMemoryElement-1:0] element_sig
	.enable(enableHeart1) 	   // output  enable_sig
);

printSprite 
#(.initialPosition_x(733),
  .initialPosition_y(30), 
  .amountMemoryElement(4), 
  .memoryElement(2),
  .addr_width(10),
  .width_x(4),
  .width_y(4),
  .sizeSprite_x(16),
  .sizeSprite_y(16))
spriteHeart2
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
	.address(addressHeart2) ,	// output [addr_width-1:0] address_sig
	.element(elementHeart2) ,	// output [amountMemoryElement-1:0] element_sig
	.enable(enableHeart2) 	   // output  enable_sig
);

printSprite 
#(.initialPosition_x(749),
  .initialPosition_y(30), 
  .amountMemoryElement(4), 
  .memoryElement(2),
  .addr_width(10),
  .width_x(4),
  .width_y(4),
  .sizeSprite_x(16),
  .sizeSprite_y(16))
spriteHeart3
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
	.address(addressHeart3) ,	// output [addr_width-1:0] address_sig
	.element(elementHeart3) ,	// output [amountMemoryElement-1:0] element_sig
	.enable(enableHeart3) 	   // output  enable_sig
);

always @ (negedge clk)
begin
	if(enableBarrier) begin 
		element <= 5;
		address <= addressBarrier;
		ready   <= 1;
	end 
	else if(enableFruit) begin
		element <= elementFruit;
		address <= addressFruit;
		ready   <= 1;
	end
	else if(enableHeart1) begin
		element <= elementHeart1;
		address <= addressHeart1;
		ready   <= 1;
	end
	else if(enableHeart2) begin
		element <= elementHeart2;
		address <= addressHeart2;
		ready   <= 1;
	end
	else if(enableHeart3) begin
		element <= elementHeart3;
		address <= addressHeart3;
		ready   <= 1;
	end
	else begin
		ready   <= 0;
	end
end

endmodule