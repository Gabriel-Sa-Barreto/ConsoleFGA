module decodeInstruction_test();

reg clk;
reg clk_en;
reg [31:0] dataA;
reg [31:0] dataB;
reg new_instruction;
reg reset;
wire [3:0] out_opcode;
wire [13:0]  out_register;
wire [31:0]  out_data;

always begin //frequência de funcionamento do módulo
	clk = 1'b1;
	#5;
	clk = 1'b0;
	#5;
end

initial begin
	reset = 0; //reseta o módulo
	@(posedge clk);
	$monitor("out_opcode: %b | out_register: %b | out_data: %b" , out_opcode, out_register, out_data);
	reset = 1;
	clk_en = 1;
	dataA = 32'b00000000000000111111111111110001;
	dataB = 32'b00000000000000000000000000111000;
	new_instruction = 1'b0;
	@(posedge clk);
	$monitor("out_opcode: %b | out_register: %b | out_data: %b" , out_opcode, out_register, out_data);

	#20;
	$stop;

end
decorderInstruction decorderInstruction_inst
(
	.clk(clk) ,				// input  clk_sig
	.clk_en(clk_en) ,	    // input  clk_en_sig
	.dataA(dataA) ,		// input [31:0] dataA_sig
	.dataB(dataB) ,	// input [31:0] dataB_sig
	.new_instruction(new_instruction) ,	// input  new_instruction_sig
	.reset(reset) ,	// input  reset_sig
	.out_opcode(out_opcode) ,	// output [3:0] out_opcode_sig
	.out_register(out_register) ,	// output [13:0] out_register_sig
	.out_data(out_data) 	// output [31:0] out_data_sig
);


endmodule