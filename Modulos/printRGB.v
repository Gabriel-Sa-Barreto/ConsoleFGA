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
wire       nextFruit;  //the signal that report for generate a new coordinate to fruit sprite 

wire [9:0] addressFruit;
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



always @ (negedge clk)
begin
	if(enableBarrier) begin 
		element <= 5;
		address <= addressBarrier;
		ready   <= 1;
	end 
	else if(enableFruit) begin
		element <= 1;
		address <= addressFruit;
		ready   <= 1;
	end
	else begin
		ready   <= 0;
	end
end

endmodule