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
	input wire [31:0] dataA,
	input wire [31:0] dataB,
	input wire        clk_en,
	input wire        new_instruction,

	output wire [1:0]  reg out_opcode,
	output wire [4:0]  reg out_register,
	output wire [31:0] reg out_data
);

//parâmetro que informa a posição fixa em que deve ficar armazenado o valor da cor de background da tela.
 
reg  [1:0] opcode;
reg  [4:0] register;
reg [31:0] data;

//Registra o resultado da decodificação na saída do módulo
always @(posedge clk) begin
	out_opcode   <= opcode;
	out_register <= register;
	out_data     <= data;
end

always @(*) begin
	if(new_instruction == 1'b0) begin //novas instructions podem ser decodificadas 
		if(clk_en == 1'b1) begin
			opcode = dataA[1:0];
			case (dataA[1:0])
				4'b00: begin                 //instruçao de alterar posiçao de um sprite.
					register = dataA[8:4];   //output Register.
					    data = dataB[31:0];  //output data (valores de x e y).
				end
				4'b01: begin                 //instruçao de escrita na memória de sprites.
					register = dataA[17:0];  //endereço onde os dados serão escritos.
					    data = dataB[31:0];  //output data (valor de nova cor).
				end
				4'b10: begin                 //instruçao de alterar offset de memoria associado a um sprite.
					register = dataA[8:4];   //output Register.
					    data = dataB[31:0];  //output data (valor de offset).
				end
				4'b11: begin                 //instrução para consultar o status do módulo de impressão.
					register = 5'dx;
					data     = 32'dx;
				end
				default: begin
				    opcode   = 2'dx;
					register = 5'dx;
					data     = 32'dx;
				end
			endcase
		end
		else begin
			opcode   = 2'hx;
			register = 5'hxx;
			data     = 32'hxxxxxxxx;
		end
	end
	else begin   //As saídas permanecem as mesmas caso ainda não possam ser executadas novas instruções.
		opcode   = opcode;
		register = register;
		data     = data;
	end
end

endmodule