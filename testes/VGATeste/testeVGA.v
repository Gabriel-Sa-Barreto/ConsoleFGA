module testeVGA(
	input wire clk,
	output reg [8:0] RGB,
	output wire hsync,
	output wire vsync
);

wire active_area;
wire out_clk;
wire [9:0]	pixel_x; 
wire [9:0]  pixel_y;

always @(posedge out_clk) begin
	if(active_area) begin
		RGB <= 9'b011010101;
	end
	else RGB <= 9'd0;
end

frequency_divisor #(.WIDTH(2),.N(1))
frequency_divisor_inst
(
	.clk(clk) ,	         // input  clk_sig
	.reset() ,	   // input  reset_sig
	.out_clk(out_clk)    // output  out_clk_sig
);


VGA_sync VGA_sync_inst
(
	.clock(out_clk) ,	   				// input  clock_sig
	.reset(1'b0) ,	   				// input  reset_sig
	.hsync(hsync) ,	   				// output  hsync_sig
	.vsync(vsync) ,	   				// output  vsync_sig
	.video_enable(active_area) ,	   // output  video_enable_sig
	.pixel_x(pixel_x) ,					      // output [9:0] pixel_x_sig
	.pixel_y(pixel_y) 					         // output [9:0] pixel_y_sig
);

endmodule