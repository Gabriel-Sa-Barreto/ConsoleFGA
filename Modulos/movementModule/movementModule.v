module movementModule
#(parameter ELEMENT = 0, QTD_MEMORY_ELEMENT = 0, ADDRESS_MEMORY = 0)
(
	input wire clk,
	input wire reset,
	input wire setSpeed,
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
wire       moveSprite;
wire enable_out;
wire [ADDRESS_MEMORY-1:0]      address_out;
wire [QTD_MEMORY_ELEMENT-1:0]element_out;
wire [2:0] speed_sp;

reg [10:0] new_position_x;
reg  [9:0] new_position_y;
reg move;

reg [10:0] position_x;
reg  [9:0] position_y;
reg  [2:0] speed;

localparam sizeSprite = 25;

initial begin
	speed = 6;
	new_position_x = 50;
	new_position_y = 300;
	position_x = 50;
	position_y = 300;
end

spriteMoveFSM spriteMoveFSM_inst
(
	.clk(clk) ,	        			// input  clk_sig
	.reset(reset) ,	  			// input  reset_sig
	.setSpeed(setSpeed), 		// input  setSpeed_sig
	.spriteSpeed(speed_sp), // input  setSpeed_sig
	.left(left) ,	     			// input  left_sig
	.right(right) ,	  			// input  right_sig
	.up(up) ,	        			// input  up_sig
	.down(down) ,	     			// input  down_sig
	.dataout(stateSprite),   	// output [2:0] dataout_sig
	.moveSprite(moveSprite)  	//output moveSprite_sig    
);

assign speed_sp = speed;

always @ (negedge clk) begin
	if(reset) begin
		          move <= 1;
		new_position_x <= 50;
		new_position_y <= 300;
	end
	else if(moveSprite && stateSprite == 3'b011) begin //up
		new_position_y <= new_position_y - 1;
		move <= 1;
	end
	else if(moveSprite && stateSprite == 3'b100) begin //down
		new_position_y <= new_position_y + 1;
		move <= 1;
	end
	else if(moveSprite && stateSprite == 3'b001) begin //left
		new_position_x <= new_position_x  - 1;
		move <= 1;
	end
	else if(moveSprite && stateSprite == 3'b010) begin //right
		new_position_x <= new_position_x + 1;
		move <= 1;
	end
	else move <= 0;
end

always @ (posedge clk) begin
	if(move) begin
		position_x <= new_position_x; 
		position_y <= new_position_y;
	end
end

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
	.moveSprite(move) ,					// input  moveSprite_sig
	.address(address) ,						   // output [addr_width-1:0] address_sig
	.element(element) ,						   // output [amountMemoryElement-1:0] element_sig
	.enable(enable) 							   // output  enable_sig
);

endmodule