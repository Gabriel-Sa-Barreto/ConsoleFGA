module printModule_full_test;

integer dataLine;              //número total de linhas a serem lidas do arquivo de entrada.

reg [51:0]  inputDatas [0:7];  //oito entradas de 52 bits.

//--------------entradas-----------------
reg clk;
reg clk_pixel;
reg reset;
reg [31:0] data_reg;
reg active_area;
reg [9:0] pixel_x;
reg [8:0] pixel_y;
/////////////////////////////////////////

//---------Fios de ligação entre módulos---------
wire      	sprite_on;
wire [31:0] sprite_datas;

//--------------saídas-------------------
wire        printtingScreen;
wire [18:0] check_value;
wire 		count_finished_2;
wire [16:0] memory_address;
wire [16:0] memory_address_2;

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
	//leitura dos dados de entrada
	$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/printModule_full_test/inputDatas.mem", inputDatas);
	dataLine = 0;
    ////////////////////////////////////////////
	reset = 0;              //reseta os dois módulos nos quais cada um possui suas respectivas máquinas de estados.
	#40;                    //delay de 40 milisegundos
	reset = 1;


	for(dataLine = 0; dataLine <= 6; dataLine = dataLine + 1) begin
		{data_reg,active_area,pixel_y,pixel_x} <= inputDatas[dataLine];
		@(negedge clk); 			//espera a borda de descida do pulso de clock onde as saídas são geradas.
		//impressão das saídas
		//Caso a contagem das linhas de impressão se inicie, a saída de endereço de memória corresponde à saída
		//do módulo sprite_line_counter, senão, do printModule.
		if(sprite_on == 1'b1) begin
			$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address_2, count_finished, printtingScreen);
		end
		else begin
			$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address, count_finished, printtingScreen);
		end
		@(posedge clk); 			//espera a borda de subida do clock para a geração de novas entradas.
	end
	#10;                            //espera de 10 milisegundos para alinha a contagem junto com o clk_pixel.


	//Os 20 pulsos de clock nos quais a linha de um sprite deve ser impresso.
	for(dataLine = 0; dataLine < 20; dataLine = dataLine + 1) begin  //contagem da linha do sprite sendo impressa.
		@(negedge clk_pixel);       //espera a borda de descida do clk_pixel para a geração de novas entradas.
		if(sprite_on == 1'b1) begin
			$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address_2, count_finished, printtingScreen);
		end
		else begin
			$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address, count_finished, printtingScreen);
		end

		if(dataLine == 19) begin
			{data_reg,active_area,pixel_y,pixel_x} <= inputDatas[7]; //última entrada.
		end
		@(posedge clk_pixel);       //espera a borda de subida do clk_pixel para a geração de novas entradas.
		pixel_x = pixel_x + 1;      //aumenta o valor da coordenada x para dar seguimento à geração de endereços de memória.
	end
	
	@(negedge clk_pixel);           //espera a borda de descida do clk_pixel para geração do último endereço.
	if(sprite_on == 1'b0) begin     //a contagem precisa ter terminado.
		$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address_2, count_finished, printtingScreen);
	end
	
	@(negedge clk);           //últiam saída, no qual a contagem foi finalizada e o módulo de impressão volta ao estado inicial.
	if(sprite_on == 1'b0) begin     //a contagem precisa ter terminado.
		$display("Memory_address: %d | Count_finished: %d | PrinttingScreen: %d", memory_address_2, count_finished, printtingScreen);
	end
	
	#35;
	$stop;
end

printModule #(.size_x(10),.size_y(9),.size_address(17),.bits_x_y(19))
printModule_inst
(
	.clk(clk) ,							// input  			  		 clk_sig
	.clk_pixel(clk_pixel) ,				// input  			  		 clk_pixel_sig
	.reset(reset) ,						// input  			  		 reset_sig
	.data_reg(data_reg) ,				// input [31:0] 	  		 data_reg_sig
	.active_area(active_area) ,			// input  			  		 active_area_sig
	.pixel_x(pixel_x) ,					// input [size_x-1:0] 	     pixel_x_sig
	.pixel_y(pixel_y) ,					// input [size_y-1:0] 		 pixel_y_sig
	.count_finished(count_finished) ,	// input  			  		 count_finished_sig
	.sprite_datas(sprite_datas) ,		// output [31:0] 	  		 sprite_datas_sig
	.memory_address(memory_address) ,	// output [size_address-1:0] memory_address_sig
	.printtingScreen(printtingScreen) ,	// output  					 printtingScreen_sig
	.check_value(check_value) ,			// output [18:0] 			 check_value_sig
	.sprite_on(sprite_on) 				// output  					 sprite_on_sig
);

sprite_line_counter # (.size_x(10), .size_y(9), .size_address(17), .size_line(20) )
sprite_line_counter_inst
(
	.clk_pixel(clk_pixel) ,				// input  clk_pixel_sig                        		ok
 	.pixel_x(pixel_x) ,					// input [size_x-1:0] pixel_x_sig              		ok
	.pixel_y(pixel_y) ,					// input [size_y-1:0] pixel_y_sig              		ok
	.sprite_datas(sprite_datas) ,		// input [31:0] sprite_datas_sig               		ok
	.sprite_on(sprite_on) ,				// input  sprite_on_sig                        		ok
	.reset(reset) ,						// input  reset_sig                            		ok
	.memory_address(memory_address_2) ,	// output [size_address-1:0] memory_address_sig     ok
	.count_finished(count_finished) 	// output  count_finished_sig                       ok
);

endmodule