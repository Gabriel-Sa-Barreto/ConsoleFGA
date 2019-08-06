/**
*Descriçao:
*  Modulo responsavel por realizar a uma divisao por N no pulso de clock.
*Inputs:
*  clk: pulso de clock
*  reset: sinal de reset do reiniciar a divisao.
*Outputs:
*  out_clk: pulso de clock dividido de acordo ao parametro configurado. 
*Parametros:
	N: define metade do valor do divisor. Porque a contagem e feita a cada 
*borda de subida do pulso de clock.
*	WITDH: define a quantidade de registros necessarios para realizar a divisao.
*/
module frequency_divisor #(parameter WITDH, parameter N) (
	input  wire clk,
	input  wire reset,
	output wire out_clk 
);

reg new_clock;
reg [WITDH-1:0] counter;
wire [WITDH-1:0] counter_next;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		  counter <= 0;
		new_clock <= 0;
	end
	else if(counter_next == N) begin
		  counter <= 0;
		new_clock <= ~new_clock;
	end
	else counter <= counter_next;
end

assign counter_next = counter + 1;
assign out_clk = new_clock;

endmodule