module phrases(
	input wire clk,
	input wire reset,
	input wire ready,
	input wire videoEnable,
	input wire [8:0]  letterColor,
	input wire [10:0] pixel_x,
	input wire [9:0]  pixel_y,
	input wire [7:0]  letters,
	input wire [12:0] address,
	output reg [8:0]  colors,
	output reg        dataReady
);

reg [8:0] colour;

wire	[12:0]	ram_address;
wire	[9:0]	   rom_address;
wire	[7:0]	   rom_data, ram_data;
wire	[6:0]	   char_x;
wire	[6:0]	   char_y;
wire	[2:0]	   char_col;
wire	[2:0]	   char_row;
wire			   pixel;


assign	char_x = pixel_x[10:3];
assign	char_y = pixel_y[9:3];
assign	char_col = pixel_x[2:0] - 1;
assign	char_row = pixel_y[2:0];
assign	ram_address = char_x + (100 * char_y);
assign	rom_address = {ram_data[6:0], char_row};
assign	pixel = rom_data[~char_col];

RAM				 Map(.clock(clk),
					 .enable_ram(1'b1),
					 .write_enable(ready),
					 .address_wr(address),
					 .address_rd(ram_address),
					 .data_in(letters),
					 .data_out(ram_data)
					);

ROM		  		Font(.clock(clk),
					 .enable_rom(1'b1),
					 .address(rom_address),
					 .data_out(rom_data)
					);

always @ *
	begin
		if (videoEnable) begin
				if (pixel) begin
						colors    = colour;
						dataReady = 1;
				end
				else dataReady  = 0;
		end
	end

always @ (posedge clk) begin
	colour <= letterColor;
end


endmodule