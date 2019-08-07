/* 
Modulo counter(contador)
Descricao:
	Modulo que realiza uma determinada contagem de 0 a N. A quantidade de
vezes que sera feita a contagem dependera dos valores dos parametros. 
*/
module counter #(parameter WIDTH = 2, parameter LIMITE = 4) (
	input wire clk,              //pulso de clock
	input wire reset,            //sinal para reiniciar a contagem
	output wire [WIDTH-1:0] out_counter
);

reg [WIDTH-1:0] counter;

assign out_counter = counter; //atribuiçao do valor de saida

always @ (posedge clk or posedge reset) begin
	if(reset) //reinicia a contagem
		counter <= 0;
	else if(counter == LIMITE-1) 
		counter <= 0;
	else
		counter <= counter + 1; //incrementa uma contagem
end

endmodule