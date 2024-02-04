module Control(
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
  wire [1:0] _io_aluop_T_5 = 7'h4 == io_funct7 ? 2'h2 : {{1'd0}, 7'h20 == io_funct7}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_9 = 7'h20 == io_funct7 ? 3'h7 : 3'h6; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_11 = 3'h0 == io_funct3 ? _io_aluop_T_5 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_13 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_11; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_15 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_13}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_17 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_15; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_19 = 3'h5 == io_funct3 ? _io_aluop_T_9 : _io_aluop_T_17; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_21 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_19}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_23 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_21; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_29 = 3'h4 == io_funct3 ? 2'h2 : 2'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_aluop_T_31 = 3'h6 == io_funct3 ? 2'h3 : _io_aluop_T_29; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_33 = 3'h7 == io_funct3 ? 3'h4 : {{1'd0}, _io_aluop_T_31}; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_35 = 3'h1 == io_funct3 ? 3'h5 : _io_aluop_T_33; // @[Mux.scala 81:58]
  wire [2:0] _io_aluop_T_37 = 3'h5 == io_funct3 ? _io_aluop_T_9 : _io_aluop_T_35; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_39 = 3'h2 == io_funct3 ? 4'h8 : {{1'd0}, _io_aluop_T_37}; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_41 = 3'h3 == io_funct3 ? 4'h9 : _io_aluop_T_39; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_51 = 3'h6 == io_funct3 ? 4'h9 : 4'h8; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_53 = 3'h7 == io_funct3 ? 4'h9 : _io_aluop_T_51; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_55 = 7'h33 == io_opcode ? _io_aluop_T_23 : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_57 = 7'h13 == io_opcode ? _io_aluop_T_41 : _io_aluop_T_55; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_59 = 7'h3 == io_opcode ? 4'h0 : _io_aluop_T_57; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_61 = 7'h23 == io_opcode ? 4'h0 : _io_aluop_T_59; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_63 = 7'h63 == io_opcode ? _io_aluop_T_53 : _io_aluop_T_61; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_65 = 7'h6f == io_opcode ? 4'h0 : _io_aluop_T_63; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_67 = 7'h67 == io_opcode ? 4'h0 : _io_aluop_T_65; // @[Mux.scala 81:58]
  wire [3:0] _io_aluop_T_69 = 7'h37 == io_opcode ? 4'h0 : _io_aluop_T_67; // @[Mux.scala 81:58]
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
  assign io_aluop = 7'h17 == io_opcode ? 4'h0 : _io_aluop_T_69; // @[Mux.scala 81:58]
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
module Regfile(
  input         clock,
  input         reset,
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_wb_rd,
  input  [31:0] io_writedata,
  input         io_wb_regwrite,
  output [31:0] io_rs1_data,
  output [31:0] io_rs2_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[regfile.scala 17:26]
  reg [31:0] registers_1; // @[regfile.scala 17:26]
  reg [31:0] registers_2; // @[regfile.scala 17:26]
  reg [31:0] registers_3; // @[regfile.scala 17:26]
  reg [31:0] registers_4; // @[regfile.scala 17:26]
  reg [31:0] registers_5; // @[regfile.scala 17:26]
  reg [31:0] registers_6; // @[regfile.scala 17:26]
  reg [31:0] registers_7; // @[regfile.scala 17:26]
  reg [31:0] registers_8; // @[regfile.scala 17:26]
  reg [31:0] registers_9; // @[regfile.scala 17:26]
  reg [31:0] registers_10; // @[regfile.scala 17:26]
  reg [31:0] registers_11; // @[regfile.scala 17:26]
  reg [31:0] registers_12; // @[regfile.scala 17:26]
  reg [31:0] registers_13; // @[regfile.scala 17:26]
  reg [31:0] registers_14; // @[regfile.scala 17:26]
  reg [31:0] registers_15; // @[regfile.scala 17:26]
  reg [31:0] registers_16; // @[regfile.scala 17:26]
  reg [31:0] registers_17; // @[regfile.scala 17:26]
  reg [31:0] registers_18; // @[regfile.scala 17:26]
  reg [31:0] registers_19; // @[regfile.scala 17:26]
  reg [31:0] registers_20; // @[regfile.scala 17:26]
  reg [31:0] registers_21; // @[regfile.scala 17:26]
  reg [31:0] registers_22; // @[regfile.scala 17:26]
  reg [31:0] registers_23; // @[regfile.scala 17:26]
  reg [31:0] registers_24; // @[regfile.scala 17:26]
  reg [31:0] registers_25; // @[regfile.scala 17:26]
  reg [31:0] registers_26; // @[regfile.scala 17:26]
  reg [31:0] registers_27; // @[regfile.scala 17:26]
  reg [31:0] registers_28; // @[regfile.scala 17:26]
  reg [31:0] registers_29; // @[regfile.scala 17:26]
  reg [31:0] registers_30; // @[regfile.scala 17:26]
  reg [31:0] registers_31; // @[regfile.scala 17:26]
  wire [31:0] _GEN_1 = 5'h1 == io_id_rs1 ? registers_1 : registers_0; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_2 = 5'h2 == io_id_rs1 ? registers_2 : _GEN_1; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_3 = 5'h3 == io_id_rs1 ? registers_3 : _GEN_2; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_4 = 5'h4 == io_id_rs1 ? registers_4 : _GEN_3; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_5 = 5'h5 == io_id_rs1 ? registers_5 : _GEN_4; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_6 = 5'h6 == io_id_rs1 ? registers_6 : _GEN_5; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_7 = 5'h7 == io_id_rs1 ? registers_7 : _GEN_6; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_8 = 5'h8 == io_id_rs1 ? registers_8 : _GEN_7; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_9 = 5'h9 == io_id_rs1 ? registers_9 : _GEN_8; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_10 = 5'ha == io_id_rs1 ? registers_10 : _GEN_9; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_11 = 5'hb == io_id_rs1 ? registers_11 : _GEN_10; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_12 = 5'hc == io_id_rs1 ? registers_12 : _GEN_11; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_13 = 5'hd == io_id_rs1 ? registers_13 : _GEN_12; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_14 = 5'he == io_id_rs1 ? registers_14 : _GEN_13; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_15 = 5'hf == io_id_rs1 ? registers_15 : _GEN_14; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_16 = 5'h10 == io_id_rs1 ? registers_16 : _GEN_15; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_17 = 5'h11 == io_id_rs1 ? registers_17 : _GEN_16; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_18 = 5'h12 == io_id_rs1 ? registers_18 : _GEN_17; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_19 = 5'h13 == io_id_rs1 ? registers_19 : _GEN_18; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_20 = 5'h14 == io_id_rs1 ? registers_20 : _GEN_19; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_21 = 5'h15 == io_id_rs1 ? registers_21 : _GEN_20; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_22 = 5'h16 == io_id_rs1 ? registers_22 : _GEN_21; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_23 = 5'h17 == io_id_rs1 ? registers_23 : _GEN_22; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_24 = 5'h18 == io_id_rs1 ? registers_24 : _GEN_23; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_25 = 5'h19 == io_id_rs1 ? registers_25 : _GEN_24; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_26 = 5'h1a == io_id_rs1 ? registers_26 : _GEN_25; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_27 = 5'h1b == io_id_rs1 ? registers_27 : _GEN_26; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_28 = 5'h1c == io_id_rs1 ? registers_28 : _GEN_27; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_29 = 5'h1d == io_id_rs1 ? registers_29 : _GEN_28; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_30 = 5'h1e == io_id_rs1 ? registers_30 : _GEN_29; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_31 = 5'h1f == io_id_rs1 ? registers_31 : _GEN_30; // @[regfile.scala 20:{21,21}]
  wire [31:0] _GEN_33 = 5'h1 == io_id_rs2 ? registers_1 : registers_0; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_34 = 5'h2 == io_id_rs2 ? registers_2 : _GEN_33; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_35 = 5'h3 == io_id_rs2 ? registers_3 : _GEN_34; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_36 = 5'h4 == io_id_rs2 ? registers_4 : _GEN_35; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_37 = 5'h5 == io_id_rs2 ? registers_5 : _GEN_36; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_38 = 5'h6 == io_id_rs2 ? registers_6 : _GEN_37; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_39 = 5'h7 == io_id_rs2 ? registers_7 : _GEN_38; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_40 = 5'h8 == io_id_rs2 ? registers_8 : _GEN_39; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_41 = 5'h9 == io_id_rs2 ? registers_9 : _GEN_40; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_42 = 5'ha == io_id_rs2 ? registers_10 : _GEN_41; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_43 = 5'hb == io_id_rs2 ? registers_11 : _GEN_42; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_44 = 5'hc == io_id_rs2 ? registers_12 : _GEN_43; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_45 = 5'hd == io_id_rs2 ? registers_13 : _GEN_44; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_46 = 5'he == io_id_rs2 ? registers_14 : _GEN_45; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_47 = 5'hf == io_id_rs2 ? registers_15 : _GEN_46; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_48 = 5'h10 == io_id_rs2 ? registers_16 : _GEN_47; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_49 = 5'h11 == io_id_rs2 ? registers_17 : _GEN_48; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_50 = 5'h12 == io_id_rs2 ? registers_18 : _GEN_49; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_51 = 5'h13 == io_id_rs2 ? registers_19 : _GEN_50; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_52 = 5'h14 == io_id_rs2 ? registers_20 : _GEN_51; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_53 = 5'h15 == io_id_rs2 ? registers_21 : _GEN_52; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_54 = 5'h16 == io_id_rs2 ? registers_22 : _GEN_53; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_55 = 5'h17 == io_id_rs2 ? registers_23 : _GEN_54; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_56 = 5'h18 == io_id_rs2 ? registers_24 : _GEN_55; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_57 = 5'h19 == io_id_rs2 ? registers_25 : _GEN_56; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_58 = 5'h1a == io_id_rs2 ? registers_26 : _GEN_57; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_59 = 5'h1b == io_id_rs2 ? registers_27 : _GEN_58; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_60 = 5'h1c == io_id_rs2 ? registers_28 : _GEN_59; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_61 = 5'h1d == io_id_rs2 ? registers_29 : _GEN_60; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_62 = 5'h1e == io_id_rs2 ? registers_30 : _GEN_61; // @[regfile.scala 21:{21,21}]
  wire [31:0] _GEN_63 = 5'h1f == io_id_rs2 ? registers_31 : _GEN_62; // @[regfile.scala 21:{21,21}]
  assign io_rs1_data = io_id_rs1 == 5'h0 ? 32'h0 : _GEN_31; // @[regfile.scala 20:21]
  assign io_rs2_data = io_id_rs2 == 5'h0 ? 32'h0 : _GEN_63; // @[regfile.scala 21:21]
  always @(posedge clock) begin
    if (reset) begin // @[regfile.scala 17:26]
      registers_0 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h0 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_0 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_1 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_1 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_2 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h2 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_2 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_3 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h3 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_3 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_4 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h4 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_4 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_5 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h5 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_5 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_6 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h6 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_6 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_7 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h7 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_7 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_8 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h8 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_8 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_9 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h9 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_9 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_10 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'ha == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_10 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_11 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'hb == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_11 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_12 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'hc == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_12 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_13 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'hd == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_13 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_14 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'he == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_14 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_15 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'hf == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_15 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_16 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h10 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_16 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_17 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h11 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_17 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_18 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h12 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_18 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_19 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h13 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_19 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_20 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h14 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_20 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_21 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h15 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_21 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_22 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h16 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_22 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_23 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h17 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_23 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_24 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h18 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_24 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_25 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h19 == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_25 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_26 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1a == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_26 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_27 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1b == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_27 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_28 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1c == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_28 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_29 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1d == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_29 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_30 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1e == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_30 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
    if (reset) begin // @[regfile.scala 17:26]
      registers_31 <= 32'h0; // @[regfile.scala 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[regfile.scala 24:44]
      if (5'h1f == io_wb_rd) begin // @[regfile.scala 25:25]
        registers_31 <= io_writedata; // @[regfile.scala 25:25]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registers_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmGen(
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
module Decode(
  input         clock,
  input         reset,
  input  [31:0] io_id_pc,
  input  [31:0] io_inst,
  output        io_csr_read,
  output        io_csr_write,
  output [11:0] io_csr_address,
  output [3:0]  io_ecause_out,
  output        io_exception_out,
  output        io_mret_out,
  output        io_wfi_out,
  output [31:0] io_ex_pc,
  output [3:0]  io_aluop,
  output        io_immsrc,
  output        io_isbranch,
  output        io_memread,
  output        io_memwrite,
  output        io_regwrite,
  output [1:0]  io_memtoreg,
  output        io_pcsel,
  output        io_rdsel,
  output        io_isjump,
  output        io_islui,
  output [31:0] io_rs1_data,
  output [31:0] io_rs2_data,
  output [31:0] io_imm,
  output [31:0] io_funct3,
  output [4:0]  io_ex_rs1,
  output [4:0]  io_ex_rs2,
  output [4:0]  io_ex_rd,
  output        io_ex_use_rs1,
  output        io_ex_use_rs2,
  input  [4:0]  io_wb_rd,
  input         io_wb_regwrite,
  input  [31:0] io_writedata,
  input         io_id_ex_flush,
  output [4:0]  io_id_rs1,
  output [4:0]  io_id_rs2,
  output        io_use_rs1,
  output        io_use_rs2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
`endif // RANDOMIZE_REG_INIT
  wire [6:0] control_io_opcode; // @[decode.scala 52:23]
  wire [6:0] control_io_funct7; // @[decode.scala 52:23]
  wire [2:0] control_io_funct3; // @[decode.scala 52:23]
  wire [3:0] control_io_aluop; // @[decode.scala 52:23]
  wire  control_io_immsrc; // @[decode.scala 52:23]
  wire  control_io_isbranch; // @[decode.scala 52:23]
  wire  control_io_memread; // @[decode.scala 52:23]
  wire  control_io_memwrite; // @[decode.scala 52:23]
  wire  control_io_regwrite; // @[decode.scala 52:23]
  wire [1:0] control_io_memtoreg; // @[decode.scala 52:23]
  wire  control_io_pcsel; // @[decode.scala 52:23]
  wire  control_io_rdsel; // @[decode.scala 52:23]
  wire  control_io_isjump; // @[decode.scala 52:23]
  wire  control_io_islui; // @[decode.scala 52:23]
  wire  control_io_use_rs1; // @[decode.scala 52:23]
  wire  control_io_use_rs2; // @[decode.scala 52:23]
  wire  regfile_clock; // @[decode.scala 53:23]
  wire  regfile_reset; // @[decode.scala 53:23]
  wire [4:0] regfile_io_id_rs1; // @[decode.scala 53:23]
  wire [4:0] regfile_io_id_rs2; // @[decode.scala 53:23]
  wire [4:0] regfile_io_wb_rd; // @[decode.scala 53:23]
  wire [31:0] regfile_io_writedata; // @[decode.scala 53:23]
  wire  regfile_io_wb_regwrite; // @[decode.scala 53:23]
  wire [31:0] regfile_io_rs1_data; // @[decode.scala 53:23]
  wire [31:0] regfile_io_rs2_data; // @[decode.scala 53:23]
  wire [31:0] immGen_io_inst; // @[decode.scala 54:22]
  wire [31:0] immGen_io_imm; // @[decode.scala 54:22]
  reg  csr_read_reg; // @[decode.scala 57:29]
  reg  csr_write_reg; // @[decode.scala 58:30]
  reg [11:0] csr_address_reg; // @[decode.scala 59:32]
  reg  mret_out_reg; // @[decode.scala 62:29]
  reg  wfi_out_reg; // @[decode.scala 63:28]
  reg [31:0] id_ex_pc_reg; // @[decode.scala 64:29]
  reg [3:0] id_ex_aluop_reg; // @[decode.scala 65:32]
  reg  id_ex_immsrc_reg; // @[decode.scala 66:33]
  reg  id_ex_isbranch_reg; // @[decode.scala 67:35]
  reg  id_ex_memread_reg; // @[decode.scala 68:34]
  reg  id_ex_memwrite_reg; // @[decode.scala 69:35]
  reg  id_ex_regwrite_reg; // @[decode.scala 70:35]
  reg [1:0] id_ex_memtoreg_reg; // @[decode.scala 71:35]
  reg  id_ex_pcsel_reg; // @[decode.scala 72:32]
  reg  id_ex_rdsel_reg; // @[decode.scala 73:32]
  reg  id_ex_isjump_reg; // @[decode.scala 74:33]
  reg  id_ex_islui_reg; // @[decode.scala 75:32]
  reg [31:0] id_ex_rs1_data_reg; // @[decode.scala 76:35]
  reg [31:0] id_ex_rs2_data_reg; // @[decode.scala 77:35]
  reg [31:0] id_ex_imm_reg; // @[decode.scala 78:30]
  reg [2:0] id_ex_funct3_reg; // @[decode.scala 79:33]
  reg [4:0] id_ex_ex_rs1_reg; // @[decode.scala 80:33]
  reg [4:0] id_ex_ex_rs2_reg; // @[decode.scala 81:33]
  reg [4:0] id_ex_ex_rd_reg; // @[decode.scala 82:32]
  reg  id_ex_ex_use_rs1_reg; // @[decode.scala 83:37]
  reg  id_ex_ex_use_rs2_reg; // @[decode.scala 84:37]
  wire  csrInst = io_inst[6:0] == 7'h73; // @[decode.scala 100:38]
  wire  csrrwInst = csrInst & io_inst[14:12] == 3'h1; // @[decode.scala 101:27]
  wire  csrrsInst = csrInst & io_inst[14:12] == 3'h2; // @[decode.scala 102:27]
  wire  csrrcInst = csrInst & io_inst[14:12] == 3'h3; // @[decode.scala 103:27]
  wire  csrrwiInst = csrInst & io_inst[14:12] == 3'h5; // @[decode.scala 104:28]
  wire  csrrsiInst = csrInst & io_inst[14:12] == 3'h6; // @[decode.scala 105:28]
  wire  csrrciInst = csrInst & io_inst[14:12] == 3'h7; // @[decode.scala 106:28]
  wire  mret_out = io_inst == 32'h30200073; // @[decode.scala 118:26]
  wire  wfi_out = io_inst == 32'h10500073; // @[decode.scala 119:25]
  Control control ( // @[decode.scala 52:23]
    .io_opcode(control_io_opcode),
    .io_funct7(control_io_funct7),
    .io_funct3(control_io_funct3),
    .io_aluop(control_io_aluop),
    .io_immsrc(control_io_immsrc),
    .io_isbranch(control_io_isbranch),
    .io_memread(control_io_memread),
    .io_memwrite(control_io_memwrite),
    .io_regwrite(control_io_regwrite),
    .io_memtoreg(control_io_memtoreg),
    .io_pcsel(control_io_pcsel),
    .io_rdsel(control_io_rdsel),
    .io_isjump(control_io_isjump),
    .io_islui(control_io_islui),
    .io_use_rs1(control_io_use_rs1),
    .io_use_rs2(control_io_use_rs2)
  );
  Regfile regfile ( // @[decode.scala 53:23]
    .clock(regfile_clock),
    .reset(regfile_reset),
    .io_id_rs1(regfile_io_id_rs1),
    .io_id_rs2(regfile_io_id_rs2),
    .io_wb_rd(regfile_io_wb_rd),
    .io_writedata(regfile_io_writedata),
    .io_wb_regwrite(regfile_io_wb_regwrite),
    .io_rs1_data(regfile_io_rs1_data),
    .io_rs2_data(regfile_io_rs2_data)
  );
  ImmGen immGen ( // @[decode.scala 54:22]
    .io_inst(immGen_io_inst),
    .io_imm(immGen_io_imm)
  );
  assign io_csr_read = csr_read_reg; // @[decode.scala 187:15]
  assign io_csr_write = csr_write_reg; // @[decode.scala 188:16]
  assign io_csr_address = csr_address_reg; // @[decode.scala 189:18]
  assign io_ecause_out = 4'h0; // @[decode.scala 190:17]
  assign io_exception_out = 1'h0; // @[decode.scala 191:20]
  assign io_mret_out = mret_out_reg; // @[decode.scala 192:15]
  assign io_wfi_out = wfi_out_reg; // @[decode.scala 193:14]
  assign io_ex_pc = id_ex_pc_reg; // @[decode.scala 194:12]
  assign io_aluop = id_ex_aluop_reg; // @[decode.scala 195:12]
  assign io_immsrc = id_ex_immsrc_reg; // @[decode.scala 196:13]
  assign io_isbranch = id_ex_isbranch_reg; // @[decode.scala 197:15]
  assign io_memread = id_ex_memread_reg; // @[decode.scala 198:14]
  assign io_memwrite = id_ex_memwrite_reg; // @[decode.scala 199:15]
  assign io_regwrite = id_ex_regwrite_reg; // @[decode.scala 200:15]
  assign io_memtoreg = id_ex_memtoreg_reg; // @[decode.scala 201:15]
  assign io_pcsel = id_ex_pcsel_reg; // @[decode.scala 202:12]
  assign io_rdsel = id_ex_rdsel_reg; // @[decode.scala 203:12]
  assign io_isjump = id_ex_isjump_reg; // @[decode.scala 204:13]
  assign io_islui = id_ex_islui_reg; // @[decode.scala 205:12]
  assign io_rs1_data = id_ex_rs1_data_reg; // @[decode.scala 206:15]
  assign io_rs2_data = id_ex_rs2_data_reg; // @[decode.scala 207:15]
  assign io_imm = id_ex_imm_reg; // @[decode.scala 208:10]
  assign io_funct3 = {{29'd0}, id_ex_funct3_reg}; // @[decode.scala 209:13]
  assign io_ex_rs1 = id_ex_ex_rs1_reg; // @[decode.scala 210:13]
  assign io_ex_rs2 = id_ex_ex_rs2_reg; // @[decode.scala 211:13]
  assign io_ex_rd = id_ex_ex_rd_reg; // @[decode.scala 212:12]
  assign io_ex_use_rs1 = id_ex_ex_use_rs1_reg; // @[decode.scala 213:17]
  assign io_ex_use_rs2 = id_ex_ex_use_rs2_reg; // @[decode.scala 214:17]
  assign io_id_rs1 = io_inst[19:15]; // @[decode.scala 217:23]
  assign io_id_rs2 = io_inst[24:20]; // @[decode.scala 218:23]
  assign io_use_rs1 = control_io_use_rs1; // @[decode.scala 219:14]
  assign io_use_rs2 = control_io_use_rs2; // @[decode.scala 220:14]
  assign control_io_opcode = io_inst[6:0]; // @[decode.scala 87:31]
  assign control_io_funct7 = io_inst[31:25]; // @[decode.scala 88:31]
  assign control_io_funct3 = io_inst[14:12]; // @[decode.scala 89:31]
  assign regfile_clock = clock;
  assign regfile_reset = reset;
  assign regfile_io_id_rs1 = io_inst[19:15]; // @[decode.scala 91:31]
  assign regfile_io_id_rs2 = io_inst[24:20]; // @[decode.scala 92:31]
  assign regfile_io_wb_rd = io_wb_rd; // @[decode.scala 93:20]
  assign regfile_io_writedata = io_writedata; // @[decode.scala 94:24]
  assign regfile_io_wb_regwrite = io_wb_regwrite; // @[decode.scala 95:26]
  assign immGen_io_inst = io_inst; // @[decode.scala 97:18]
  always @(posedge clock) begin
    if (reset) begin // @[decode.scala 57:29]
      csr_read_reg <= 1'h0; // @[decode.scala 57:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      csr_read_reg <= 1'h0; // @[decode.scala 145:18]
    end else if (csrrwInst | csrrwiInst & io_inst[11:7] == 5'h0) begin // @[decode.scala 111:66]
      csr_read_reg <= 1'h0; // @[decode.scala 112:12]
    end else begin
      csr_read_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 58:30]
      csr_write_reg <= 1'h0; // @[decode.scala 58:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      csr_write_reg <= 1'h0; // @[decode.scala 146:19]
    end else if ((csrrsInst | csrrcInst | csrrsiInst | csrrciInst) & io_inst[19:15] == 5'h0) begin // @[decode.scala 114:94]
      csr_write_reg <= 1'h0; // @[decode.scala 115:13]
    end else begin
      csr_write_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 59:32]
      csr_address_reg <= 12'h0; // @[decode.scala 59:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      csr_address_reg <= 12'h0; // @[decode.scala 147:21]
    end else begin
      csr_address_reg <= io_inst[31:20]; // @[decode.scala 155:21]
    end
    if (reset) begin // @[decode.scala 62:29]
      mret_out_reg <= 1'h0; // @[decode.scala 62:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      mret_out_reg <= 1'h0; // @[decode.scala 150:18]
    end else begin
      mret_out_reg <= mret_out; // @[decode.scala 158:18]
    end
    if (reset) begin // @[decode.scala 63:28]
      wfi_out_reg <= 1'h0; // @[decode.scala 63:28]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      wfi_out_reg <= 1'h0; // @[decode.scala 151:17]
    end else begin
      wfi_out_reg <= wfi_out; // @[decode.scala 159:17]
    end
    if (reset) begin // @[decode.scala 64:29]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 64:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 124:18]
    end else begin
      id_ex_pc_reg <= io_id_pc; // @[decode.scala 160:18]
    end
    if (reset) begin // @[decode.scala 65:32]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 65:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 125:21]
    end else begin
      id_ex_aluop_reg <= control_io_aluop; // @[decode.scala 161:21]
    end
    if (reset) begin // @[decode.scala 66:33]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 66:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 126:22]
    end else begin
      id_ex_immsrc_reg <= control_io_immsrc; // @[decode.scala 162:22]
    end
    if (reset) begin // @[decode.scala 67:35]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 67:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 127:24]
    end else begin
      id_ex_isbranch_reg <= control_io_isbranch; // @[decode.scala 163:24]
    end
    if (reset) begin // @[decode.scala 68:34]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 68:34]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 128:23]
    end else begin
      id_ex_memread_reg <= control_io_memread; // @[decode.scala 164:23]
    end
    if (reset) begin // @[decode.scala 69:35]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 69:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 129:24]
    end else begin
      id_ex_memwrite_reg <= control_io_memwrite; // @[decode.scala 165:24]
    end
    if (reset) begin // @[decode.scala 70:35]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 70:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 130:24]
    end else begin
      id_ex_regwrite_reg <= control_io_regwrite; // @[decode.scala 166:24]
    end
    if (reset) begin // @[decode.scala 71:35]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 71:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 131:24]
    end else begin
      id_ex_memtoreg_reg <= control_io_memtoreg; // @[decode.scala 167:24]
    end
    if (reset) begin // @[decode.scala 72:32]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 72:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 132:21]
    end else begin
      id_ex_pcsel_reg <= control_io_pcsel; // @[decode.scala 168:21]
    end
    if (reset) begin // @[decode.scala 73:32]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 73:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 133:21]
    end else begin
      id_ex_rdsel_reg <= control_io_rdsel; // @[decode.scala 169:21]
    end
    if (reset) begin // @[decode.scala 74:33]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 74:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 134:22]
    end else begin
      id_ex_isjump_reg <= control_io_isjump; // @[decode.scala 170:22]
    end
    if (reset) begin // @[decode.scala 75:32]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 75:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 135:21]
    end else begin
      id_ex_islui_reg <= control_io_islui; // @[decode.scala 171:21]
    end
    if (reset) begin // @[decode.scala 76:35]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 76:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 136:24]
    end else begin
      id_ex_rs1_data_reg <= regfile_io_rs1_data; // @[decode.scala 172:24]
    end
    if (reset) begin // @[decode.scala 77:35]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 77:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 137:24]
    end else begin
      id_ex_rs2_data_reg <= regfile_io_rs2_data; // @[decode.scala 173:24]
    end
    if (reset) begin // @[decode.scala 78:30]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 78:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 138:19]
    end else begin
      id_ex_imm_reg <= immGen_io_imm; // @[decode.scala 174:19]
    end
    if (reset) begin // @[decode.scala 79:33]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 79:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 139:22]
    end else begin
      id_ex_funct3_reg <= io_inst[14:12]; // @[decode.scala 175:22]
    end
    if (reset) begin // @[decode.scala 80:33]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 80:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 140:22]
    end else begin
      id_ex_ex_rs1_reg <= io_inst[19:15]; // @[decode.scala 176:22]
    end
    if (reset) begin // @[decode.scala 81:33]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 81:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 141:22]
    end else begin
      id_ex_ex_rs2_reg <= io_inst[24:20]; // @[decode.scala 177:22]
    end
    if (reset) begin // @[decode.scala 82:32]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 82:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 142:21]
    end else begin
      id_ex_ex_rd_reg <= io_inst[11:7]; // @[decode.scala 178:21]
    end
    if (reset) begin // @[decode.scala 83:37]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 83:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 143:26]
    end else begin
      id_ex_ex_use_rs1_reg <= control_io_use_rs1; // @[decode.scala 179:26]
    end
    if (reset) begin // @[decode.scala 84:37]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 84:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 144:26]
    end else begin
      id_ex_ex_use_rs2_reg <= control_io_use_rs2; // @[decode.scala 180:26]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  csr_read_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  csr_write_reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  csr_address_reg = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  mret_out_reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  wfi_out_reg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  id_ex_pc_reg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  id_ex_aluop_reg = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  id_ex_immsrc_reg = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  id_ex_isbranch_reg = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  id_ex_memread_reg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  id_ex_memwrite_reg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  id_ex_regwrite_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  id_ex_memtoreg_reg = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  id_ex_pcsel_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  id_ex_rdsel_reg = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  id_ex_isjump_reg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  id_ex_islui_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  id_ex_rs1_data_reg = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  id_ex_rs2_data_reg = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  id_ex_imm_reg = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  id_ex_funct3_reg = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  id_ex_ex_rs1_reg = _RAND_21[4:0];
  _RAND_22 = {1{`RANDOM}};
  id_ex_ex_rs2_reg = _RAND_22[4:0];
  _RAND_23 = {1{`RANDOM}};
  id_ex_ex_rd_reg = _RAND_23[4:0];
  _RAND_24 = {1{`RANDOM}};
  id_ex_ex_use_rs1_reg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  id_ex_ex_use_rs2_reg = _RAND_25[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
