
/*Demultiplexador para a saída Register do decodificador de instrução*/
module demultiplexadorRegister(
	 input wire selector,        //entrada de seleção da saída de dados.
	 input wire [16:0] data,     //entrada de endereços.
	output wire [16:0] out1,     //primeira saída de endereços. (Memória)
 	output wire [4:0] out2       //segunda saída de endereços.   (Banco de registradores)
);

//Bloco combinacional para redirecionamento da entrada.
always @(*) begin
	if(selector == 1'b0) 
		out1 = data;
	else if(selector == 1'b1)
		out2 = data[4:0];
	else begin
		out1 = 17'hxxxxx;
		out2 = 5'hxx;
	end
end
endmodule