module debounce ( 
		input wire  clk,
		input wire  data,
		output wire out		
);

wire D1,D2;
wire clk_enable;

assign out = D1 && (~D2);

flip_flopD flip_flopD_inst
(
	.clk(clk) ,	// input  clk_sig
	.enable_clk(clk_enable) ,	// input  enable_clk_sig
	.input_D(data) ,	// input  input_D_sig
	.output_D(D1) 	// output  output_D_sig
);

flip_flopD flip_flopD_inst2
(
	.clk(clk) ,	// input  clk_sig
	.enable_clk(clk_enable) ,	// input  enable_clk_sig
	.input_D(D1) ,	// input  input_D_sig
	.output_D(D2) 	// output  output_D_sig
);

clock_div div_inst(
	.clk(clk),
	.button_sig(data),
	.slow_clk(clk_enable)
);

endmodule


