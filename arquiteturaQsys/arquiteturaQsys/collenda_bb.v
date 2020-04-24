
module collenda (
	check_printting_export,
	clk_clk,
	reset_reset_n,
	color_g_readdata,
	color_b_readdata,
	color_r_readdata,
	vsync_writeresponsevalid_n,
	hsync_writeresponsevalid_n,
	printting_writeresponsevalid_n);	

	input		check_printting_export;
	input		clk_clk;
	input		reset_reset_n;
	output	[2:0]	color_g_readdata;
	output	[2:0]	color_b_readdata;
	output	[2:0]	color_r_readdata;
	output		vsync_writeresponsevalid_n;
	output		hsync_writeresponsevalid_n;
	output		printting_writeresponsevalid_n;
endmodule
