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
  output        io_mert_out,
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
  reg  mert_out_reg; // @[decode.scala 62:29]
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
  wire  mert_out = io_inst == 32'h30200073; // @[decode.scala 118:26]
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
  assign io_mert_out = mert_out_reg; // @[decode.scala 192:15]
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
      mert_out_reg <= 1'h0; // @[decode.scala 62:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 123:25]
      mert_out_reg <= 1'h0; // @[decode.scala 150:18]
    end else begin
      mert_out_reg <= mert_out; // @[decode.scala 158:18]
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
  mert_out_reg = _RAND_3[0:0];
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