module AluSelect(
  input         clock,
  input         reset,
  input  [31:0] io_rs1_data,
  input  [31:0] io_rs2_data,
  input  [31:0] io_imm,
  input  [31:0] io_mem_aluresult,
  input  [31:0] io_writedata,
  input         io_immsrc,
  input         io_islui,
  input  [1:0]  io_forward1,
  input  [1:0]  io_forward2,
  output [31:0] io_alu_in1,
  output [31:0] io_alu_in2
);
  wire  _T = io_forward1 == 2'h0; // @[cmd7.sc 21:18]
  wire  _T_1 = io_forward1 == 2'h1; // @[cmd7.sc 22:18]
  wire  _T_2 = io_forward1 == 2'h2; // @[cmd7.sc 23:18]
  wire [31:0] _T_3 = _T_2 ? io_writedata : io_rs1_data; // @[Mux.scala 98:16]
  wire [31:0] _T_4 = _T_1 ? io_mem_aluresult : _T_3; // @[Mux.scala 98:16]
  wire [31:0] select1 = _T ? io_rs1_data : _T_4; // @[Mux.scala 98:16]
  wire  _T_6 = io_forward2 == 2'h0; // @[cmd7.sc 29:18]
  wire  _T_7 = io_forward2 == 2'h1; // @[cmd7.sc 30:18]
  wire  _T_8 = io_forward2 == 2'h2; // @[cmd7.sc 31:18]
  wire [31:0] _T_9 = _T_8 ? io_writedata : io_rs2_data; // @[Mux.scala 98:16]
  wire [31:0] _T_10 = _T_7 ? io_mem_aluresult : _T_9; // @[Mux.scala 98:16]
  wire [31:0] select2 = _T_6 ? io_rs2_data : _T_10; // @[Mux.scala 98:16]
  assign io_alu_in1 = io_islui ? 32'h0 : select1; // @[cmd7.sc 25:20]
  assign io_alu_in2 = io_immsrc ? io_imm : select2; // @[cmd7.sc 33:20]
endmodule
