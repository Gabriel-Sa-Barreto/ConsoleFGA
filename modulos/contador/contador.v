module contador #(parameter MAX_VALUE = 640, parameter MIN_VALUE = 0)(
	input wire clk,
	input wire button1,
	input wire button2,
	input wire reset,
	output wire [9:0] outputData
);

reg [9:0] value;
wire out_clk;

frequency_divisor #(.WITDH(20),.N(600000))
frequency_divisor_inst
(
	.clk(clk) ,			// input  clk_sig
	.reset(reset) ,		// input  reset_sig
	.out_clk(out_clk)	// output  out_clk_sig
);

always @(posedge out_clk or negedge reset) begin
	if(!reset) begin
		value <= 10'd0;
	end
	else begin
		if(button1 == 1'b0) begin
			if(value == MIN_VALUE) begin
				value <= value;
			end
			else begin
				value <= value - 10'd1;
			end
		end
		else if(button2 == 1'b0) begin
			if(value == MAX_VALUE) begin
				value <= value;
			end
			else begin
				value <= value + 10'd1;
			end
		end
		else begin
			value <= value;
		end
	end
end

assign outputData = value;


endmodule