`timescale 1ns / 1ns
module regmem(
	input[15:0] wdata, 						
	input[2:0] r_addr1, r_addr2, w_addr,
	input clk,rst,we,	 							
	output[15:0] out_port1, out_port2 
	);
	
	integer i;
	reg [15:0] registry [0:6]; 		//7 registers, 16bit words

/*
initial begin

registry[0] <= 16'b0;
registry[1] <= 16'b0;
registry[2] <= 16'b0;
registry[3] <= 16'b0;
registry[4] <= 16'b0;
registry[5] <= 16'b0;
registry[6] <= 16'b0;

end
*/

always@(posedge clk) begin
	
	registry[0] <= 16'b0; //always keep $0 as 0, design specs
	registry[6] <= 16'b0; //always keep $6 as 0, design specs
	

	if(~rst) begin			//clears register values, synced to clk posedge, write enable async
	for(i=0; i<6; i=i+1)
			registry[i] <= 16'b0;
	end
		
	if (we) begin
		if(w_addr == 0)begin
			//disregard write address pointers to $0 and $6
		end 
		else registry[w_addr] <= wdata;
	end
		

end

assign out_port1 = (r_addr1 == 0) ? 16'b0 : registry[r_addr1];
assign out_port2 = (r_addr2 == 0) ? 16'b0 : registry[r_addr2];

endmodule