
module collenda (
	check_printting_export,
	clk_clk,
	color_b_readdata,
	color_g_readdata,
	color_r_readdata,
	hsync_writeresponsevalid_n,
	printting_writeresponsevalid_n,
	pushbutton_reset_export,
	reset_reset_n,
	vsync_writeresponsevalid_n);	

	input		check_printting_export;
	input		clk_clk;
	output	[2:0]	color_b_readdata;
	output	[2:0]	color_g_readdata;
	output	[2:0]	color_r_readdata;
	output		hsync_writeresponsevalid_n;
	output		printting_writeresponsevalid_n;
	input		pushbutton_reset_export;
	input		reset_reset_n;
	output		vsync_writeresponsevalid_n;
endmodule
