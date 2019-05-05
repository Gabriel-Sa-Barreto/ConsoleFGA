module top(
	  input      clk,          //clock da FPGA (50MHz)
	  input  wire leftSprite,	  //mover sprite para a esquerda
	  input  wire rightSprite,    //mover sprite para a direita
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
//Número de itens que ira para a matriz de memoria
localparam VRAM_DEPTH = SPRITE_SIZE * SPRITE_SIZE; 
////////////////////////////////////////////
//// 2^10 e o valor correspondente a 32 x 32.
localparam VRAM_A_WIDTH = 10;  
////////////////////////////////////////////
//Quantidade de bits para a cor de um pixel
localparam VRAM_D_WIDTH = 8;   
////////////////////////////////////////////
reg [VRAM_A_WIDTH-1:0] address;      //endereco da memoria
wire [VRAM_D_WIDTH-1:0] dataout;     //saida de dados da memoria


sram #(
        .ADDR_WIDTH(VRAM_A_WIDTH), 
        .DATA_WIDTH(VRAM_D_WIDTH), 
        .DEPTH(VRAM_DEPTH), 
        .MEMFILE("/home/gabriel/Documentos/ConsoleFPGA/ConsoleFGA/teste3.mem"))  // bitmap to load
        vram (
        .i_addr(address), 
        .i_clk(clk), 
        .i_write(0),   // we're always reading
        .i_data(0), 
        .o_data(dataout)
    );

reg [11:0] palette [0:255];  // 64 x 12-bit colour palette entries
reg [11:0] colour;

initial begin
	sprite_x = 0;
	sprite_y = 0;
	address  = 0;
   $readmemh("/home/gabriel/Documentos/ConsoleFPGA/ConsoleFGA/teste3_palette.mem", palette);  // bitmap palette to load
end

always @ (posedge clk)
    begin
		  address <= (SPRITE_SIZE * sprite_y) + sprite_x;
        if (video_enable)
				begin
					if( ( pixel_x >= 400 && pixel_x <= 432) && (pixel_y >= 300 && pixel_y <= 332)  )//caso esteja no centro
						begin
							colour <= palette[dataout];
							if(sprite_y > SPRITE_SIZE) 
							begin
								sprite_y <= 0;
								sprite_x <= 0;
							end
							if(sprite_x > SPRITE_SIZE-1) 
								begin
									sprite_x <= 0;
									sprite_y <= sprite_y + 1;
								end
							else sprite_x <= sprite_x + 1;
						end
					else
						begin
							colour[11:8] <= 0;
							colour[7:4]  <= 0;
							colour[3:0]  <= 0;
						end
				end
        else    
				begin 
					colour <= 0;
				end
        VGA_R <= colour[10:8];
        VGA_G <= colour[6:4];
        VGA_B <= colour[2:0];
    end			 
		 
endmodule