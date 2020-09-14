module geradorDataB(
	input  wire clk,
	input  wire reset,
	input  wire buttonLeft,
	input  wire buttonRight,
	input  wire up,
	input  wire down,
	output reg [31:0] out
);

localparam [8:0] OFFSET = 9'd0;
localparam [2:0] ACTIVE_SPRITE = 3'b001;

reg [7:0] LED;
reg [31:0] outData;
wire [9:0] outputData_x;
wire [9:0] outputData_y;

contador #(.MAX_VALUE(620), .MIN_VALUE(1))
contador_inst
(
	.clk(clk) ,					// input  clk_sig
	.button1(buttonLeft) ,	// input  buttonLeft_sig
	.button2(buttonRight) ,	// input  buttonRight_sig
	.reset(!reset) ,				// input  reset_sig
	.outputData(outputData_x) 	// output [9:0] outputData_sig
);


contador #(.MAX_VALUE(460), .MIN_VALUE(0))
contador_inst2
(
	.clk(clk) ,					// input  clk_sig
	.button1(up) ,	// input  buttonLeft_sig
	.button2(down) ,	// input  buttonRight_sig
	.reset(!reset) ,				// input  reset_sig
	.outputData(outputData_y) 	// output [9:0] outputData_sig
);



always @(outputData_x or outputData_y ) begin
	outData[8:0]   = OFFSET;
	outData[18:9]  = outputData_y;    //valor da coordenada y
	outData[28:19] = outputData_x; //valor da coordenada x
	outData[31:29] = ACTIVE_SPRITE;
end

always @(posedge clk) begin
	out <= outData;
end


endmodule