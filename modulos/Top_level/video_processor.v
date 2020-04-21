module video_processor(
	input wire clk,
	input wire clk_pixel,
	input wire clk_en,
	input wire reset,
	input wire [31:0] dataA,
	input wire [31:0] dataB,

	output reg [2:0] R,
	output reg [2:0] G,
	output reg [2:0] B,
	output reg      out_printtingScreen,
	output wire     out_hsync,
	output wire     out_vsync
);

/*------------------Fios de ligação entre os módulos---------------------*/
wire        new_instruction;
wire 		done;
wire [1:0]  out_opcode;
wire [17:0] out_register;
wire [31:0] out_data;
wire 		success;
wire [4:0]  n_reg;
wire [31:0] register_data;
wire 		printtingScreen;
wire [18:0] check_value;
wire [31:0] data_reg;
wire [16:0] memory_address;
wire [16:0] decoded_address;
wire 		active_area;
/*------------------------------------------------------------------------*/

/*-----Sinais da unidade de controle para o gerenciamento dos módulos-----*/
wire 	   memmory_wr;
wire [3:0] selectField;
wire 	   register_wr;
wire 	   selectorDemuxRegister;
wire 	   selectorDemuxData;
wire 	   selectorAddress;
/*------------------------------------------------------------------------*/

reg reg_done;

decorderInstruction 
decorderInstruction_inst
(
	.clk(clk) ,							// input  clk_sig
	.clk_en(clk_en) ,					// input  clk_en_sig
	.dataA(dataA) ,						// input [31:0] dataA_sig
	.dataB(dataB) ,						// input [31:0] dataB_sig
	.new_instruction(new_instruction) ,	// input  new_instruction_sig
	.reset(reset) ,						// input  reset_sig
	.out_opcode(out_opcode) ,			// output [1:0]  out_opcode_sig
	.out_register(out_register) ,		// output [17:0] out_register_sig
	.out_data(out_data) 				// output [31:0] out_data_sig
);

controlUnit 
controlUnit_inst
(
	.clk(clk) ,								// input  clk_sig
	.reset(reset) ,							// input  reset_sig
	.opCode(out_opCode) ,					// input [3:0] opCode_sig
	.printtingScreen(printtingScreen) ,		// input  printtingScreen_sig
	.done(reg_done) ,					    // input  done_sig
	.new_instruction(new_instruction) ,		// output  new_instruction_sig
	.memory_wr(memory_wr) ,					// output  memory_wr_sig
	.selectField(selectField) ,						// output [3:0] selectField_sig
	.register_wr(register_wr) ,						// output  register_wr_sig
	.selectorDemuxRegister(selectorDemuxRegister) ,	// output  selectorDemuxRegister_sig
	.selectorDemuxData(selectorDemuxData) ,			// output  selectorDemuxData_sig
	.selectorAddress(selectorAddress) 				// output  selectorAddress_sig
);


/*--------Demultiplexador para redirecionamento da saída "out_register" do decodificador de instrução--------*/
demultiplexador #(.data_bits(17), .out1_bits_size(17), .out2_bits_size(5), .bits_to_out1(17), .bits_to_out2(5))
demultiplexador_inst
(
	.selector(selectorDemuxRegister) ,	// input  selector_sig
	.data(out_register) ,				// input [data_bits-1:0] data_sig
	.out1(decoded_address) ,		    // output [out1_bits_size-1:0] out1_sig (para a memoria)
	.out2(n_reg) 					    // output [out2_bits_size-1:0] out2_sig (para o banco de registradores)
);


/*--------Demultiplexador para redirecionamento da saída "data" do decodificador de instrução--------*/
demultiplexador #(.data_bits(32), .out1_bits_size(9), .out2_bits_size(32), .bits_to_out1(9), .bits_to_out2(32))
demultiplexador_inst
(
	.selector(selectorDemuxData) ,		// input  selector_sig
	.data(out_data) ,					// input [data_bits-1:0] data_sig
	.out1() ,							// output [out1_bits_size-1:0] out1_sig (para a memoria)
	.out2(register_data) 			    // output [out2_bits_size-1:0] out2_sig (para o banco de registradores)
);

registerFile registerFile_inst
(
	.clk(clk) ,						// input  clk_sig
	.n_reg(n_reg) ,					// input [4:0] n_reg_sig
	.check() ,					    // input [17:0] check_sig
	.data(register_data) ,			// input [31:0] data_sig
	.written(register_wr) ,			// input  written_sig
	.selectField(selectField) ,		// input [3:0] selectField_sig
	.out_readData(data_reg) ,		// output [31:0] out_readData_sig
	.success(success) 				// output  success_sig
);

full_print_module #(.size_x1(10), .size_y1(9), .size_address1(17), bits_x_y_1(19), size_line1(20))
full_print_module_inst
(
	.clk(clk) ,									// input  clk_sig
	.clk_pixel(clk_pixel) ,						// input  clk_pixel_sig
	.reset(reset) ,								// input  reset_sig
	.data_reg(data_reg) ,						// input [31:0] data_reg_sig
	.active_area(active_area) ,					// input  active_area_sig
	.pixel_x(pixel_x) ,							// input [size_x1-1:0] pixel_x_sig
	.pixel_y(pixel_y) ,							// input [size_y1-1:0] pixel_y_sig
	.memory_address(memory_address) ,	        // output [size_address1-1:0] memory_address_sig
	.printtingScreen(printtingScreen) ,			// output  printtingScreen_sig
	.check_value(check_value_sig) 				// output [bits_x_y_1-1:0] check_value_sig
);

/*-------Multiplexador para selecionar a entrada de endereço para a memória de sprites--------*/
multiplexador #(.data_bits1(17), .data_bits2(17), .out_bits_size(17))
multiplexador_inst
(
	.selector(selectorAddress) ,   	// input  selector_sig
	.data(decoded_address) ,		// input [data_bits1-1:0] data_sig  (vem do decodificador)
	.data2(memory_address) ,		// input [data_bits2-1:0] data2_sig (vem do módulo de impressão)
	.out() 							// output [out_bits_size-1:0] out_sig
);


/*------------Módulo para geração do sinais de sincronização do monitor e seus pixeis-----------*/
VGA_sync VGA_sync_inst
(
	.clock(clk_pixel) ,					// input  clock_sig
	.reset(reset) ,						// input  reset_sig
	.hsync(out_hsync) ,					// output  hsync_sig
	.vsync(out_vsync) ,					// output  vsync_sig
	.video_enable(active_area) ,	    // output  video_enable_sig
	.pixel_x(pixel_x) ,					// output [9:0] pixel_x_sig
	.pixel_y(pixel_y) 					// output [8:0] pixel_y_sig
);

/*
	Bloco combinacional para verificar se um registro no banco de registradores ou uma leitura na memória foi realiza com sucesso.
*/
always @(success or read_Memory) begin 
	reg_done = sucess | read_Memory;
end

always @(negedge clk_pixel) begin
	if(active_area && read_Memory) begin
		R <=
		G <=
		B <=  
	end
	else begin
		R <= 3'd0;
		G <= 3'd0;
		B <= 3'd0;
	end
	out_printtingScreen  <= prittingScreen;
end


endmodule