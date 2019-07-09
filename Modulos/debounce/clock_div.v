// Slow clock for debouncing 
module clock_div(
	input  wire clk, 
	input  wire button_sig,
	output wire slow_clk
);

reg [26:0] counter=0;

assign slow_clk = (counter == 249999) ? 1'b1 : 1'b0;

always @(posedge clk, negedge button_sig)
	begin
		if(button_sig==0)	counter <= 0;
		else counter <= (counter>=249999) ? 0 : counter+1;
end
endmodule