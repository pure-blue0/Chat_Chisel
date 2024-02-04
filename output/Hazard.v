module Hazard(
  input         clock,
  input         reset,
  output        io_predict,
  output        io_pc_stall,
  output        io_if_id_stall,
  output        io_if_id_flush,
  input         io_memread,
  input         io_use_rs1,
  input         io_use_rs2,
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_ex_rd,
  input         io_ex_use_rs1,
  input         io_ex_use_rs2,
  input  [4:0]  io_ex_rs1,
  input  [4:0]  io_ex_rs2,
  input  [31:0] io_ex_pc,
  output        io_id_ex_flush,
  input  [4:0]  io_mem_rd,
  input         io_mem_regwrite,
  input  [31:0] io_mem_pc,
  input  [31:0] io_target_pc,
  output [1:0]  io_forward1,
  output [1:0]  io_forward2,
  output        io_ex_mem_flush,
  input  [4:0]  io_wb_rd,
  input         io_wb_regwrite,
  input         io_pcsrc,
  input         io_trapped,
  input         io_mret,
  output        io_mem_wb_flush
);
  wire  _T_5 = io_mem_rd != 5'h0; // @[hazard.scala 48:97]
  wire  _T_12 = io_wb_rd != 5'h0; // @[hazard.scala 50:100]
  wire [1:0] _GEN_0 = io_ex_use_rs1 & io_ex_rs1 == io_wb_rd & io_wb_regwrite & io_wb_rd != 5'h0 ? 2'h2 : 2'h0; // @[hazard.scala 50:109 51:14 53:14]
  wire [1:0] _GEN_2 = io_ex_use_rs2 & io_ex_rs2 == io_wb_rd & io_wb_regwrite & _T_12 ? 2'h2 : 2'h0; // @[hazard.scala 58:109 59:14 61:14]
  wire  hazard = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  wire  _T_30 = io_pcsrc & io_target_pc != io_ex_pc; // @[hazard.scala 79:25]
  wire [31:0] _T_33 = io_mem_pc + 32'h4; // @[hazard.scala 83:52]
  wire  controlHazard = ~io_pcsrc & io_ex_pc != _T_33 | _T_30; // @[hazard.scala 83:60 84:19]
  wire  _io_if_id_flush_T_1 = controlHazard | io_trapped; // @[hazard.scala 92:35]
  assign io_predict = io_pcsrc & io_target_pc == io_ex_pc; // @[hazard.scala 87:25]
  assign io_pc_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  assign io_if_id_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  assign io_if_id_flush = controlHazard | io_trapped | io_mret; // @[hazard.scala 92:57]
  assign io_id_ex_flush = hazard | controlHazard | io_trapped | io_mret; // @[hazard.scala 95:67]
  assign io_forward1 = io_ex_use_rs1 & io_ex_rs1 == io_mem_rd & io_mem_regwrite & io_mem_rd != 5'h0 ? 2'h1 : _GEN_0; // @[hazard.scala 48:106 49:14]
  assign io_forward2 = io_ex_use_rs2 & io_ex_rs2 == io_mem_rd & io_mem_regwrite & _T_5 ? 2'h1 : _GEN_2; // @[hazard.scala 56:106 57:14]
  assign io_ex_mem_flush = _io_if_id_flush_T_1 | io_mret; // @[hazard.scala 93:58]
  assign io_mem_wb_flush = io_trapped | io_mret; // @[hazard.scala 96:41]
endmodule
