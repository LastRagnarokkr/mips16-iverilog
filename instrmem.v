`timescale 1ns / 1ns
module instrmem(
	input[12:0] pc_pointer, 
	input clk, rst,
	output reg[15:0] inst_out
	);
	integer i;
	reg [15:0] inst_mem [0:23]; //[23:0]; //[0:23];	//word width 13bits deep, stack top at addr 0
	
initial begin	//init instructions	
inst_mem[0] <= 16'b1001100100000001;	//	lw $2, 1($6)
inst_mem[1] <= 16'b1001100110000010;	//	lw $3, 2($6)
inst_mem[2] <= 16'b0000100111000000;	//	add $4, $2, $3
inst_mem[3] <= 16'b0000100110010100;	//	slt $1, $2, $3
inst_mem[4] <= 16'b1100010000000010;	//	beq $0, $1, 2
inst_mem[5] <= 16'b0000100111000010;	//	and $4, $2, $3
inst_mem[6] <= 16'b0100000000001000;	//	j 8						
inst_mem[7] <= 16'b0000100111000001;	//	sub $4, $2, $3
inst_mem[8] <= 16'b0000100111000011;	//	or $4, $2, $3
inst_mem[9] <= 16'b0110000000001101;	//	jal 13					
inst_mem[10] <= 16'b1111001000000010;	//	addi $4, $4, 2
inst_mem[11] <= 16'b1011101000000011;	//	sw $4, 3($6)
inst_mem[12] <= 16'b0100000000001111;	//	jump 15
inst_mem[13] <= 16'b0000100111000110;	//	div $4, $2, $3			
inst_mem[14] <= 16'b0001110000001000;	//	jr $7
inst_mem[15] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[16] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[17] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[18] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[19] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[20] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[21] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[22] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_mem[23] <= 16'b0000000000000000;	//	add $0, $0, $0
inst_out <= 16'b0;
end
	
always@(posedge clk) begin
	if(rst) 
		inst_out = inst_mem[pc_pointer];
		//$display("%t inst_mem[%d] loaded to line",$time, pc_pointer);
end

endmodule