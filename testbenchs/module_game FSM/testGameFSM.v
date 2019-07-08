module testGameFSM;

//Input's FSM
reg clk;
reg reset;
reg resetFSM;
reg startGame;
reg pauseGame;
reg dead;

wire [2:0] dataout;

localparam timeout = 20;

always 
begin
	clk = 0;
	forever #20 clk = ~clk; 
end

initial begin
	/*//reset the game FSM
	resetFSM = 1;
	@ (posedge clk);*/ 
	
	resetFSM = 0;
	@ (posedge clk); 
	outputFSM(dataout);
	//////////////////////////////

	//State START
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);

	//State START
	startGame = 0;
	pauseGame = 0;
	dead      = 0;
	reset     = 1;
	@ (posedge clk);
	outputFSM(dataout);


	//State PLAYING
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);

	//State PLAYING
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);


	//State PAUSE
	startGame = 0;
	pauseGame = 1;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);

	//State RESET
	startGame = 0;
	pauseGame = 0;
	dead      = 0;
	reset     = 1;
	@ (posedge clk);
	outputFSM(dataout);

	//State START
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);

	//State PLAYING
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0;
	@ (posedge clk);
	outputFSM(dataout);

	//State DEAD
	startGame = 0;
	pauseGame = 0;
	dead      = 1;
	reset     = 0; 
	@ (posedge clk);
	outputFSM(dataout);

	//Continue on state DEAD
	startGame = 0;
	pauseGame = 1;
	dead      = 0;
	reset     = 0; 
	@ (posedge clk);
	outputFSM(dataout);

	//State RESET
	startGame = 1;
	pauseGame = 0;
	dead      = 0;
	reset     = 0; 
	@ (posedge clk);
	outputFSM(dataout);

end


task outputFSM;
	input [2:0] dataout;
	begin
		if(dataout == 3'b000)      $display("State: start");
		else if(dataout == 3'b001) $display("State: PLAYING");
		else if(dataout == 3'b010) $display("State: PAUSE");
		else if(dataout == 3'b011) $display("State: RESET");
		else if(dataout == 3'b100) $display("State: GAMEOVER");
		else $display("Sem estado definido");
	$display("%d: ", startGame);
	$display("%d: ", pauseGame);
	$display("%d: ", dead);
	$display("%d: ", reset);
	$display("//////////////////////////////");
	end
endtask


gameFSM game_fsm_inst(
	.clk(clk),                //input clk signal
	.reset(reset),            //input reset signal
	.resetFSM(resetFSM),            //input resetFSM signal
	.startGame(startGame),    //input startGame signal
	.pauseGame(pauseGame),    //input pauseGame signal
	.dead(dead),              //input dead signal
	.stateGame(dataout)         //output [2:0] dataout
);

endmodule