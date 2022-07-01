module ctu(	input [2:0] 		opcode, 			//3bit instruction (opcode)
					input  				clk, 					//1bit clock signal
					output reg [1:0] 	regdst, 			//2bit MUX sel signal
					output reg					jump, 				//jmpmux sel
					output reg					branch,				//AND gate enable
					output reg					memread, 		//mem_re 1bit enable signal
					output reg [1:0]		memtoreg, 		//2bit MUX select signal
					output reg [1:0]		aluop, 				//2bits 0-3dec
					output reg					memwrite, 		//datam_we //1bit enable signal
					output reg					alusrc,				//MUX select signal
					output reg					regwrite			
					);

initial begin //init output regs to zero
regdst <= 0;
jump <= 0;
branch <= 0;
memread <= 0;
memtoreg <= 0;
aluop <= 0;
memwrite <= 0;
alusrc <= 0;
regwrite <= 0;
end

always@(*) begin
	case(opcode)
		3'b000 :	begin
							//R-type instruction + JR
							$display("Curr. instruction: R/JR type instruction");
							regdst 		<= 1;
							jump 			<= 0;
							branch 		<= 0; 
							memread 	<= 0; //R type does not deal with memory
							memtoreg 	<= 0; //0 to send ALU result to registry via wdr
							aluop 		<= 0;
							memwrite 	<= 0; //R type does not deal with memory
							alusrc 		<= 0; //register to register
							regwrite 	<= 1; //enable to update register
						end
						
		3'b001 :	begin 
							//slti -type
							$display("Curr. instruction: SLTI instruction");
							regdst 		<= 0;
							jump 			<= 0;
							branch 		<= 0;
							memread 	<= 0;
							memtoreg 	<= 0;
							aluop 		<= 2;
							memwrite 	<= 0;
							alusrc 		<= 1; //register-immidiate
							regwrite 	<= 1;
						end
						
		3'b010 :	begin 
							//j -type, jump does not touch register or memory
							$display("Curr. instruction: J instruction");
							regdst 		<= 0;
							jump 			<= 1;
							branch 		<= 0;
							memread 	<= 0;
							memtoreg 	<= 0;
							aluop 		<= 0;
							memwrite 	<= 0;
							alusrc 		<= 0; 
							regwrite 	<= 0;
						end
						
		3'b011 :	begin 
							//jal -type, jump and link requires registry write for $ra
							$display("Curr. instruction: JAL instruction");
							regdst 		<= 2;  //select $7
							jump 			<= 1;
							branch 		<= 0;
							memread 	<= 0;
							memtoreg 	<= 2; //select pc_p2 to $7
							aluop 		<= 0;
							memwrite 	<= 0;
							alusrc 		<= 0; //trgt addr is coming along opcode
							regwrite 	<= 1;
						end
						
		3'b100 :	begin 
							//lw -type
							$display("Curr. instruction: LW instruction");
							regdst 		<= 0;
							jump 			<= 0;
							branch 		<= 0;
							memread 	<= 1;
							memtoreg 	<= 1;
							aluop 		<= 3;
							memwrite 	<= 0; //loading, not storing
							alusrc 		<= 1; 
							regwrite 	<= 1;
						end
						
		3'b101 :	begin 
							//sw -type
							$display("Curr. instruction: SW instruction");
							regdst 		<= 0;
							jump 			<= 0;
							branch 		<= 0;
							memread 	<= 0;
							memtoreg 	<= 0;
							aluop 		<= 3;
							memwrite 	<= 1;
							alusrc 		<= 1; 
							regwrite 	<= 0;
						end
						
		3'b110 :	begin 
							//beq -type
							$display("Curr. instruction: BEQ instruction");
							regdst 		<= 0;
							jump 			<= 0;
							branch 		<= 1;
							memread 	<= 0;
							memtoreg 	<= 0;
							aluop 		<= 1;
							memwrite 	<= 0;
							alusrc 		<= 0; //comparing registers 
							regwrite 	<= 0;
						end
						
		3'b111 :	begin 
							//addi -type
							$display("Curr. instruction: ADDI instruction");
							regdst 		<= 0;
							jump 			<= 0;
							branch 		<= 0; 
							memread 	<= 0;
							memtoreg 	<= 0;
							aluop 		<= 3;
							memwrite 	<= 0;
							alusrc 		<= 1;
							regwrite 	<= 1;
						end
						
	endcase
	
end

endmodule