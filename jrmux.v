module jrmux(	input[12:0] src_jumpmux,
						input[15:0] src_reg_out1, //register 1 source
						input sel,
						output reg[12:0] pc_loopback //prog_count input
						);

/*
initial begin
	pc_loopback <= 0; //initialize proc module loopback
end
*/
//remove jrmux from prog_count process
			
always@(*)begin //has to be trig on any value to send init signal to pc_loopback
	case(sel)
	1'b0 : pc_loopback <= src_jumpmux;
	1'b1 : pc_loopback <= src_reg_out1[12:0];
	endcase
end
				
endmodule