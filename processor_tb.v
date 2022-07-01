`timescale 1ns / 1ns 
module processor_tb;
	reg clk, rst;
	wire[12:0] current_instr;
	integer i; 
	
processor processor(clk,rst,current_instr);

initial begin
	clk 	= 0;
	rst 	= 0;
	
	#20
	$display("The final result of $s3 in memory is: %d", processor.regmem.registry[4]); 
	$finish;
end

initial begin
	#2 rst = 1;
end

always begin
	#1 clk = ~clk; //toggle clock every 1ns
end

always begin
	#2
	$write("ID:8107 at time: %tns PC= %d RF[0 1 2 3 4 7] is: ", $time, current_instr); //processor.proc.curr_pc);
	$display("");
	for(i=0;i<7;i=i+1)
		$write("%d=%b, ",i,processor.regmem.registry[i]);
	$display("");
end


initial begin
    $dumpfile("output.vcd");
	$dumpvars(0);
end

endmodule