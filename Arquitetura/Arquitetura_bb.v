
module Arquitetura (
	clk_clk,
	data_a_export,
	data_b_export,
	printting_export,
	reset_reset_n,
	switch_export);	

	input		clk_clk;
	output	[31:0]	data_a_export;
	output	[31:0]	data_b_export;
	input		printting_export;
	input		reset_reset_n;
	input	[2:0]	switch_export;
endmodule
