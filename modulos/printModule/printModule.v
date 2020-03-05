/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sá Barreto Alves
DESCRICAO: modulo responsável por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	clk_pixel:   clock utilizado na interface VGA. 
	data_reg:    valor recebido do banco de registradores.
	active_area: sinal que informa se o monitor esta na area ativa ou nao.
	new_pixel:   sinal que informa se um novo pixel foi gerado.
	pixel_x:     coordenada x atual do monitor.
	pixel_y:     coordenada y atual do monitor.
SAIDAS:		 
	address_memory:   endereço a ser acessado na memoria.
	check_value:      valor de coordenada a ser comparado com valores armazenados no banco de registradores. 
   printtingScreeen:  sinal de status do modulo de impressao. (1-imprimindo, 0-nao imprimindo).     
//////////////////////////////////////////////////////////////////////////
**/
module printModule(
	input wire        clk,
	input wire        clk_pixel,
	input wire        reset,
	input wire [31:0]  data_reg,
	input wire        active_area,
	input wire        new_pixel,
	input wire  [8:0] pixel_x,
	input wire  [8:0] pixel_y,
   output wire [16:0] address_memory,
   output wire        printtingScreen, 
   output wire [17:0] check_value,	
);

parameter [1:0] RECEBE   = 2'b00,
				PROCESSA = 2'b01,
				SPRITE   = 2'b10,  
				AGUARDO  = 2'b11;

parameter [17:0] address_BG = 115200;
parameter [4:0]  lineSprite = 20; //sprites com tamanho 20x20
parameter [9:0]  screen_x = 480;
parameter [9:0]  screen_y = 320;

reg [1:0]  next, state;
reg [1:0]  counter;
reg [4:0]  counterLine;
reg [17:0] adrs_sprite;
 
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
always @(state, pixel_x, pixel_y, data_reg) begin
	next = 2'bxx;
	case(state)
		//só volta/entra no estado de RECEBE se somente se foi finalizado uma impressão da linha de um sprite
		//ou o tempo de aguardo depois de impresso a cor de background.
		RECEBE:
			begin
				if(active_area) 
					next = PROCESSA;
				else 
					next = RECEBE;						
			end	

		PROCESSA:
			begin
				if(data_reg == 32'h00000001) begin //pixel atual pertence ao background do monitor.
					next = AGUARDO;               
				end
				else begin
					next = SPRITE;                //sprite detectado.
				end
			end 

		SPRITE:
			begin
				if(counterLine == 5'd19) begin    //último pixel da linha do sprite.
					next = RECEBE;
				end
				else begin
					next = SPRITE;
					//verificação de condição para calculo de endereço.
					if( (data_reg[26:18] >= pixel_x) && (data_reg[26:18] < (pixel_x + spriteLine-1)) ) begin
						//calcula o endereço de memória para a cor do pixel do sprite.
						if(data_reg[26:18] == pixel_x) begin
							adrs_sprite = data_reg[8:0]; //primeira posição do sprite
						end	
						else adrs_sprite = adrs_sprite + 1;
					end
				end
			end

		AGUARDO:
			begin
				if(counter == 2'd1) begin
					next = RECEBE;  //o tempo de aguardo foi finalizado.
				end
				else begin 
					next = AGUARDO;
				end
			end
		default: next = RECEBE;
	endcase
end

/*Bloco always responsável por gerenciar as saídas do módulo*/
always @(negedge clk or negedge reset) begin
	if(!reset) begin
		adrs_sprite         = 17'hxxxxx;
		out_address_memory  = 17'hxxxxx;
		out_printtingScreen = 1'bx; 
		out_check_value     = 32'hxxxxxxxx;
	end
	else begin
		case(state) 
			RECEBE:
				begin
					if(active_area) begin
						//envio de coordenadas para comparação.
						out_check_value[8:0]  <= pixel_y; 
						out_check_value[17:9] <= pixel_x;
					end
				end
			PROCESSA:
				begin
					if(data_reg == 32'h00000001) begin //pixel atual pertence ao background do monitor.
						out_address_memory <= address_BG;  //endereço de memória onde está localizado a cor de background.
					end
					else out_address_memory <= 18'hxxxxx;
				end

			AGUARDO:
				begin
					if(counter == 2'd1) begin
						counter <= 0;  //o tempo de aguardo foi finalizado.
					end
					else begin 
						counter <= counter + 1;
					end
				end

			SPRITE:
				begin
					if(counterLine == 5'd19) begin    //último pixel da linha do sprite.
						counterLine <= 0;
					end
					else begin
						counterLine <= counterLine + 1;
					end
					address_memory <= adrs_sprite;
				end
		endcase
	end
end

/*Bloco always que define se o módulo está em impressão de tela ou não*/
always @(posedge clk_pixel) begin
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