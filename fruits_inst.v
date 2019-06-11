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
// Created on Mon Jun 10 19:27:08 2019

fruits fruits_inst
(
	.clk(clk_sig) ,	// input  clk_sig
	.reset(reset_sig) ,	// input  reset_sig
	.pixel_x(pixel_x_sig) ,	// input [10:0] pixel_x_sig
	.pixel_y(pixel_y_sig) ,	// input [9:0] pixel_y_sig
	.nextFruit(nextFruit_sig) ,	// input  nextFruit_sig
	.enable(enable_sig) ,	// output  enable_sig
	.addressFruit(addressFruit_sig) 	// output [9:0] addressFruit_sig
);
