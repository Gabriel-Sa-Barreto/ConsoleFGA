/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: modulo decodificador de instruçao, responsavel por receber
as instruçoes do processador de video e separar seus determinados campos.
--------------------------------------------------------------------------
ENTRADAS: 
  dataA e dataB: campos que compoem a estrutura da instruçao.
         clk_en: sinal que indica em nivel alto que uma nova instruçao foi recebida. 
new_instruction: sinal que informa ao decodificador de instruçao se pode ou não 
decodificar uma nova instrução que for enviada.
		 		 
SAIDAS:		 
   opcode: valor que indica a unidade de controle qual instruçao sera executada.
 regsiter: identificaçao do registrador no banco de registrador.
     data: valores a serem escritos no banco de registradores.
//////////////////////////////////////////////////////////////////////////
**/
module decorderInstruction(
	input wire        clk,
	input wire        clk_en,
	input wire [31:0] dataA,
	input wire [31:0] dataB,
	input wire        new_instruction,
	input wire        reset,
	output reg [3:0]   out_opcode,
	output reg [13:0]  out_register,
	output reg [31:0]  out_data
);

//parâmetro que informa a posição fixa em que deve ficar armazenado o valor da cor de background da tela.
 
reg [3:0]  opcode;
reg [13:0] register;
reg [31:0] data;

//Registra o resultado da decodificação na saída do módulo
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		out_opcode   <=  4'bxxxx;
		out_register <= 14'bxxxxxxxxxxxxxx;
		out_data     <= 32'hxxxxxxxx;
	end
	else begin
		out_opcode   <= opcode;
		out_register <= register;
		out_data     <= data;
	end
end

always @(*) begin
	if(new_instruction == 1'b0) begin 				//novas instruções podem ser decodificadas 
		if(clk_en == 1'b1) begin
			opcode = dataA[3:0];
			case (dataA[3:0])
				4'b0000: begin                 		//instruçao de alterar posiçao de um sprite.
					register[4:0]  = dataA[8:4];    //output Register.
					register[13:5] = 9'd0; 
					    data = dataB[31:0];  		//output data (valores de x e y).
				end
				4'b0001: begin                 		//instruçao de escrita na memória de sprites.
					register = dataA[13:0];  		//endereço onde os dados serão escritos.
					    data = dataB[31:0];  		//output data (valor de nova cor).
				end
				4'b0010: begin                 		//instruçao de alterar offset de memoria associado a um sprite.
					register[4:0] = dataA[8:4];   	//output Register.
					register[13:5] = 9'd0;
					data = dataB[31:0];  			//output data (valor de offset).
				end
				4'b0011: begin
					register = 14'bxxxxxxxxxxxxxx;
					data     = 32'dx;
				end
				default: begin
				   	opcode   = 4'b1111; //valor default de opcode
					register = 0;       //valor default de register
					data     = 0;       //valor default de data
				end
			endcase
		end
		else begin
			opcode   = 4'b1111; //valor default de opcode
			register = 0;       //valor default de register
			data     = 0;       //valor default de data
		end
	end
	else begin   			//As saídas permanecem as mesmas caso ainda não possam ser executadas novas instruções.
		opcode   = 4'b1111; //valor default de opcode
		register = 0;       //valor default de register
		data     = 0;       //valor default de data
	end
end

endmodule