module geradorDataB(
	input  wire [3:0] switch,
	output reg [31:0] outData
);


always @(switch) begin
	outData = 32'd0;
	case(switch)
		4'd0:	outData = 32'h21906400;  //coodenadas: x = 50, y = 50  
		4'd1:	outData = 32'h21935c00;  //coodenadas: x = 50, y = 430
		4'd2:	outData = 32'h32706400;  //coodenadas: x = 590, y = 50
		4'd3:	outData = 32'h32735c00;  //coodenadas: x = 590, y = 430
		4'd4:	outData = 32'h2a01e000;  //coodenadas: x = 320, y = 240
		
		4'd5:	outData = 32'h2320c800;  //coodenadas: x = 100, y = 100
		4'd6:	outData = 32'h24b19000;  //coodenadas: x = 150, y = 200
		4'd7:	outData = 32'h30432000;  //coodenadas: x = 520, y = 400
		4'd8:	outData = 32'h27525800;  //coodenadas: x = 234, y = 300
		4'd9:	outData = 32'h27d38400;  //coodenadas: x = 250, y = 450
		4'd10:	outData = 32'h22489200;  //coodenadas: x = 73, y = 73
		4'd11:	outData = 32'h2318c800;  //coodenadas: x = 99, y = 100
		4'd12:	outData = 32'h26410400;  //coodenadas: x = 200, y = 130
		4'd13:	outData = 32'h237ab000;  //coodenadas: x = 111, y = 344
		4'd14:	outData = 32'h2d88f600;  //coodenadas: x = 433, y = 123
		4'd15:	outData = 32'h2c81cc00;  //coodenadas: x = 400, y = 230
		default: outData = 32'h20000000; //coodenadas: x = 0, y = 0
	endcase
end


endmodule