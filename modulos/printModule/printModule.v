/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: modulo responsavel por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	data_reg:    valor recebido do banco de registradores.
	active_area: sinal que informa se o monitor esta na area ativa ou nao.
	pixel_x:     coordenada x atual do monitor.
	pixel_y:     coordenada y atual do monitor.
SAIDAS:		 
	address_memory:   endereço a ser acessado na memoria.
	check_value:      valor de coordenada a ser comparado com valores armazenados no banco de registradores. 
   printtingScreeen: sinal de status do modulo de impressao. (1-imprimindo, 0-nao imprimindo).     
//////////////////////////////////////////////////////////////////////////
**/
module printModule(
	input wire        clk,
	input wire        reset,
	input wire [8:0]  data_reg,
	input wire        active_area,
	input wire  [8:0] pixel_x,
	input wire  [8:0] pixel_y,
   output wire [16:0] address_memory,
   output wire        printtingScreen, 
   output wire [17:0] check_value,	
);


parameter [1:0] RECEBE   = 2'b00,
				PROCESSA = 2'b01,
				SPRITE   = 2'b10;

parameter [17:0] address_BG;
parameter [4:0]  lineSprite = 20; //sprites com tamanho 20x20
parameter [9:0]  screen_x = 480;
parameter [9:0]  screen_y = 320;

reg [1:0] next, state;
reg [4:0] counter;

reg [16:0] out_address_memory;
reg        out_printtingScreen; 
reg [17:0] out_check_value;

always(posedge clk or negedge reset) begin
	if(!reset) 
		state <= RECEBE;
	else 
		state <= next;
end

/*Bloco combinacional responsável pela mudança de estados*/
always @(state, active_area, pixel_x, pixel_y, data_reg) begin
	next = 2'bxx;
	case(state)
		//só volta/entra no estado de RECEBE se somente se foi finalizado uma impressão da linha de um sprite
		//ou foi impresso um pixel no background.
		RECEBE:
			begin
				if(active_area) next = PROCESSA;
				else next = RECEBE;						
			end	
		PROCESSA:
			begin
				if(data_reg == 8'b00000001) begin //pixel atual pertence ao background do monitor.
					next = RECEBE;                //retorna ao estado inicial
				end
				else begin
					next = SPRITE;                //sprite detectado.
				end
			end 
		SPRITE:
			begin
				//último pixel do sprite, ou seja, no próximo pulso de clock retorna ao estado inicial.
				if(counter == 5'd19) next = RECEBE;
				else                 next = SPRITE;
			end
		default: next = RECEBE;
	endcase
end

/*Bloco always responsável por gerenciar as saídas do módulo*/
always @(posedge clk or negedge reset) begin
	if(!reset) begin

	end
	else begin
		case(state) 
			RECEBE:
				if(active_area) begin
					//envio de coordenadas para comparação.
					out_check_value[8:0]  <= pixel_y; 
					out_check_value[17:9] <= pixel_x;
				end
			PROCESSA:
				if(data_reg == 8'b00000001) begin //pixel atual pertence ao background do monitor.
					out_address_memory <= address_BG;  //endereço de memória onde está localizado a cor de background.
				end
				else out_address_memory <= 18'hxxxxx;
			SPRITE:
	end
end

/*Bloco always que define se o módulo está em impressão de tela ou não*/
always @(posedge clk) begin
	if( active_area && (pixel_x >= 0 && pixel_x < screen_x) && (pixel_y >= 0 && pixel_y < screen_y) ) 
		out_printtingScreen = 1;
	else 
		out_printtingScreen = 0;
end

/*Atribuição contínua da saída*/
assign out_address_memory  = address_memory;
assign out_printtingScreen = printtingScreen; 
assign out_check_value     = check_value;


































endmodule