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
	input  wire        reset,
	input  wire [4:0]  n_reg,
	input  wire [19:0] check, 
	input  wire [31:0] data,
	input  wire        written,
	input  wire [3:0]  selectField,
	
	output reg [31:0] out_readData,
   output reg        success
);

/*---Parametros que definem as posições de inicio e fim dos atributos de cada sprite em cada registrador---*/
localparam  n_sprite_inicio = 0; 
localparam 	n_sprite_final  = 8;

localparam  y_inicio = 9;
localparam  y_final  = 18;

localparam  x_inicio = 19;
localparam  x_final  = 28;

localparam spriteLine = 20;

/*----------------------------------------------------------------------------------------------------------*/
//wire [31:0] readData;
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
/*
wire [31:0] r0;
wire [31:0] r1;
wire [31:0] r2;
wire [31:0] r3;
wire [31:0] r4;
wire [31:0] r5;
wire [31:0] r6;
wire [31:0] r7;
wire [31:0] r8;
wire [31:0] r9;
wire [31:0] r10;
wire [31:0] r11;
wire [31:0] r12;
wire [31:0] r13;
wire [31:0] r14;
wire [31:0] r15;
wire [31:0] r16;
wire [31:0] r17;
wire [31:0] r18;
wire [31:0] r19;
wire [31:0] r20;
wire [31:0] r21;
wire [31:0] r22;
wire [31:0] r23;
wire [31:0] r24;
wire [31:0] r25;
wire [31:0] r26;
wire [31:0] r27;
wire [31:0] r28;
wire [31:0] r29;
wire [31:0] r30;
wire [31:0] r31;
*/
//////////////////////////////////////////////////////////////
/*
assign r0 = reg0;
assign r1 = reg1;
assign r2 = reg2;
assign r3 = reg3;
assign r4 = reg4;
assign r5 = reg5;
assign r6 = reg6;
assign r7 = reg7;
assign r8 = reg8;
assign r9 = reg9;
assign r10 = reg10;
assign r11 = reg11;
assign r12 = reg12;
assign r13 = reg13;
assign r14 = reg14;
assign r15 = reg15;
assign r16 = reg16;
assign r17 = reg17;
assign r18 = reg18;
assign r19 = reg19;
assign r20 = reg20;
assign r21 = reg21;
assign r22 = reg22;
assign r23 = reg23;
assign r24 = reg24;
assign r25 = reg25;
assign r26 = reg26;
assign r27 = reg27;
assign r28 = reg28;
assign r29 = reg29;
assign r30 = reg30;
assign r31 = reg31;
*/
/*Bloco always responsavel por realizar as operaçoes de escrita e leitura
no banco de registradores na descida do pulso de clock.
*/
always @(negedge clk or negedge reset) begin
	if(!reset) begin
		//Define a numeração dos sprites
		 reg0 <= 32'b00000000000000000000000000000000;
		 reg1 <= 32'b00000000000000000000000000000000;
		 reg2 <= 32'b00000000000000000000000000000000;
		 reg3 <= 32'b00000000000000000000000000000000;
		 reg4 <= 32'b00000000000000000000000000000000;
		 reg5 <= 32'b00000000000000000000000000000000;
		 reg6 <= 32'b00000000000000000000000000000000;
		 reg7 <= 32'b00000000000000000000000000000000;
		 reg8 <= 32'b00000000000000000000000000000000;
		 reg9 <= 32'b00000000000000000000000000000000;
		reg10 <= 32'b00000000000000000000000000000000;
		reg11 <= 32'b00000000000000000000000000000000;
		reg12 <= 32'b00000000000000000000000000000000;
		reg13 <= 32'b00000000000000000000000000000000;
		reg14 <= 32'b00000000000000000000000000000000;
		reg15 <= 32'b00000000000000000000000000000000;
		reg16 <= 32'b00000000000000000000000000000000;
		reg17 <= 32'b00000000000000000000000000000000;
		reg18 <= 32'b00000000000000000000000000000000;
		reg19 <= 32'b00000000000000000000000000000000;
		reg20 <= 32'b00000000000000000000000000000000;
		reg21 <= 32'b00000000000000000000000000000000;
		reg22 <= 32'b00000000000000000000000000000000;
		reg23 <= 32'b00000000000000000000000000000000;
		reg24 <= 32'b00000000000000000000000000000000;
		reg25 <= 32'b00000000000000000000000000000000;
		reg26 <= 32'b00000000000000000000000000000000;
		reg27 <= 32'b00000000000000000000000000000000;
		reg28 <= 32'b00000000000000000000000000000000;
		reg29 <= 32'b00000000000000000000000000000000;
		reg30 <= 32'b00000000000000000000000000000000;
		reg31 <= 32'b00000000000000000000000000000000;
	end
	else if(written) begin //realiza uma atualizaçao no banco
		case(n_reg) 
			5'd0:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg0 <= data[x_final:x_inicio];
						reg0 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg0 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg0 <= reg0;
				end
			5'd1:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg1 <= data[x_final:x_inicio];
						reg1 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg1 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg1 <= reg1;
				end
			5'd2:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg2 <= data[x_final:x_inicio];
						reg2 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg2 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg2 <= reg2;
				end
			5'd3:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg3 <= data[x_final:x_inicio];
						reg3 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg3 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg3 <= reg3;
				end
			5'd4:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg4 <= data[x_final:x_inicio];
						reg4 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg4 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg4 <= reg4;
				end
			5'd5:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg5 <= data[x_final:x_inicio];
						reg5 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg5 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg5 <= reg5;
				end
			5'd6:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg6 <= data[x_final:x_inicio];
						reg6 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg6 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg6 <= reg6;
				end
			5'd7:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg7 <= data[x_final:x_inicio];
						reg7 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg7 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg7 <= reg7;
				end
			5'd8:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg8 <= data[x_final:x_inicio];
						reg8 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg8 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg8 <= reg8;
				end
			5'd9:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg9 <= data[x_final:x_inicio];
						reg9 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg9 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg9 <= reg9;
				end
			5'd10:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg10 <= data[x_final:x_inicio];
						reg10 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg10 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg10 <= reg10;
				end
			5'd11:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg11 <= data[x_final:x_inicio];
						reg11 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg11 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg11 <= reg11;
				end
			5'd12:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg12 <= data[x_final:x_inicio];
						reg12 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg12 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg12 <= reg12;
				end
			5'd13:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg13 <= data[x_final:x_inicio];
						reg13 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg13 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg13 <= reg13;
				end
			5'd14:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg14 <= data[x_final:x_inicio];
						reg14 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg14 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg14 <= reg14;
				end
			5'd15:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg15 <= data[x_final:x_inicio];
						reg15 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg15 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg15 <= reg15;
				end
			5'd16:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg16 <= data[x_final:x_inicio];
						reg16 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg16 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg16 <= reg16;
				end
			5'd17:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg17 <= data[x_final:x_inicio];
						reg17 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg17 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg17 <= reg17;
				end
			5'd18:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg18 <= data[x_final:x_inicio];
						reg18 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg18 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg18 <= reg18;
				end
			5'd19:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg19 <= data[x_final:x_inicio];
						reg19 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg19 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg19 <= reg19;
				end
			5'd20:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg20 <= data[x_final:x_inicio];
						reg20 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg20 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg20 <= reg20;
				end

			5'd21:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg21 <= data[x_final:x_inicio];
						reg21 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg21 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg21 <= reg21;
				end

			5'd22:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg22 <= data[x_final:x_inicio];
						reg22 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg22 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg22 <= reg22;
				end
			5'd23:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg23 <= data[x_final:x_inicio];
						reg23 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg23 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg23 <= reg23;
				end
			5'd24:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg24 <= data[x_final:x_inicio];
						reg24 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg24 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg24 <= reg24;
				end
			5'd25:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg25 <= data[x_final:x_inicio];
						reg25 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg25 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg25 <= reg25;
				end
			5'd26:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg26 <= data[x_final:x_inicio];
						reg26 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg26 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg26 <= reg26;
				end
			5'd27:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg27 <= data[x_final:x_inicio];
						reg27 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg27 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg27 <= reg27;
				end
			5'd28:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg28 <= data[x_final:x_inicio];
						reg28 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg28 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg28 <= reg28;
				end
			5'd29:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg29 <= data[x_final:x_inicio];
						reg29 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg29 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg29 <= reg29;
				end
			5'd30:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg30 <= data[x_final:x_inicio];
						reg30 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg30 <= data[n_sprite_final:n_sprite_inicio];
						success <= 1;
					end
					else reg30 <= reg0;
				end
			5'd31:
				begin
					if(selectField == 4'b0000) begin       //modifica x e y
						reg31 <= data[x_final:x_inicio];
						reg31 <= data[y_final:y_inicio];
						success <= 1;
					end
					else if(selectField == 4'b0010) begin  //modifica offset
						reg31 <= data[n_sprite_final:n_sprite_inicio];
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
/*
mod_comparator #( .size_reg(32), .size_check(20) , .x_init(19), .x_fim(28), .y_init(9), .y_fim(18), .sprLine(20) )
mod_comparator_inst
(
	.r0(r0) ,	// input [size_reg-1:0] r0_sig
	.r1(r1) ,	// input [size_reg-1:0] r1_sig
	.r2(r2) ,	// input [size_reg-1:0] r2_sig
	.r3(r3) ,	// input [size_reg-1:0] r3_sig
	.r4(r4) ,	// input [size_reg-1:0] r4_sig
	.r5(r5) ,	// input [size_reg-1:0] r5_sig
	.r6(r6) ,	// input [size_reg-1:0] r6_sig
	.r7(r7) ,	// input [size_reg-1:0] r7_sig
	.r8(r8) ,	// input [size_reg-1:0] r8_sig
	.r9(r9) ,	// input [size_reg-1:0] r9_sig
	.r10(r10) ,	// input [size_reg-1:0] r10_sig
	.r11(r11) ,	// input [size_reg-1:0] r11_sig
	.r12(r12) ,	// input [size_reg-1:0] r12_sig
	.r13(r13) ,	// input [size_reg-1:0] r13_sig
	.r14(r14) ,	// input [size_reg-1:0] r14_sig
	.r15(r15) ,	// input [size_reg-1:0] r15_sig
	.r16(r16) ,	// input [size_reg-1:0] r16_sig
	.r17(r17) ,	// input [size_reg-1:0] r17_sig
	.r18(r18) ,	// input [size_reg-1:0] r18_sig
	.r19(r19) ,	// input [size_reg-1:0] r19_sig
	.r20(r20) ,	// input [size_reg-1:0] r20_sig
	.r21(r21) ,	// input [size_reg-1:0] r21_sig
	.r22(r22) ,	// input [size_reg-1:0] r22_sig
	.r23(r23) ,	// input [size_reg-1:0] r23_sig
	.r24(r24) ,	// input [size_reg-1:0] r24_sig
	.r25(r25) ,	// input [size_reg-1:0] r25_sig
	.r26(r26) ,	// input [size_reg-1:0] r26_sig
	.r27(r27) ,	// input [size_reg-1:0] r27_sig
	.r28(r28) ,	// input [size_reg-1:0] r28_sig
	.r29(r29) ,	// input [size_reg-1:0] r29_sig
	.r30(r30) ,	// input [size_reg-1:0] r30_sig
	.r31(r31) ,	// input [size_reg-1:0] r31_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(written), 			//input compare_sig
	.register_read(readData) 	// output [size_reg-1:0] register_read_sig
);
*/

always @(*) begin
    if(!written) begin //comparaçao ativada.
		readData = 32'h00000001; 
		if( (check[19:10] == reg0[x_final:x_inicio]) && (check[9:0] >= reg0[y_final:y_inicio]) && (check[9:0] < (reg0[y_final:y_inicio] + spriteLine) )) 
    		readData = reg0;
    	if( (check[19:10] == reg1[x_final:x_inicio]) && (check[9:0] >= reg1[y_final:y_inicio]) && (check[9:0] < (reg1[y_final:y_inicio] + spriteLine) )) 
    		readData = reg1;
    	if( (check[19:10] == reg2[x_final:x_inicio]) && (check[9:0] >= reg2[y_final:y_inicio]) && (check[9:0] < (reg2[y_final:y_inicio] + spriteLine)  )) 
    		readData = reg2;
    	if( (check[19:10] == reg3[x_final:x_inicio]) && (check[9:0] >= reg3[y_final:y_inicio]) && (check[9:0] < (reg3[y_final:y_inicio] + spriteLine) )) 
    		readData = reg3;
    	if( (check[19:10] == reg4[x_final:x_inicio]) && (check[9:0] >= reg4[y_final:y_inicio]) && (check[9:0] < (reg4[y_final:y_inicio] + spriteLine) )) 
    		readData = reg4;
    	if( (check[19:10] == reg5[x_final:x_inicio]) && (check[9:0] >= reg5[y_final:y_inicio]) && (check[9:0] < (reg5[y_final:y_inicio] + spriteLine) )) 
    		readData = reg5;
    	if( (check[19:10] == reg6[x_final:x_inicio]) && (check[9:0] >= reg6[y_final:y_inicio]) && (check[9:0] < (reg6[y_final:y_inicio] + spriteLine) )) 
    		readData = reg6;
    	if( (check[19:10] == reg7[x_final:x_inicio]) && (check[9:0] >= reg7[y_final:y_inicio]) && (check[9:0] < (reg7[y_final:y_inicio] + spriteLine) )) 
    		readData = reg7;
    	if( (check[19:10] == reg8[x_final:x_inicio]) && (check[9:0] >= reg8[y_final:y_inicio]) && (check[9:0] < (reg8[y_final:y_inicio] + spriteLine) )) 
    		readData = reg8;
    	if( (check[19:10] == reg9[x_final:x_inicio]) && (check[9:0] >= reg9[y_final:y_inicio]) && (check[9:0] < (reg9[y_final:y_inicio] + spriteLine) )) 
    		readData = reg9;
    	if( (check[19:10] == reg10[x_final:x_inicio]) && (check[9:0] >= reg10[y_final:y_inicio]) && (check[9:0] < (reg10[y_final:y_inicio] + spriteLine) )) 
    		readData = reg10;
    	if( (check[19:10] == reg11[x_final:x_inicio]) && (check[9:0] >= reg11[y_final:y_inicio]) && (check[9:0] < (reg11[y_final:y_inicio] + spriteLine) )) 
    		readData = reg11;
    	if( (check[19:10] == reg12[x_final:x_inicio]) && (check[9:0] >= reg12[y_final:y_inicio]) && (check[9:0] < (reg12[y_final:y_inicio] + spriteLine) )) 
    		readData = reg12;
    	if( (check[19:10] == reg13[x_final:x_inicio]) && (check[9:0] >= reg13[y_final:y_inicio]) && (check[9:0] < (reg13[y_final:y_inicio] + spriteLine) )) 
    		readData = reg13;
    	if( (check[19:10] == reg14[x_final:x_inicio]) && (check[9:0] >= reg14[y_final:y_inicio]) && (check[9:0] < (reg14[y_final:y_inicio] + spriteLine) )) 
    		readData = reg14;
    	if( (check[19:10] == reg15[x_final:x_inicio]) && (check[9:0] >= reg15[y_final:y_inicio]) && (check[9:0] < (reg15[y_final:y_inicio] + spriteLine) )) 
    		readData = reg15;
    	if( (check[19:10] == reg16[x_final:x_inicio]) && (check[9:0] >= reg16[y_final:y_inicio]) && (check[9:0] < (reg16[y_final:y_inicio] + spriteLine) )) 
    		readData = reg16;
    	if( (check[19:10] == reg17[x_final:x_inicio]) && (check[9:0] >= reg17[y_final:y_inicio]) && (check[9:0] < (reg17[y_final:y_inicio] + spriteLine) )) 
    		readData = reg17;
    	if( (check[19:10] == reg18[x_final:x_inicio]) && (check[9:0] >= reg18[y_final:y_inicio]) && (check[9:0] < (reg18[y_final:y_inicio] + spriteLine) )) 
    		readData = reg18;
    	if( (check[19:10] == reg19[x_final:x_inicio]) && (check[9:0] >= reg19[y_final:y_inicio]) && (check[9:0] < (reg19[y_final:y_inicio] + spriteLine) )) 
    		readData = reg19;
    	if( (check[19:10] == reg20[x_final:x_inicio]) && (check[9:0] >= reg20[y_final:y_inicio]) && (check[9:0] < (reg20[y_final:y_inicio] + spriteLine) ))
    		readData = reg20;
    	if( (check[19:10] == reg21[x_final:x_inicio]) && (check[9:0] >= reg21[y_final:y_inicio]) && (check[9:0] < (reg21[y_final:y_inicio] + spriteLine) ))
    		readData = reg21;
    	if( (check[19:10] == reg22[x_final:x_inicio]) && (check[9:0] >= reg22[y_final:y_inicio]) && (check[9:0] < (reg22[y_final:y_inicio] + spriteLine) ))
    		readData = reg22;
    	if( (check[19:10] == reg23[x_final:x_inicio]) && (check[9:0] >= reg23[y_final:y_inicio]) && (check[9:0] < (reg23[y_final:y_inicio] + spriteLine) ))
    		readData = reg23;
    	if( (check[19:10] == reg24[x_final:x_inicio]) && (check[9:0] >= reg24[y_final:y_inicio]) && (check[9:0] < (reg24[y_final:y_inicio] + spriteLine) ))
    		readData = reg24;
    	if( (check[19:10] == reg25[x_final:x_inicio]) && (check[9:0] >= reg25[y_final:y_inicio]) && (check[9:0] < (reg25[y_final:y_inicio] + spriteLine) ))
    		readData = reg25;
    	if( (check[19:10] == reg26[x_final:x_inicio]) && (check[9:0] >= reg26[y_final:y_inicio]) && (check[9:0] < (reg26[y_final:y_inicio] + spriteLine) ))
    		readData = reg26;
    	if( (check[19:10] == reg27[x_final:x_inicio]) && (check[9:0] >= reg27[y_final:y_inicio]) && (check[9:0] < (reg27[y_final:y_inicio] + spriteLine) ))
    		readData = reg27;
    	if( (check[19:10] == reg28[x_final:x_inicio]) && (check[9:0] >= reg28[y_final:y_inicio]) && (check[9:0] < (reg28[y_final:y_inicio] + spriteLine) ))
    		readData = reg28;
    	if( (check[19:10] == reg29[x_final:x_inicio]) && (check[9:0] >= reg29[y_final:y_inicio]) && (check[9:0] < (reg29[y_final:y_inicio] + spriteLine) ))
    		readData = reg29;
    	if( (check[19:10] == reg30[x_final:x_inicio]) && (check[9:0] >= reg30[y_final:y_inicio]) && (check[9:0] < (reg30[y_final:y_inicio] + spriteLine) ))
    		readData = reg30;
    	if( (check[19:10] == reg31[x_final:x_inicio]) && (check[9:0] >= reg31[y_final:y_inicio]) && (check[9:0] < (reg31[y_final:y_inicio] + spriteLine) ))
    		readData = reg31;
    	//else readData = 32'h00000001; //valor que define que nenhum pixel foi encontrado com os valores informados.
    end
    else readData = 32'h00000001;
end


//Escreve no registro de saída o valor lido de algum registrador.
always @(posedge clk) begin
	if(!written)
		out_readData <= readData;
	else
		out_readData <= 32'hxxxxxxxx;
end

endmodule