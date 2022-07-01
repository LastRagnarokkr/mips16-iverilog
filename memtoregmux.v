`timescale 1ns / 1ns
module memtoregmux(		input[15:0] alu, mem_out,
									input[12:0] pc_p2,
									input[1:0] sel,
									output reg[15:0] memtoregmux_out
									);
					
always@(*)begin
	case(sel)
	2'b00 : memtoregmux_out <= alu; 					//alures
	2'b01 : memtoregmux_out <= mem_out; 					//mem_out
	2'b10 : memtoregmux_out <= {3'b000, pc_p2};	//pad missing 3bits from word with zeroes
	endcase
	//$display("memtoregmux_out=%b, sel=%d",memtoregmux_out,sel);
end
				
endmodule
