`include "defines.v"

module IfStage(clk, rst, freeze, branch_taken, branch_address, PC, instruction);
  input clk, rst, freeze, branch_taken;
  input [31:0]branch_address;
  output [31:0]PC;
  output [31:0]instruction;
  
  wire [31:0]PC_out, mux_out, add_out;
  
  Mux32_2 Mux32_2_0(add_out, branch_address, branch_taken, mux_out);
  Adder32 Adder32_0(PC_out, 32'b00000000000000000000000000000100, add_out);
  Register32 pc(clk, rst, ~freeze, mux_out, PC_out);
  InstructionMemory InstructionMemory_0(clk, rst, PC_out, instruction);

  assign PC = add_out;
endmodule
