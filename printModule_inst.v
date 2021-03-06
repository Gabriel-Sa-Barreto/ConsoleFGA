// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.


// Generated by Quartus Prime Version 18.1 (Build Build 625 09/12/2018)
// Created on Thu Apr 23 12:04:09 2020

printModule printModule_inst
(
	.clk(clk_sig) ,	// input  clk_sig
	.clk_pixel(clk_pixel_sig) ,	// input  clk_pixel_sig
	.reset(reset_sig) ,	// input  reset_sig
	.data_reg(data_reg_sig) ,	// input [31:0] data_reg_sig
	.active_area(active_area_sig) ,	// input  active_area_sig
	.pixel_x(pixel_x_sig) ,	// input [size_x-1:0] pixel_x_sig
	.pixel_y(pixel_y_sig) ,	// input [size_y-1:0] pixel_y_sig
	.count_finished(count_finished_sig) ,	// input  count_finished_sig
	.sprite_datas(sprite_datas_sig) ,	// output [31:0] sprite_datas_sig
	.memory_address(memory_address_sig) ,	// output [size_address-1:0] memory_address_sig
	.printtingScreen(printtingScreen_sig) ,	// output  printtingScreen_sig
	.check_value(check_value_sig) ,	// output [bits_x_y-1:0] check_value_sig
	.sprite_on(sprite_on_sig) 	// output  sprite_on_sig
);

defparam printModule_inst.size_x = 10;
defparam printModule_inst.size_y = 9;
defparam printModule_inst.size_address = 14;
defparam printModule_inst.bits_x_y = 19;
