module testMultiplex;

reg clk;
reg [10:0] x1;
reg [10:0] x2; 
reg [10:0] x3;
reg [10:0] x4;
reg [9:0] y1;
reg [9:0] y2;
reg [9:0] y3;
reg [9:0] y4;
reg [1:0] selector;

wire [10:0] out_x;
wire [9:0] out_y;
 
always 
begin
	clk = 0;
	forever #20 clk = ~clk; 
end

initial begin
	$monitor("X1: %d, Y1: %d, X2: %d, Y2: %d, x3: %d, Y3: %d, X4: %d, Y4: %d, SELECTOR: %d, OUT_X: %d, OUT_Y: %d",x1,y1,x2,y2,x3,y3,x4,y4,selector,out_x, out_y);
end

initial begin
	x1 = 10; y1 = 20;
	x2 = 12; y2 = 12;
	x3 = 23; y3 = 13;
	x4 = 20; y4 = 2;
	selector = 0; 
	#10;

	x1 = 4; y1 = 24;
	x2 = 23; y2 = 12;
	x3 = 56; y3 = 15;
	x4 = 20; y4 = 112;
	selector = 1;
	#10;

	x1 = 356; y1 = 321;
	x2 = 35;  y2 = 23;
	x3 = 153; y3 = 243;
	x4 = 75; y4 = 34;
	selector = 2;
	#10;


	x1 = 123; y1 = 12;
	x2 = 35; y2 = 32;
	x3 = 14; y3 = 123;
	x4 = 56; y4 = 34;
	selector = 3;
	#20;

	$finish; //encerra a simulação
end

multiplex multiplex_inst
(
	.x1(x1) ,	// input [10:0] x1_sig
	.y1(y1) ,	// input [9:0] y1_sig
	.x2(x2) ,	// input [10:0] x2_sig
	.y2(y2) ,	// input [9:0] y2_sig
	.x3(x3) ,	// input [10:0] x3_sig
	.y3(y3) ,	// input [9:0] y3_sig
	.x4(x4) ,   // input [10:0] x4_sig 
	.y4(y4) ,   // input [9:0]  y4_sig
	.selector(selector) ,	// input [1:0] selector_sig
	.out_x(out_x) ,	// output [10:0] out_x_sig
	.out_y(out_y) 	// output [9:0] out_y_sig
);

endmodule