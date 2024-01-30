module Writeback(
  input         clock,
  input         reset,
  input  [31:0] io_wb_reg_pc,
  input  [31:0] io_wb_readdata,
  input  [31:0] io_wb_aluresult,
  input  [1:0]  io_wb_memtoreg,
  output [31:0] io_writedata
);
  wire  _T = io_wb_memtoreg == 2'h0; // @[cmd7.sc 14:21]
  wire  _T_1 = io_wb_memtoreg == 2'h1; // @[cmd7.sc 15:21]
  wire  _T_2 = io_wb_memtoreg == 2'h2; // @[cmd7.sc 16:21]
  wire [31:0] _T_3 = _T_2 ? io_wb_aluresult : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_4 = _T_1 ? io_wb_readdata : _T_3; // @[Mux.scala 98:16]
  assign io_writedata = _T ? io_wb_reg_pc : _T_4; // @[Mux.scala 98:16]
endmodule
