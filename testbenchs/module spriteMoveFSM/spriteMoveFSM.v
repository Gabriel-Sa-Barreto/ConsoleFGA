module spriteMoveFSM(
	 input wire clk,
	 input wire reset,
	 input wire left,
	 input wire right,
	 input wire up,
	 input wire down,
	 output reg [2:0] dataout
);

parameter [4:0] DEF_STATE   = 0, //default state
			    LEFT_STATE  = 1,
				RIGHT_STATE = 2,
				UP_STATE    = 3,
				DOWN_STATE  = 4;

reg [4:0] state,next;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		state <= 5'b0;
		state[DEF_STATE] <= 1'b1;
		next[DEF_STATE]  <= 1'b1;
	end
	else state <= next;
end

always @ (state or left or right or up or down) begin
	next = 5'b0;
	case(1'b1)
		state[DEF_STATE]: begin
			 if(left)        next[LEFT_STATE]  = 1'b1;
			 else if(right)  next[RIGHT_STATE] = 1'b1;
			 else if(up)     next[UP_STATE]    = 1'b1;
			 else if(down)   next[DOWN_STATE]  = 1'b1;
			 else            next[DEF_STATE]   = 1'b1;
		end
		state[LEFT_STATE]: begin
			 if(right)       next[RIGHT_STATE] = 1'b1;
			 else if(up)     next[UP_STATE]    = 1'b1;
			 else if(down)   next[DOWN_STATE]  = 1'b1;
			 else            next[LEFT_STATE]  = 1'b1;
		end
		state[RIGHT_STATE]: begin
			 if(left)        next[LEFT_STATE]  = 1'b1;
			 else if(up)     next[UP_STATE]    = 1'b1;
			 else if(down)   next[DOWN_STATE]  = 1'b1;
			 else            next[RIGHT_STATE] = 1'b1;
		end
		state[UP_STATE]:  begin
			 if(up)     	  next[UP_STATE]    = 1'b1;
			 else if(down)   next[DOWN_STATE]  = 1'b1;
			 else if(right)  next[RIGHT_STATE] = 1'b1;
			 else if(left)   next[LEFT_STATE]  = 1'b1;
			 else            next[UP_STATE]    = 1'b1;
		end
		state[DOWN_STATE]:  begin
			 if(up)          next[UP_STATE]  = 1'b1;
			 else if(right)  next[RIGHT_STATE] = 1'b1;
			 else if(left)   next[LEFT_STATE]  = 1'b1;
			 else            next[DOWN_STATE]    = 1'b1;
		end
	endcase
end

always @ (negedge clk) begin
	case(1'b1)
			next[DEF_STATE]:  dataout <= 3'b000;
			next[RIGHT_STATE]:dataout <= 3'b001;
			next[DOWN_STATE]: dataout <= 3'b010;
			next[UP_STATE]:   dataout <= 3'b011;
			next[LEFT_STATE]: dataout <= 3'b100;
	endcase
end
endmodule