module Branch(
  input         io_mem_zero,
  input  [31:0] io_mem_aluresult,
  input  [2:0]  io_mem_funct3,
  input         io_mem_isbranch,
  input         io_mem_isjump,
  output        io_branch,
  output        io_pcsrc
);
  wire  branchEq = io_mem_funct3 == 3'h0 & io_mem_zero; // @[branch.scala 18:41]
  wire  branchNe = io_mem_funct3 == 3'h1 & ~io_mem_zero; // @[branch.scala 19:41]
  wire  branchLt = io_mem_funct3 == 3'h4 & io_mem_aluresult[0]; // @[branch.scala 20:41]
  wire  _branchGe_T_2 = ~io_mem_aluresult[0]; // @[branch.scala 21:44]
  wire  branchGe = io_mem_funct3 == 3'h5 & ~io_mem_aluresult[0]; // @[branch.scala 21:41]
  wire  branchLtu = io_mem_funct3 == 3'h6 & io_mem_aluresult[0]; // @[branch.scala 22:41]
  wire  branchGeu = io_mem_funct3 == 3'h7 & _branchGe_T_2; // @[branch.scala 23:41]
  assign io_branch = io_mem_isbranch; // @[branch.scala 25:13]
  assign io_pcsrc = io_mem_isjump | (branchEq | branchNe | branchLt | branchGe | branchLtu | branchGeu) &
    io_mem_isbranch; // @[branch.scala 26:22]
