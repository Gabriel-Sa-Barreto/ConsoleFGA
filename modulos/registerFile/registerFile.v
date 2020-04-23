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
	input  wire [18:0] check, 
	input  wire [31:0] data,
	input  wire        written,
	input  wire [3:0]  selectField,
	
	output reg [31:0] out_readData,
   output reg        success
);

/*---Parametros que definem as posições de inicio e fim dos atributos de cada sprite em cada registrador---*/
parameter       offset_inicio = 0; 
parameter [4:0] offset_final  = 8;

parameter [4:0] y_inicio = 9;
parameter [5:0] y_final  = 17;

parameter [5:0] x_inicio = 18;
parameter [5:0] x_final  = 27;

parameter spriteLine = 20;

/*----------------------------------------------------------------------------------------------------------*/
reg [31:0] readData;

/*-------------------Registradores----------------------*/	
reg [31:0] reg0;
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
			5'd0:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg0 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg0 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg0 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg0 <= reg0;
				end
			5'd1:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg1 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg1 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg1 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg1 <= reg1;
				end
			5'd2:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg2 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg2 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg2 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg2 <= reg2;
				end
			5'd3:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg3 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg3 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg3 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg3 <= reg3;
				end
			5'd4:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg4 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg4 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg4 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg4 <= reg4;
				end
			5'd5:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg5 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg5 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg5 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg5 <= reg5;
				end
			5'd6:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg6 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg6 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg6 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg6 <= reg6;
				end
			5'd7:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg7 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg7 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg7 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg7 <= reg7;
				end
			5'd8:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg8 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg8 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg8 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg8 <= reg8;
				end
			5'd9:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg9 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg9 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg9 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg9 <= reg9;
				end
			5'd10:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg10 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg10 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg10 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg10 <= reg10;
				end
			5'd11:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg11 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg11 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg11 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg11 <= reg11;
				end
			5'd12:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg12 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg12 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg12 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg12 <= reg12;
				end
			5'd13:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg13 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg13 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg13 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg13 <= reg13;
				end
			5'd14:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg14 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg14 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg14 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg14 <= reg14;
				end
			5'd15:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg15 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg15 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg15 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg15 <= reg15;
				end
			5'd16:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg16 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg16 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg16 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg16 <= reg16;
				end
			5'd17:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg17 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg17 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg17 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg17 <= reg17;
				end
			5'd18:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg18 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg18 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg18 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg18 <= reg18;
				end
			5'd19:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg19 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg19 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg19 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg19 <= reg19;
				end
			5'd20:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg20 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg20 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg20 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg20 <= reg20;
				end

			5'd21:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg21 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg21 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg21 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg21 <= reg21;
				end

			5'd22:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg22 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg22 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg22 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg22 <= reg22;
				end
			5'd23:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg23 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg23 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg23 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg23 <= reg23;
				end
			5'd24:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg24 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg24 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg24 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg24 <= reg24;
				end
			5'd25:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg25 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg25 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg25 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg25 <= reg25;
				end
			5'd26:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg26 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg26 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg26 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg26 <= reg26;
				end
			5'd27:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg27 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg27 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg27 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg27 <= reg27;
				end
			5'd28:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg28 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg28 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg28 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg28 <= reg28;
				end
			5'd29:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg29 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg29 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg29 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg29 <= reg29;
				end
			5'd30:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg30 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg30 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
						reg30 <= data[x_final:x_inicio];
						success <= 1;
					end
					else reg30 <= reg30;
				end
			5'd31:
				begin
					if(selectField == 4'b0000) begin       //modifica offset
						reg31 <= data[offset_final:offset_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0001)  begin //modifica y
						reg31 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica x
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
		if( (check[18:9] == reg0[x_final:x_inicio]) && (check[8:0] >= reg0[y_final:y_inicio]) && (check[8:0] < reg0[y_final:y_inicio] + spriteLine)) 
    		readData = reg0;
    	else if( (check[18:9] == reg1[x_final:x_inicio]) && (check[8:0] >= reg1[y_final:y_inicio]) && (check[8:0] < reg1[y_final:y_inicio] + spriteLine)) 
    		readData = reg1;
    	else if( (check[18:9] == reg2[x_final:x_inicio]) && (check[8:0] >= reg2[y_final:y_inicio]) && (check[8:0] < reg2[y_final:y_inicio] + spriteLine)) 
    		readData = reg2;
    	else if( (check[18:9] == reg3[x_final:x_inicio]) && (check[8:0] >= reg3[y_final:y_inicio]) && (check[8:0] < reg3[y_final:y_inicio] + spriteLine)) 
    		readData = reg3;
    	else if( (check[18:9] == reg4[x_final:x_inicio]) && (check[8:0] >= reg4[y_final:y_inicio]) && (check[8:0] < reg4[y_final:y_inicio] + spriteLine)) 
    		readData = reg4;
    	else if( (check[18:9] == reg5[x_final:x_inicio]) && (check[8:0] >= reg5[y_final:y_inicio]) && (check[8:0] < reg5[y_final:y_inicio] + spriteLine)) 
    		readData = reg5;
    	else if( (check[18:9] == reg6[x_final:x_inicio]) && (check[8:0] >= reg6[y_final:y_inicio]) && (check[8:0] < reg6[y_final:y_inicio] + spriteLine)) 
    		readData = reg6;
    	else if( (check[18:9] == reg7[x_final:x_inicio]) && (check[8:0] >= reg7[y_final:y_inicio]) && (check[8:0] < reg7[y_final:y_inicio] + spriteLine)) 
    		readData = reg7;
    	else if( (check[18:9] == reg8[x_final:x_inicio]) && (check[8:0] >= reg8[y_final:y_inicio]) && (check[8:0] < reg8[y_final:y_inicio] + spriteLine)) 
    		readData = reg8;
    	else if( (check[18:9] == reg9[x_final:x_inicio]) && (check[8:0] >= reg9[y_final:y_inicio]) && (check[8:0] <reg9[y_final:y_inicio] + spriteLine)) 
    		readData = reg9;
    	else if( (check[18:9] == reg10[x_final:x_inicio]) && (check[8:0] >= reg10[y_final:y_inicio]) && (check[8:0] < reg10[y_final:y_inicio] + spriteLine)) 
    		readData = reg10;
    	else if( (check[18:9] == reg11[x_final:x_inicio]) && (check[8:0] >= reg11[y_final:y_inicio]) && (check[8:0] < reg11[y_final:y_inicio] + spriteLine)) 
    		readData = reg11;
    	else if( (check[18:9] == reg12[x_final:x_inicio]) && (check[8:0] >= reg12[y_final:y_inicio]) && (check[8:0] < reg12[y_final:y_inicio] + spriteLine)) 
    		readData = reg12;
    	else if( (check[18:9] == reg13[x_final:x_inicio]) && (check[8:0] >= reg13[y_final:y_inicio]) && (check[8:0] < reg13[y_final:y_inicio] + spriteLine)) 
    		readData = reg13;
    	else if( (check[18:9] == reg14[x_final:x_inicio]) && (check[8:0] >= reg14[y_final:y_inicio]) && (check[8:0] < reg14[y_final:y_inicio] + spriteLine)) 
    		readData = reg14;
    	else if( (check[18:9] == reg15[x_final:x_inicio]) && (check[8:0] >= reg15[y_final:y_inicio]) && (check[8:0] < reg15[y_final:y_inicio] + spriteLine)) 
    		readData = reg15;
    	else if( (check[18:9] == reg16[x_final:x_inicio]) && (check[8:0] >= reg16[y_final:y_inicio]) && (check[8:0] < reg16[y_final:y_inicio] + spriteLine)) 
    		readData = reg16;
    	else if( (check[18:9] == reg17[x_final:x_inicio]) && (check[8:0] >= reg17[y_final:y_inicio]) && (check[8:0] < reg17[y_final:y_inicio] + spriteLine)) 
    		readData = reg17;
    	else if( (check[18:9] == reg18[x_final:x_inicio]) && (check[8:0] >= reg18[y_final:y_inicio]) && (check[8:0] < reg18[y_final:y_inicio] + spriteLine)) 
    		readData = reg18;
    	else if( (check[18:9] == reg19[x_final:x_inicio]) && (check[8:0] >= reg19[y_final:y_inicio]) && (check[8:0] < reg19[y_final:y_inicio] + spriteLine)) 
    		readData = reg19;
    	else if( (check[18:9] == reg20[x_final:x_inicio]) && (check[8:0] >= reg20[y_final:y_inicio]) && (check[8:0] < reg20[y_final:y_inicio] + spriteLine))
    		readData = reg20;
    	else if( (check[18:9] == reg21[x_final:x_inicio]) && (check[8:0] >= reg21[y_final:y_inicio]) && (check[8:0] < reg21[y_final:y_inicio] + spriteLine))
    		readData = reg21;
    	else if( (check[18:9] == reg22[x_final:x_inicio]) && (check[8:0] >= reg22[y_final:y_inicio]) && (check[8:0] < reg22[y_final:y_inicio] + spriteLine))
    		readData = reg22;
    	else if( (check[18:9] == reg23[x_final:x_inicio]) && (check[8:0] >= reg23[y_final:y_inicio]) && (check[8:0] < reg23[y_final:y_inicio] + spriteLine))
    		readData = reg23;
    	else if( (check[18:9] == reg24[x_final:x_inicio]) && (check[8:0] >= reg24[y_final:y_inicio]) && (check[8:0] < reg24[y_final:y_inicio] + spriteLine))
    		readData = reg24;
    	else if( (check[18:9] == reg25[x_final:x_inicio]) && (check[8:0] >= reg25[y_final:y_inicio]) && (check[8:0] < reg25[y_final:y_inicio] + spriteLine))
    		readData = reg25;
    	else if( (check[18:9] == reg26[x_final:x_inicio]) && (check[8:0] >= reg26[y_final:y_inicio]) && (check[8:0] < reg26[y_final:y_inicio] + spriteLine))
    		readData = reg26;
    	else if( (check[18:9] == reg27[x_final:x_inicio]) && (check[8:0] >= reg27[y_final:y_inicio]) && (check[8:0] < reg27[y_final:y_inicio] + spriteLine))
    		readData = reg27;
    	else if( (check[18:9] == reg28[x_final:x_inicio]) && (check[8:0] >= reg28[y_final:y_inicio]) && (check[8:0] < reg28[y_final:y_inicio] + spriteLine))
    		readData = reg28;
    	else if( (check[18:9] == reg29[x_final:x_inicio]) && (check[8:0] >= reg29[y_final:y_inicio]) && (check[8:0] < reg29[y_final:y_inicio] + spriteLine))
    		readData = reg29;
    	else if( (check[18:9] == reg30[x_final:x_inicio]) && (check[8:0] >= reg30[y_final:y_inicio]) && (check[8:0] < reg30[y_final:y_inicio] + spriteLine))
    		readData = reg30;
    	else if( (check[18:9] == reg31[x_final:x_inicio]) && (check[8:0] >= reg31[y_final:y_inicio]) && (check[8:0] < reg31[y_final:y_inicio] + spriteLine))
    		readData = reg31;
    	else readData = 32'h00000001; //valor que define que nenhum pixel foi encontrado com os valores informados.
    end
    else readData = 32'h00000001;
end


//Escreve no registro de saída o valor lido de algum registrador.
always @(negedge clk) begin
	out_readData <= readData;
end

endmodule