module regdestmux(		input[2:0] rt, 	//instr_line[9:7]
													rd, 	//instr_line[6:4]
									input[1:0] sel,
									output reg[2:0] regdestmux_out
									);
					
always@(*)begin
	case(sel)
	2'b00 : regdestmux_out <= rt;
	2'b01 : regdestmux_out <= rd;	
	2'b10 : regdestmux_out <= 3'b111; 		//$ra , jal - hardcoded addr, no input
	endcase
end

endmodule