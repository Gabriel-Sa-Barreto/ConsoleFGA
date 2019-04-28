module top(
		input      clk,          //clock da FPGA (50MHz)
	  output reg  [2:0] VGA_R,   //intensidade de vermelho
	  output reg  [2:0] VGA_G,   //intensidade de verde
	  output reg  [2:0] VGA_B,   //intensidade do azul
	  output wire hsync,        //sinal de sincronizaçao horizontal
	  output wire vsync         //sinal de sincronizaçao vertical
);


wire	 video_enable;    //sinal de area ativa da tela para impressao
wire [10:0]	pixel_x;    //coordenada x do pixel atual da tela 
wire [9:0]  pixel_y;    //coordenada y do pixel atual da tela


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
//Definiçao do espaço que a imagem ira ocupar
localparam SCREEN_WIDTH = 32;
localparam SCREEN_HEIGHT = 32;
////////////////////////////////////////////
//Número de itens que ira para a matriz de memoria
localparam VRAM_DEPTH = SCREEN_WIDTH * SCREEN_HEIGHT; 
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
        .MEMFILE("/home/gabriel/Documentos/ConsoleFPGA/ConsoleFGA/nave.mem"))  // bitmap to load
        vram (
        .i_addr(address), 
        .i_clk(clk), 
        .i_write(0),   // we're always reading
        .i_data(0), 
        .o_data(dataout)
    );

reg [8:0] palette [0:255];  // 255 x 12-bit colour palette entries
reg [8:0] colour;

initial begin
        
        $readmemh("/home/gabriel/Documentos/ConsoleFPGA/ConsoleFGA/nave_palette.mem", palette);  // bitmap palette to load
end

always @ (posedge clk)
    begin
        address <= pixel_y * SCREEN_WIDTH + pixel_x;

        if (video_enable)
            colour <= palette[dataout];
        else    
            colour <= 0;

        VGA_R <= colour[8:6];
        VGA_G <= colour[5:3];
        VGA_B <= colour[2:0];
    end
endmodule