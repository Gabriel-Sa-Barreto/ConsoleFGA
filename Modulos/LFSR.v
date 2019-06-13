module LFSR(
		input  wire        clk,
		input  wire        reset,
		output wire [12:0] value 
);



reg [12:0] random, random_next, random_done;
reg [3:0]  counter, count_next; //to keep track of the shifts

wire xorRegisters;
 
always @ (posedge clk or posedge reset)
begin
	if (reset) begin
		random  <= 13'hF; //An LFSR cannot have an all 0 state, thus reset to FF
		counter <= 0;
	end
	else begin
		random  <= random_next;
		counter <= count_next;
	end
end
 
always @ (*)
begin
	random_next = random; //default state stays the same
	count_next = counter;
   
	random_next = {random[11:0], xorRegisters}; //shift left the xor'd every posedge clock
	count_next = counter + 1;
 
	if (counter == 13) begin
		counter = 0;
		random_done = random; //assign the random number to output after 13 shifts
	end
end

assign xorRegisters = random[12] ^ random[3] ^ random[2] ^ random[0];  
assign value = random_done;

endmodule
