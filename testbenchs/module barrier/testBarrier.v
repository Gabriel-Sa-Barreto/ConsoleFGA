`timescale 1ns / 1ps
module testBarrier;

//Inputs
reg        clk;
reg        reset;
reg        active;
reg [10:0] pixel_x;
reg  [9:0] pixel_y;

//Outputs
wire       enableBarrier;
wire [9:0] addressBarrier;

always 
begin
	clk = 0;
	forever #20 clk = ~clk;
end


initial begin
	active  = 1;
	reset   = 0;
	pixel_x = 0;
	pixel_y = 0;
end

//active Vga area is x between 0 to 799 and y between 0 to 599
always @ (posedge clk) begin
	if(pixel_x == 799) begin
		pixel_x <= 0;
		pixel_y <= pixel_y + 1;
	end
	else pixel_x <= pixel_x + 1;

	if(pixel_y > 599) pixel_y <= 0; 
end


always @ (negedge clk) begin
	$display("Enable value: %b", enableBarrier);
	$display("Address: %d", addressBarrier);
	$display("pixel_x: %d , pixel_y: %d" , pixel_x, pixel_y);
end

barrier barrier_inst
(
	.clk(clk) ,	            		 // input  clk_sig
	.reset(reset),                   // input reset_sig
	.active(active),                 // input active_sig
	.pixel_x(pixel_x) ,	   			 // input [10:0] pixel_x_sig
	.pixel_y(pixel_y) ,	   			 // input [9:0] pixel_y_sig
	.enable(enableBarrier) ,	     // output  enable_sig
	.addressBarrier(addressBarrier)  // output [9:0] addressBarrier_sig
);

endmodule