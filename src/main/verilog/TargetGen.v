module TargetGen(
  input         clock,
  input         reset,
  input  [31:0] io_ex_pc,
  input  [31:0] io_imm,
  input  [31:0] io_alu_result,
  input         io_isupper,
  input         io_pcsel,
  input         io_rdsel,
  output [31:0] io_reg_pc,
  output [31:0] io_target_pc
);
  wire [31:0] _T_2 = io_ex_pc + io_imm; // @[cmd6.sc 18:30]
  wire [31:0] _T_7 = io_ex_pc + 32'h4; // @[cmd6.sc 24:27]
  assign io_reg_pc = io_rdsel ? _T_2 : _T_7; // @[cmd6.sc 21:26 cmd6.sc 22:15 cmd6.sc 24:15]
  assign io_target_pc = io_pcsel ? io_alu_result : _T_2; // @[cmd6.sc 15:26 cmd6.sc 16:18 cmd6.sc 18:18]
endmodule
