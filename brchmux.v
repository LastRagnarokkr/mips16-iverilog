module brchmux(	input[12:0] pc_p2, 	//pc_p2
							input[12:0] brch_adder_res, 		//brch adder result
							input sel,
							output reg[12:0] brchmux_out
							);
					
always@(*)begin
	case(sel)
	1'b0 : brchmux_out <= pc_p2;
	1'b1 : brchmux_out <= brch_adder_res;
	endcase
end
				
endmodule