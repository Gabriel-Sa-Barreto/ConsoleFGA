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
	output wire [27:0] data
);

reg [1:0]  outOpcode;
reg [4:0]  outRegister;
reg [27:0] outData;

always @(posedge clk_en) begin
	if(new_instruction == 1'b0) begin     //Uma nova instruçao pode ser decodificada.
		outOpcode <= dataA[1:0];
		case (dataA[1:0])
			4'b00: begin                    //instruçao de alterar posiçao de um sprite
				outRegister <= dataA[8:4];   //output Register
				outData     <= dataB[27:0];  //output data (valores de x e y)
			end
			4'b01: begin                    //instruçao de alterar o background da tela.
				outRegister <= dataA[8:4];   //output Register
				outData     <= dataB[27:0];  //output data (valor de nova cor)
			end
			4'b10: begin                    //instruçao de alterar offset de memoria associado a um sprite.
				outRegister <= dataA[8:4];   //output Register
				outData     <= dataB[27:0];  //output data (valor de offset)
			end
			4'b11: begin
			end
			default: begin
			   outOpcode   <= 2'bx;
				outRegister <= 5'bx;
				outData     <= 28'bx;
			end
		endcase
	end
	else begin                         //A instruçao anterior ainda esta em execuçao.
	   outOpcode   <= outOpcode;
		outRegister <= outRegister;
		outData     <= outData;
	end
end

//Atribuicao continua dos valores de saida.
assign   opcode = outOpcode;
assign register = outRegister;
assign     data = outData;

endmodule