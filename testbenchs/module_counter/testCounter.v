module testCounter;

reg clk;
reg reset;
wire [3:0] out_counter;

always 
begin
	clk = 0;
	forever #20 clk = ~clk; 
end


initial begin
	#5 reset = 1;
	#5 reset = 0;
	#800; //executa por mais 800 unidades de tempo
	#5 reset = 1;
	#5 reset = 0;
	#200; //executa por mais 800 unidades de tempo
	$finish;
end

initial begin
	$monitor("out_counter: %d, CLK: %d", out_counter, clk);
end 


counter #(.WIDTH(4), .LIMITE(16))
counter_inst
(
	.clk(clk) ,					// input  clk_sig
	.reset(reset) ,				// input  reset_sig
	.out_counter(out_counter) 	// output [WIDTH-1:0] out_counter_sig
);

endmodule