module ALU(
  input         clock,
  input         reset,
  input  [31:0] io_alu_in1,
  input  [31:0] io_alu_in2,
  input  [3:0]  io_aluop,
  output        io_zero,
  output [31:0] io_alu_result
);
  wire [31:0] add_result = io_alu_in1 + io_alu_in2; // @[cmd29.sc 14:31]
  wire [31:0] sub_result = io_alu_in1 - io_alu_in2; // @[cmd29.sc 15:31]
  wire [31:0] xor_result = io_alu_in1 ^ io_alu_in2; // @[cmd29.sc 16:31]
  wire [31:0] or_result = io_alu_in1 | io_alu_in2; // @[cmd29.sc 17:30]
  wire [31:0] and_result = io_alu_in1 & io_alu_in2; // @[cmd29.sc 18:31]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in1}; // @[cmd29.sc 19:31]
  wire [62:0] sll_result = _GEN_0 << io_alu_in2[4:0]; // @[cmd29.sc 19:31]
  wire [31:0] srl_result = io_alu_in1 >> io_alu_in2[4:0]; // @[cmd29.sc 20:31]
  wire [31:0] sra_result = $signed(io_alu_in1) >>> io_alu_in2[4:0]; // @[cmd29.sc 21:60]
  wire  slt_result = $signed(io_alu_in1) < $signed(io_alu_in2); // @[cmd29.sc 22:38]
  wire  sltu_result = io_alu_in1 < io_alu_in2; // @[cmd29.sc 23:32]
  wire [31:0] _T_11 = 4'h0 == io_aluop ? add_result : 32'h0; // @[Mux.scala 80:57]
  wire [31:0] _T_13 = 4'h1 == io_aluop ? sub_result : _T_11; // @[Mux.scala 80:57]
  wire [31:0] _T_15 = 4'h2 == io_aluop ? xor_result : _T_13; // @[Mux.scala 80:57]
  wire [31:0] _T_17 = 4'h3 == io_aluop ? or_result : _T_15; // @[Mux.scala 80:57]
  wire [31:0] _T_19 = 4'h4 == io_aluop ? and_result : _T_17; // @[Mux.scala 80:57]
  wire [62:0] _T_21 = 4'h5 == io_aluop ? sll_result : {{31'd0}, _T_19}; // @[Mux.scala 80:57]
  wire [62:0] _T_23 = 4'h6 == io_aluop ? {{31'd0}, srl_result} : _T_21; // @[Mux.scala 80:57]
  wire [62:0] _T_25 = 4'h7 == io_aluop ? {{31'd0}, sra_result} : _T_23; // @[Mux.scala 80:57]
  wire [62:0] _T_27 = 4'h8 == io_aluop ? {{62'd0}, slt_result} : _T_25; // @[Mux.scala 80:57]
  wire [62:0] _T_29 = 4'h9 == io_aluop ? {{62'd0}, sltu_result} : _T_27; // @[Mux.scala 80:57]
  assign io_zero = io_alu_in1 == io_alu_in2; // @[cmd29.sc 25:26]
  assign io_alu_result = _T_29[31:0]; // @[cmd29.sc 27:17]
endmodule
