
/*Demultiplexador para a saída Register do decodificador de instrução*/
module multiplexadorAddress(
	 input wire selector,        //entrada de seleção da saída de dados.
	 input wire [16:0] data,     //entrada de endereços (Vindo do decodificador de instrução)
	 input wire [16:0] data2,    //entrada de endereços (Vindo do módulo de impressão)
 	output wire [16:0] out       //segunda saída de endereços. (Memória)
);

//Bloco combinacional para seleção das entradas.
always @(*) begin
	if(selector == 1'b0)
		 data = out;
	else if(selector == 1'b1) 
		data2 = out;
	else out = 16'hxxxx;
end
endmodule