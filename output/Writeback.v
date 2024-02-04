module Writeback(
  input         clock,
  input         reset,
  input  [31:0] io_csr_read_data_in,
  input  [31:0] io_wb_reg_pc,
  input  [31:0] io_wb_readdata,
  input  [31:0] io_wb_aluresult,
  input  [1:0]  io_wb_memtoreg,
  output [31:0] io_writedata
);
  wire [31:0] _io_writedata_T_1 = 2'h1 == io_wb_memtoreg ? io_wb_readdata : io_wb_reg_pc; // @[Mux.scala 81:58]
  wire [31:0] _io_writedata_T_3 = 2'h2 == io_wb_memtoreg ? io_wb_aluresult : _io_writedata_T_1; // @[Mux.scala 81:58]
  assign io_writedata = 2'h3 == io_wb_memtoreg ? io_csr_read_data_in : _io_writedata_T_3; // @[Mux.scala 81:58]
endmodule
