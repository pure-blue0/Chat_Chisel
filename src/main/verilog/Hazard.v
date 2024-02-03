module Hazard(
  input         clock,
  input         reset,
  input         io_ex_use_rs1,
  input         io_ex_use_rs2,
  input  [4:0]  io_ex_rs1,
  input  [4:0]  io_ex_rs2,
  input  [4:0]  io_mem_rd,
  input         io_mem_regwrite,
  input  [4:0]  io_wb_rd,
  input         io_wb_regwrite,
  output [1:0]  io_forward1,
  output [1:0]  io_forward2,
  output        io_pc_stall,
  output        io_if_id_stall,
  input         io_memread,
  input         io_use_rs1,
  input         io_use_rs2,
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_ex_rd,
  output        io_id_ex_flush,
  output        io_predict,
  input  [31:0] io_ex_pc,
  input  [31:0] io_mem_pc,
  input  [31:0] io_target_pc,
  input         io_pcsrc,
  output        io_if_id_flush,
  output        io_ex_mem_flush
);
  wire  _T_5 = io_mem_rd != 5'h0; // @[cmd5.sc 37:97]
  wire  _T_12 = io_wb_rd != 5'h0; // @[cmd5.sc 39:100]
  wire [1:0] _GEN_0 = io_ex_use_rs1 & io_ex_rs1 == io_wb_rd & io_wb_regwrite & io_wb_rd != 5'h0 ? 2'h2 : 2'h0; // @[cmd5.sc 39:109 cmd5.sc 40:14 cmd5.sc 42:14]
  wire [1:0] _GEN_2 = io_ex_use_rs2 & io_ex_rs2 == io_wb_rd & io_wb_regwrite & _T_12 ? 2'h2 : 2'h0; // @[cmd5.sc 47:109 cmd5.sc 48:14 cmd5.sc 50:14]
  wire  hazard = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[cmd5.sc 58:35]
  wire  _T_38 = io_pcsrc & io_target_pc != io_ex_pc; // @[cmd5.sc 68:25]
  wire [31:0] _T_41 = io_mem_pc + 32'h4; // @[cmd5.sc 72:52]
  wire  controlHazard = ~io_pcsrc & io_ex_pc != _T_41 | _T_38; // @[cmd5.sc 72:60 cmd5.sc 73:19]
  assign io_forward1 = io_ex_use_rs1 & io_ex_rs1 == io_mem_rd & io_mem_regwrite & io_mem_rd != 5'h0 ? 2'h1 : _GEN_0; // @[cmd5.sc 37:106 cmd5.sc 38:14]
  assign io_forward2 = io_ex_use_rs2 & io_ex_rs2 == io_mem_rd & io_mem_regwrite & _T_5 ? 2'h1 : _GEN_2; // @[cmd5.sc 45:106 cmd5.sc 46:14]
  assign io_pc_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[cmd5.sc 58:35]
  assign io_if_id_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[cmd5.sc 58:35]
  assign io_id_ex_flush = hazard | controlHazard; // @[cmd5.sc 83:28]
  assign io_predict = io_pcsrc & io_target_pc == io_ex_pc; // @[cmd5.sc 76:25]
  assign io_if_id_flush = ~io_pcsrc & io_ex_pc != _T_41 | _T_38; // @[cmd5.sc 72:60 cmd5.sc 73:19]
  assign io_ex_mem_flush = ~io_pcsrc & io_ex_pc != _T_41 | _T_38; // @[cmd5.sc 72:60 cmd5.sc 73:19]
endmodule
