module jmpmux(		input[12:0] brchmux_out,
							input[12:0] instr_line, //if jump mux is enabled, this is jump instruction target addr
							input sel,
							output reg[12:0] jmpmux_out //to jrmux
							);
				
always@(*)begin
	case(sel)
	1'b0 : jmpmux_out <= brchmux_out;	//take brch mux if jump <= 0 
	1'b1 : jmpmux_out <= instr_line;		//if jump <= 1, take target address
	endcase
end
				
endmodule