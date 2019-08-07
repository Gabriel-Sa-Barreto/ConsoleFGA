module testCollision;

reg clk;
reg reset;
reg [10:0] x1;
reg  [9:0] y1;
reg [10:0] x2;
reg  [9:0] y2;
reg [10:0] x3;
reg  [9:0] y3;
reg [10:0] x4;
reg  [9:0] y4;
reg [10:0] main_x;
reg  [9:0] main_y;

wire collision;
wire [1:0] sprite_collision;

always begin
	clk = 0;
	forever #20 clk = ~clk;
end

integer i;

initial begin
	
	#5 reset = 1;
	#5 reset = 0;
	#100;
 	for(i = 0; i < 10; i = i + 1) begin
 		x1 = 615;
		y1 = 520;
		x2 = $urandom%800;
		y2 = $urandom%600;
	 	x3 = 610;
	 	y3 = 515;
	 	x4 = $urandom%800;
	 	y4 = $urandom%600;
	 	main_x = 600;
	 	main_y = 500;
	 	#500;
 	end
 	$finish;
end

initial begin
	$monitor("COLLISION:%d, ---SPRITE: %d", collision, sprite_collision);
end

collision collision_inst
(
	.clk(clk) ,	// input  clk_sig
	.reset(reset) ,	// input  reset_sig
	.main_x(main_x) ,	// input [10:0] main_x_sig
	.main_y(main_y) ,	// input [9:0] main_y_sig
	.x1(x1) ,	// input [10:0] x1_sig
	.y1(y1) ,	// input [9:0] y1_sig
	.x2(x2) ,	// input [10:0] x2_sig
	.y2(y2) ,	// input [9:0] y2_sig
	.x3(x3) ,	// input [10:0] x3_sig
	.y3(y3) ,	// input [9:0] y3_sig
	.x4(x4) ,	// input [10:0] x4_sig
	.y4(y4) ,	// input [9:0] y4_sig
	.collision(collision) ,	// output  collision_sig
	.sprite_collision(sprite_collision) 	// output [1:0] sprite_collision_sig
);

endmodule