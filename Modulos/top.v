module top(
	  input      clk,          //clock da FPGA (50MHz)
	  //input  wire leftSprite,	  //mover sprite para a esquerda
	  //input  wire rightSprite,    //mover sprite para a direita
	  input wire changePosition,
	  output reg  [2:0] VGA_R,   //intensidade de vermelho
	  output reg  [2:0] VGA_G,   //intensidade de verde
	  output reg  [2:0] VGA_B,   //intensidade do azul
	  output wire hsync,        //sinal de sincronizaçao horizontal
	  output wire vsync         //sinal de sincronizaçao vertical
);


wire	 video_enable;    //sinal de area ativa da tela para impressao
wire [10:0]	pixel_x;    //coordenada x do pixel atual da tela 
wire [9:0]  pixel_y;    //coordenada y do pixel atual da tela

reg [9:0] sprite_x;
reg [9:0] sprite_y;

reg [9:0] x_position;
reg [9:0] y_position;


SVGA_sync	SVGA(.clock(clk),
				 .reset(),
				 .hsync(hsync),
				 .vsync(vsync),
				 .video_enable(video_enable),
				 .pixel_x(pixel_x),
				 .pixel_y(pixel_y)
				);

// VRAM frame buffers (read-write)
////////////////////////////////////////////
localparam SCREEN_WIDTH = 800;
localparam SCREEN_HEIGHT = 600;
////////////////////////////////////////////
//Definiçao do espaço que a imagem ira ocupar
localparam SPRITE_SIZE = 32;
////////////////////////////////////////////
//Definiçao do numero de sprites armazenado na memoria
localparam SPRITE_COUNT = 8;
////////////////////////////////////////////
//Número de itens que ira para a matriz de memoria
localparam VRAM_DEPTH = SPRITE_SIZE * SPRITE_SIZE * SPRITE_COUNT; 
////////////////////////////////////////////
//// 2^13 e o valor correspondente a 32 x 32 x 8.
localparam VRAM_A_WIDTH = 13;  
////////////////////////////////////////////
//Quantidade de bits para a cor de um pixel
localparam VRAM_D_WIDTH = 8;   
////////////////////////////////////////////
reg [VRAM_A_WIDTH-1:0] address;      //endereco da memoria
wire [VRAM_D_WIDTH-1:0] dataout;     //saida de dados da memoria
///////////////////////////////////////////
localparam SPRITE_OFFSET = 4 * SPRITE_SIZE * SPRITE_SIZE;


sram #(
        .ADDR_WIDTH(VRAM_A_WIDTH), 
        .DATA_WIDTH(VRAM_D_WIDTH), 
        .DEPTH(VRAM_DEPTH), 
        .MEMFILE("/home/gabriel/Documentos/ConsoleFPGA/sprites.mem"))  // bitmap to load
        vram (
        .i_addr(address), 
        .i_clk(clk), 
        .i_write(0),   // we're always reading
        .i_data(0), 
        .o_data(dataout)
    );

reg [11:0] palette [0:255];  // 256 x 12-bit colour palette entries
reg [11:0] colour;

initial begin
	sprite_x = 0;
	sprite_y = 0;
	address  = 0;
	x_position = 400;
   y_position = 300;
   $readmemh("/home/gabriel/Documentos/ConsoleFPGA/sprites_palette.mem", palette);  // bitmap palette to load
end

always @ (posedge changePosition)
begin
	x_position <= (x_position + 20);
	y_position <= (y_position*2);
	
	if(x_position >= 768) x_position <= 0;
	if(y_position >= 568) y_position <= 0;
	
end

always @ (posedge clk)
    begin
		  address <= SPRITE_OFFSET + (SPRITE_SIZE * sprite_y) + sprite_x;
        if (video_enable)
				begin
					buildSprite(x_position,y_position);	
				end
        else    
				begin 
					colour <= 0;
				end
        VGA_R <= colour[11:9];
        VGA_G <= colour[7:5];
        VGA_B <= colour[3:1];
    end			 
		 
task buildSprite;
	input [9:0] x;
	input [9:0] y;
	begin
		if( (pixel_x >= x && pixel_x < (x + SPRITE_SIZE) ) && (pixel_y >= y && pixel_y < (y + SPRITE_SIZE)) )//caso esteja no centro
		begin
			colour <= palette[dataout];
			if(sprite_y > SPRITE_SIZE) 
			begin
				sprite_y <= 0;
				sprite_x <= 0;
			end
			else
			begin
				if(sprite_x > SPRITE_SIZE-1) 
				begin
					sprite_x <= 0;
					sprite_y <= sprite_y + 1;
				end
				else sprite_x <= sprite_x + 1;
			end
		end
		else
		begin
			colour[11:8] <= 0;
			colour[7:4]  <= 0;
			colour[3:0]  <= 0;
		end
	end
endtask
		 
endmodule