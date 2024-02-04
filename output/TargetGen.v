module TargetGen(
  input         clock,
  input         reset,
  input  [31:0] io_ex_pc,
  input  [31:0] io_imm,
  input  [31:0] io_alu_result,
  input         io_pcsel,
  input         io_rdsel,
  output [31:0] io_reg_pc,
  output [31:0] io_target_pc
);
  wire [31:0] _io_target_pc_T_1 = io_ex_pc + io_imm; // @[targetgen.scala 17:30]
  wire [31:0] _io_reg_pc_T_3 = io_ex_pc + 32'h4; // @[targetgen.scala 23:27]
  assign io_reg_pc = io_rdsel ? _io_target_pc_T_1 : _io_reg_pc_T_3; // @[targetgen.scala 20:26 21:15 23:15]
  assign io_target_pc = io_pcsel ? io_alu_result : _io_target_pc_T_1; // @[targetgen.scala 14:26 15:18 17:18]
endmodule
