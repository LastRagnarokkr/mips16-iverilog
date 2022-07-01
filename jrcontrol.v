`timescale 1ns / 1ns
module jrcontrol(
	input[3:0] funct,				 //from instr_line
	input[1:0] aluop, 			//from ctu
	input clk,
	output reg sel
	);
	
initial begin
	sel <= 0;
end

	
//always@(posedge clk)begin
always@(*)begin
	if(aluop==2'b10)begin
		if(funct==4'b1000) begin
			sel <= 1; 						//if aluop is jr, enable jrmux
			  //$display("jr enabled");
			end
	end else sel <= 0;
end
	
endmodule