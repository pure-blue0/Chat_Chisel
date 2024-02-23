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
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
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
  reg [3:0] ecause_out_reg; // @[decode.scala 60:31]
  reg  exception_out_reg; // @[decode.scala 61:34]
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
  wire  _csrrwInst_T_1 = io_inst[14:12] == 3'h1; // @[decode.scala 101:53]
  wire  csrrwInst = csrInst & io_inst[14:12] == 3'h1; // @[decode.scala 101:27]
  wire  _csrrsInst_T_1 = io_inst[14:12] == 3'h2; // @[decode.scala 102:53]
  wire  csrrsInst = csrInst & io_inst[14:12] == 3'h2; // @[decode.scala 102:27]
  wire  _csrrcInst_T_1 = io_inst[14:12] == 3'h3; // @[decode.scala 103:53]
  wire  csrrcInst = csrInst & io_inst[14:12] == 3'h3; // @[decode.scala 103:27]
  wire  _csrrwiInst_T_1 = io_inst[14:12] == 3'h5; // @[decode.scala 104:54]
  wire  csrrwiInst = csrInst & io_inst[14:12] == 3'h5; // @[decode.scala 104:28]
  wire  _csrrsiInst_T_1 = io_inst[14:12] == 3'h6; // @[decode.scala 105:54]
  wire  csrrsiInst = csrInst & io_inst[14:12] == 3'h6; // @[decode.scala 105:28]
  wire  _csrrciInst_T_1 = io_inst[14:12] == 3'h7; // @[decode.scala 106:54]
  wire  csrrciInst = csrInst & io_inst[14:12] == 3'h7; // @[decode.scala 106:28]
  wire  mret_out = io_inst == 32'h30200073; // @[decode.scala 118:26]
  wire  wfi_out = io_inst == 32'h10500073; // @[decode.scala 119:25]
  wire  _isLegalInstruction_T = io_inst[6:0] == 7'h33; // @[decode.scala 127:13]
  wire  _isLegalInstruction_T_1 = io_inst[14:12] == 3'h0; // @[decode.scala 127:40]
  wire  _isLegalInstruction_T_2 = io_inst[6:0] == 7'h33 & io_inst[14:12] == 3'h0; // @[decode.scala 127:30]
  wire  _isLegalInstruction_T_3 = io_inst[31:25] == 7'h0; // @[decode.scala 127:63]
  wire  _isLegalInstruction_T_4 = io_inst[6:0] == 7'h33 & io_inst[14:12] == 3'h0 & io_inst[31:25] == 7'h0; // @[decode.scala 127:53]
  wire  _isLegalInstruction_T_8 = io_inst[31:25] == 7'h20; // @[decode.scala 128:63]
  wire  _isLegalInstruction_T_9 = _isLegalInstruction_T_2 & io_inst[31:25] == 7'h20; // @[decode.scala 128:53]
  wire  _isLegalInstruction_T_11 = io_inst[14:12] == 3'h4; // @[decode.scala 129:40]
  wire  _isLegalInstruction_T_14 = _isLegalInstruction_T & io_inst[14:12] == 3'h4 & _isLegalInstruction_T_3; // @[decode.scala 129:53]
  wire  _isLegalInstruction_T_19 = _isLegalInstruction_T & _csrrsiInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 130:53]
  wire  _isLegalInstruction_T_24 = _isLegalInstruction_T & _csrrciInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 131:53]
  wire  _isLegalInstruction_T_29 = _isLegalInstruction_T & _csrrwInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 132:53]
  wire  _isLegalInstruction_T_32 = _isLegalInstruction_T & _csrrwiInst_T_1; // @[decode.scala 133:30]
  wire  _isLegalInstruction_T_34 = _isLegalInstruction_T & _csrrwiInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 133:53]
  wire  _isLegalInstruction_T_39 = _isLegalInstruction_T_32 & _isLegalInstruction_T_8; // @[decode.scala 134:53]
  wire  _isLegalInstruction_T_44 = _isLegalInstruction_T & _csrrsInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 135:53]
  wire  _isLegalInstruction_T_49 = _isLegalInstruction_T & _csrrcInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 136:53]
  wire  _isLegalInstruction_T_50 = io_inst[6:0] == 7'h13; // @[decode.scala 137:13]
  wire  _isLegalInstruction_T_52 = io_inst[6:0] == 7'h13 & _isLegalInstruction_T_1; // @[decode.scala 137:30]
  wire  _isLegalInstruction_T_55 = _isLegalInstruction_T_50 & _isLegalInstruction_T_11; // @[decode.scala 138:30]
  wire  _isLegalInstruction_T_58 = _isLegalInstruction_T_50 & _csrrsiInst_T_1; // @[decode.scala 139:30]
  wire  _isLegalInstruction_T_61 = _isLegalInstruction_T_50 & _csrrciInst_T_1; // @[decode.scala 140:30]
  wire  _isLegalInstruction_T_66 = _isLegalInstruction_T_50 & _csrrwInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 141:53]
  wire  _isLegalInstruction_T_69 = _isLegalInstruction_T_50 & _csrrwiInst_T_1; // @[decode.scala 142:30]
  wire  _isLegalInstruction_T_71 = _isLegalInstruction_T_50 & _csrrwiInst_T_1 & _isLegalInstruction_T_3; // @[decode.scala 142:53]
  wire  _isLegalInstruction_T_76 = _isLegalInstruction_T_69 & _isLegalInstruction_T_8; // @[decode.scala 143:53]
  wire  _isLegalInstruction_T_79 = _isLegalInstruction_T_50 & _csrrsInst_T_1; // @[decode.scala 144:30]
  wire  _isLegalInstruction_T_82 = _isLegalInstruction_T_50 & _csrrcInst_T_1; // @[decode.scala 145:30]
  wire  _isLegalInstruction_T_83 = io_inst[6:0] == 7'h3; // @[decode.scala 146:13]
  wire  _isLegalInstruction_T_85 = io_inst[6:0] == 7'h3 & _isLegalInstruction_T_1; // @[decode.scala 146:30]
  wire  _isLegalInstruction_T_88 = _isLegalInstruction_T_83 & _csrrwInst_T_1; // @[decode.scala 147:30]
  wire  _isLegalInstruction_T_91 = _isLegalInstruction_T_83 & _csrrsInst_T_1; // @[decode.scala 148:30]
  wire  _isLegalInstruction_T_94 = _isLegalInstruction_T_83 & _isLegalInstruction_T_11; // @[decode.scala 149:30]
  wire  _isLegalInstruction_T_97 = _isLegalInstruction_T_83 & _csrrwiInst_T_1; // @[decode.scala 150:30]
  wire  _isLegalInstruction_T_98 = io_inst[6:0] == 7'h23; // @[decode.scala 151:13]
  wire  _isLegalInstruction_T_100 = io_inst[6:0] == 7'h23 & _isLegalInstruction_T_1; // @[decode.scala 151:30]
  wire  _isLegalInstruction_T_103 = _isLegalInstruction_T_98 & _csrrwInst_T_1; // @[decode.scala 152:30]
  wire  _isLegalInstruction_T_106 = _isLegalInstruction_T_98 & _csrrsInst_T_1; // @[decode.scala 153:30]
  wire  _isLegalInstruction_T_107 = io_inst[6:0] == 7'h63; // @[decode.scala 154:13]
  wire  _isLegalInstruction_T_109 = io_inst[6:0] == 7'h63 & _isLegalInstruction_T_1; // @[decode.scala 154:30]
  wire  _isLegalInstruction_T_112 = _isLegalInstruction_T_107 & _csrrwInst_T_1; // @[decode.scala 155:30]
  wire  _isLegalInstruction_T_115 = _isLegalInstruction_T_107 & _isLegalInstruction_T_11; // @[decode.scala 156:30]
  wire  _isLegalInstruction_T_118 = _isLegalInstruction_T_107 & _csrrwiInst_T_1; // @[decode.scala 157:30]
  wire  _isLegalInstruction_T_121 = _isLegalInstruction_T_107 & _csrrsiInst_T_1; // @[decode.scala 158:30]
  wire  _isLegalInstruction_T_124 = _isLegalInstruction_T_107 & _csrrciInst_T_1; // @[decode.scala 159:30]
  wire  _isLegalInstruction_T_125 = io_inst[6:0] == 7'h6f; // @[decode.scala 160:13]
  wire  _isLegalInstruction_T_128 = io_inst[6:0] == 7'h67 & _isLegalInstruction_T_1; // @[decode.scala 161:30]
  wire  _isLegalInstruction_T_129 = io_inst[6:0] == 7'h37; // @[decode.scala 162:13]
  wire  _isLegalInstruction_T_130 = io_inst[6:0] == 7'h17; // @[decode.scala 163:13]
  wire  _isLegalInstruction_T_133 = csrInst & _isLegalInstruction_T_1; // @[decode.scala 164:30]
  wire  _isLegalInstruction_T_135 = csrInst & _isLegalInstruction_T_1 & _isLegalInstruction_T_3; // @[decode.scala 164:53]
  wire  _isLegalInstruction_T_140 = _isLegalInstruction_T_133 & io_inst[31:25] == 7'h1; // @[decode.scala 165:53]
  wire  _isLegalInstruction_T_145 = _isLegalInstruction_T_133 & io_inst[31:25] == 7'h18; // @[decode.scala 166:53]
  wire  _isLegalInstruction_T_150 = _isLegalInstruction_T_133 & io_inst[31:25] == 7'h8; // @[decode.scala 167:53]
  wire  _isLegalInstruction_T_169 = io_inst[6:0] == 7'hf; // @[decode.scala 174:13]
  wire  _isLegalInstruction_T_171 = io_inst[6:0] == 7'hf & _isLegalInstruction_T_1; // @[decode.scala 174:30]
  wire  _isLegalInstruction_T_174 = _isLegalInstruction_T_169 & _csrrwInst_T_1; // @[decode.scala 175:30]
  wire  _isLegalInstruction_T_205 = _isLegalInstruction_T_82 | (_isLegalInstruction_T_85 | (_isLegalInstruction_T_88 | (
    _isLegalInstruction_T_91 | (_isLegalInstruction_T_94 | (_isLegalInstruction_T_97 | (_isLegalInstruction_T_100 | (
    _isLegalInstruction_T_103 | (_isLegalInstruction_T_106 | (_isLegalInstruction_T_109 | (_isLegalInstruction_T_112 | (
    _isLegalInstruction_T_115 | (_isLegalInstruction_T_118 | (_isLegalInstruction_T_121 | (_isLegalInstruction_T_124 | (
    _isLegalInstruction_T_125 | (_isLegalInstruction_T_128 | (_isLegalInstruction_T_129 | (_isLegalInstruction_T_130 | (
    _isLegalInstruction_T_135 | (_isLegalInstruction_T_140 | (_isLegalInstruction_T_145 | (_isLegalInstruction_T_150 | (
    csrrwInst | (csrrsInst | (csrrcInst | (csrrwiInst | (csrrsiInst | (csrrciInst | (_isLegalInstruction_T_171 |
    _isLegalInstruction_T_174))))))))))))))))))))))))))))); // @[Mux.scala 101:16]
  wire  isLegalInstruction = _isLegalInstruction_T_4 | (_isLegalInstruction_T_9 | (_isLegalInstruction_T_14 | (
    _isLegalInstruction_T_19 | (_isLegalInstruction_T_24 | (_isLegalInstruction_T_29 | (_isLegalInstruction_T_34 | (
    _isLegalInstruction_T_39 | (_isLegalInstruction_T_44 | (_isLegalInstruction_T_49 | (_isLegalInstruction_T_52 | (
    _isLegalInstruction_T_55 | (_isLegalInstruction_T_58 | (_isLegalInstruction_T_61 | (_isLegalInstruction_T_66 | (
    _isLegalInstruction_T_71 | (_isLegalInstruction_T_76 | (_isLegalInstruction_T_79 | _isLegalInstruction_T_205))))))))
    ))))))))); // @[Mux.scala 101:16]
  wire [1:0] ecause_out = isLegalInstruction ? 2'h0 : 2'h2; // @[decode.scala 179:23]
  wire [1:0] _GEN_26 = io_id_ex_flush ? 2'h0 : ecause_out; // @[decode.scala 182:25 207:20 215:20]
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
  assign io_csr_read = csr_read_reg; // @[decode.scala 246:15]
  assign io_csr_write = csr_write_reg; // @[decode.scala 247:16]
  assign io_csr_address = csr_address_reg; // @[decode.scala 248:18]
  assign io_ecause_out = ecause_out_reg; // @[decode.scala 249:17]
  assign io_exception_out = exception_out_reg; // @[decode.scala 250:20]
  assign io_mret_out = mret_out_reg; // @[decode.scala 251:15]
  assign io_wfi_out = wfi_out_reg; // @[decode.scala 252:14]
  assign io_ex_pc = id_ex_pc_reg; // @[decode.scala 253:12]
  assign io_aluop = id_ex_aluop_reg; // @[decode.scala 254:12]
  assign io_immsrc = id_ex_immsrc_reg; // @[decode.scala 255:13]
  assign io_isbranch = id_ex_isbranch_reg; // @[decode.scala 256:15]
  assign io_memread = id_ex_memread_reg; // @[decode.scala 257:14]
  assign io_memwrite = id_ex_memwrite_reg; // @[decode.scala 258:15]
  assign io_regwrite = id_ex_regwrite_reg; // @[decode.scala 259:15]
  assign io_memtoreg = id_ex_memtoreg_reg; // @[decode.scala 260:15]
  assign io_pcsel = id_ex_pcsel_reg; // @[decode.scala 261:12]
  assign io_rdsel = id_ex_rdsel_reg; // @[decode.scala 262:12]
  assign io_isjump = id_ex_isjump_reg; // @[decode.scala 263:13]
  assign io_islui = id_ex_islui_reg; // @[decode.scala 264:12]
  assign io_rs1_data = id_ex_rs1_data_reg; // @[decode.scala 265:15]
  assign io_rs2_data = id_ex_rs2_data_reg; // @[decode.scala 266:15]
  assign io_imm = id_ex_imm_reg; // @[decode.scala 267:10]
  assign io_funct3 = {{29'd0}, id_ex_funct3_reg}; // @[decode.scala 268:13]
  assign io_ex_rs1 = id_ex_ex_rs1_reg; // @[decode.scala 269:13]
  assign io_ex_rs2 = id_ex_ex_rs2_reg; // @[decode.scala 270:13]
  assign io_ex_rd = id_ex_ex_rd_reg; // @[decode.scala 271:12]
  assign io_ex_use_rs1 = id_ex_ex_use_rs1_reg; // @[decode.scala 272:17]
  assign io_ex_use_rs2 = id_ex_ex_use_rs2_reg; // @[decode.scala 273:17]
  assign io_id_rs1 = io_inst[19:15]; // @[decode.scala 276:23]
  assign io_id_rs2 = io_inst[24:20]; // @[decode.scala 277:23]
  assign io_use_rs1 = control_io_use_rs1; // @[decode.scala 278:14]
  assign io_use_rs2 = control_io_use_rs2; // @[decode.scala 279:14]
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
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      csr_read_reg <= 1'h0; // @[decode.scala 204:18]
    end else if ((csrrwInst | csrrwiInst) & io_inst[11:7] == 5'h0) begin // @[decode.scala 111:66]
      csr_read_reg <= 1'h0; // @[decode.scala 112:12]
    end else begin
      csr_read_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 58:30]
      csr_write_reg <= 1'h0; // @[decode.scala 58:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      csr_write_reg <= 1'h0; // @[decode.scala 205:19]
    end else if ((csrrsInst | csrrcInst | csrrsiInst | csrrciInst) & io_inst[19:15] == 5'h0) begin // @[decode.scala 114:94]
      csr_write_reg <= 1'h0; // @[decode.scala 115:13]
    end else begin
      csr_write_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 59:32]
      csr_address_reg <= 12'h0; // @[decode.scala 59:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      csr_address_reg <= 12'h0; // @[decode.scala 206:21]
    end else begin
      csr_address_reg <= io_inst[31:20]; // @[decode.scala 214:21]
    end
    if (reset) begin // @[decode.scala 60:31]
      ecause_out_reg <= 4'h0; // @[decode.scala 60:31]
    end else begin
      ecause_out_reg <= {{2'd0}, _GEN_26};
    end
    if (reset) begin // @[decode.scala 61:34]
      exception_out_reg <= 1'h0; // @[decode.scala 61:34]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      exception_out_reg <= 1'h0; // @[decode.scala 208:23]
    end else if (isLegalInstruction) begin // @[decode.scala 178:26]
      exception_out_reg <= 1'h0;
    end else begin
      exception_out_reg <= 1'h1;
    end
    if (reset) begin // @[decode.scala 62:29]
      mret_out_reg <= 1'h0; // @[decode.scala 62:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      mret_out_reg <= 1'h0; // @[decode.scala 209:18]
    end else begin
      mret_out_reg <= mret_out; // @[decode.scala 217:18]
    end
    if (reset) begin // @[decode.scala 63:28]
      wfi_out_reg <= 1'h0; // @[decode.scala 63:28]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      wfi_out_reg <= 1'h0; // @[decode.scala 210:17]
    end else begin
      wfi_out_reg <= wfi_out; // @[decode.scala 218:17]
    end
    if (reset) begin // @[decode.scala 64:29]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 64:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 183:18]
    end else begin
      id_ex_pc_reg <= io_id_pc; // @[decode.scala 219:18]
    end
    if (reset) begin // @[decode.scala 65:32]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 65:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 184:21]
    end else begin
      id_ex_aluop_reg <= control_io_aluop; // @[decode.scala 220:21]
    end
    if (reset) begin // @[decode.scala 66:33]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 66:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 185:22]
    end else begin
      id_ex_immsrc_reg <= control_io_immsrc; // @[decode.scala 221:22]
    end
    if (reset) begin // @[decode.scala 67:35]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 67:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 186:24]
    end else begin
      id_ex_isbranch_reg <= control_io_isbranch; // @[decode.scala 222:24]
    end
    if (reset) begin // @[decode.scala 68:34]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 68:34]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 187:23]
    end else begin
      id_ex_memread_reg <= control_io_memread; // @[decode.scala 223:23]
    end
    if (reset) begin // @[decode.scala 69:35]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 69:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 188:24]
    end else begin
      id_ex_memwrite_reg <= control_io_memwrite; // @[decode.scala 224:24]
    end
    if (reset) begin // @[decode.scala 70:35]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 70:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 189:24]
    end else begin
      id_ex_regwrite_reg <= control_io_regwrite; // @[decode.scala 225:24]
    end
    if (reset) begin // @[decode.scala 71:35]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 71:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 190:24]
    end else begin
      id_ex_memtoreg_reg <= control_io_memtoreg; // @[decode.scala 226:24]
    end
    if (reset) begin // @[decode.scala 72:32]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 72:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 191:21]
    end else begin
      id_ex_pcsel_reg <= control_io_pcsel; // @[decode.scala 227:21]
    end
    if (reset) begin // @[decode.scala 73:32]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 73:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 192:21]
    end else begin
      id_ex_rdsel_reg <= control_io_rdsel; // @[decode.scala 228:21]
    end
    if (reset) begin // @[decode.scala 74:33]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 74:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 193:22]
    end else begin
      id_ex_isjump_reg <= control_io_isjump; // @[decode.scala 229:22]
    end
    if (reset) begin // @[decode.scala 75:32]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 75:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 194:21]
    end else begin
      id_ex_islui_reg <= control_io_islui; // @[decode.scala 230:21]
    end
    if (reset) begin // @[decode.scala 76:35]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 76:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 195:24]
    end else begin
      id_ex_rs1_data_reg <= regfile_io_rs1_data; // @[decode.scala 231:24]
    end
    if (reset) begin // @[decode.scala 77:35]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 77:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 196:24]
    end else begin
      id_ex_rs2_data_reg <= regfile_io_rs2_data; // @[decode.scala 232:24]
    end
    if (reset) begin // @[decode.scala 78:30]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 78:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 197:19]
    end else begin
      id_ex_imm_reg <= immGen_io_imm; // @[decode.scala 233:19]
    end
    if (reset) begin // @[decode.scala 79:33]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 79:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 198:22]
    end else begin
      id_ex_funct3_reg <= io_inst[14:12]; // @[decode.scala 234:22]
    end
    if (reset) begin // @[decode.scala 80:33]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 80:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 199:22]
    end else begin
      id_ex_ex_rs1_reg <= io_inst[19:15]; // @[decode.scala 235:22]
    end
    if (reset) begin // @[decode.scala 81:33]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 81:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 200:22]
    end else begin
      id_ex_ex_rs2_reg <= io_inst[24:20]; // @[decode.scala 236:22]
    end
    if (reset) begin // @[decode.scala 82:32]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 82:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 201:21]
    end else begin
      id_ex_ex_rd_reg <= io_inst[11:7]; // @[decode.scala 237:21]
    end
    if (reset) begin // @[decode.scala 83:37]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 83:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 202:26]
    end else begin
      id_ex_ex_use_rs1_reg <= control_io_use_rs1; // @[decode.scala 238:26]
    end
    if (reset) begin // @[decode.scala 84:37]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 84:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 182:25]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 203:26]
    end else begin
      id_ex_ex_use_rs2_reg <= control_io_use_rs2; // @[decode.scala 239:26]
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
  ecause_out_reg = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  exception_out_reg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mret_out_reg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  wfi_out_reg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  id_ex_pc_reg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  id_ex_aluop_reg = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  id_ex_immsrc_reg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  id_ex_isbranch_reg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  id_ex_memread_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  id_ex_memwrite_reg = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  id_ex_regwrite_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  id_ex_memtoreg_reg = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  id_ex_pcsel_reg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  id_ex_rdsel_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  id_ex_isjump_reg = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  id_ex_islui_reg = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  id_ex_rs1_data_reg = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  id_ex_rs2_data_reg = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  id_ex_imm_reg = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  id_ex_funct3_reg = _RAND_22[2:0];
  _RAND_23 = {1{`RANDOM}};
  id_ex_ex_rs1_reg = _RAND_23[4:0];
  _RAND_24 = {1{`RANDOM}};
  id_ex_ex_rs2_reg = _RAND_24[4:0];
  _RAND_25 = {1{`RANDOM}};
  id_ex_ex_rd_reg = _RAND_25[4:0];
  _RAND_26 = {1{`RANDOM}};
  id_ex_ex_use_rs1_reg = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  id_ex_ex_use_rs2_reg = _RAND_27[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
