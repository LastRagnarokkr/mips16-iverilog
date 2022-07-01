`timescale 1ns / 1ns
module prog_count(		
								input[12:0] 			next_pc, 
								input 					clk, rst,
								output reg[12:0] 	curr_pc
								);
reg count_zero_flag;

initial begin
	count_zero_flag = 1;
	curr_pc <= 0; //init cycle to zero for simulation purposes
end

/*
always@(posedge clk)begin
	if(rst)
		curr_pc <= next_pc; //update program count from returning wire
	else curr_pc = 0;
end


always@(posedge clk or posedge rst)begin
	if(rst)
		curr_pc <= next_pc; 
		//every posedge clk, current instruction counter value is taken from next_pc wire value, otherwise current pc is 0
	else curr_pc <= 0;
end
*/

always@(posedge clk)begin
	
	if(rst)begin 
		if(count_zero_flag)begin
			curr_pc <= 13'b0;			//if czf is 1, send 0
			count_zero_flag <= 0;		//disable flag
		end else curr_pc <= next_pc; //load next_pc to curr_pc if flag is not set
		
	end else begin
		curr_pc <= 13'b0; //if rst 0 -> reset counter to zero and set czf to 1
		count_zero_flag <= 1; //set czf flag to count instructions from 0
	end
end

endmodule 