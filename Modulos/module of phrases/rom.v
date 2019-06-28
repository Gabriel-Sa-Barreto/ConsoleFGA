module ROM (clock, enable_rom, address, data_out);

input			clock;
input			enable_rom;
input	[9:0]	address;

output	[7:0]	data_out;

reg		[7:0]	mem [0:1023];
reg		[7:0]	data_out;

initial
begin
	$readmemb("/home/gabriel/Documentos/ConsoleFPGA/Modulos/module of phrases/bitmaps.txt", mem);
end

always @(negedge clock)
begin
	if (enable_rom)
	begin
		data_out <= mem[address];
	end
end

endmodule
