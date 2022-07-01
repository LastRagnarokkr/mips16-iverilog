`timescale 1ns / 1ns
module alu_control	(
								input[1:0]	aluopcode, 	//2bit alu opcode from CTU
								input[3:0]	funct,			//4bit function instruction taken from instbus
								input clk,	
								output reg [3:0] sel				//3bit alu select signal 
								);
								
initial begin
	sel <= 4'b0;
end

//always@(posedge clk) begin
always@(*)begin
	if(aluopcode == 2'b00) //R-type + j, jal instruction
		begin
			case(funct)
				4'b0000 : begin 
								sel <= 4'b0000; 
								//$display("aluop: add");
								end //add
								
				4'b0001 : begin 
								sel <= 4'b0001;  
								//$display("aluop: sub"); 
								end //sub
				
				4'b0010 : begin 
								sel <= 4'b0100;  
								//$display("aluop: and"); 
								end //and
				
				4'b0011 : begin 
								sel <= 4'b0101;  
								//$display("aluop: or"); 
								end //or
				
				4'b0100 : begin 
								sel = 4'b0110;  
								//$display("aluop: slt"); 
								end //slt
				
				4'b0101 : begin 
								sel <= 4'b0010;  
								//$display("aluop: mul"); 
								end //mul
				
				4'b0110 : begin 
								sel <= 4'b0011;  
								//$display("aluop: div"); 
								end //div
				
			endcase
		end
	else if(aluopcode == 2'b01) //beq
					begin 
					sel <= 4'b1000;   
					//$display("aluop: beq"); 
					end
			else if(aluopcode == 2'b10) //slti
							begin 
							sel <= 4'b1001;  
							//$display("aluop: slti"); 
							end
					else if(aluopcode == 2'b11) //lw,sw,addi
									begin 
									sel <= 4'b1010;  
									//$display("aluop: lw,sw,addi"); 
									end
							else begin 
										$display("debug: alu_control - no valid code received!");
										sel <= 4'b0000;
								end

end

endmodule