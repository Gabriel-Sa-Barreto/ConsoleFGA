
/*Demultiplexador para saída de dados do decodificador de instrução*/
module demultiplexador(
	 input wire selector,        //entrada de seleção da saída de dados.
	 input wire [31:0] data,     //entrada de dados.
	output wire [31:0] out1,     //primeira saída de dados. (Memória)
 	output wire [31:0] out2      //segunda saída de dados.
);

//Bloco combinacional para redirecionamento da entrada.
always @(*) begin
	if(selector == 1'b0) 
		out1 = data;
	else if(selector == 1'b1)
		out2 = data;
	else begin
		out1 = 32'hxxxxxxxx;
		out2 = 32'hxxxxxxxx;
	end
end
endmodule