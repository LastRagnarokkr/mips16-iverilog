module amod1(	input branch,
						input alu_brch_en,
						output brchmux_sel
						);

and a0(brchmux_sel, alu_brch_en, branch);

/*
always@(*)begin

	if(branch)begin 
		if(alu_brch_en)
			brchmux_sel <= 1;
	end else begin 
		brchmux_sel <= 0;
	end

	if((branch) and (alu_brch_en))
		brchmux_sel <= 1'b1;
		else brchmux_sel <= 1'b0;

end
*/

endmodule