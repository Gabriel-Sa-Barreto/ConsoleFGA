/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: Module responsavel por gerenciar o uso correto das unidades
que compoem o processador de video apartir da geraçao dos respectivos sinais de controle.
--------------------------------------------------------------------------
ENTRADAS: 
	clk:               sinal de clock (50Mhz)
	opCode:            campo que denota a instrucao que deve ser executada.
	printtingScreen:   campo que informa se o monitor esta em processo de impressao. (0)Nao (1)Sim
SAIDAS:		 
	new_instruction:   informa se uma nova instruçao pode ser executada. (0)Sim (1)Nao
	memory_wr:         sinal de escrita/leitura da memoria de sprites.
	selectField:       sinal que informa qual intervalo de bits da parte de dados da instruçao
deve ser guardada pelo banco de registradores.
	register_wr:       sinal de escrita/leitura do banco de registradores.
	muxOut:            sinal de seleçao da saida do processador de video.
	mux_file_register: sinal de seleçao da entrada do banco de registradores.
//////////////////////////////////////////////////////////////////////////
**/
module controlUnit(
	 input wire clk,
	 input wire [3:0] opCode,
	 input wire       printtingScreen,
	 output reg       new_instruction,
	 output reg       memory_wr,
	 output reg [3:0] selectField,
	 output reg       register_wr,
	 output reg       muxOut,
	 output reg       mux_file_register
);


parameter [1:0] PRONTO              = 2'b00,
					 ESCREVER_NO_BANCO   = 2'b01,
					 HABILITAR_IMPRESSAO = 2'b10;

reg [1:0] state, next;

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		 state <= PRONTO;
	end else state <= next;
end

/*
Bloco always (combinacional) responsavel por analisar as entradas
da maquina de estados e realizar a mudança para o proximo estado.
*/
always @(state or opCode or printtingScreen) begin
	next = 2'bx;
	case(state)
		PRONTO: begin
			if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010) && !printttingScreen)	
				next = ESCREVER_NO_BANCO;
			else if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010 || opCode == 4'b0011) && (printtingScreeen) )
				next = HABILITAR_IMPRESSAO;
			else if( opCode == 4'b0011 & !printtingScreen)
				next = PRONTO;
			else if(!printtingScreen) 
				next = PRONTO;
			else next = HABILITAR_IMPRESSAO;
		end
		
		ESCREVER_NO_BANCO: begin
			if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010) && !printttingScreen)	
				next = ESCREVER_NO_BANCO;
			else if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010 || opCode == 4'b0011) && (printtingScreeen) )
				next = HABILITAR_IMPRESSAO;
			else if( opCode == 4'b0011 & !printtingScreen)
				next = PRONTO;
			else if(!printtingScreen) 
				next = PRONTO;
			else next = HABILITAR_IMPRESSAO;
		end
		
		HABILITAR_IMPRESSAO: begin
			if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010) && !printttingScreen)	
				next = ESCREVER_NO_BANCO;
			else if( (opCode == 4'b0000 || opCode == 4'b0001 || opCode == 4'b0010 || opCode == 4'b0011) && (printtingScreeen) )
				next = HABILITAR_IMPRESSAO;
			else if( opCode == 4'b0011 & !printtingScreen)
				next = PRONTO;
			else if(!printtingScreen) 
				next = PRONTO;
			else next = HABILITAR_IMPRESSAO;	
		end
		default: next = PRONTO;
	endcase
end

/*
Block always responsavel por gerar de acordo ao proximo estado as
saidas correspondentes.
*/
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		memory_wr;
		selectField;
		register_wr;
		muxOut;
		mux_file_register;
	end
	else begin
		case(next)
			PRONTO: begin
				new_instruction   <= 1'b0;    //permite executar novas instruçoes
				memory_wr         <= 1'bx;    //nao tem leitura na memoria
				selectField       <= 4'bxxxx; //nao existem campos a serem alterados no registradores do banco
				register_wr       <= 1'bx;    //nao existe leitura ou escrita para serem realizadas
				muxOut            <= 1'b0;    //aciona multiplexador para verificar status do modulo de impressao
			   mux_file_register <= 1'bx;   //nao existe entradas a serem selecionadas para o banco de registradores
			end
			
			ESCREVER_NO_BANCO: begin
				new_instruction   <= 1'b1;   //nao permite executar novas instruçoes
				memory_wr         <= 1'bx;   //nao tem leitura na memoria
				selectField       <= opCode; //existem campos a serem alterados no registradores do banco
				register_wr       <= 1'b1;   //aciona escrita no banco de registradores
				muxOut            <= 1'b1;   //aciona o mux da saida do procesador de video para verificar se a alteraçao no banco foi realizada com sucesso
				mux_file_register <= 1'b1;   //seleciona entrada para o banco de registradores vindo do decodificador de intruçao
			end
			
			
			HABILITAR_IMPRSSSAO: begin
				new_instruction   <= 1'b1;     //nao permite executar novas instruçoes
				memory_wr         <= 1'b0;     //aciona leitura da memoria
				selectField       <= 4'bxxxx;  //nao existem campos a serem alterados no registradores do banco
				register_wr       <= 1'b0;     //aciona leitura no banco de registradores
				
				if(opCode == 4'b0011)          //instruçao de verificar status de modulo de impressao
					  muxOut       <= 1'b0;     //aciona a verificaçao de status do modulo de impressao
				else muxOut       <= 1'b1;     //aciona a verificaçao de alguma possivel operaçao feita no banco de registradores 
				
				mux_file_register <= 1'b0;     //seleciona entrada vinda do modulo de impressao para o banco de registradores
			end
			default: begin
				/////////////////////////////////////
				//Todas as saidas estao desativadas
				new_instruction   <= 1'bx;   
				memory_wr         <= 1'bx;    
				selectField       <= 4'bxxxx; 
				register_wr       <= 1'bx;    
				muxOut            <= 1'bx;   
			   mux_file_register <= 1'bx;
				/////////////////////////////////////
			end
		endcase
	end
end 
endmodule