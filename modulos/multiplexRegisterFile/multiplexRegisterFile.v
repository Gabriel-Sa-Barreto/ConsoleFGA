/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: multiplexador responsavel por selecionar as entradas para o banco de registradores.
--------------------------------------------------------------------------
ENTRADAS: 
  selector: entrada de seleçao do multiplexador
  write_R: numero do registrador vindo do decodificador de instruçao.
   read_R: numero do registrador vindo do modulo de impressao com o objetivo de leitura do mesmo.		 		 
SAIDAS:		 
 outReg1 e o valor selecionado para a entrada do banco de registradores.
//////////////////////////////////////////////////////////////////////////
**/
module multiplexRegisterFile(
	input  wire        selector,
	input  wire  [4:0]  write_R,
	input  wire  [4:0]  read_R,
	output wire  [4:0] outReg1
);

//Para selector = 0 seleciona o valor vindo do decodificador de instruçao.
//Para selector = 1 seleciona o valor vindo do modulo de impressao.
assign ouReg = selector ? write_R : read_R;

endmodule