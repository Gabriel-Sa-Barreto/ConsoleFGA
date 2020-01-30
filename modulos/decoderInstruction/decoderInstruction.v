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

	output wire [1:0]  opcode,
	output wire [4:0]  register,
	output wire [31:0] data
);

always @(clk_en) begin
	if(clk_en == 1'b1) begin
		if(new_instruction == 1'b0) begin    //Uma nova instruçao pode ser decodificada.
			opcode = dataA[1:0];
			case (dataA[1:0])
				4'b00: begin                 //instruçao de alterar posiçao de um sprite.
					register = dataA[8:4];   //output Register.
					    data = dataB[31:0];  //output data (valores de x e y).
				end
				4'b01: begin                 //instruçao de alterar o background da tela.
					register = dataA[8:4];   //output Register.
					    data = dataB[31:0];  //output data (valor de nova cor).
				end
				4'b10: begin                 //instruçao de alterar offset de memoria associado a um sprite.
					register = dataA[8:4];   //output Register.
					    data = dataB[31:0];  //output data (valor de offset).
				end
				4'b11: begin
				end
				default: begin
				    opcode   = 2'dx;
					register = 5'dx;
					data     = 32'dx;
				end
			endcase
		end
		else begin                         //A instruçao anterior ainda esta em execuçao.
		    opcode   = 2'dx;
			register = 5'dx;
			data     = 32'dx;
		end
	end
	else
end

endmodule