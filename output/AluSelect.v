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
  wire  _select1_T = io_forward1 == 2'h0; // @[aluselect.scala 21:18]
  wire  _select1_T_1 = io_forward1 == 2'h1; // @[aluselect.scala 22:18]
  wire  _select1_T_2 = io_forward1 == 2'h2; // @[aluselect.scala 23:18]
  wire [31:0] _select1_T_3 = _select1_T_2 ? io_writedata : io_rs1_data; // @[Mux.scala 101:16]
  wire [31:0] _select1_T_4 = _select1_T_1 ? io_mem_aluresult : _select1_T_3; // @[Mux.scala 101:16]
  wire [31:0] select1 = _select1_T ? io_rs1_data : _select1_T_4; // @[Mux.scala 101:16]
  wire  _select2_T = io_forward2 == 2'h0; // @[aluselect.scala 29:18]
  wire  _select2_T_1 = io_forward2 == 2'h1; // @[aluselect.scala 30:18]
  wire  _select2_T_2 = io_forward2 == 2'h2; // @[aluselect.scala 31:18]
  wire [31:0] _select2_T_3 = _select2_T_2 ? io_writedata : io_rs2_data; // @[Mux.scala 101:16]
  wire [31:0] _select2_T_4 = _select2_T_1 ? io_mem_aluresult : _select2_T_3; // @[Mux.scala 101:16]
  wire [31:0] select2 = _select2_T ? io_rs2_data : _select2_T_4; // @[Mux.scala 101:16]
  assign io_alu_in1 = io_islui ? 32'h0 : select1; // @[aluselect.scala 25:20]
  assign io_alu_in2 = io_immsrc ? io_imm : select2; // @[aluselect.scala 33:20]
endmodule
