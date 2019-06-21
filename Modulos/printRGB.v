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

wire       enableBarrier;
wire       enableFruit;
//wire       nextFruit;  //the signal that report for generate a new coordinate to fruit sprite 
wire [4:0] elementFruit;
wire [9:0] addressFruit;

wire [4:0] elementHeart;
wire [9:0] addressHeart;

wire [9:0] addressBarrier;

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


/*
fruits fruits_inst
(
	.clk(clk) ,	            			// input  clk_sig
	.reset(reset) ,	      			// input  reset_sig
	.p_x(pixel_x) ,		   			// input [10:0] pixel_x_sig
	.p_y(pixel_y) ,		   			// input [9:0] pixel_y_sig
	.active(active) ,                // input  active_sig         
	.nextFruit(nextFruit) ,				// input  nextFruit_sig
	.enable(enableFruit) ,				// output  enable_sig
	.address(addressFruit)	 			// output [9:0] addressFruit_sig
);
*/


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
	else if(enableHeart) begin
		element <= elementHeart;
		addres  <= addressHeart;
		ready   <= 1;
	end
	else begin
		ready   <= 0;
	end
end

endmodule