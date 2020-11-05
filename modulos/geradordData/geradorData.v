module geradorData (
	input  wire clk,
	input  wire reset,
	input  wire [31:0] dataA,
	input  wire [31:0] dataB,

	output reg [31:0] out_dataA,
	output reg [31:0] out_dataB
);


localparam [1:0]    RECEBER_DATA_A = 2'b00,
					RECEBER_DATA_B = 2'b01,
					LIMPAR_DATAS   = 2'b10;


reg [1:0] state, next;
reg [31:0] aux_dataA;
reg [31:0] aux_dataB;

always @(posedge clk or negedge reset) begin
	if(!reset)
		state <= RECEBER_DATA_A;
	else 
		state <= next;
end

always @(state or dataA or dataB) begin
	next = 2'bxx;
	case(state)
		RECEBER_DATA_A: begin
			if(dataA[18] == 1'b1) begin
				next = RECEBER_DATA_B;
			end
			else begin
				next = RECEBER_DATA_A;
			end
		end

		RECEBER_DATA_B: begin
			if(dataB[30] == 1'b1) begin
				next      = LIMPAR_DATAS;
			end
			else begin
				next = RECEBER_DATA_B;
			end
		end

		LIMPAR_DATAS: begin
			next      = RECEBER_DATA_A;
		end
		
		default: begin
			next = RECEBER_DATA_A;
		end
	endcase
end


always @(negedge clk or negedge reset) begin
	if(!reset) begin
		out_dataA <= 32'dx;
		out_dataB <= 32'dx;
	end 
	else begin
		case(state)
			RECEBER_DATA_A: begin
				aux_dataA[17:0]    <= dataA[17:0];
				aux_dataA[31:18]   <= 14'd0;
			end

			RECEBER_DATA_B: begin
				aux_dataB <= dataB;
			end

			LIMPAR_DATAS: begin
				out_dataA <= aux_dataA;
				out_dataB <= aux_dataB;
			end

			default: begin
				out_dataA <= out_dataA;
				out_dataB <= out_dataB;
			end
		endcase
	end
end

endmodule