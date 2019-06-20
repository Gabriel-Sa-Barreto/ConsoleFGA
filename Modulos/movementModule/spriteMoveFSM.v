module spriteMoveFSM(
	 input wire clk,
	 input wire reset,
	 input wire left,
	 input wire right,
	 input wire up,
	 input wire down,
	 output reg [2:0] dataout
);

parameter [4:0]  DEF_STATE   = 0, //default state
					  LEFT_STATE  = 0,
					  RIGHT_STATE = 0,
					  UP_STATE    = 0,
					  DOWN_STATE  = 0;

reg [4:0] state,next;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		state <= 5'b0;
		state[DEF_STATE] <= 1'b1;
	end
	else state <= next;
end

always @ (state or left or right or up or down) begin
	next <= 5'b0;
	case(1'b1)
		state[DEF_STATE]: begin
			 if(left)        next[LEFT_STATE]  = 1'b1;
			 else if(right)  next[RIGHT_STATE] = 1'b1;
			 else if(up)     next[UP_STATE]    = 1'b1;
			 else if(down)   next[DOWN_STATE]  = 1'b1;
			 else            next[DEF_STATE] = 1'b1;
		end
		state[LEFT_STATE]: begin
		
		end
		state[RIGHT_STATE]: begin
		
		
		end
		state[UP_STATE]:  begin
		
		
		end
		state[DOWN_STATE]:  begin
		
		
		end
	endcase
end




endmodule