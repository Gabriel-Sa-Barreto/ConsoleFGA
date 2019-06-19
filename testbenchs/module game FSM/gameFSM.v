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
	input clk,
	input reset,
	input resetFSM,
	input startGame,
	input pauseGame,
	input dead,
	output reg [2:0] dataout
);

/*
STATES:
 - START: state that waiting the start signal be assigned on input(start) for begin the game.
 - PLAYING: state that shows that the game is activated.
 - PAUSE: the game is paused.
 - RESET: this state is responsable for restart all system and its components.
 - GAMEOVER: the game is over
*/
parameter [2:0]      START    = 0,
					 PLAYING  = 1,
					 PAUSE    = 2,
					 RESET    = 3,
					 GAMEOVER = 4;
		
reg [4:0] state,next;

always @ (posedge clk or posedge resetFSM) begin
	if(resetFSM) begin
		state        <= 5'b0;
		state[RESET] <= 1'b1;
	end
	else state <= next;
end

//This always block do the transitions of state.
always @ (state or startGame or pauseGame or dead or reset) 
begin
	next = 5'b0;
	case(1'b1)
		state[START]: begin
			if(!startGame) next[START]   = 1'b1;
			else           next[PLAYING] = 1'b1;
		end
		state[PLAYING]: begin
			if(pauseGame)  next[PAUSE]    = 1'b1;
			else if(reset) next[RESET]    = 1'b1;
			else if(dead)  next[GAMEOVER] = 1'b1;
		
		end
		state[PAUSE]:  begin
			if(!pauseGame)  next[PAUSE] = 1'b1;
			else if(reset)  next[RESET] = 1'b1;
		
		end
		state[RESET]:  begin
			if(startGame)  next[PLAYING] = 1'b1;
			else next[RESET] = 1'b1;
		end

		state[GAMEOVER]: if(startGame) next[RESET]  = 1'b1;
	endcase
end

always @ (negedge clk) begin
		case(1'b1)
			next[START]:    dataout <= 3'b000;
			next[PLAYING]:  dataout <= 3'b001;
			next[PAUSE]:    dataout <= 3'b010;
			next[RESET]:    dataout <= 3'b011;
			next[GAMEOVER]: dataout <= 3'b100;
		endcase
end

endmodule