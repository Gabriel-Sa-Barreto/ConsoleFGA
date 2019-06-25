/*
////////////////////////////////////////////////////////////////////////////////
//AUTHOR: Gabriel Sa Barreto Alves
//DATE: June 17 2019
//DESCRIPTION: 
//	This module FSM is responsable for controls the state's game and
//	active others modules of the game according to state that the game is
//	in the moment.
//////////////////////////////////////////////////////////////////////////////////
*/
module gameFSM(
	input wire clk,
	input wire reset,
	input wire resetFSM,
	input wire startGame,
	input wire pauseGame,
	input wire dead,
	output wire [2:0] stateGame
);

/*
STATES:
 - START: state that waiting the start signal be assigned on input(start) for begin the game.
 - PLAYING: state that shows that the game is activated.
 - PAUSE: the game is paused.
 - RESET: this state is responsable for restart all system and its components.
 - GAMEOVER: the game is over
*/
parameter [2:0] START    = 3'b000,
					  PLAYING  = 3'b001,
					  PAUSE    = 3'b010,
					  RESET    = 3'b011,
					  GAMEOVER = 3'b100;
		
reg [2:0] state,next;
reg [2:0] dataout;

always @ (posedge clk or posedge resetFSM) begin
	if(resetFSM) state <=  RESET;
	else         state <= next;
end

//This always block do the transitions of state.
always @ (state or startGame or pauseGame or dead or reset) 
begin
	next = 3'bx;
	case(state)
		START: begin
			if(startGame)  next = PLAYING;
			else           next = START;
		end
		PLAYING: begin
			if(pauseGame)  next  = PAUSE;
			else if(reset) next  = RESET;
			else if(dead)  next  = GAMEOVER;
			else           next  = PLAYING;
		
		end
		PAUSE:  begin
			if(pauseGame)      next = PAUSE;
			else if(startGame) next = PLAYING;
			else if(reset)     next = RESET;
			else               next = PAUSE; 
		
		end
		RESET:  begin
			if(startGame) next = START;
			else          next = RESET;
		end

		GAMEOVER: begin
			if(startGame) next = RESET;
			else          next = GAMEOVER;
		end
	
		default: next = START;		
	endcase
end

always @ (negedge clk) begin
	case(state)
		START:    dataout <= 3'b000;
		PLAYING:  dataout <= 3'b001;
		PAUSE:    dataout <= 3'b010;
		RESET:    dataout <= 3'b011;
		GAMEOVER: dataout <= 3'b100;
	endcase
end

assign stateGame = dataout;

endmodule