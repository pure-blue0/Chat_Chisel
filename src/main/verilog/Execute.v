module Execute(
  input         clock,
  input         reset,
  input         io_csr_read,
  input         io_csr_write,
  input  [11:0] io_csr_address,
  input  [3:0]  io_ecause_in,
  input         io_exception_in,
  input         io_mert_in,
  input         io_wfi_in,
  input  [31:0] io_ex_pc,
  input  [3:0]  io_aluop,
  input         io_immsrc,
  input         io_isbranch,
  input         io_memread,
  input         io_memwrite,
  input         io_regwrite,
  input  [1:0]  io_memtoreg,
  input         io_pcsel,
  input         io_rdsel,
  input         io_isjump,
  input         io_islui,
  input  [31:0] io_rs1_data,
  input  [31:0] io_rs2_data,
  input  [31:0] io_imm,
  input  [31:0] io_funct3,
  input  [4:0]  io_ex_rs1,
  input  [4:0]  io_ex_rd,
  output [31:0] io_mem_pc,
  output [31:0] io_target_pc,
  input  [31:0] io_csr_read_data,
  input         io_readable,
  input         io_writeable,
  output [31:0] io_csr_read_data_out,
  output        io_csr_write_enable_out,
  output [11:0] io_csr_write_address_out,
  output [31:0] io_csr_write_data_out,
  output [3:0]  io_ecause_out,
  output        io_exception_out,
  output        io_mert_out,
  output        io_wfi_out,
  output [31:0] io_reg_pc,
  output        io_mem_isbranch,
  output        io_mem_isjump,
  output        io_mem_memread,
  output        io_mem_memwrite,
  output        io_mem_regwrite,
  output [1:0]  io_mem_memtoreg,
  output        io_mem_zero,
  output [31:0] io_mem_aluresult,
  output [31:0] io_mem_rs2_data,
  output [2:0]  io_mem_funct3,
  output [4:0]  io_mem_rd,
  input  [31:0] io_writedata,
  input  [1:0]  io_forward1,
  input  [1:0]  io_forward2,
  input         io_ex_mem_flush
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
`endif // RANDOMIZE_REG_INIT
  wire [31:0] aluSelect_io_rs1_data; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_rs2_data; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_imm; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_mem_aluresult; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_writedata; // @[excute.scala 69:25]
  wire  aluSelect_io_immsrc; // @[excute.scala 69:25]
  wire  aluSelect_io_islui; // @[excute.scala 69:25]
  wire [1:0] aluSelect_io_forward1; // @[excute.scala 69:25]
  wire [1:0] aluSelect_io_forward2; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_alu_in1; // @[excute.scala 69:25]
  wire [31:0] aluSelect_io_alu_in2; // @[excute.scala 69:25]
  wire [31:0] alu_io_alu_in1; // @[excute.scala 70:19]
  wire [31:0] alu_io_alu_in2; // @[excute.scala 70:19]
  wire [3:0] alu_io_aluop; // @[excute.scala 70:19]
  wire  alu_io_zero; // @[excute.scala 70:19]
  wire [31:0] alu_io_alu_result; // @[excute.scala 70:19]
  wire [31:0] targetGen_io_ex_pc; // @[excute.scala 71:25]
  wire [31:0] targetGen_io_imm; // @[excute.scala 71:25]
  wire [31:0] targetGen_io_alu_result; // @[excute.scala 71:25]
  wire  targetGen_io_pcsel; // @[excute.scala 71:25]
  wire  targetGen_io_rdsel; // @[excute.scala 71:25]
  wire [31:0] targetGen_io_reg_pc; // @[excute.scala 71:25]
  wire [31:0] targetGen_io_target_pc; // @[excute.scala 71:25]
  reg  mert_out_reg; // @[excute.scala 74:29]
  reg  wfi_out_reg; // @[excute.scala 75:28]
  reg [3:0] ecause_out_reg; // @[excute.scala 76:31]
  reg  exception_out_reg; // @[excute.scala 77:34]
  reg [31:0] csr_read_data_out_reg; // @[excute.scala 78:38]
  reg  csr_write_enable_out_reg; // @[excute.scala 79:41]
  reg [11:0] csr_write_address_out_reg; // @[excute.scala 80:42]
  reg [31:0] csr_write_data_out_reg; // @[excute.scala 81:39]
  reg [31:0] reg_pc_reg; // @[excute.scala 82:27]
  reg [31:0] target_pc_reg; // @[excute.scala 83:30]
  reg [31:0] mem_pc_reg; // @[excute.scala 84:27]
  reg  mem_isbranch_reg; // @[excute.scala 85:33]
  reg  mem_isjump_reg; // @[excute.scala 86:31]
  reg  mem_memread_reg; // @[excute.scala 87:32]
  reg  mem_memwrite_reg; // @[excute.scala 88:33]
  reg  mem_regwrite_reg; // @[excute.scala 89:33]
  reg [1:0] mem_memtoreg_reg; // @[excute.scala 90:33]
  reg  mem_zero_reg; // @[excute.scala 91:29]
  reg [31:0] mem_aluresult_reg; // @[excute.scala 92:34]
  reg [31:0] mem_rs2_data_reg; // @[excute.scala 93:33]
  reg [2:0] mem_funct3_reg; // @[excute.scala 94:31]
  reg [4:0] mem_rd_reg; // @[excute.scala 95:27]
  wire  _aluSelect_io_mem_aluresult_T = mem_memtoreg_reg == 2'h0; // @[excute.scala 104:21]
  wire  _aluSelect_io_mem_aluresult_T_1 = mem_memtoreg_reg == 2'h3; // @[excute.scala 105:21]
  wire [31:0] _aluSelect_io_mem_aluresult_T_2 = _aluSelect_io_mem_aluresult_T_1 ? csr_read_data_out_reg :
    mem_aluresult_reg; // @[Mux.scala 101:16]
  wire [31:0] _csr_write_temp_T = {27'h0,io_ex_rs1}; // @[Cat.scala 31:58]
  wire [31:0] csr_write_temp = io_immsrc ? _csr_write_temp_T : io_rs1_data; // @[excute.scala 124:27]
  wire [31:0] _csr_write_out_T = io_csr_read_data | csr_write_temp; // @[excute.scala 128:35]
  wire [31:0] _csr_write_out_T_2 = ~csr_write_temp; // @[excute.scala 130:37]
  wire [31:0] _csr_write_out_T_3 = io_csr_read_data & _csr_write_out_T_2; // @[excute.scala 130:35]
  wire [31:0] _csr_write_out_T_11 = 32'h2 == io_funct3 ? _csr_write_out_T : csr_write_temp; // @[Mux.scala 81:58]
  wire [31:0] _csr_write_out_T_13 = 32'h6 == io_funct3 ? _csr_write_out_T : _csr_write_out_T_11; // @[Mux.scala 81:58]
  wire  csr_exception = io_csr_read != io_readable | io_csr_write != io_writeable; // @[excute.scala 135:53]
  wire  _ecause_out_reg_T_1 = ~io_exception_in & csr_exception; // @[excute.scala 164:48]
  wire [31:0] _GEN_20 = io_ex_mem_flush ? 32'h0 : io_funct3; // @[excute.scala 138:25 159:24 182:24]
  wire [31:0] _GEN_22 = reset ? 32'h0 : _GEN_20; // @[excute.scala 94:{31,31}]
  AluSelect aluSelect ( // @[excute.scala 69:25]
    .io_rs1_data(aluSelect_io_rs1_data),
    .io_rs2_data(aluSelect_io_rs2_data),
    .io_imm(aluSelect_io_imm),
    .io_mem_aluresult(aluSelect_io_mem_aluresult),
    .io_writedata(aluSelect_io_writedata),
    .io_immsrc(aluSelect_io_immsrc),
    .io_islui(aluSelect_io_islui),
    .io_forward1(aluSelect_io_forward1),
    .io_forward2(aluSelect_io_forward2),
    .io_alu_in1(aluSelect_io_alu_in1),
    .io_alu_in2(aluSelect_io_alu_in2)
  );
  ALU alu ( // @[excute.scala 70:19]
    .io_alu_in1(alu_io_alu_in1),
    .io_alu_in2(alu_io_alu_in2),
    .io_aluop(alu_io_aluop),
    .io_zero(alu_io_zero),
    .io_alu_result(alu_io_alu_result)
  );
  TargetGen targetGen ( // @[excute.scala 71:25]
    .io_ex_pc(targetGen_io_ex_pc),
    .io_imm(targetGen_io_imm),
    .io_alu_result(targetGen_io_alu_result),
    .io_pcsel(targetGen_io_pcsel),
    .io_rdsel(targetGen_io_rdsel),
    .io_reg_pc(targetGen_io_reg_pc),
    .io_target_pc(targetGen_io_target_pc)
  );
  assign io_mem_pc = mem_pc_reg; // @[excute.scala 197:19]
  assign io_target_pc = target_pc_reg; // @[excute.scala 196:22]
  assign io_csr_read_data_out = csr_read_data_out_reg; // @[excute.scala 191:30]
  assign io_csr_write_enable_out = csr_write_enable_out_reg; // @[excute.scala 192:33]
  assign io_csr_write_address_out = csr_write_address_out_reg; // @[excute.scala 193:34]
  assign io_csr_write_data_out = csr_write_data_out_reg; // @[excute.scala 194:31]
  assign io_ecause_out = ecause_out_reg; // @[excute.scala 189:23]
  assign io_exception_out = exception_out_reg; // @[excute.scala 190:26]
  assign io_mert_out = mert_out_reg; // @[excute.scala 187:21]
  assign io_wfi_out = wfi_out_reg; // @[excute.scala 188:20]
  assign io_reg_pc = reg_pc_reg; // @[excute.scala 195:19]
  assign io_mem_isbranch = mem_isbranch_reg; // @[excute.scala 198:25]
  assign io_mem_isjump = mem_isjump_reg; // @[excute.scala 199:23]
  assign io_mem_memread = mem_memread_reg; // @[excute.scala 200:24]
  assign io_mem_memwrite = mem_memwrite_reg; // @[excute.scala 201:25]
  assign io_mem_regwrite = mem_regwrite_reg; // @[excute.scala 202:25]
  assign io_mem_memtoreg = mem_memtoreg_reg; // @[excute.scala 203:25]
  assign io_mem_zero = mem_zero_reg; // @[excute.scala 204:21]
  assign io_mem_aluresult = mem_aluresult_reg; // @[excute.scala 205:26]
  assign io_mem_rs2_data = mem_rs2_data_reg; // @[excute.scala 206:25]
  assign io_mem_funct3 = mem_funct3_reg; // @[excute.scala 207:23]
  assign io_mem_rd = mem_rd_reg; // @[excute.scala 208:19]
  assign aluSelect_io_rs1_data = io_rs1_data; // @[excute.scala 100:25]
  assign aluSelect_io_rs2_data = io_rs2_data; // @[excute.scala 101:25]
  assign aluSelect_io_imm = io_imm; // @[excute.scala 102:20]
  assign aluSelect_io_mem_aluresult = _aluSelect_io_mem_aluresult_T ? reg_pc_reg : _aluSelect_io_mem_aluresult_T_2; // @[Mux.scala 101:16]
  assign aluSelect_io_writedata = io_writedata; // @[excute.scala 107:26]
  assign aluSelect_io_immsrc = io_immsrc; // @[excute.scala 108:23]
  assign aluSelect_io_islui = io_islui; // @[excute.scala 109:22]
  assign aluSelect_io_forward1 = io_forward1; // @[excute.scala 110:25]
  assign aluSelect_io_forward2 = io_forward2; // @[excute.scala 111:25]
  assign alu_io_alu_in1 = aluSelect_io_alu_in1; // @[excute.scala 112:18]
  assign alu_io_alu_in2 = aluSelect_io_alu_in2; // @[excute.scala 113:18]
  assign alu_io_aluop = io_aluop; // @[excute.scala 114:16]
  assign targetGen_io_ex_pc = io_ex_pc; // @[excute.scala 115:22]
  assign targetGen_io_imm = io_imm; // @[excute.scala 116:20]
  assign targetGen_io_alu_result = alu_io_alu_result; // @[excute.scala 117:27]
  assign targetGen_io_pcsel = io_pcsel; // @[excute.scala 118:22]
  assign targetGen_io_rdsel = io_rdsel; // @[excute.scala 119:22]
  always @(posedge clock) begin
    if (reset) begin // @[excute.scala 74:29]
      mert_out_reg <= 1'h0; // @[excute.scala 74:29]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mert_out_reg <= 1'h0; // @[excute.scala 139:18]
    end else begin
      mert_out_reg <= io_mert_in; // @[excute.scala 162:22]
    end
    if (reset) begin // @[excute.scala 75:28]
      wfi_out_reg <= 1'h0; // @[excute.scala 75:28]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      wfi_out_reg <= 1'h0; // @[excute.scala 140:17]
    end else begin
      wfi_out_reg <= io_wfi_in; // @[excute.scala 163:21]
    end
    if (reset) begin // @[excute.scala 76:31]
      ecause_out_reg <= 4'h0; // @[excute.scala 76:31]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      ecause_out_reg <= 4'h0; // @[excute.scala 141:24]
    end else if (~io_exception_in & csr_exception) begin // @[excute.scala 164:30]
      ecause_out_reg <= 4'h2;
    end else begin
      ecause_out_reg <= io_ecause_in;
    end
    if (reset) begin // @[excute.scala 77:34]
      exception_out_reg <= 1'h0; // @[excute.scala 77:34]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      exception_out_reg <= 1'h0; // @[excute.scala 142:27]
    end else begin
      exception_out_reg <= _ecause_out_reg_T_1 | io_exception_in; // @[excute.scala 165:27]
    end
    if (reset) begin // @[excute.scala 78:38]
      csr_read_data_out_reg <= 32'h0; // @[excute.scala 78:38]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      csr_read_data_out_reg <= 32'h0; // @[excute.scala 143:31]
    end else begin
      csr_read_data_out_reg <= io_csr_read_data; // @[excute.scala 166:31]
    end
    if (reset) begin // @[excute.scala 79:41]
      csr_write_enable_out_reg <= 1'h0; // @[excute.scala 79:41]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      csr_write_enable_out_reg <= 1'h0; // @[excute.scala 144:34]
    end else begin
      csr_write_enable_out_reg <= io_csr_write; // @[excute.scala 167:34]
    end
    if (reset) begin // @[excute.scala 80:42]
      csr_write_address_out_reg <= 12'h0; // @[excute.scala 80:42]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      csr_write_address_out_reg <= 12'h0; // @[excute.scala 145:35]
    end else begin
      csr_write_address_out_reg <= io_csr_address; // @[excute.scala 168:35]
    end
    if (reset) begin // @[excute.scala 81:39]
      csr_write_data_out_reg <= 32'h0; // @[excute.scala 81:39]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      csr_write_data_out_reg <= 32'h0; // @[excute.scala 146:32]
    end else if (32'h7 == io_funct3) begin // @[Mux.scala 81:58]
      csr_write_data_out_reg <= _csr_write_out_T_3;
    end else if (32'h3 == io_funct3) begin // @[Mux.scala 81:58]
      csr_write_data_out_reg <= _csr_write_out_T_3;
    end else begin
      csr_write_data_out_reg <= _csr_write_out_T_13;
    end
    if (reset) begin // @[excute.scala 82:27]
      reg_pc_reg <= 32'h0; // @[excute.scala 82:27]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      reg_pc_reg <= 32'h0; // @[excute.scala 147:20]
    end else begin
      reg_pc_reg <= targetGen_io_reg_pc; // @[excute.scala 170:20]
    end
    if (reset) begin // @[excute.scala 83:30]
      target_pc_reg <= 32'h0; // @[excute.scala 83:30]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      target_pc_reg <= 32'h0; // @[excute.scala 148:23]
    end else begin
      target_pc_reg <= targetGen_io_target_pc; // @[excute.scala 171:23]
    end
    if (reset) begin // @[excute.scala 84:27]
      mem_pc_reg <= 32'h0; // @[excute.scala 84:27]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_pc_reg <= 32'h0; // @[excute.scala 149:20]
    end else begin
      mem_pc_reg <= io_ex_pc; // @[excute.scala 172:20]
    end
    if (reset) begin // @[excute.scala 85:33]
      mem_isbranch_reg <= 1'h0; // @[excute.scala 85:33]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_isbranch_reg <= 1'h0; // @[excute.scala 150:26]
    end else begin
      mem_isbranch_reg <= io_isbranch; // @[excute.scala 173:26]
    end
    if (reset) begin // @[excute.scala 86:31]
      mem_isjump_reg <= 1'h0; // @[excute.scala 86:31]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_isjump_reg <= 1'h0; // @[excute.scala 151:24]
    end else begin
      mem_isjump_reg <= io_isjump; // @[excute.scala 174:24]
    end
    if (reset) begin // @[excute.scala 87:32]
      mem_memread_reg <= 1'h0; // @[excute.scala 87:32]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_memread_reg <= 1'h0; // @[excute.scala 152:25]
    end else begin
      mem_memread_reg <= io_memread; // @[excute.scala 175:25]
    end
    if (reset) begin // @[excute.scala 88:33]
      mem_memwrite_reg <= 1'h0; // @[excute.scala 88:33]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_memwrite_reg <= 1'h0; // @[excute.scala 153:26]
    end else begin
      mem_memwrite_reg <= io_memwrite; // @[excute.scala 176:26]
    end
    if (reset) begin // @[excute.scala 89:33]
      mem_regwrite_reg <= 1'h0; // @[excute.scala 89:33]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_regwrite_reg <= 1'h0; // @[excute.scala 154:26]
    end else begin
      mem_regwrite_reg <= io_regwrite; // @[excute.scala 177:26]
    end
    if (reset) begin // @[excute.scala 90:33]
      mem_memtoreg_reg <= 2'h0; // @[excute.scala 90:33]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_memtoreg_reg <= 2'h0; // @[excute.scala 155:26]
    end else begin
      mem_memtoreg_reg <= io_memtoreg; // @[excute.scala 178:26]
    end
    if (reset) begin // @[excute.scala 91:29]
      mem_zero_reg <= 1'h0; // @[excute.scala 91:29]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_zero_reg <= 1'h0; // @[excute.scala 156:22]
    end else begin
      mem_zero_reg <= alu_io_zero; // @[excute.scala 179:22]
    end
    if (reset) begin // @[excute.scala 92:34]
      mem_aluresult_reg <= 32'h0; // @[excute.scala 92:34]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_aluresult_reg <= 32'h0; // @[excute.scala 157:27]
    end else begin
      mem_aluresult_reg <= alu_io_alu_result; // @[excute.scala 180:27]
    end
    if (reset) begin // @[excute.scala 93:33]
      mem_rs2_data_reg <= 32'h0; // @[excute.scala 93:33]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_rs2_data_reg <= 32'h0; // @[excute.scala 158:26]
    end else begin
      mem_rs2_data_reg <= io_rs2_data; // @[excute.scala 181:26]
    end
    mem_funct3_reg <= _GEN_22[2:0]; // @[excute.scala 94:{31,31}]
    if (reset) begin // @[excute.scala 95:27]
      mem_rd_reg <= 5'h0; // @[excute.scala 95:27]
    end else if (io_ex_mem_flush) begin // @[excute.scala 138:25]
      mem_rd_reg <= 5'h0; // @[excute.scala 160:20]
    end else begin
      mem_rd_reg <= io_ex_rd; // @[excute.scala 183:20]
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
  mert_out_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wfi_out_reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  ecause_out_reg = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  exception_out_reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  csr_read_data_out_reg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  csr_write_enable_out_reg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  csr_write_address_out_reg = _RAND_6[11:0];
  _RAND_7 = {1{`RANDOM}};
  csr_write_data_out_reg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_pc_reg = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  target_pc_reg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  mem_pc_reg = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  mem_isbranch_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mem_isjump_reg = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mem_memread_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mem_memwrite_reg = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  mem_regwrite_reg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  mem_memtoreg_reg = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  mem_zero_reg = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mem_aluresult_reg = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mem_rs2_data_reg = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mem_funct3_reg = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  mem_rd_reg = _RAND_21[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule