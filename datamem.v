`timescale 1ns / 1ns
module datamem(
	input[15:0] wdata,
					addr,
	input clk,
			we,
			re,					
			//rst
	output[15:0] data_out
	);

	reg [15:0] data [0:23]; 
	
initial begin
//init specified values to memory
data[	0	] <= 	16'b0000000000000000	;
data[	1	] <= 	16'b0000000000100011	;
data[	2	] <= 	16'b0000000000001001	;
data[	3	] <= 	16'b0000000000110001	;
data[	4	] <= 	16'b0000000011001001	;
data[	5	] <= 	16'b0000000000111100	;
data[	6	] <= 	16'b0000000011011011	;
data[	7	] <= 	16'b0000000000000111	;
data[	8	] <= 	16'b1110000100101000	;
data[	9	] <= 	16'b0101001111000101	;
data[	10	] <= 	16'b1001011110001001	;
data[	11	] <= 	16'b1101001111011111	;
data[	12	] <= 	16'b1011100110010001	;
data[	13	] <= 	16'b0000010001100101	;
data[	14	] <= 	16'b0001110001010110	;
data[	15	] <= 	16'b0001001011100100	;
data[	16	] <= 	16'b0110100000111001	;
data[	17	] <= 	16'b1111100000101011	;
data[	18	] <= 	16'b0011110101111001	;
data[	19	] <= 	16'b1011000001110001	;
data[	20	] <= 	16'b0010000111100110	;
data[	21	] <= 	16'b1101000011001010	;
data[	22	] <= 	16'b0111011100001110	;
data[	23	] <= 	16'b1111110110111001	;
end
	
always@(posedge clk) begin
		if (we) begin
			data[addr] <= wdata; //if we enabled, set wdata port data into addr location of data 
		end
		
		//$display("%t memloc=%d mem_out=%b", $time, addr, data_out);
end

assign data_out = (re) ? data[addr] : 16'b0;

endmodule