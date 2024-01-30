module Hazard(
  input         clock,
  input         reset,
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
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_ex_rd,
  output        io_id_ex_flush,
  input  [31:0] io_ex_pc,
  input  [31:0] io_mem_pc,
  input  [31:0] io_target_pc,
  input         io_pcsrc,
  output        io_if_id_flush,
  output        io_ex_mem_flush
);
  wire  _T_3 = io_mem_rd != 5'h0; // @[cmd19.sc 30:72]
  wire  _T_8 = io_wb_rd != 5'h0; // @[cmd19.sc 32:75]
  wire [1:0] _GEN_0 = io_ex_rs1 == io_wb_rd & io_wb_regwrite & io_wb_rd != 5'h0 ? 2'h2 : 2'h0; // @[cmd19.sc 32:84 cmd19.sc 33:14 cmd19.sc 35:14]
  wire [1:0] _GEN_2 = io_ex_rs2 == io_wb_rd & io_wb_regwrite & _T_8 ? 2'h2 : 2'h0; // @[cmd19.sc 40:84 cmd19.sc 41:14 cmd19.sc 43:14]
  wire  _T_26 = io_pcsrc & io_target_pc != io_ex_pc; // @[cmd19.sc 61:25]
  wire [31:0] _T_29 = io_mem_pc + 32'h4; // @[cmd19.sc 65:56]
  assign io_forward1 = io_ex_rs1 == io_mem_rd & io_mem_regwrite & io_mem_rd != 5'h0 ? 2'h1 : _GEN_0; // @[cmd19.sc 30:81 cmd19.sc 31:14]
  assign io_forward2 = io_ex_rs2 == io_mem_rd & io_mem_regwrite & _T_3 ? 2'h1 : _GEN_2; // @[cmd19.sc 38:81 cmd19.sc 39:14]
  assign io_pc_stall = io_memread & (io_id_rs1 == io_ex_rd | io_id_rs2 == io_ex_rd); // @[cmd19.sc 51:35]
  assign io_if_id_stall = io_memread & (io_id_rs1 == io_ex_rd | io_id_rs2 == io_ex_rd); // @[cmd19.sc 51:35]
  assign io_id_ex_flush = io_memread & (io_id_rs1 == io_ex_rd | io_id_rs2 == io_ex_rd); // @[cmd19.sc 51:35]
  assign io_if_id_flush = io_target_pc == 32'h0 & io_ex_pc != _T_29 | _T_26; // @[cmd19.sc 65:64 cmd19.sc 66:19]
  assign io_ex_mem_flush = io_target_pc == 32'h0 & io_ex_pc != _T_29 | _T_26; // @[cmd19.sc 65:64 cmd19.sc 66:19]
endmodule
