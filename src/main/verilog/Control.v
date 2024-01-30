module Control(
  input        clock,
  input        reset,
  input  [6:0] io_opcode,
  input  [6:0] io_funct7,
  input  [2:0] io_funct3,
  output [3:0] io_aluop,
  output       io_immsrc,
  output       io_isbranch,
  output       io_memread,
  output       io_memwrite,
  output       io_regwrite,
  output [1:0] io_memtoreg,
  output       io_pcsel,
  output       io_rdsel,
  output       io_isjump,
  output       io_isupper,
  output       io_islui
);
  wire [1:0] _T_5 = 7'h4 == io_funct7 ? 2'h2 : {{1'd0}, 7'h20 == io_funct7}; // @[Mux.scala 80:57]
  wire [2:0] _T_9 = 7'h20 == io_funct7 ? 3'h7 : 3'h6; // @[Mux.scala 80:57]
  wire [1:0] _T_11 = 3'h0 == io_funct3 ? _T_5 : 2'h0; // @[Mux.scala 80:57]
  wire [1:0] _T_13 = 3'h6 == io_funct3 ? 2'h3 : _T_11; // @[Mux.scala 80:57]
  wire [2:0] _T_15 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _T_13}; // @[Mux.scala 80:57]
  wire [2:0] _T_17 = 3'h1 == io_funct3 ? 3'h5 : _T_15; // @[Mux.scala 80:57]
  wire [2:0] _T_19 = 3'h5 == io_funct3 ? _T_9 : _T_17; // @[Mux.scala 80:57]
  wire [3:0] _T_21 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _T_19}; // @[Mux.scala 80:57]
  wire [3:0] _T_23 = 3'h3 == io_funct3 ? 4'h9 : _T_21; // @[Mux.scala 80:57]
  wire [1:0] _T_29 = 3'h4 == io_funct3 ? 2'h2 : 2'h0; // @[Mux.scala 80:57]
  wire [1:0] _T_31 = 3'h6 == io_funct3 ? 2'h3 : _T_29; // @[Mux.scala 80:57]
  wire [2:0] _T_33 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _T_31}; // @[Mux.scala 80:57]
  wire [2:0] _T_35 = 3'h1 == io_funct3 ? 3'h5 : _T_33; // @[Mux.scala 80:57]
  wire [2:0] _T_37 = 3'h5 == io_funct3 ? _T_9 : _T_35; // @[Mux.scala 80:57]
  wire [3:0] _T_39 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _T_37}; // @[Mux.scala 80:57]
  wire [3:0] _T_41 = 3'h3 == io_funct3 ? 4'h9 : _T_39; // @[Mux.scala 80:57]
  wire [3:0] _T_51 = 3'h6 == io_funct3 ? 4'h9 : 4'h8; // @[Mux.scala 80:57]
  wire [3:0] _T_53 = 3'h7 == io_funct3 ? 4'h9 : _T_51; // @[Mux.scala 80:57]
  wire [3:0] _T_55 = 7'h33 == io_opcode ? _T_23 : 4'h0; // @[Mux.scala 80:57]
  wire [3:0] _T_57 = 7'h13 == io_opcode ? _T_41 : _T_55; // @[Mux.scala 80:57]
  wire [3:0] _T_59 = 7'h3 == io_opcode ? 4'h0 : _T_57; // @[Mux.scala 80:57]
  wire [3:0] _T_61 = 7'h23 == io_opcode ? 4'h0 : _T_59; // @[Mux.scala 80:57]
  wire [3:0] _T_63 = 7'h63 == io_opcode ? _T_53 : _T_61; // @[Mux.scala 80:57]
  wire [3:0] _T_65 = 7'h6f == io_opcode ? 4'h0 : _T_63; // @[Mux.scala 80:57]
  wire [3:0] _T_67 = 7'h67 == io_opcode ? 4'h0 : _T_65; // @[Mux.scala 80:57]
  wire [3:0] _T_69 = 7'h37 == io_opcode ? 4'h0 : _T_67; // @[Mux.scala 80:57]
  wire  _T_81 = 7'h63 == io_opcode ? 1'h0 : 7'h23 == io_opcode | (7'h3 == io_opcode | 7'h13 == io_opcode); // @[Mux.scala 80:57]
  wire  _T_103 = 7'h23 == io_opcode ? 1'h0 : 7'h3 == io_opcode | (7'h13 == io_opcode | 7'h33 == io_opcode); // @[Mux.scala 80:57]
  wire  _T_105 = 7'h63 == io_opcode ? 1'h0 : _T_103; // @[Mux.scala 80:57]
  wire [1:0] _T_115 = 7'h33 == io_opcode ? 2'h2 : 2'h0; // @[Mux.scala 80:57]
  wire [1:0] _T_117 = 7'h13 == io_opcode ? 2'h2 : _T_115; // @[Mux.scala 80:57]
  wire [1:0] _T_119 = 7'h3 == io_opcode ? 2'h1 : _T_117; // @[Mux.scala 80:57]
  wire [1:0] _T_121 = 7'h6f == io_opcode ? 2'h0 : _T_119; // @[Mux.scala 80:57]
  assign io_aluop = 7'h17 == io_opcode ? 4'h0 : _T_69; // @[Mux.scala 80:57]
  assign io_immsrc = 7'h17 == io_opcode | (7'h37 == io_opcode | (7'h67 == io_opcode | (7'h6f == io_opcode | _T_81))); // @[Mux.scala 80:57]
  assign io_isbranch = 7'h63 == io_opcode; // @[Mux.scala 80:60]
  assign io_memread = 7'h3 == io_opcode; // @[Mux.scala 80:60]
  assign io_memwrite = 7'h23 == io_opcode; // @[Mux.scala 80:60]
  assign io_regwrite = 7'h17 == io_opcode | (7'h37 == io_opcode | (7'h67 == io_opcode | (7'h6f == io_opcode | _T_105))); // @[Mux.scala 80:57]
  assign io_memtoreg = 7'h37 == io_opcode ? 2'h2 : _T_121; // @[Mux.scala 80:57]
  assign io_pcsel = 7'h67 == io_opcode; // @[Mux.scala 80:60]
  assign io_rdsel = 7'h17 == io_opcode; // @[Mux.scala 80:60]
  assign io_isjump = 7'h67 == io_opcode | 7'h6f == io_opcode; // @[Mux.scala 80:57]
  assign io_isupper = 7'h17 == io_opcode | 7'h37 == io_opcode; // @[Mux.scala 80:57]
  assign io_islui = 7'h37 == io_opcode; // @[Mux.scala 80:60]
endmodule
