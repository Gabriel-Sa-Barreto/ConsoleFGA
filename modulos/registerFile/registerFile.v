/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: banco de registradores responsavel por armazenar as informaçoes de coordenadas e offset
dos sprites que estao na tela.
--------------------------------------------------------------------------
ENTRADAS: 
       n_reg: numero do registrador a ser escrito ou lido.
        data: dado a ser escrito no registrador desejado 
     written: sinal de escrita/leitura
  selectFied: seleciona qual intervalo de bits na entrada "data" sera capturado.
SAIDAS:		 
  readData:   valor lido de um registrador.
      done:   informa se uma operacao de atualizaçao foi realizada com sucesso.
//////////////////////////////////////////////////////////////////////////
**/
module registerFile(
	input  wire        clk,
	input  wire [4:0]  n_reg,
	input  wire [27:0] data,
	input  wire        written,
	input  wire [1:0]  selectField,
	
	output wire [29:0] readData,
   output wire        done
);
/*-------------------Registradores----------------------*/	
reg [29:0] reg0; //esse registrador armazena a cor atual de background da tela.
reg [29:0] reg1;
reg [29:0] reg2;
reg [29:0] reg3;
reg [29:0] reg4;
reg [29:0] reg5;
reg [29:0] reg6;
reg [29:0] reg7;
reg [29:0] reg8;
reg [29:0] reg9;
reg [29:0] reg10;
reg [29:0] reg11;
reg [29:0] reg12;
reg [29:0] reg13;
reg [29:0] reg14;
reg [29:0] reg15;
reg [29:0] reg16;
reg [29:0] reg17;
reg [29:0] reg18;
reg [29:0] reg19;
reg [29:0] reg20;
////////////////////////////////////////////////////////	

/*Bloco always responsavel por realizar as operaçoes de escrita e leitura
no banco de registradores
*/
always @(posedge clk) begin
	if(written) begin //realiza uma atualizaçao no banco
		case(n_reg) 
			5'd0: 
				begin		
					if(selectFiled == 2'b11) begin      //modifica o background da tela
						reg0 <= data[9:0];
						done <= 1;
					end
				end
			5'd1:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg1 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg1 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg1 <= data[29:20];
						done <= 1;
					end
					else reg1 <= reg1;
				end
			5'd2:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg2 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg2 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg2 <= data[29:20];
						done <= 1;
					end
					else reg2 <= reg2;
				end
			5'd3:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg3 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg3 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg3 <= data[29:20];
						done <= 1;
					end
					else reg3 <= reg3;
				end
			5'd4:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg4 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg4 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg4 <= data[29:20];
						done <= 1;
					end
					else reg4 <= reg4;
				end
			5'd5:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg5 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg5 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg5 <= data[29:20];
						done <= 1;
					end
					else reg5 <= reg5;
				end
			5'd6:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg6 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg6 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg6 <= data[29:20];
						done <= 1;
					end
					else reg6 <= reg6;
				end
			5'd7:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg7 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg7 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg7 <= data[29:20];
						done <= 1;
					end
					else reg7 <= reg7;
				end
			5'd8:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg8 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg8 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg8 <= data[29:20];
						done <= 1;
					end
					else reg8 <= reg8;
				end
			5'd9:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg9 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg9 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg9 <= data[29:20];
						done <= 1;
					end
					else reg9 <= reg9;
				end
			5'd10:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg10 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg10 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg10 <= data[29:20];
						done <= 1;
					end
					else reg10 <= reg10;
				end
			5'd11:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg11 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg11 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg11 <= data[29:20];
						done <= 1;
					end
					else reg11 <= reg11;
				end
			5'd12:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg12 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg12 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg12 <= data[29:20];
						done <= 1;
					end
					else reg12 <= reg12;
				end
			5'd13:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg13 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg13 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg13 <= data[29:20];
						done <= 1;
					end
					else reg13 <= reg13;
				end
			5'd14:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg14 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg14 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg14 <= data[29:20];
						done <= 1;
					end
					else reg14 <= reg14;
				end
			5'd15:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg15 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg15 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg15 <= data[29:20];
						done <= 1;
					end
					else reg15 <= reg15;
				end
			5'd16:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg16 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg16 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg16 <= data[29:20];
						done <= 1;
					end
					else reg16 <= reg16;
				end
			5'd17:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg17 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg17 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg17 <= data[29:20];
						done <= 1;
					end
					else reg17 <= reg17;
				end
			5'd18:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg18 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg18 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg18 <= data[29:20];
						done <= 1;
					end
					else reg18 <= reg18;
				end
			5'd19:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg19 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg19 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg19 <= data[29:20];
						done <= 1;
					end
					else reg19 <= reg19;
				end
			5'd20:
				begin
					if(selectField == 2'b00) begin       //modifica x
						reg20 <= data[9:0];
						done <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg20 <= data[19:10];
						done <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica offset
						reg20 <= data[29:20];
						done <= 1;
					end
					else reg20 <= reg20;
				end
			default:	
				done <= 0;
		endcase
	end
	else begin   //realiza uma leitura
		case(n_reg)
			5'd0:  readData <= reg0;
			5'd1:  readData <= reg1;
			5'd2:  readData <= reg2;
			5'd3:  readData <= reg3;
			5'd4:  readData <= reg4;
			5'd5:  readData <= reg5;
			5'd6:  readData <= reg6;
			5'd7:  readData <= reg7;
			5'd8:  readData <= reg8;
			5'd9:  readData <= reg9;
			5'd10: readData <= reg10;
			5'd11: readData <= reg11;
			5'd12: readData <= reg12;
			5'd13: readData <= reg13;
			5'd14: readData <= reg14;
			5'd15: readData <= reg15;
			5'd16: readData <= reg16;
			5'd17: readData <= reg17;
			5'd18: readData <= reg18;
			5'd19: readData <= reg19;
			5'd20: readData <= reg20;
			default: readData <= 30'bx;
		endcase
	end
end
endmodule