endmodule
module DataCache(
  input         clock,
  input  [31:0] io_mem_aluresult,
  input  [31:0] io_mem_rs2_data,
  input         io_mem_memread,
  input  [2:0]  io_mem_funct3,
  input         io_mem_memwrite,
  output [31:0] io_read_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] mem [0:1048575]; // @[datacache.scala 13:16]
  wire  mem_cacheData_en; // @[datacache.scala 13:16]
  wire [19:0] mem_cacheData_addr; // @[datacache.scala 13:16]
  wire [31:0] mem_cacheData_data; // @[datacache.scala 13:16]
  wire  mem_writeData_MPORT_en; // @[datacache.scala 13:16]
  wire [19:0] mem_writeData_MPORT_addr; // @[datacache.scala 13:16]
  wire [31:0] mem_writeData_MPORT_data; // @[datacache.scala 13:16]
  wire  mem_writeData_MPORT_1_en; // @[datacache.scala 13:16]
  wire [19:0] mem_writeData_MPORT_1_addr; // @[datacache.scala 13:16]
  wire [31:0] mem_writeData_MPORT_1_data; // @[datacache.scala 13:16]
  wire [31:0] mem_MPORT_data; // @[datacache.scala 13:16]
  wire [19:0] mem_MPORT_addr; // @[datacache.scala 13:16]
  wire  mem_MPORT_mask; // @[datacache.scala 13:16]
  wire  mem_MPORT_en; // @[datacache.scala 13:16]
  wire [15:0] address = io_mem_aluresult[17:2]; // @[datacache.scala 15:33]
  wire  _T_1 = io_mem_funct3 == 3'h0; // @[datacache.scala 23:24]
  wire [23:0] _result_T_2 = mem_cacheData_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _result_T_4 = {_result_T_2,mem_cacheData_data[7:0]}; // @[Cat.scala 31:58]
  wire  _T_2 = io_mem_funct3 == 3'h1; // @[datacache.scala 25:30]
  wire [15:0] _result_T_7 = mem_cacheData_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _result_T_9 = {_result_T_7,mem_cacheData_data[15:0]}; // @[Cat.scala 31:58]
  wire  _T_3 = io_mem_funct3 == 3'h2; // @[datacache.scala 27:30]
  wire [31:0] _result_T_11 = {24'h0,mem_cacheData_data[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] _result_T_13 = {16'h0,mem_cacheData_data[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = io_mem_funct3 == 3'h5 ? _result_T_13 : 32'h0; // @[datacache.scala 31:44 32:14 34:14]
  wire [31:0] _GEN_1 = io_mem_funct3 == 3'h4 ? _result_T_11 : _GEN_0; // @[datacache.scala 29:44 30:14]
  wire [31:0] _GEN_2 = io_mem_funct3 == 3'h2 ? mem_cacheData_data : _GEN_1; // @[datacache.scala 27:44 28:14]
  wire [31:0] _GEN_3 = io_mem_funct3 == 3'h1 ? _result_T_9 : _GEN_2; // @[datacache.scala 25:44 26:14]
  wire [31:0] result = io_mem_funct3 == 3'h0 ? _result_T_4 : _GEN_3; // @[datacache.scala 23:38 24:14]
  wire [31:0] _writeData_T_2 = {mem_writeData_MPORT_data[31:8],io_mem_rs2_data[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] _writeData_T_5 = {mem_writeData_MPORT_1_data[31:16],io_mem_rs2_data[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_5 = _T_3 ? io_mem_rs2_data : 32'h0; // @[datacache.scala 49:46 51:19 53:19]
  wire [31:0] _GEN_9 = _T_2 ? _writeData_T_5 : _GEN_5; // @[datacache.scala 46:46 48:19]
  wire  _GEN_16 = _T_1 ? 1'h0 : _T_2; // @[datacache.scala 13:16 43:40]
  wire  _GEN_19 = io_mem_memwrite & _T_1; // @[datacache.scala 13:16 40:35]
  wire  _GEN_22 = io_mem_memwrite & _GEN_16; // @[datacache.scala 13:16 40:35]
  assign mem_cacheData_en = io_mem_memread;
  assign mem_cacheData_addr = {{4'd0}, address};
  assign mem_cacheData_data = mem[mem_cacheData_addr]; // @[datacache.scala 13:16]
  assign mem_writeData_MPORT_en = io_mem_memread ? 1'h0 : _GEN_19;
  assign mem_writeData_MPORT_addr = {{4'd0}, address};
  assign mem_writeData_MPORT_data = mem[mem_writeData_MPORT_addr]; // @[datacache.scala 13:16]
  assign mem_writeData_MPORT_1_en = io_mem_memread ? 1'h0 : _GEN_22;
  assign mem_writeData_MPORT_1_addr = {{4'd0}, address};
  assign mem_writeData_MPORT_1_data = mem[mem_writeData_MPORT_1_addr]; // @[datacache.scala 13:16]
  assign mem_MPORT_data = _T_1 ? _writeData_T_2 : _GEN_9;
  assign mem_MPORT_addr = {{4'd0}, address};
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_mem_memread ? 1'h0 : io_mem_memwrite;
  assign io_read_data = io_mem_memread ? result : 32'h0; // @[datacache.scala 17:32 37:18 59:18]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[datacache.scala 13:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1048576; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
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
  input         io_mem_wb_flush
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
  wire  branch_io_mem_zero; // @[memory.scala 93:22]
  wire [31:0] branch_io_mem_aluresult; // @[memory.scala 93:22]
  wire [2:0] branch_io_mem_funct3; // @[memory.scala 93:22]
  wire  branch_io_mem_isbranch; // @[memory.scala 93:22]
  wire  branch_io_mem_isjump; // @[memory.scala 93:22]
  wire  branch_io_branch; // @[memory.scala 93:22]
  wire  branch_io_pcsrc; // @[memory.scala 93:22]
  wire  dataCache_clock; // @[memory.scala 101:25]
  wire [31:0] dataCache_io_mem_aluresult; // @[memory.scala 101:25]
  wire [31:0] dataCache_io_mem_rs2_data; // @[memory.scala 101:25]
  wire  dataCache_io_mem_memread; // @[memory.scala 101:25]
  wire [2:0] dataCache_io_mem_funct3; // @[memory.scala 101:25]
  wire  dataCache_io_mem_memwrite; // @[memory.scala 101:25]
  wire [31:0] dataCache_io_read_data; // @[memory.scala 101:25]
  wire  load_exception = io_mem_memread & io_mem_rd != 5'h0; // @[memory.scala 57:39]
  wire  mem_misaligned_exception = (io_mem_memread | io_mem_memwrite) & io_mem_aluresult[1:0] != 2'h0; // @[memory.scala 58:70]
  wire  _T = ~io_exception_in; // @[memory.scala 74:14]
  wire [2:0] _ecause_out_T = io_mem_memread ? 3'h4 : 3'h6; // @[memory.scala 80:22]
  wire  _GEN_0 = _T & mem_misaligned_exception | io_exception_in; // @[memory.scala 78:60 79:15 83:15]
  wire [3:0] _GEN_1 = _T & mem_misaligned_exception ? {{1'd0}, _ecause_out_T} : io_ecause_in; // @[memory.scala 78:60 80:16 84:16]
  wire  _GEN_3 = ~io_exception_in & load_exception | _GEN_0; // @[memory.scala 74:50 75:15]
  wire [3:0] _GEN_4 = ~io_exception_in & load_exception ? 4'h5 : _GEN_1; // @[memory.scala 74:50 76:16]
  wire [3:0] _GEN_6 = io_sip ? 4'h3 : _GEN_4; // @[memory.scala 71:22 72:16]
  wire  _GEN_8 = io_sip ? 1'h0 : _GEN_3; // @[memory.scala 71:22]
  wire  _GEN_10 = io_tip | io_sip; // @[memory.scala 68:22 70:15]
  wire  _GEN_11 = io_tip ? 1'h0 : _GEN_8; // @[memory.scala 68:22]
  wire  interrupt = io_eip | _GEN_10; // @[memory.scala 65:16 67:15]
  wire  exception = io_eip ? 1'h0 : _GEN_11; // @[memory.scala 65:16]
  wire  trapped = io_sip | io_tip | io_eip | exception; // @[memory.scala 88:42]
  wire  retired = ~trapped & ~io_wfi_in; // @[memory.scala 89:23]
  reg  csr_write_enable_out_reg; // @[memory.scala 109:41]
  reg [11:0] csr_write_address_out_reg; // @[memory.scala 110:42]
  reg [31:0] csr_write_data_out_reg; // @[memory.scala 111:39]
  reg [3:0] ecause_out_reg; // @[memory.scala 112:31]
  reg  trapped_reg; // @[memory.scala 113:28]
  reg  interrupt_reg; // @[memory.scala 114:30]
  reg  inst_retired_reg; // @[memory.scala 115:33]
  reg [31:0] csr_read_data_out_reg; // @[memory.scala 116:38]
  reg  mret_out_reg; // @[memory.scala 117:29]
  reg  wfi_out_reg; // @[memory.scala 118:28]
  reg [31:0] wb_reg_pc_reg; // @[memory.scala 119:30]
  reg [31:0] wb_readdata_reg; // @[memory.scala 120:32]
  reg [31:0] wb_aluresult_reg; // @[memory.scala 121:33]
  reg [1:0] wb_memtoreg_reg; // @[memory.scala 122:32]
  reg  wb_regwrite_reg; // @[memory.scala 123:32]
  reg [4:0] wb_rd_reg; // @[memory.scala 124:26]
  reg  pcsrc_reg; // @[memory.scala 125:26]
  reg  branch_reg; // @[memory.scala 126:27]
  wire  _T_4 = ~io_mem_wb_flush; // @[memory.scala 130:8]
  wire  _GEN_15 = ~io_mem_wb_flush & io_csr_write_enable_in; // @[memory.scala 130:26 131:30 140:30]
  wire  _GEN_19 = ~io_mem_wb_flush & trapped; // @[memory.scala 130:26 135:17 144:17]
  wire  _GEN_20 = ~io_mem_wb_flush & interrupt; // @[memory.scala 130:26 136:19 145:19]
  wire  _GEN_21 = ~io_mem_wb_flush & retired; // @[memory.scala 130:26 137:22 146:22]
  wire  _GEN_22 = ~io_mem_wb_flush & io_mret_in; // @[memory.scala 130:26 138:18 147:18]
  wire  _GEN_24 = _T_4 & io_wfi_in; // @[memory.scala 151:26 153:17 162:17]
  wire  _GEN_29 = _T_4 & io_mem_regwrite; // @[memory.scala 151:26 158:21 167:21]
  wire  _GEN_31 = _T_4 & branch_io_pcsrc; // @[memory.scala 172:26 173:15 176:15]
  wire  _GEN_32 = _T_4 & branch_io_branch; // @[memory.scala 172:26 174:16 177:16]
  Branch branch ( // @[memory.scala 93:22]
    .io_mem_zero(branch_io_mem_zero),
    .io_mem_aluresult(branch_io_mem_aluresult),
    .io_mem_funct3(branch_io_mem_funct3),
    .io_mem_isbranch(branch_io_mem_isbranch),
    .io_mem_isjump(branch_io_mem_isjump),
    .io_branch(branch_io_branch),
    .io_pcsrc(branch_io_pcsrc)
  );
  DataCache dataCache ( // @[memory.scala 101:25]
    .clock(dataCache_clock),
    .io_mem_aluresult(dataCache_io_mem_aluresult),
    .io_mem_rs2_data(dataCache_io_mem_rs2_data),
    .io_mem_memread(dataCache_io_mem_memread),
    .io_mem_funct3(dataCache_io_mem_funct3),
    .io_mem_memwrite(dataCache_io_mem_memwrite),
    .io_read_data(dataCache_io_read_data)
  );
  assign io_csr_write_enable_out = csr_write_enable_out_reg; // @[memory.scala 181:27]
  assign io_csr_write_address_out = csr_write_address_out_reg; // @[memory.scala 182:28]
  assign io_csr_write_data_out = csr_write_data_out_reg; // @[memory.scala 183:25]
  assign io_ecause_out = ecause_out_reg; // @[memory.scala 184:17]
  assign io_trapped = trapped_reg; // @[memory.scala 185:14]
  assign io_interrupt = interrupt_reg; // @[memory.scala 186:16]
  assign io_inst_retired = inst_retired_reg; // @[memory.scala 187:19]
  assign io_mret_out = mret_out_reg; // @[memory.scala 189:15]
  assign io_csr_read_data_out = csr_read_data_out_reg; // @[memory.scala 188:24]
  assign io_wfi_out = wfi_out_reg; // @[memory.scala 190:14]
  assign io_wb_reg_pc = wb_reg_pc_reg; // @[memory.scala 191:16]
  assign io_wb_readdata = wb_readdata_reg; // @[memory.scala 192:18]
  assign io_wb_aluresult = wb_aluresult_reg; // @[memory.scala 193:19]
  assign io_wb_memtoreg = wb_memtoreg_reg; // @[memory.scala 194:18]
  assign io_wb_regwrite = wb_regwrite_reg; // @[memory.scala 195:18]
  assign io_wb_rd = wb_rd_reg; // @[memory.scala 196:12]
  assign io_pcsrc = pcsrc_reg; // @[memory.scala 197:12]
  assign io_branch = branch_reg; // @[memory.scala 198:13]
  assign branch_io_mem_zero = io_mem_zero; // @[memory.scala 94:22]
  assign branch_io_mem_aluresult = io_mem_aluresult; // @[memory.scala 95:27]
  assign branch_io_mem_funct3 = io_mem_funct3; // @[memory.scala 96:24]
  assign branch_io_mem_isbranch = io_mem_isbranch; // @[memory.scala 97:26]
  assign branch_io_mem_isjump = io_mem_isjump; // @[memory.scala 98:24]
  assign dataCache_clock = clock;
  assign dataCache_io_mem_aluresult = io_mem_aluresult; // @[memory.scala 102:30]
  assign dataCache_io_mem_rs2_data = io_mem_rs2_data; // @[memory.scala 103:29]
  assign dataCache_io_mem_memread = io_mem_memread; // @[memory.scala 104:28]
  assign dataCache_io_mem_funct3 = io_mem_funct3; // @[memory.scala 105:27]
  assign dataCache_io_mem_memwrite = io_mem_memwrite & trapped; // @[memory.scala 106:48]
  always @(posedge clock) begin
    if (reset) begin // @[memory.scala 109:41]
      csr_write_enable_out_reg <= 1'h0; // @[memory.scala 109:41]
    end else begin
      csr_write_enable_out_reg <= _GEN_15;
    end
    if (reset) begin // @[memory.scala 110:42]
      csr_write_address_out_reg <= 12'h0; // @[memory.scala 110:42]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 130:26]
      csr_write_address_out_reg <= io_csr_write_address_in; // @[memory.scala 132:31]
    end else begin
      csr_write_address_out_reg <= 12'h0; // @[memory.scala 141:31]
    end
    if (reset) begin // @[memory.scala 111:39]
      csr_write_data_out_reg <= 32'h0; // @[memory.scala 111:39]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 130:26]
      csr_write_data_out_reg <= io_csr_write_data_in; // @[memory.scala 133:28]
    end else begin
      csr_write_data_out_reg <= 32'h0; // @[memory.scala 142:28]
    end
    if (reset) begin // @[memory.scala 112:31]
      ecause_out_reg <= 4'h0; // @[memory.scala 112:31]
    end else if (~io_mem_wb_flush) begin // @[memory.scala 130:26]
      if (io_eip) begin // @[memory.scala 65:16]
        ecause_out_reg <= 4'hb; // @[memory.scala 66:16]
      end else if (io_tip) begin // @[memory.scala 68:22]
        ecause_out_reg <= 4'h7; // @[memory.scala 69:16]
      end else begin
        ecause_out_reg <= _GEN_6;
      end
    end else begin
      ecause_out_reg <= 4'h0; // @[memory.scala 143:20]
    end
    if (reset) begin // @[memory.scala 113:28]
      trapped_reg <= 1'h0; // @[memory.scala 113:28]
    end else begin
      trapped_reg <= _GEN_19;
    end
    if (reset) begin // @[memory.scala 114:30]
      interrupt_reg <= 1'h0; // @[memory.scala 114:30]
    end else begin
      interrupt_reg <= _GEN_20;
    end
    if (reset) begin // @[memory.scala 115:33]
      inst_retired_reg <= 1'h0; // @[memory.scala 115:33]
    end else begin
      inst_retired_reg <= _GEN_21;
    end
    if (reset) begin // @[memory.scala 116:38]
      csr_read_data_out_reg <= 32'h0; // @[memory.scala 116:38]
    end else if (_T_4) begin // @[memory.scala 151:26]
      csr_read_data_out_reg <= io_csr_read_data_in; // @[memory.scala 152:27]
    end else begin
      csr_read_data_out_reg <= 32'h0; // @[memory.scala 161:27]
    end
    if (reset) begin // @[memory.scala 117:29]
      mret_out_reg <= 1'h0; // @[memory.scala 117:29]
    end else begin
      mret_out_reg <= _GEN_22;
    end
    if (reset) begin // @[memory.scala 118:28]
      wfi_out_reg <= 1'h0; // @[memory.scala 118:28]
    end else begin
      wfi_out_reg <= _GEN_24;
    end
    if (reset) begin // @[memory.scala 119:30]
      wb_reg_pc_reg <= 32'h0; // @[memory.scala 119:30]
    end else if (_T_4) begin // @[memory.scala 151:26]
      wb_reg_pc_reg <= io_reg_pc; // @[memory.scala 154:19]
    end else begin
      wb_reg_pc_reg <= 32'h0; // @[memory.scala 163:19]
    end
    if (reset) begin // @[memory.scala 120:32]
      wb_readdata_reg <= 32'h0; // @[memory.scala 120:32]
    end else if (_T_4) begin // @[memory.scala 151:26]
      wb_readdata_reg <= dataCache_io_read_data; // @[memory.scala 155:21]
    end else begin
      wb_readdata_reg <= 32'h0; // @[memory.scala 164:21]
    end
    if (reset) begin // @[memory.scala 121:33]
      wb_aluresult_reg <= 32'h0; // @[memory.scala 121:33]
    end else if (_T_4) begin // @[memory.scala 151:26]
      wb_aluresult_reg <= io_mem_aluresult; // @[memory.scala 156:22]
    end else begin
      wb_aluresult_reg <= 32'h0; // @[memory.scala 165:22]
    end
    if (reset) begin // @[memory.scala 122:32]
      wb_memtoreg_reg <= 2'h0; // @[memory.scala 122:32]
    end else if (_T_4) begin // @[memory.scala 151:26]
      wb_memtoreg_reg <= io_mem_memtoreg; // @[memory.scala 157:21]
    end else begin
      wb_memtoreg_reg <= 2'h0; // @[memory.scala 166:21]
    end
    if (reset) begin // @[memory.scala 123:32]
      wb_regwrite_reg <= 1'h0; // @[memory.scala 123:32]
    end else begin
      wb_regwrite_reg <= _GEN_29;
    end
    if (reset) begin // @[memory.scala 124:26]
      wb_rd_reg <= 5'h0; // @[memory.scala 124:26]
    end else if (_T_4) begin // @[memory.scala 151:26]
      wb_rd_reg <= io_mem_rd; // @[memory.scala 159:15]
    end else begin
      wb_rd_reg <= 5'h0; // @[memory.scala 168:15]
    end
    if (reset) begin // @[memory.scala 125:26]
      pcsrc_reg <= 1'h0; // @[memory.scala 125:26]
    end else begin
      pcsrc_reg <= _GEN_31;
    end
    if (reset) begin // @[memory.scala 126:27]
      branch_reg <= 1'h0; // @[memory.scala 126:27]
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
