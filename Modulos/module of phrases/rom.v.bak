module ROM (clock, enable_rom, address, data_out);

input			clock;
input			enable_rom;
input	[9:0]	address;

output	[7:0]	data_out;

reg		[7:0]	mem [0:1023];
reg		[7:0]	data_out;

initial
begin
	$readmemb("bitmaps.txt", mem);
end

always @(posedge clock)
begin
	if (enable_rom)
	begin
		data_out <= mem[address];
	end
end

endmodule
