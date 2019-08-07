module multiplex(
	input wire [10:0] x1,
	input wire  [9:0] y1,
	input wire [10:0] x2,
	input wire  [9:0] y2,
	input wire [10:0] x3,
	input wire  [9:0] y3,
	input wire [10:0] x4,
	input wire  [9:0] y4,
	input wire [1:0] selector,
	
	output wire [10:0] out_x,
	output wire  [9:0] out_y
);

reg [10:0] coordenate_x;
reg [9:0]  coordenate_y;


assign out_x = coordenate_x;
assign out_y = coordenate_y;

always @ (selector) begin
	case(selector)
		2'b00: begin
			coordenate_x = x1;
			coordenate_y = y1;
		end	
		2'b01: begin
			coordenate_x = x2;
			coordenate_y = y2;
		end
		2'b10: begin
			coordenate_x = x3;
			coordenate_y = y3;
		end
		2'b11: begin
			coordenate_x = x4;
			coordenate_y = y4;
		end
		
		default: begin
			coordenate_x = coordenate_x;
			coordenate_y = coordenate_y;
		end
	endcase
end
endmodule