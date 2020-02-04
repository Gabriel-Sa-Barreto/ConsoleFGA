/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: banco de registradores responsavel por armazenar as informaçoes de coordenadas e offset
dos sprites que estao na tela.
--------------------------------------------------------------------------
ENTRADAS: 
       n_reg: numero do registrador a ser escrito.
       check: valor para comparaçao entre valores armazenados.
        data: dado a ser escrito no registrador desejado. 
     written: sinal de escrita/leitura.
  selectFied: seleciona qual intervalo de bits na entrada "data" sera capturado.
SAIDAS:		 
  readData:   valor lido de um registrador.
      done:   informa se uma operacao de atualizaçao foi realizada com sucesso.
//////////////////////////////////////////////////////////////////////////
**/
module registerFile(
	input  wire        clk,
	input  wire [4:0]  n_reg,
	input  wire [17:0] check, 
	input  wire [31:0] data,
	input  wire        written,
	input  wire [1:0]  selectField,
	
	output wire [8:0] readData,
    output wire        success
);

/*---Parametros que definem as posições de inicio e fim dos atributos de cada sprite em cada registrador---*/
parameter       offset_inicio = 0; 
parameter [4:0] offset_final  = 8;

parameter [4:0] y_inicio = 9;
parameter [5:0] y_final  = 18;

parameter [5:0] x_inicio = 19;
parameter [5:0] x_final  = 27;

parameter       back_inicio = 0;
parameter [4:0] back_final  = 8; 

/*----------------------------------------------------------------------------------------------------------*/

/*-------------------Registradores----------------------*/	
reg [31:0] reg1;
reg [31:0] reg2;
reg [31:0] reg3;
reg [31:0] reg4;
reg [31:0] reg5;
reg [31:0] reg6;
reg [31:0] reg7;
reg [31:0] reg8;
reg [31:0] reg9;
reg [31:0] reg10;
reg [31:0] reg11;
reg [31:0] reg12;
reg [31:0] reg13;
reg [31:0] reg14;
reg [31:0] reg15;
reg [31:0] reg16;
reg [31:0] reg17;
reg [31:0] reg18;
reg [31:0] reg19;
reg [31:0] reg20;
reg [31:0] reg21;
reg [31:0] reg22;
reg [31:0] reg23;
reg [31:0] reg24;
reg [31:0] reg25;
reg [31:0] reg26;
reg [31:0] reg27;
reg [31:0] reg28;
reg [31:0] reg29;
reg [31:0] reg30;
reg [31:0] reg31;
////////////////////////////////////////////////////////	

