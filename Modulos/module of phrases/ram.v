module RAM (clock, enable_ram, write_enable, address_wr, address_rd, data_in, data_out);

input 			clock, enable_ram, write_enable;
input	[12:0]	address_wr, address_rd;
input	[7:0]		data_in;

output	[7:0]	data_out;

reg		[7:0]	mem [8191:0];
reg		[7:0]	data_out;

integer n;

initial
begin
	for(n=0; n<4192; n=n+1)
		mem[n] = 8'h0;
	for(n=4192; n<8192; n=n+1)
		mem[n] = 8'h0;
end
  
always @(negedge clock)
begin
	if (enable_ram)
	begin
		if (write_enable)
		begin
			mem[address_wr] <= data_in;
		end
		data_out <= mem[address_rd];
	end
end

endmodule
