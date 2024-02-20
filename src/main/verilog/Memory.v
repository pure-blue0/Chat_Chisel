`include  "Branch.v"
module Memory(
  input         clock,
  input         reset,
  input  [31:0] io_csr_read_data_in,
  input         io_csr_write_enable_in,
  input  [11:0] io_csr_write_address_in,
  input  [31:0] io_csr_write_data_in,
  input  [3:0]  io_ecause_in,
  input         io_exception_in,
  input         io_mret_in,
  input         io_wfi_in,
  input  [31:0] io_reg_pc,
  input         io_mem_isbranch,
  input         io_mem_isjump,
  input         io_mem_memread,
  input         io_mem_memwrite,
  input         io_mem_regwrite,
  input  [1:0]  io_mem_memtoreg,
  input         io_mem_zero,
  input  [31:0] io_mem_aluresult,
  input  [31:0] io_mem_rs2_data,
  input  [2:0]  io_mem_funct3,
  input  [4:0]  io_mem_rd,
  input         io_sip,
  input         io_tip,
  input         io_eip,
  output        io_csr_write_enable_out,
  output [11:0] io_csr_write_address_out,
  output [31:0] io_csr_write_data_out,
  output [3:0]  io_ecause_out,
  output        io_trapped,
  output        io_interrupt,
  output        io_inst_retired,
  output        io_mret_out,
  output [31:0] io_csr_read_data_out,
  output        io_wfi_out,
  output [31:0] io_wb_reg_pc,
  output [31:0] io_wb_readdata,
  output [31:0] io_wb_aluresult,
  output [1:0]  io_wb_memtoreg,
  output        io_wb_regwrite,
  output [4:0]  io_wb_rd,
  output        io_pcsrc,
  output        io_branch,
  input         io_mem_wb_flush,
  input  [31:0] io_memory_read_data,
  output        io_load_store_unsigned,
  output [1:0]  io_memory_size,
  output [31:0] io_memory_address,
  output [31:0] io_memory_write_data,
  output        io_memory_read,
  output        io_memory_write
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
`endif // RANDOMIZE_REG_INIT
  wire  branch_io_mem_zero; // @[memory.scala 102:22]
  wire [31:0] branch_io_mem_aluresult; // @[memory.scala 102:22]
  wire [2:0] branch_io_mem_funct3; // @[memory.scala 102:22]
  wire  branch_io_mem_isbranch; // @[memory.scala 102:22]
  wire  branch_io_mem_isjump; // @[memory.scala 102:22]
  wire  branch_io_branch; // @[memory.scala 102:22]
  wire  branch_io_pcsrc; // @[memory.scala 102:22]
  wire  load_exception = io_mem_memread & io_mem_rd != 5'h0; // @[memory.scala 66:39]
  wire  mem_misaligned_exception = (io_mem_memread | io_mem_memwrite) & io_mem_aluresult[1:0] != 2'h0; // @[memory.scala 67:70]
  wire  _T = ~io_exception_in; // @[memory.scala 83:14]
  wire [2:0] _ecause_out_T = io_mem_memread ? 3'h4 : 3'h6; // @[memory.scala 89:22]
  wire  _GEN_0 = _T & mem_misaligned_exception | io_exception_in; // @[memory.scala 87:60 88:15 92:15]
  wire [3:0] _GEN_1 = _T & mem_misaligned_exception ? {{1'd0}, _ecause_out_T} : io_ecause_in; // @[memory.scala 87:60 89:16 93:16]
  wire  _GEN_3 = ~io_exception_in & load_exception | _GEN_0; // @[memory.scala 83:50 84:15]
  wire [3:0] _GEN_4 = ~io_exception_in & load_exception ? 4'h5 : _GEN_1; // @[memory.scala 83:50 85:16]
  wire [3:0] _GEN_6 = io_sip ? 4'h3 : _GEN_4; // @[memory.scala 80:22 81:16]
  wire  _GEN_8 = io_sip ? 1'h0 : _GEN_3; // @[memory.scala 80:22]
  wire  _GEN_10 = io_tip | io_sip; // @[memory.scala 77:22 79:15]
  wire  _GEN_11 = io_tip ? 1'h0 : _GEN_8; // @[memory.scala 77:22]
  wire  interrupt = io_eip | _GEN_10; // @[memory.scala 74:16 76:15]
  wire  exception = io_eip ? 1'h0 : _GEN_11; // @[memory.scala 74:16]
  wire  trapped = io_sip | io_tip | io_eip | exception; // @[memory.scala 97:42]
  wire  retired = ~trapped & ~io_wfi_in; // @[memory.scala 98:23]
  reg  csr_write_enable_out_reg; // @[memory.scala 118:41]
  reg [11:0] csr_write_address_out_reg; // @[memory.scala 119:42]
  reg [31:0] csr_write_data_out_reg; // @[memory.scala 120:39]
  reg [3:0] ecause_out_reg; // @[memory.scala 121:31]
  reg  trapped_reg; // @[memory.scala 122:28]
  reg  interrupt_reg; // @[memory.scala 123:30]
  reg  inst_retired_reg; // @[memory.scala 124:33]
  reg [31:0] csr_read_data_out_reg; // @[memory.scala 125:38]
  reg  mret_out_reg; // @[memory.scala 126:29]
  reg  wfi_out_reg; // @[memory.scala 127:28]
  reg [31:0] wb_reg_pc_reg; // @[memory.scala 128:30]
  reg [31:0] wb_readdata_reg; // @[memory.scala 129:32]
  reg [31:0] wb_aluresult_reg; // @[memory.scala 130:33]
  reg [1:0] wb_memtoreg_reg; // @[memory.scala 131:32]
  reg  wb_regwrite_reg; // @[memory.scala 132:32]
  reg [4:0] wb_rd_reg; // @[memory.scala 133:26]
  reg  pcsrc_reg; // @[memory.scala 134:26]
  reg  branch_reg; // @[memory.scala 135:27]
  wire  _T_4 = ~io_mem_wb_flush; // @[memory.scala 139:8]
  wire  _GEN_15 = ~io_mem_wb_flush & io_csr_write_enable_in; // @[memory.scala 139:26 140:30 149:30]
  wire  _GEN_19 = ~io_mem_wb_flush & trapped; // @[memory.scala 139:26 144:17 153:17]
  wire  _GEN_20 = ~io_mem_wb_flush & interrupt; // @[memory.scala 139:26 145:19 154:19]
  wire  _GEN_21 = ~io_mem_wb_flush & retired; // @[memory.scala 139:26 146:22 155:22]
  wire  _GEN_22 = ~io_mem_wb_flush & io_mret_in; // @[memory.scala 139:26 147:18 156:18]
  wire  _GEN_24 = _T_4 & io_wfi_in; // @[memory.scala 160:26 162:17 171:17]
  wire  _GEN_29 = _T_4 & io_mem_regwrite; // @[memory.scala 160:26 167:21 176:21]
  wire  _GEN_31 = _T_4 & branch_io_pcsrc; // @[memory.scala 181:26 182:15 185:15]
  wire  _GEN_32 = _T_4 & branch_io_branch; // @[memory.scala 181:26 183:16 186:16]
  Branch branch ( // @[memory.scala 102:22]
    .io_mem_zero(branch_io_mem_zero),
    .io_mem_aluresult(branch_io_mem_aluresult),
    .io_mem_funct3(branch_io_mem_funct3),
    .io_mem_isbranch(branch_io_mem_isbranch),
    .io_mem_isjump(branch_io_mem_isjump),
    .io_branch(branch_io_branch),
    .io_pcsrc(branch_io_pcsrc)
  );
  assign io_csr_write_enable_out = csr_write_enable_out_reg; // @[memory.scala 190:27]
  assign io_csr_write_address_out = csr_write_address_out_reg; // @[memory.scala 191:28]
  assign io_csr_write_data_out = csr_write_data_out_reg; // @[memory.scala 192:25]
  assign io_ecause_out = ecause_out_reg; // @[memory.scala 193:17]
  assign io_trapped = trapped_reg; // @[memory.scala 194:14]
  assign io_interrupt = interrupt_reg; // @[memory.scala 195:16]
  assign io_inst_retired = inst_retired_reg; // @[memory.scala 196:19]
  assign io_mret_out = mret_out_reg; // @[memory.scala 198:15]
  assign io_csr_read_data_out = csr_read_data_out_reg; // @[memory.scala 197:24]
  assign io_wfi_out = wfi_out_reg; // @[memory.scala 199:14]
  assign io_wb_reg_pc = wb_reg_pc_reg; // @[memory.scala 200:16]
  assign io_wb_readdata = wb_readdata_reg; // @[memory.scala 201:18]
  assign io_wb_aluresult = wb_aluresult_reg; // @[memory.scala 202:19]
  assign io_wb_memtoreg = wb_memtoreg_reg; // @[memory.scala 203:18]
  assign io_wb_regwrite = wb_regwrite_reg; // @[memory.scala 204:18]
  assign io_wb_rd = wb_rd_reg; // @[memory.scala 205:12]
  assign io_pcsrc = pcsrc_reg; // @[memory.scala 206:12]
  assign io_branch = branch_reg; // @[memory.scala 207:13]
  assign io_load_store_unsigned = io_mem_funct3[2]; // @[memory.scala 113:42]
  assign io_memory_size = io_mem_funct3[1:0]; // @[memory.scala 114:34]
  assign io_memory_address = io_mem_aluresult; // @[memory.scala 110:21]
  assign io_memory_write_data = io_mem_rs2_data; // @[memory.scala 111:24]
  assign io_memory_read = io_mem_memread; // @[memory.scala 112:18]
  assign io_memory_write = io_mem_memwrite & trapped; // @[memory.scala 115:38]
  assign branch_io_mem_zero = io_mem_zero; // @[memory.scala 103:22]
  assign branch_io_mem_aluresult = io_mem_aluresult; // @[memory.scala 104:27]
  assign branch_io_mem_funct3 = io_mem_funct3; // @[memory.scala 105:24]
  assign branch_io_mem_isbranch = io_mem_isbranch; // @[memory.scala 106:26]
  assign branch_io_mem_isjump = io_mem_isjump; // @[memory.scala 107:24]
  always @(posedge clock) begin
    if (reset) begin // @[memory.scala 118:41]
      csr_write_enable_out_reg <= 1'h0; // @[memory.scala 118:41]
    end else begin
      csr_write_enable_out_reg <= _GEN_15;
    end
    if (reset) begin // @[memory.scala 119:42]
      csr_write_address_out_reg <= 12'h0; // @[memory.scala 119:42]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 139:26]
      csr_write_address_out_reg <= io_csr_write_address_in; // @[memory.scala 141:31]
    end else begin
      csr_write_address_out_reg <= 12'h0; // @[memory.scala 150:31]
    end
    if (reset) begin // @[memory.scala 120:39]
      csr_write_data_out_reg <= 32'h0; // @[memory.scala 120:39]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 139:26]
      csr_write_data_out_reg <= io_csr_write_data_in; // @[memory.scala 142:28]
    end else begin
      csr_write_data_out_reg <= 32'h0; // @[memory.scala 151:28]
    end
    if (reset) begin // @[memory.scala 121:31]
      ecause_out_reg <= 4'h0; // @[memory.scala 121:31]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 139:26]
      if (io_eip) begin // @[memory.scala 74:16]
        ecause_out_reg <= 4'hb; // @[memory.scala 75:16]
      end else if (io_tip) begin // @[memory.scala 77:22]
        ecause_out_reg <= 4'h7; // @[memory.scala 78:16]
      end else begin
        ecause_out_reg <= _GEN_6;
      end
    end else begin
      ecause_out_reg <= 4'h0; // @[memory.scala 152:20]
    end
    if (reset) begin // @[memory.scala 122:28]
      trapped_reg <= 1'h0; // @[memory.scala 122:28]
    end else begin
      trapped_reg <= _GEN_19;
    end
    if (reset) begin // @[memory.scala 123:30]
      interrupt_reg <= 1'h0; // @[memory.scala 123:30]
    end else begin
      interrupt_reg <= _GEN_20;
    end
    if (reset) begin // @[memory.scala 124:33]
      inst_retired_reg <= 1'h0; // @[memory.scala 124:33]
    end else begin
      inst_retired_reg <= _GEN_21;
    end
    if (reset) begin // @[memory.scala 125:38]
      csr_read_data_out_reg <= 32'h0; // @[memory.scala 125:38]
    end else if (_T_4) begin // @[memory.scala 160:26]
      csr_read_data_out_reg <= io_csr_read_data_in; // @[memory.scala 161:27]
    end else begin
      csr_read_data_out_reg <= 32'h0; // @[memory.scala 170:27]
    end
    if (reset) begin // @[memory.scala 126:29]
      mret_out_reg <= 1'h0; // @[memory.scala 126:29]
    end else begin
      mret_out_reg <= _GEN_22;
    end
    if (reset) begin // @[memory.scala 127:28]
      wfi_out_reg <= 1'h0; // @[memory.scala 127:28]
    end else begin
      wfi_out_reg <= _GEN_24;
    end
    if (reset) begin // @[memory.scala 128:30]
      wb_reg_pc_reg <= 32'h0; // @[memory.scala 128:30]
    end else if (_T_4) begin // @[memory.scala 160:26]
      wb_reg_pc_reg <= io_reg_pc; // @[memory.scala 163:19]
    end else begin
      wb_reg_pc_reg <= 32'h0; // @[memory.scala 172:19]
    end
    if (reset) begin // @[memory.scala 129:32]
      wb_readdata_reg <= 32'h0; // @[memory.scala 129:32]
    end else if (_T_4) begin // @[memory.scala 160:26]
      wb_readdata_reg <= io_memory_read_data; // @[memory.scala 164:21]
    end else begin
      wb_readdata_reg <= 32'h0; // @[memory.scala 173:21]
    end
    if (reset) begin // @[memory.scala 130:33]
      wb_aluresult_reg <= 32'h0; // @[memory.scala 130:33]
    end else if (_T_4) begin // @[memory.scala 160:26]
      wb_aluresult_reg <= io_mem_aluresult; // @[memory.scala 165:22]
    end else begin
      wb_aluresult_reg <= 32'h0; // @[memory.scala 174:22]
    end
    if (reset) begin // @[memory.scala 131:32]
      wb_memtoreg_reg <= 2'h0; // @[memory.scala 131:32]
    end else if (_T_4) begin // @[memory.scala 160:26]
      wb_memtoreg_reg <= io_mem_memtoreg; // @[memory.scala 166:21]
    end else begin
      wb_memtoreg_reg <= 2'h0; // @[memory.scala 175:21]
    end
    if (reset) begin // @[memory.scala 132:32]
      wb_regwrite_reg <= 1'h0; // @[memory.scala 132:32]
    end else begin
      wb_regwrite_reg <= _GEN_29;
    end
    if (reset) begin // @[memory.scala 133:26]
      wb_rd_reg <= 5'h0; // @[memory.scala 133:26]
    end else if (_T_4) begin // @[memory.scala 160:26]
      wb_rd_reg <= io_mem_rd; // @[memory.scala 168:15]
    end else begin
      wb_rd_reg <= 5'h0; // @[memory.scala 177:15]
    end
    if (reset) begin // @[memory.scala 134:26]
      pcsrc_reg <= 1'h0; // @[memory.scala 134:26]
    end else begin
      pcsrc_reg <= _GEN_31;
    end
    if (reset) begin // @[memory.scala 135:27]
      branch_reg <= 1'h0; // @[memory.scala 135:27]
    end else begin
      branch_reg <= _GEN_32;
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
  csr_write_enable_out_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  csr_write_address_out_reg = _RAND_1[11:0];
  _RAND_2 = {1{`RANDOM}};
  csr_write_data_out_reg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ecause_out_reg = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  trapped_reg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  interrupt_reg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  inst_retired_reg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  csr_read_data_out_reg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  mret_out_reg = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  wfi_out_reg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  wb_reg_pc_reg = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  wb_readdata_reg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  wb_aluresult_reg = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  wb_memtoreg_reg = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  wb_regwrite_reg = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  wb_rd_reg = _RAND_15[4:0];
  _RAND_16 = {1{`RANDOM}};
  pcsrc_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  branch_reg = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
