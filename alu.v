`timescale 1ns / 1ns
module alu(
					input[15:0] 			in1, in2, 
					input[3:0] 			sel, 		//sel from alu_control
					//input						clk,
					output reg				branch_enable,
					output reg[15:0] 	res		//output is 16bits
					);

initial begin
branch_enable = 0;
res = 16'b0;	//to remove unknown state during simulation
end

//always@(posedge clk)begin
always@(*)begin
	case(sel)
		//Arithmetic
		4'b0000 : res <= in1 + in2; //add, Register-Register
		4'b0001 : res <= in1 - in2; //sub, RR
		4'b0010 : res <= in1 * in2; //mul, RR
		4'b0011 : begin 
						if(in2 == 0)begin
								res <= 0; //result in zero if divide by zero, no illegal condition flag in this iteration
						end else res <= in1 / in2; //div, RR
						end
		
		//Logic
		4'b0100 : res <= in1 & in2; //and, RR
		4'b0101 : res <= in1 | in2; //or, RR
		4'b0110 : res <= (in1<in2); // ? 16'b1 : 16'b0 ;
		
		//Immidate type
		4'b1000 : begin  
							//beq branch if equal, Register-Register
							//branch_enable = (in1 == in2) ? 1'b1 : 1'b0; 
							if(in1 == in2) begin
								branch_enable = 1;
								//$display("ALU: BEQ_ENABLE EXECUTED, brch_en = %b, in1=%b, in2=%b", branch_enable,in1,in2);
							end else begin 
								branch_enable = 0;
								//$display("ALU: BEQ_DISABLE EXECUTED, brch_en = %b, in1=%b, in2=%b", branch_enable, in1,in2);
							end
							
						end 
		4'b1001 : res <= in1 < in2; //slti, R-Imm
		4'b1010 : res <= in1 + in2; //lw,sw,addi, R-Imm
		
		//default : res <= in1 + in2;	
		
	endcase
	//$display("Alu endcase res: %b",res);
end

endmodule