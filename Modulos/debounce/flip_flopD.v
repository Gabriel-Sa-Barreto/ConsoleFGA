module flip_flopD (
	input  wire clk,
	input  wire enable_clk,
	input  wire input_D,
	output reg output_D	
);

always @ (posedge clk) begin
	if(enable_clk) output_D <= input_D;
end

endmodule