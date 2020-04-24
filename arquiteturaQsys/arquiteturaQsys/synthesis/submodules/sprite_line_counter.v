/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sá Barreto Alves
DESCRICAO: modulo responsável por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	clk_pixel: clock utilizado na interface VGA. 
	sprite_on: sinal de entrada para informar que a contagem das linhas deve ser iniciada.
	    reset: sinal de reset do contador.
	sprite_datas: dados do sprite a ser impresso.    
SAIDAS:		 
	address_memory: endereço a ser acessado na memoria.  
	count_finished: sinal para informar que a contagem foi finalizada.
//////////////////////////////////////////////////////////////////////////
**/

module sprite_line_counter #( parameter size_x = 10, size_y = 9, size_address = 14, size_line = 20)
(
	input  wire                     clk_pixel,
	input  wire  [size_x-1:0]       pixel_x,
	input  wire  [size_y-1:0]       pixel_y,
	input  wire  [31:0]             sprite_datas,
	input  wire                     sprite_on,
	input  wire                     reset,
	output wire [size_address-1:0]  memory_address,
	output wire        			    count_finished
);

localparam [8:0] offset = 400;
/*------------------Parâmetros da máquina de estados-------------------------*/
localparam [4:0] ZERO     =  5'b00000,
				ONE          =  5'b00001,
				TWO          =  5'b00010,
				THREE        =  5'b00011,
				FOUR         =  5'b00100,
				FIVE         =  5'b00101,
				SIX          =  5'b00110,
				SEVEN        =  5'b00111,
				EIGHT        =  5'b01000,
				NINE         =  5'b01001,
				TEN          =  5'b01010,
				ELEVEN       =  5'b01011,
				TWELVE       =  5'b01100,
				THIRTEEN     =  5'b01101,
				FOURTEEN     =  5'b01110,
				FIFTEEN      =  5'b01111,
				SIXTEEN      =  5'b10000,
				SEVENTEEN    =  5'b10001,
				EIGHTEEN     =  5'b10010,
				NINETEEN     =  5'b10011;			
/*---------------------------------------------------------------------------*/


/*----------------------Registradores auxiliares de saída---------------------------*/
reg [size_address-1:0] out_memory_address;
reg                    out_count_finished;
/*-----------------------------------------------------------------------------------*/

reg [size_address-1:0] aux_memory_address;
reg  [4:0]              next, state;

/*----------------Bloco always para atualização do estado atual----------------------*/
always @(posedge clk_pixel or negedge reset) begin
	if(!reset) begin
		state <= ZERO;
	end
	else begin
		state <= next;
	end
end
/*-------------------------------------------------------------------------------------*/

/*--------------------Bloco combinacional responsável pela mudança de estados----------------------------*/
always @(state or sprite_on) begin
	if(sprite_on == 1'b1) begin
		case(state)
			ZERO: begin
				next = ONE;
			end
			ONE: begin
				next = TWO;
			end
			TWO: begin
				next = THREE;
			end
			THREE: begin
				next = FOUR;
			end
			FOUR: begin
				next = FIVE;
			end
			FIVE: begin
				next = SIX;
			end
			SIX: begin
				next = SEVEN;
			end
			SEVEN: begin
				next = EIGHT;
			end
			EIGHT: begin
				next = NINE;
			end
			NINE: begin
				next = TEN;
			end
			TEN: begin
				next = ELEVEN;
			end
			ELEVEN: begin
				next = TWELVE;
			end
			TWELVE: begin
				next = THIRTEEN;
			end
			THIRTEEN: begin
				next = FOURTEEN;
			end
			FOURTEEN: begin
				next = FIFTEEN;
			end
			FIFTEEN: begin
				next = SIXTEEN;
			end
	 		SIXTEEN: begin
	 			next = SEVENTEEN;
	 		end
			SEVENTEEN: begin
				next = EIGHTEEN;
			end
			EIGHTEEN: begin
				next = NINETEEN;
			end
			NINETEEN: begin
				next = ZERO;
			end
			default: next = ZERO;
		endcase
	end
	else next = ZERO;
end
/*--------------------------------------------------------------------------------------------------------*/

/*--------Bloco always combinacional responsável por gerar o endereço de memória a ser acessado-----*/
always @(pixel_x or pixel_y or sprite_on or sprite_datas or state or next) begin
	if(sprite_on == 1'b1) begin  //se o sprite_on está habilitado então uma linha de um sprite deve ser impressa.
		if( (pixel_x == sprite_datas[26:18]) ) begin  //primeiro pixel da linha
			//aux_memory_address = número do sprite(registrador) * offset  
			  aux_memory_address = sprite_datas[8:0] * offset;  
		end
		else if( (pixel_x > sprite_datas[26:18]) && ( pixel_x <= ( sprite_datas[26:18] + (size_line-1) ) ) ) begin
			//ainda está dentro do limite da linha do sprite.
			aux_memory_address = (sprite_datas[8:0] * offset) + state; 
		end
		else aux_memory_address = 14'bxxxxxxxxxxxxxx; 
	end
	else begin
		aux_memory_address = 14'bxxxxxxxxxxxxxx;
	end
end
/*--------------------------------------------------------------------------------------------------*/


/*-------------------Bloco always responsável por gerenciar as saídas do módulo---------------------*/
always @(negedge clk_pixel) begin
	out_memory_address <= aux_memory_address; //atualiza o valor do registrador de saída que armazena endereços de memória.
	if(sprite_on == 1'b1) begin
		if(next == ZERO) begin                    //contagem  será desabilitada.
			out_count_finished <= 1'b1;
		end
		else begin
			out_count_finished <= 1'b0;
		end 
	end
	else  out_count_finished <= 1'b1; 
end
/*--------------------------------------------------------------------------------------------------*/

/*-----------------Atribuição contínua das saídas---------------------------*/
assign count_finished = out_count_finished;
assign memory_address = out_memory_address;
/*---------------------------------------------------------------------------*/

endmodule