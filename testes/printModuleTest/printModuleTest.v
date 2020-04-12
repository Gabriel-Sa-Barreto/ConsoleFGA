module printModuleTest;

integer dataLine;  //número total de linhas a serem lidas do arquivo de entrada.

reg [50:0]  inputDatas [0:6];  //sete entradas de 51 bits.

//--------------entradas-----------------
reg clk;
reg clk_pixel;
reg reset;
reg [31:0] data_reg;
reg active_area;
reg [8:0] pixel_x;
reg [8:0] pixel_y;
/////////////////////////////////////////

//--------------saídas-------------------
wire [16:0] address_memory;
wire        printtingScreen;
wire [17:0] check_value;
/////////////////////////////////////////

always begin //frequência de funcionamento do módulo de impressão (100 MHz)
	clk = 1'b1;
	#5;
	clk = 1'b0;
	#5;
end

always begin //frequência de geração dos pixeis (25 MHz)
	clk_pixel = 1'b1;
	#20;
	clk_pixel = 1'b0;
	#20;
end

initial begin
		//Inicializando os registros de entrada.
		data_reg     = 32'hxxxxxxxx;
        active_area  = 1'bx;
        pixel_x      = 9'bxxxxxxxxx;
        pixel_y      = 9'bxxxxxxxxx;
        dataLine = 0;
        ////////////////////////////////////////////
		reset = 0; //reseta a máquina de estados da unidade de controle.
		#40; //delay de 20 milisegundos
		reset = 1;

		//leitura dos dados de entrada
		$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/printModuleTest/inputDatas.mem", inputDatas);


		for(dataLine = 0; dataLine < 7; dataLine = dataLine + 1) begin
			{data_reg,active_area,pixel_y,pixel_x} <= inputDatas[dataLine];
			@(negedge clk); //espera a borda de descida do pulso de clock onde as saídas são geradas.
			///////////////////////////////////////////////////////////////
			$display("entradas %d: %b | %b | %b | %b" , dataLine, data_reg,active_area,pixel_y,pixel_x);
			$monitor("saidas: %b | %b | pixel_y: %b | pixel_x: %b ", address_memory,printtingScreen, check_value[17:9], check_value[8:0]);
			@(posedge clk); //espera a borda de subida do clock para a geração de novas entradas.
			$display("//////////////////////////////////");
		end



		#10000; //delay de 10000 milisegundos
		$stop; //encerra a simulação
end


printModule printModule_inst
(
	.clk(clk) ,							// input  clk
	.clk_pixel(clk_pixel) ,				// input  clk_pixel
	.reset(reset) ,						// input  reset
	.data_reg(data_reg) ,				// input [31:0] data_reg
	.active_area(active_area) ,			// input  active_area
	.pixel_x(pixel_x) ,					// input [8:0] pixel_x
	.pixel_y(pixel_y) ,					// input [8:0] pixel_y
	.address_memory(address_memory) ,	// output [16:0] address_memory
	.printtingScreen(printtingScreen) ,	// output  printtingScreen
	.check_value(check_value) 			// output [17:0] check_value
);

endmodule