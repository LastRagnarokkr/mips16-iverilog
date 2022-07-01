module alusrcmux(	input[15:0] rd2,sign_ext_line, //register 2 and sign extended line
								input sel,
								output reg[15:0] alusrcmux_out_ALU_in2
								);

always@(*)begin
	case(sel)
	1'b0 : alusrcmux_out_ALU_in2 <= rd2;
	1'b1 : alusrcmux_out_ALU_in2 <= sign_ext_line;
	endcase
end

endmodule	