# mips16-iverilog
A processor implementation in Icarus Verilog (iVerilog), 16bit MIPS format.

Processor behaviour:
1. Processor waits at PC0 until rst from processor_tb.v is enabled (high), after which program counter module begins counting and counter value is sent to instruction memory as input for address fetching.
2. Current PC is sent to pc_add module where it is incremented by 1 and passed to wire pc_inc
3. Instructions memory sends its PC address to instr_bus wire where it is passed to subsequent modules.
4. Control unit (CTU) takes instr_bus 3 MSBs (opcode) and evaluates control signals to be enabled.
5. Registry file sends and takes values as instr_bus and CTU instruct.
6. ALU takes registry output 1 as input 1 and ALU source MUX output as input 2 and performs its operation as selected by ALU control, which takes its instructions from instr_bus and CTU also.
7. Data memory module takes ALU result as address value and registry output 2 as data input, which are evaluated according to CTU enable signals, memory_write, memory_read, respectively.
8. All MUX’s take their select signals from the CTU, except branch MUX which takes its select from amod1 module. amod1 takes CTU branch and ALU branch enable signals and evaluates them with a AND gate. 
9. Program counter is updated from pc_loopback which is from JRMux output, the last MUX in datapath, and the cycle continues with the new value. 

Notes about the processor:
 - Some modules variables are initialized to zero for simulation purposes. These are ignored during synthesis. 
 - Single cycle processing. 
 - Test programs currently need to be written into the processor instruction and data memory manually.
 - Registry is assumed to be initialized to zeroes during rst LOW.
 - Processor is not designed structurally.
 - <b>Processor does not appear to be working correctly when inspected via GTKwave, odd behaviour related to timing is present.</b>
 
 Currently missing from repository, to be added:
 - Instruction reference table
 - Datapath visualization/drawing
 - Registry reference table
 - Test Program
 - Detailed code comments with intentions/function
