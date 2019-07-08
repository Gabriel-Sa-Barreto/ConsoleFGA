module testSpriteMoveFSM;
	
reg clk;
reg reset;
reg left;
reg right;
reg up;
reg down;
wire [2:0] dataout;

integer i;
//[4:0] 5 bit data input
//[39:0] number of rows in file "inputMoveFSM.txt" is equal to 40.
reg [4:0] file_input [39:0];

always begin
	clk = 1;
	#20;
	clk = ~clk;
	#20;
end

initial begin
	$readmemb("/home/lablenda2/Documentos/Gabriel_Sa/ConsoleFPGA/testbenchs/module_spriteMoveFSM/inputMoveFSM.txt", file_input);

	for(i = 0; i < 40; i = i+1) begin
		{reset,left,right,up,down} = file_input[i];
		@ (negedge clk);
		if(dataout == 3'b000)      $display("State: DEFAULT");
		else if(dataout == 3'b001) $display("State: RIGHT");
		else if(dataout == 3'b010) $display("State: DOWN");
		else if(dataout == 3'b011) $display("State: UP");
		else if(dataout == 3'b100) $display("State: LEFT");
		$display("%d: ", reset);
		$display("%d: ", left);
		$display("%d: ", right);
		$display("%d: ", up);
		$display("%d: ", down);
		$display("//////////////////////////////");
	end
end

spriteMoveFSM fsm_inst(
	.clk(clk),       //input  clk_sig
	.reset(reset),     //input  reset_sig
	.left(left),      //input  left_sig
	.right(right),     //input  right_sig 
	.up(up),        //input  up_sig
	.down(down),      //input  down_sig
	.dataout(dataout)    //output [2:0] dataout_sig
);


endmodule