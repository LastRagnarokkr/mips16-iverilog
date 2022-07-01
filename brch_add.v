/*

module brch_add(
							input[12:0] a,
							input[12:0] b,
							input clk,
							output reg[12:0] res 
							);

always@(posedge clk)begin
	 res <= a + b;
end
endmodule
*/

module brch_add(a,b,res);
	input[12:0] a,b;
	output[12:0] res;
	
	assign res = a + b;
endmodule
