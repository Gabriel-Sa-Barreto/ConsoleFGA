module controleUnitTeste;

integer dataLine;  //número total de linhas a serem lidas do arquivo de entrada.

reg [5:0]  inputDatas [0:31];

//Entradas
reg clk;
reg reset;
reg [3:0] opCode;
reg printtingScreen;
reg done;
//////////////////////////////

//Saídas
wire new_instruction;
wire memory_wr;
wire [3:0] selectField;
wire register_wr;
wire selectorDemuxRegister;
wire selectorDemuxData;
wire selectorAddress;
//////////////////

always begin
	clk = 1'b1;
	#10;
	clk = 1'b0;
	#10;
end

initial 
	begin
		//Inicializando os registros de entrada.
		opCode = 4'bxxxx;
		done   = 1'bx;
		printtingScreen = 1'bx;
		dataLine = 0;
		///////////////////////////////////////////

		//leitura dos dados de entrada
		$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/ControlUnitTest/inputDatas.mem", inputDatas);

		#20; //delay de 20 milisegundos
		reset = 0; //reseta a máquina de estados da unidade de controle.
		#20; //delay de 20 milisegundos
		reset = 1;

		for(dataLine = 0; dataLine < 32; dataLine = dataLine + 1) begin
			{opCode,done,printtingScreen} <= inputDatas[dataLine];
			@(negedge clk); //espera a borda de descida do pulso de clock onde as saídas são geradas
			///////////////////////////////////////////////////////////////
			$display("Entrada %d", dataLine);
			$monitor("Saida do sistema: %b%b%b%b%b%b%b" , new_instruction,memory_wr,selectField,register_wr,selectorDemuxRegister,selectorDemuxData,selectorAddress);
			@(posedge clk); //espera a borda de subida do clock para a geração de novas entradas na unidade de controle
			$display("//////////////////////////////////");
		end
		$stop; //encerra a simulação
	end

controlUnit controlUnit_inst
(
	.clk(clk) ,	                                   	// input   clk_sig
	.reset(reset) ,	                                // input   reset_sig
	.opCode(opCode) ,	                            // input  [3:0] opCode_sig
	.printtingScreen(printtingScreen) ,	            // input   printtingScreen_sig
	.done(done) ,	                                // input   done_sig
	.new_instruction(new_instruction) ,	            // output  new_instruction_sig
	.memory_wr(memory_wr) ,	                        // output  memory_wr_sig
	.selectField(selectField) ,	                    // output [3:0] selectField_sig
	.register_wr(register_wr) ,	                    // output  register_wr_sig
	.selectorDemuxRegister(selectorDemuxRegister) ,	// output  selectorDemuxRegister_sig
	.selectorDemuxData(selectorDemuxData) ,	        // output  selectorDemuxData_sig
	.selectorAddress(selectorAddress) 	            // output  selectorAddress_sig
);

endmodule