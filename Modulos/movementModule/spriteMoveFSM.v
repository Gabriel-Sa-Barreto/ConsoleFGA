module spriteMoveFSM(
	 input wire clk,
	 input wire reset,
	 input wire left,
	 input wire right,
	 input wire up,
	 input wire down,
	 output wire [2:0] dataout,
	 output reg       moveSprite
);

parameter [2:0]  DEF_STATE   = 3'b000, //default state
					  LEFT_STATE  = 3'b001,
					  RIGHT_STATE = 3'b010,
					  UP_STATE    = 3'b011,
					  DOWN_STATE  = 3'b100;

reg [2:0] state,next;
reg [2:0] fsm_out;

always @ (posedge clk or posedge reset) begin
	if(reset) state <= DEF_STATE;
	else      state <= next;
end

always @ (state or left or right or up or down) begin
	next = 3'bx;
	case(state)
		DEF_STATE: begin
			 if(left)        next = LEFT_STATE;
			 else if(right)  next = RIGHT_STATE;
			 else if(up)     next = UP_STATE;
			 else if(down)   next = DOWN_STATE;
			 else            next = DEF_STATE;
		end
		LEFT_STATE: begin
			 if(right)       next = RIGHT_STATE;
			 else if(up)     next = UP_STATE;
			 else if(down)   next = DOWN_STATE;
			 else            next = LEFT_STATE;
		end
		RIGHT_STATE: begin
			 if(left)        next = LEFT_STATE;
			 else if(up)     next = UP_STATE;
			 else if(down)   next = DOWN_STATE;
			 else            next = RIGHT_STATE;
		end
		UP_STATE:  begin
			 if(up)     	  next = UP_STATE;
			 else if(down)   next = DOWN_STATE;
			 else if(right)  next = RIGHT_STATE;
			 else if(left)   next = LEFT_STATE;
			 else            next = UP_STATE;
		end
		DOWN_STATE:  begin
			 if(up)          next = UP_STATE;
			 else if(right)  next = RIGHT_STATE;
			 else if(left)   next = LEFT_STATE;
			 else            next = DOWN_STATE;
		end
		default: next = DEF_STATE;	
	endcase
end

always @ (negedge clk) begin
	case(state)
			DEF_STATE:  fsm_out <= 3'b000;
			RIGHT_STATE:fsm_out <= 3'b010;
			DOWN_STATE: fsm_out <= 3'b100;
			UP_STATE:   fsm_out <= 3'b011;
			LEFT_STATE: fsm_out <= 3'b001;
	endcase
end

assign dataout = fsm_out; 

reg [19:0] counter = 0;
reg move = 0;
/*------------------------------------------*/
always @ (posedge clk) begin
	if(counter == 20'hfffff) begin
		counter <= 0;
		move <= 1;
	end
	else begin 
		move <= 0;
		case({left,right,up,down})
			4'b0010: begin	//up
				if(state == UP_STATE) counter <= counter + 1;
				else counter <= 0;
			end
			4'b0001: begin //down
				if(state == DOWN_STATE) counter <= counter + 1;
				else counter <= 0;
			end
			4'b1000: begin //left
				if(state == DOWN_STATE) counter <= counter + 1;
				else counter <= 0;
			end
			4'b0100: begin //right
				if(state == DOWN_STATE) counter <= counter + 1;
				else counter <= 0;
			end
		endcase
	end
end

always @ (posedge clk) begin
	moveSprite <= move;
end	
/*-------------------------------------------*/





endmodule