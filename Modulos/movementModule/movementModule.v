module movementModule
#(parameter SIZE_SPRITE = 0, ELEMENT = 0, QTD_MEMORY_ELEMENT = 0, ADDRESS_MEMORY = 0)
(
	input wire clk,
	input wire reset,
	input wire left,
	input wire right,
	input wire up,
	input wire down,
	input wire offset_x,
	input wire offset_y,
	output reg enable,
	output reg [ADDRESS_MEMORY:0] address,
	output reg [QTD_MEMORY_ELEMENT-1:0] element
);




endmodule