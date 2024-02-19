module ALU(
  input         clock,
  input         reset,
  input  [31:0] io_alu_in1,
  input  [31:0] io_alu_in2,
  input  [3:0]  io_aluop,
  output        io_zero,
  output [31:0] io_alu_result
);
  wire [31:0] add_result = io_alu_in1 + io_alu_in2; // @[alu.scala 13:31]
  wire [31:0] sub_result = io_alu_in1 - io_alu_in2; // @[alu.scala 14:31]
  wire [31:0] xor_result = io_alu_in1 ^ io_alu_in2; // @[alu.scala 15:31]
  wire [31:0] or_result = io_alu_in1 | io_alu_in2; // @[alu.scala 16:30]
  wire [31:0] and_result = io_alu_in1 & io_alu_in2; // @[alu.scala 17:31]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in1}; // @[alu.scala 18:31]
  wire [62:0] sll_result = _GEN_0 << io_alu_in2[4:0]; // @[alu.scala 18:31]
  wire [31:0] srl_result = io_alu_in1 >> io_alu_in2[4:0]; // @[alu.scala 19:31]
  wire [31:0] sra_result = $signed(io_alu_in1) >>> io_alu_in2[4:0]; // @[alu.scala 20:60]
  wire  slt_result = $signed(io_alu_in1) < $signed(io_alu_in2); // @[alu.scala 21:38]
  wire  sltu_result = io_alu_in1 < io_alu_in2; // @[alu.scala 22:32]
  wire [31:0] _io_alu_result_T_1 = 4'h0 == io_aluop ? add_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_3 = 4'h1 == io_aluop ? sub_result : _io_alu_result_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_5 = 4'h2 == io_aluop ? xor_result : _io_alu_result_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_7 = 4'h3 == io_aluop ? or_result : _io_alu_result_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_9 = 4'h4 == io_aluop ? and_result : _io_alu_result_T_7; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_11 = 4'h5 == io_aluop ? sll_result : {{31'd0}, _io_alu_result_T_9}; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_13 = 4'h6 == io_aluop ? {{31'd0}, srl_result} : _io_alu_result_T_11; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_15 = 4'h7 == io_aluop ? {{31'd0}, sra_result} : _io_alu_result_T_13; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_17 = 4'h8 == io_aluop ? {{62'd0}, slt_result} : _io_alu_result_T_15; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_19 = 4'h9 == io_aluop ? {{62'd0}, sltu_result} : _io_alu_result_T_17; // @[Mux.scala 81:58]
  assign io_zero = io_alu_in1 == io_alu_in2; // @[alu.scala 24:26]
  assign io_alu_result = _io_alu_result_T_19[31:0]; // @[alu.scala 26:17]
endmodule