/*Bloco always responsavel por realizar as operaçoes de escrita e leitura
no banco de registradores na descida do pulso de clock.
*/
always @(negedge clk) begin
	if(written) begin //realiza uma atualizaçao no banco
		case(n_reg) 
			5'd1:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg1 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg1 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg1 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg1 <= reg1;
				end
			5'd2:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg2 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg2 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg2 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg2 <= reg;
				end
			5'd3:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg3 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg3 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg3 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg3 <= reg3;
				end
			5'd4:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg4 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg4 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg4 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg4 <= reg4;
				end
			5'd5:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg5 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg5 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg5 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg5 <= reg5;
				end
			5'd6:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg6 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg6 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg6 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg6 <= reg6;
				end
			5'd7:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg7 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg7 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg7 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg7 <= reg7;
				end
			5'd8:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg8 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg8 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg8 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg8 <= reg8;
				end
			5'd9:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg9 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg9 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg9 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg9 <= reg9;
				end
			5'd10:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg10 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg10 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg10 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg10 <= reg10;
				end
			5'd11:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg11 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg11 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg11 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg11 <= reg11;
				end
			5'd12:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg12 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg12 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg12 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg12 <= reg12;
				end
			5'd13:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg13 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg13 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg13 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg13 <= reg13;
				end
			5'd14:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg14 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg14 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg14 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg14 <= reg14;
				end
			5'd15:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg15 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg15 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg15 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg15 <= reg15;
				end
			5'd16:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg16 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg16 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg16 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg16 <= reg16;
				end
			5'd17:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg17 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg17 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg17 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg17 <= reg17;
				end
			5'd18:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg18 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg18 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg18 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg18 <= reg18;
				end
			5'd19:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg19 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg19 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg19 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg19 <= reg19;
				end
			5'd20:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg20 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg20 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg20 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg20 <= reg20;
				end

			5'd21:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg21 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg21 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg21 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg21 <= reg21;
				end

			5'd22:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg22 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg22 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg22 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg22 <= reg22;
				end
			5'd23:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg23 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg23 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg23 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg23 <= reg23;
				end
			5'd24:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg24 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg24 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg24 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg24 <= reg24;
				end
			5'd25:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg25 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg25 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg25 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg25 <= reg25;
				end
			5'd26:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg26 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg26 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg26 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg26 <= reg26;
				end
			5'd27:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg27 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg27 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg27 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg27 <= reg27;
				end
			5'd28:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg28 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg28 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg28 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg28 <= reg28;
				end
			5'd29:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg29 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg29 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg29 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg29 <= reg29;
				end
			5'd30:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg30 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg30 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg30 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg30 <= reg30;
				end
			5'd31:
				begin
					if(selectField == 2'b00) begin       //modifica offset
						reg31 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 2'b01)  begin //modifica y
						reg31 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 2'b10) begin  //modifica x
						reg31 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg31 <= reg31;
				end
			default:	
				success <= 0;
		endcase
	end
	else success <= 0;
end

/*Bloco combinacional para realizacao de comparaçoes entre valores de entrada e valores armazenados nos registradores*/
/*RETORNA o valor de offset armazenado em um registrador.*/
always @(*) begin
    if(!written) begin //comparaçao ativada.
    	if(check == reg1[x_final:y_inicio]); 
    		readData = reg1[8:0];
    	else if(check == reg2[x_final:y_inicio]);
    		readData = reg2[8:0];
    	else if(check == reg3[x_final:y_inicio]);
    		readData = reg3[8:0];
    	else if(check == reg4[x_final:y_inicio]);
    		readData = reg4[8:0];
    	else if(check == reg[x_final:y_inicio]);
    		readData = reg5[8:0];
    	else if(check == reg6[x_final:y_inicio]);
    		readData = reg6[8:0];
    	else if(check == reg[x_final:y_inicio]);
    		readData = reg7[8:0];
    	else if(check == reg8[x_final:y_inicio]);
    		readData = reg8[8:0];
    	else if(check == reg9[x_final:y_inicio]);
    		readData = reg9[8:0];
    	else if(check == reg10[x_final:y_inicio]);
    		readData = reg10[8:0];
    	else if(check == reg11[x_final:y_inicio]);
    		readData = reg11[8:0];
    	else if(check == reg12[x_final:y_inicio]);
    		readData = reg12[8:0];
    	else if(check == reg13[x_final:y_inicio]);
    		readData = reg13[8:0];
    	else if(check == reg14[x_final:y_inicio]);
    		readData = reg14[8:0];
    	else if(check == reg15[x_final:y_inicio]);
    		readData = reg15[8:0];
    	else if(check == reg16[x_final:y_inicio]);
    		readData = reg16[8:0];
    	else if(check == reg17[x_final:y_inicio]);
    		readData = reg17[8:0];
    	else if(check == reg18[x_final:y_inicio]);
    		readData = reg18[8:0];
    	else if(check == reg19[x_final:y_inicio]);
    		readData = reg19[8:0];
    	else if(check == reg20[x_final:y_inicio]);
    		readData = reg20[8:0];
    	else if(check == reg21[x_final:y_inicio]);
    		readData = reg21[8:0];
    	else if(check == reg22[x_final:y_inicio]);
    		readData = reg22[8:0];
    	else if(check == reg23[x_final:y_inicio]);
    		readData = reg23[8:0];
    	else if(check == reg24[x_final:y_inicio]);
    		readData = reg24[8:0];
    	else if(check == reg25[x_final:y_inicio]);
    		readData = reg25[8:0];
    	else if(check == reg26[x_final:y_inicio]);
    		readData = reg26[8:0];
    	else if(check == reg27[x_final:y_inicio]);
    		readData = reg27[8:0];
    	else if(check == reg28[x_final:y_inicio]);
    		readData = reg28[8:0];
    	else if(check == reg29[x_final:y_inicio]);
    		readData = reg29[8:0];
    	else if(check == reg30[x_final:y_inicio]);
    		readData = reg30[8:0];
    	else if(check == reg31[x_final:y_inicio]);
    		readData = reg31[8:0];
    	else readData = 10'b0000000001; //valor que define que nenhum pixel foi encontrado com os valores informados.
    end
    else readData = 10'b0000000001;
end
endmodule