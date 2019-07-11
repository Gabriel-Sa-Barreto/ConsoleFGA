// iclk = clock input
// in_bit = input from toggle switch
// out_state = output that flows into program
module button_Debounce #(parameter INTERVAL = 0, COUNTER_LIMITE = 0)
(
	input wire clk, 
	input wire data, 
	output reg out_state
); 

reg current_bit;
reg prev_bit;
reg [INTERVAL-1:0] count_bit_diff;
    
always @(posedge clk) begin
  // store current and previous input bit from switch 
  current_bit <= data; 
  prev_bit <= current_bit;
        
  // if previous input bit is different from current 
  if(out_state != prev_bit) begin
		// increment the count
		count_bit_diff <= count_bit_diff + 1'b1;        
      // When count has reached 2^16 - 1, 
      // toggle the current state 
      if(count_bit_diff == COUNTER_LIMITE)          
			out_state <= ~out_state;  
  end
  else begin
    // reset count to 0 
    // when state equal to previous input bit
    count_bit_diff <= 0;
  end 
end 
endmodule