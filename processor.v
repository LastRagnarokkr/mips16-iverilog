`timescale 1ns / 1ns
module processor(
					input clk, rst,
					//output current_instr
					);


	wire[15:0] 	instr_line, 
						ext_line, 
						reg_out1, 
						reg_out2, 
						wdr, 
						mem_out, 
						alu_result,
						//alu_input1,
						alu_input2;
	
	wire[12:0] 	pc_p2, 
						pc_loopback,
						curr_pc, 
						//current_instr,
						brch_res,
						brch_out,
						jmp_out;
						
	wire[3:0] 		alu_sel;

	wire[2:0]		wr; //regdest mux output to register write addr
	
	wire[1:0] 		regdst, 
						aluop, 
						memtoreg;

	wire 				jump, 
						//branch, 
						mem_re, 
						mem_we, 
						alusrc, 
						reg_we, 
						jrmux_en; 
						//brch_en,
						//alu_brch_en;

	wire clk, rst;


//Control modules
ctu 				ctu(	instr_line[15:13],	//opcode
							clk, 						
							regdst, 				
							jump, 
							branch, 
							mem_re, 
							memtoreg, 
							aluop, 
							mem_we, 
							alusrc, 
							reg_we
							);
alu_control 	alu_contrl(		aluop, 
							instr_line[3:0],	//funct
							clk,
							alu_sel
							);
alu				alu(	reg_out1, //wire registry out port 1 directly to alu
							alu_input2,  
							alu_sel,
							//clk,
							alu_brch_en,
							alu_result
							);
sign_extend	sign_ext(		//clk,			//removed clock dependency
							instr_line[6:0], 
							ext_line
							); 
prog_count 	proc(		pc_loopback, 
							clk, 
							rst,
							curr_pc  	//current count
							);
jrcontrol	jr_control(		instr_line[3:0], 
							aluop, 
							clk, 
							jrmux_en
							);
amod1		andgate(		branch, 
							alu_brch_en,
							brch_en
							);
brch_add 	brch_adder( pc_p2,
							ext_line[12:0], //select only relevant section of the vector, disregard topmost pad bits
							//clk, 
							brch_res
							);
pc_add		pc_adder(
							curr_pc,	//PC line
							13'b1, 	//hardcode increment bit
							//rst,
							pc_p2	//PC+1 line
							);


//NON-Parameterized MUX's
regdestmux		muxregdst(		instr_line[9:7], 	
								instr_line[6:4], 			
								regdst, 		//sel
								wr			//write addr pointer
								);
memtoregmux	muxdatamem(	alu_result, 	//ina 
								mem_out, 	//inb 
								pc_p2, 		//inc
								memtoreg, 	//sel
								wdr //registry data input
								);
alusrcmux		muxalusource(	reg_out2, 
								ext_line, //sign extended instr 
								alusrc, //mux sel
								alu_input2 //mux out
								);
brchmux			muxbranch(		pc_p2, 
								brch_res, //brch 13bit adder result
								brch_en, 
								brch_out
								);
jmpmux			muxjump(		brch_out,  
								instr_line[12:0], 
								jump,
								jmp_out
								);
jrmux				muxjumpreg(	jmp_out, 
								reg_out1,
								jrmux_en,
								pc_loopback
								);



//Memory modules
regmem 			regmem(	wdr[15:0],			//Write in Data Registry 
								instr_line[12:10],	//regaddr1,
								instr_line[9:7],	//regaddr2,
								wr,						//write register "wr"
								clk, 
								rst, 
								reg_we, 
								reg_out1,
								reg_out2
								);
datamem 			datamem(	reg_out2,		//write data port
								alu_result, 	//feed alu result as memory address to fetch
								clk, 
								//rst, //do not allow clearing of data memory
								mem_we, 
								mem_re, 
								mem_out
								);
instrmem			instrmem(	curr_pc, 
								clk,
								rst,
								instr_line
								); 

endmodule