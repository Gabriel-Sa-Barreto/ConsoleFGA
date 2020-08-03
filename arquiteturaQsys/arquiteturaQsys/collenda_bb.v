
module collenda (
	buttonmov_export,
	check_printting_export,
	clk_clk,
	color_b_readdata,
	color_g_readdata,
	color_r_readdata,
	hsync_writeresponsevalid_n,
	printtingscreen_writeresponsevalid_n,
	switchcor_export,
	vsync_writeresponsevalid_n);	

	input	[1:0]	buttonmov_export;
	input		check_printting_export;
	input		clk_clk;
	output	[2:0]	color_b_readdata;
	output	[2:0]	color_g_readdata;
	output	[2:0]	color_r_readdata;
	output		hsync_writeresponsevalid_n;
	output		printtingscreen_writeresponsevalid_n;
	input	[3:0]	switchcor_export;
	output		vsync_writeresponsevalid_n;
endmodule
