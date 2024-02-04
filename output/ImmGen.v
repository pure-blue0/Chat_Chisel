module ImmGen(
  input         clock,
  input         reset,
  input  [31:0] io_inst,
  output [31:0] io_imm
);
  wire [6:0] opcode = io_inst[6:0]; // @[immgen.scala 11:23]
  wire [2:0] _GEN_0 = 7'h17 == opcode ? 3'h7 : 3'h0; // @[immgen.scala 14:19 23:29]
  wire [2:0] _GEN_1 = 7'h37 == opcode ? 3'h6 : _GEN_0; // @[immgen.scala 14:19 22:29]
  wire [2:0] _GEN_2 = 7'h67 == opcode ? 3'h5 : _GEN_1; // @[immgen.scala 14:19 21:29]
  wire [2:0] _GEN_3 = 7'h6f == opcode ? 3'h4 : _GEN_2; // @[immgen.scala 14:19 20:29]
  wire [2:0] _GEN_4 = 7'h63 == opcode ? 3'h3 : _GEN_3; // @[immgen.scala 14:19 19:29]
  wire [2:0] _GEN_5 = 7'h23 == opcode ? 3'h2 : _GEN_4; // @[immgen.scala 14:19 18:29]
  wire [2:0] _GEN_6 = 7'h3 == opcode ? 3'h1 : _GEN_5; // @[immgen.scala 14:19 17:29]
  wire [2:0] _GEN_7 = 7'h13 == opcode ? 3'h1 : _GEN_6; // @[immgen.scala 14:19 16:29]
  wire [2:0] fmt = 7'h33 == opcode ? 3'h0 : _GEN_7; // @[immgen.scala 14:19 15:29]
  wire [19:0] _imm_T_2 = io_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _imm_T_4 = {_imm_T_2,io_inst[31:20]}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_10 = {_imm_T_2,io_inst[31:25],io_inst[11:7]}; // @[Cat.scala 31:58]
  wire [18:0] _imm_T_13 = io_inst[31] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [30:0] _imm_T_17 = {_imm_T_13,io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 31:58]
  wire [10:0] _imm_T_20 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [30:0] _imm_T_24 = {_imm_T_20,io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] _imm_T_32 = {io_inst[31:12],12'h0}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_9 = 3'h7 == fmt ? _imm_T_32 : 32'h0; // @[immgen.scala 28:16 36:25]
  wire [31:0] _GEN_10 = 3'h6 == fmt ? _imm_T_32 : _GEN_9; // @[immgen.scala 28:16 35:25]
  wire [31:0] _GEN_11 = 3'h5 == fmt ? _imm_T_4 : _GEN_10; // @[immgen.scala 28:16 34:25]
  wire [31:0] _GEN_12 = 3'h4 == fmt ? {{1'd0}, _imm_T_24} : _GEN_11; // @[immgen.scala 28:16 33:25]
  wire [31:0] _GEN_13 = 3'h3 == fmt ? {{1'd0}, _imm_T_17} : _GEN_12; // @[immgen.scala 28:16 32:25]
  wire [31:0] _GEN_14 = 3'h2 == fmt ? _imm_T_10 : _GEN_13; // @[immgen.scala 28:16 31:25]
  wire [31:0] _GEN_15 = 3'h1 == fmt ? _imm_T_4 : _GEN_14; // @[immgen.scala 28:16 30:25]
  assign io_imm = 3'h0 == fmt ? 32'h0 : _GEN_15; // @[immgen.scala 28:16 29:25]
endmodule
