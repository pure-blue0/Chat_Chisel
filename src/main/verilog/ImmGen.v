module ImmGen(
  input         clock,
  input         reset,
  input  [31:0] io_inst,
  output [31:0] io_imm
);
  wire [6:0] opcode = io_inst[6:0]; // @[cmd21.sc 11:23]
  wire  _T = 7'h33 == opcode; // @[Conditional.scala 37:30]
  wire  _T_1 = 7'h13 == opcode; // @[Conditional.scala 37:30]
  wire  _T_2 = 7'h3 == opcode; // @[Conditional.scala 37:30]
  wire  _T_3 = 7'h23 == opcode; // @[Conditional.scala 37:30]
  wire  _T_4 = 7'h63 == opcode; // @[Conditional.scala 37:30]
  wire  _T_5 = 7'h6f == opcode; // @[Conditional.scala 37:30]
  wire  _T_6 = 7'h67 == opcode; // @[Conditional.scala 37:30]
  wire  _T_7 = 7'h37 == opcode; // @[Conditional.scala 37:30]
  wire  _T_8 = 7'h17 == opcode; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_0 = _T_8 ? 3'h7 : 3'h0; // @[Conditional.scala 39:67 cmd21.sc 23:29]
  wire [2:0] _GEN_1 = _T_7 ? 3'h6 : _GEN_0; // @[Conditional.scala 39:67 cmd21.sc 22:29]
  wire [2:0] _GEN_2 = _T_6 ? 3'h5 : _GEN_1; // @[Conditional.scala 39:67 cmd21.sc 21:29]
  wire [2:0] _GEN_3 = _T_5 ? 3'h4 : _GEN_2; // @[Conditional.scala 39:67 cmd21.sc 20:29]
  wire [2:0] _GEN_4 = _T_4 ? 3'h3 : _GEN_3; // @[Conditional.scala 39:67 cmd21.sc 19:29]
  wire [2:0] _GEN_5 = _T_3 ? 3'h2 : _GEN_4; // @[Conditional.scala 39:67 cmd21.sc 18:29]
  wire [2:0] _GEN_6 = _T_2 ? 3'h1 : _GEN_5; // @[Conditional.scala 39:67 cmd21.sc 17:29]
  wire [2:0] _GEN_7 = _T_1 ? 3'h1 : _GEN_6; // @[Conditional.scala 39:67 cmd21.sc 16:29]
  wire [2:0] fmt = _T ? 3'h0 : _GEN_7; // @[Conditional.scala 40:58 cmd21.sc 15:29]
  wire  _T_9 = 3'h0 == fmt; // @[Conditional.scala 37:30]
  wire  _T_10 = 3'h1 == fmt; // @[Conditional.scala 37:30]
  wire [19:0] _T_13 = io_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_15 = {_T_13,io_inst[31:20]}; // @[Cat.scala 30:58]
  wire  _T_16 = 3'h2 == fmt; // @[Conditional.scala 37:30]
  wire [31:0] _T_22 = {_T_13,io_inst[31:25],io_inst[11:7]}; // @[Cat.scala 30:58]
  wire  _T_23 = 3'h3 == fmt; // @[Conditional.scala 37:30]
  wire [18:0] _T_26 = io_inst[31] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [30:0] _T_30 = {_T_26,io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 30:58]
  wire  _T_31 = 3'h4 == fmt; // @[Conditional.scala 37:30]
  wire [10:0] _T_34 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [30:0] _T_38 = {_T_34,io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 30:58]
  wire  _T_39 = 3'h5 == fmt; // @[Conditional.scala 37:30]
  wire  _T_45 = 3'h6 == fmt; // @[Conditional.scala 37:30]
  wire [31:0] _T_48 = {io_inst[31:12],12'h0}; // @[Cat.scala 30:58]
  wire  _T_49 = 3'h7 == fmt; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_9 = _T_49 ? _T_48 : 32'h0; // @[Conditional.scala 39:67 cmd21.sc 36:25]
  wire [31:0] _GEN_10 = _T_45 ? _T_48 : _GEN_9; // @[Conditional.scala 39:67 cmd21.sc 35:25]
  wire [31:0] _GEN_11 = _T_39 ? _T_15 : _GEN_10; // @[Conditional.scala 39:67 cmd21.sc 34:25]
  wire [31:0] _GEN_12 = _T_31 ? {{1'd0}, _T_38} : _GEN_11; // @[Conditional.scala 39:67 cmd21.sc 33:25]
  wire [31:0] _GEN_13 = _T_23 ? {{1'd0}, _T_30} : _GEN_12; // @[Conditional.scala 39:67 cmd21.sc 32:25]
  wire [31:0] _GEN_14 = _T_16 ? _T_22 : _GEN_13; // @[Conditional.scala 39:67 cmd21.sc 31:25]
  wire [31:0] _GEN_15 = _T_10 ? _T_15 : _GEN_14; // @[Conditional.scala 39:67 cmd21.sc 30:25]
  assign io_imm = _T_9 ? 32'h0 : _GEN_15; // @[Conditional.scala 40:58 cmd21.sc 29:25]
endmodule
