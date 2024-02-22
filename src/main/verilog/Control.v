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
  output       io_islui,
  output       io_use_rs1,
  output       io_use_rs2
);
  wire [2:0] _io_aluop_T_5 = 7'h0 == io_funct7 ? 3'h6 : 3'h0; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_7 = 7'h20 == io_funct7 ? 3'h7 : _io_aluop_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_9 = 3'h4 == io_funct3 ? 2'h2 : {{1'd0}, 7'h20 == io_funct7}; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_11 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_9; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_13 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_11}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_15 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_13; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_17 = 3'h5 == io_funct3 ? _io_aluop_T_7 : _io_aluop_T_15; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_19 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_17}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_21 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_19; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_27 = 3'h4 == io_funct3 ? 2'h2 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_29 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_27; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_31 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_29}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_33 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_31; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_35 = 3'h5 == io_funct3 ? _io_aluop_T_7 : _io_aluop_T_33; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_37 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_35}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_39 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_37; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_41 = 3'h0 == io_funct3 ? 4'h8 : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_43 = 3'h1 == io_funct3 ? 4'h8 : _io_aluop_T_41; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_45 = 3'h4 == io_funct3 ? 4'h8 : _io_aluop_T_43; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_47 = 3'h5 == io_funct3 ? 4'h8 : _io_aluop_T_45; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_49 = 3'h6 == io_funct3 ? 4'h9 : _io_aluop_T_47; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_51 = 3'h7 == io_funct3 ? 4'h9 : _io_aluop_T_49; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_53 = 7'h33 == io_opcode ? _io_aluop_T_21 : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_55 = 7'h13 == io_opcode ? _io_aluop_T_39 : _io_aluop_T_53; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_57 = 7'h3 == io_opcode ? 4'h0 : _io_aluop_T_55; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_59 = 7'h23 == io_opcode ? 4'h0 : _io_aluop_T_57; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_61 = 7'h63 == io_opcode ? _io_aluop_T_51 : _io_aluop_T_59; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_63 = 7'h6f == io_opcode ? 4'h0 : _io_aluop_T_61; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_65 = 7'h67 == io_opcode ? 4'h0 : _io_aluop_T_63; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_67 = 7'h37 == io_opcode ? 4'h0 : _io_aluop_T_65; // @[Mux.scala 81:58]
  wire  _io_immsrc_T_23 = 7'h63 == io_opcode ? 1'h0 : 7'h23 == io_opcode | (7'h3 == io_opcode | 7'h13 == io_opcode); // @[Mux.scala 81:58]
  wire  _io_regwrite_T_21 = 7'h23 == io_opcode ? 1'h0 : 7'h3 == io_opcode | (7'h13 == io_opcode | 7'h33 == io_opcode); // @[Mux.scala 81:58]
  wire  _io_regwrite_T_23 = 7'h63 == io_opcode ? 1'h0 : _io_regwrite_T_21; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_3 = 3'h1 == io_funct3 ? 2'h3 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_5 = 3'h2 == io_funct3 ? 2'h3 : _io_memtoreg_T_3; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_7 = 3'h3 == io_funct3 ? 2'h3 : _io_memtoreg_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_9 = 3'h5 == io_funct3 ? 2'h3 : _io_memtoreg_T_7; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_11 = 3'h6 == io_funct3 ? 2'h3 : _io_memtoreg_T_9; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_13 = 3'h7 == io_funct3 ? 2'h3 : _io_memtoreg_T_11; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_15 = 7'h33 == io_opcode ? 2'h2 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_17 = 7'h13 == io_opcode ? 2'h2 : _io_memtoreg_T_15; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_19 = 7'h3 == io_opcode ? 2'h1 : _io_memtoreg_T_17; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_21 = 7'h6f == io_opcode ? 2'h0 : _io_memtoreg_T_19; // @[Mux.scala 81:58]
  wire [1:0] _io_memtoreg_T_23 = 7'h37 == io_opcode ? 2'h2 : _io_memtoreg_T_21; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_9 = 3'h5 == io_funct3 ? 1'h0 : 3'h3 == io_funct3 | (3'h2 == io_funct3 | 3'h1 == io_funct3); // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_11 = 3'h6 == io_funct3 ? 1'h0 : _io_use_rs1_T_9; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_13 = 3'h7 == io_funct3 ? 1'h0 : _io_use_rs1_T_11; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_25 = 7'h6f == io_opcode ? 1'h0 : 7'h63 == io_opcode | (7'h23 == io_opcode | (7'h3 == io_opcode | (7'h13
     == io_opcode | 7'h33 == io_opcode))); // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_29 = 7'h37 == io_opcode ? 1'h0 : 7'h67 == io_opcode | _io_use_rs1_T_25; // @[Mux.scala 81:58]
  wire  _io_use_rs1_T_31 = 7'h17 == io_opcode ? 1'h0 : _io_use_rs1_T_29; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_17 = 7'h13 == io_opcode ? 1'h0 : 7'h33 == io_opcode; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_19 = 7'h3 == io_opcode ? 1'h0 : _io_use_rs2_T_17; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_25 = 7'h6f == io_opcode ? 1'h0 : 7'h63 == io_opcode | (7'h23 == io_opcode | _io_use_rs2_T_19); // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_27 = 7'h67 == io_opcode ? 1'h0 : _io_use_rs2_T_25; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_29 = 7'h37 == io_opcode ? 1'h0 : _io_use_rs2_T_27; // @[Mux.scala 81:58]
  wire  _io_use_rs2_T_31 = 7'h17 == io_opcode ? 1'h0 : _io_use_rs2_T_29; // @[Mux.scala 81:58]
  assign io_aluop = 7'h17 == io_opcode ? 4'h0 : _io_aluop_T_67; // @[Mux.scala 81:58]
  assign io_immsrc = 7'h73 == io_opcode ? 3'h7 == io_funct3 | (3'h6 == io_funct3 | 3'h5 == io_funct3) : 7'h17 ==
    io_opcode | (7'h37 == io_opcode | (7'h67 == io_opcode | (7'h6f == io_opcode | _io_immsrc_T_23))); // @[Mux.scala 81:58]
  assign io_isbranch = 7'h63 == io_opcode; // @[Mux.scala 81:61]
  assign io_memread = 7'h3 == io_opcode; // @[Mux.scala 81:61]
  assign io_memwrite = 7'h23 == io_opcode; // @[Mux.scala 81:61]
  assign io_regwrite = 7'h73 == io_opcode ? 3'h7 == io_funct3 | (3'h6 == io_funct3 | (3'h5 == io_funct3 | (3'h3 ==
    io_funct3 | (3'h2 == io_funct3 | 3'h1 == io_funct3)))) : 7'h17 == io_opcode | (7'h37 == io_opcode | (7'h67 ==
    io_opcode | (7'h6f == io_opcode | _io_regwrite_T_23))); // @[Mux.scala 81:58]
  assign io_memtoreg = 7'h73 == io_opcode ? _io_memtoreg_T_13 : _io_memtoreg_T_23; // @[Mux.scala 81:58]
  assign io_pcsel = 7'h67 == io_opcode; // @[Mux.scala 81:61]
  assign io_rdsel = 7'h17 == io_opcode; // @[Mux.scala 81:61]
  assign io_isjump = 7'h67 == io_opcode | 7'h6f == io_opcode; // @[Mux.scala 81:58]
  assign io_islui = 7'h37 == io_opcode; // @[Mux.scala 81:61]
  assign io_use_rs1 = 7'h73 == io_opcode ? _io_use_rs1_T_13 : _io_use_rs1_T_31; // @[Mux.scala 81:58]
  assign io_use_rs2 = 7'h73 == io_opcode ? 1'h0 : _io_use_rs2_T_31; // @[Mux.scala 81:58]
endmodule
