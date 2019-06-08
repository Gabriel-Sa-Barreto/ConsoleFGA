module printRGB #(parameter ELEMENT = 5)(
		input  wire         clk,
		input  wire [10:0]  pixel_x, //current pixel from VGA h_sync 
		input  wire [9:0]   pixel_y, //curent pixel from VGA  v_sync
		output  reg         ready,
		output  reg [ELEMENT-1:0] element,
		output  reg [9:0]   address
);

wire       enableBarrier;
wire [9:0] addressBarrier;

barrier barrier_inst //The barrier consist in the fourth element on sprites memory
(
	.clk(clk) ,	            			// input  clk_sig
	.pixel_x(pixel_x) ,	   			// input [10:0] pixel_x_sig
	.pixel_y(pixel_y) ,	   			// input [9:0] pixel_y_sig
	.enable(enableBarrier) ,			// output  enable_sig
	.addressBarrier(addressBarrier)  // output [9:0] addressBarrier_sig
);


always @ (posedge clk)
begin
	if(enableBarrier) begin 
		element <= 4;
		address <= addressBarrier;
		ready   <= 1;
	end 
	else if() begin
	
	
	end
	else if() begin
	
	
	end
	else if() begin
	
	
	end
	else if() begin
	

	end
	else ready <= 0;
end

endmodule