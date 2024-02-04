module BHT(
  input         clock,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input  [31:0] io_target_pc,
  output        io_match,
  output        io_valid,
  output [31:0] io_bht_pred_pc
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
  reg [25:0] bhtTable_tag [0:15]; // @[bht.scala 24:21]
  wire  bhtTable_tag_bhtEntry_en; // @[bht.scala 24:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[bht.scala 24:21]
  wire [25:0] bhtTable_tag_bhtEntry_data; // @[bht.scala 24:21]
  wire [25:0] bhtTable_tag_MPORT_data; // @[bht.scala 24:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[bht.scala 24:21]
  wire  bhtTable_tag_MPORT_mask; // @[bht.scala 24:21]
  wire  bhtTable_tag_MPORT_en; // @[bht.scala 24:21]
  reg  bhtTable_valid [0:15]; // @[bht.scala 24:21]
  wire  bhtTable_valid_bhtEntry_en; // @[bht.scala 24:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[bht.scala 24:21]
  wire  bhtTable_valid_bhtEntry_data; // @[bht.scala 24:21]
  wire  bhtTable_valid_MPORT_data; // @[bht.scala 24:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[bht.scala 24:21]
  wire  bhtTable_valid_MPORT_mask; // @[bht.scala 24:21]
  wire  bhtTable_valid_MPORT_en; // @[bht.scala 24:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[bht.scala 24:21]
  wire  bhtTable_target_pc_bhtEntry_en; // @[bht.scala 24:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[bht.scala 24:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[bht.scala 24:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[bht.scala 24:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[bht.scala 24:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[bht.scala 24:21]
  wire  bhtTable_target_pc_MPORT_en; // @[bht.scala 24:21]
  assign bhtTable_tag_bhtEntry_en = 1'h1;
  assign bhtTable_tag_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[bht.scala 24:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:6];
  assign bhtTable_tag_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_en = 1'h1;
  assign bhtTable_valid_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[bht.scala 24:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_en = 1'h1;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[bht.scala 24:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_match = bhtTable_tag_bhtEntry_data == io_pc[31:6]; // @[bht.scala 30:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[bht.scala 31:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[bht.scala 32:18]
  always @(posedge clock) begin
    if (bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[bht.scala 24:21]
    end
    if (bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[bht.scala 24:21]
    end
    if (bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[bht.scala 24:21]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_tag[initvar] = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_valid[initvar] = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_target_pc[initvar] = _RAND_2[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BTB(
  input         clock,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  output        io_btb_taken
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [1:0] btbTable [0:15]; // @[btb.scala 14:21]
  wire  btbTable_btbEntry_en; // @[btb.scala 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[btb.scala 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[btb.scala 14:21]
  wire  btbTable_MPORT_en; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_data; // @[btb.scala 14:21]
  wire  btbTable_MPORT_1_en; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[btb.scala 14:21]
  wire  btbTable_MPORT_3_en; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_3_data; // @[btb.scala 14:21]
  wire  btbTable_MPORT_4_en; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_4_data; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_2_data; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[btb.scala 14:21]
  wire  btbTable_MPORT_2_mask; // @[btb.scala 14:21]
  wire  btbTable_MPORT_2_en; // @[btb.scala 14:21]
  wire [1:0] btbTable_MPORT_5_data; // @[btb.scala 14:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[btb.scala 14:21]
  wire  btbTable_MPORT_5_mask; // @[btb.scala 14:21]
  wire  btbTable_MPORT_5_en; // @[btb.scala 14:21]
  wire  _T_3 = btbTable_MPORT_data < 2'h3; // @[btb.scala 26:38]
  wire  _T_9 = btbTable_MPORT_3_data > 2'h0; // @[btb.scala 31:38]
  wire  _GEN_17 = io_pcsrc & _T_3; // @[btb.scala 14:21 24:28]
  wire  _GEN_23 = io_pcsrc ? 1'h0 : 1'h1; // @[btb.scala 14:21 24:28 31:20]
  wire  _GEN_26 = io_pcsrc ? 1'h0 : _T_9; // @[btb.scala 14:21 24:28]
  assign btbTable_btbEntry_en = 1'h1;
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[btb.scala 14:21]
  assign btbTable_MPORT_en = io_branch & io_pcsrc;
  assign btbTable_MPORT_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_data = btbTable[btbTable_MPORT_addr]; // @[btb.scala 14:21]
  assign btbTable_MPORT_1_en = io_branch & _GEN_17;
  assign btbTable_MPORT_1_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_1_data = btbTable[btbTable_MPORT_1_addr]; // @[btb.scala 14:21]
  assign btbTable_MPORT_3_en = io_branch & _GEN_23;
  assign btbTable_MPORT_3_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_3_data = btbTable[btbTable_MPORT_3_addr]; // @[btb.scala 14:21]
  assign btbTable_MPORT_4_en = io_branch & _GEN_26;
  assign btbTable_MPORT_4_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_4_data = btbTable[btbTable_MPORT_4_addr]; // @[btb.scala 14:21]
  assign btbTable_MPORT_2_data = btbTable_MPORT_1_data + 2'h1;
  assign btbTable_MPORT_2_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_2_mask = 1'h1;
  assign btbTable_MPORT_2_en = io_branch & _GEN_17;
  assign btbTable_MPORT_5_data = btbTable_MPORT_4_data - 2'h1;
  assign btbTable_MPORT_5_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_5_mask = 1'h1;
  assign btbTable_MPORT_5_en = io_branch & _GEN_26;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[btb.scala 20:28]
  always @(posedge clock) begin
    if (btbTable_MPORT_2_en & btbTable_MPORT_2_mask) begin
      btbTable[btbTable_MPORT_2_addr] <= btbTable_MPORT_2_data; // @[btb.scala 14:21]
    end
    if (btbTable_MPORT_5_en & btbTable_MPORT_5_mask) begin
      btbTable[btbTable_MPORT_5_addr] <= btbTable_MPORT_5_data; // @[btb.scala 14:21]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    btbTable[initvar] = _RAND_0[1:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Icache(
  input         clock,
  input  [31:0] io_pc,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] cacheData [0:1048575]; // @[Icache.scala 10:22]
  wire  cacheData_cacheEntry_en; // @[Icache.scala 10:22]
  wire [19:0] cacheData_cacheEntry_addr; // @[Icache.scala 10:22]
  wire [31:0] cacheData_cacheEntry_data; // @[Icache.scala 10:22]
  wire [15:0] cacheIndex = io_pc[17:2]; // @[Icache.scala 11:25]
  assign cacheData_cacheEntry_en = 1'h1;
  assign cacheData_cacheEntry_addr = {{4'd0}, cacheIndex};
  assign cacheData_cacheEntry_data = cacheData[cacheData_cacheEntry_addr]; // @[Icache.scala 10:22]
  assign io_inst = cacheData_cacheEntry_data; // @[Icache.scala 16:11]
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
    cacheData[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Fetch(
  input         clock,
  input         reset,
  input  [31:0] io_trap_vector,
  input  [31:0] io_mret_vector,
  input  [31:0] io_target_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  input         io_trap,
  input         io_mret,
  input         io_pc_stall,
  input         io_if_id_stall,
  input         io_if_id_flush,
  input         io_predict,
  output [31:0] io_id_pc,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bht_clock; // @[fetch.scala 28:19]
  wire [31:0] bht_io_pc; // @[fetch.scala 28:19]
  wire [31:0] bht_io_mem_pc; // @[fetch.scala 28:19]
  wire  bht_io_pcsrc; // @[fetch.scala 28:19]
  wire [31:0] bht_io_target_pc; // @[fetch.scala 28:19]
  wire  bht_io_match; // @[fetch.scala 28:19]
  wire  bht_io_valid; // @[fetch.scala 28:19]
  wire [31:0] bht_io_bht_pred_pc; // @[fetch.scala 28:19]
  wire  btb_clock; // @[fetch.scala 29:19]
  wire [31:0] btb_io_pc; // @[fetch.scala 29:19]
  wire [31:0] btb_io_mem_pc; // @[fetch.scala 29:19]
  wire  btb_io_pcsrc; // @[fetch.scala 29:19]
  wire  btb_io_branch; // @[fetch.scala 29:19]
  wire  btb_io_btb_taken; // @[fetch.scala 29:19]
  wire  icache_clock; // @[fetch.scala 30:22]
  wire [31:0] icache_io_pc; // @[fetch.scala 30:22]
  wire [31:0] icache_io_inst; // @[fetch.scala 30:22]
  reg [31:0] pcReg; // @[fetch.scala 33:22]
  reg [31:0] idPcReg; // @[fetch.scala 34:24]
  reg [31:0] instReg; // @[fetch.scala 35:24]
  wire [31:0] _pcReg_T_1 = pcReg + 32'h4; // @[fetch.scala 62:20]
  wire [31:0] _GEN_0 = btb_io_btb_taken & bht_io_valid & bht_io_match ? bht_io_bht_pred_pc : _pcReg_T_1; // @[fetch.scala 59:74 60:11 62:11]
  wire [31:0] _GEN_1 = io_pc_stall ? pcReg : _GEN_0; // @[fetch.scala 57:27 58:11]
  BHT bht ( // @[fetch.scala 28:19]
    .clock(bht_clock),
    .io_pc(bht_io_pc),
    .io_mem_pc(bht_io_mem_pc),
    .io_pcsrc(bht_io_pcsrc),
    .io_target_pc(bht_io_target_pc),
    .io_match(bht_io_match),
    .io_valid(bht_io_valid),
    .io_bht_pred_pc(bht_io_bht_pred_pc)
  );
  BTB btb ( // @[fetch.scala 29:19]
    .clock(btb_clock),
    .io_pc(btb_io_pc),
    .io_mem_pc(btb_io_mem_pc),
    .io_pcsrc(btb_io_pcsrc),
    .io_branch(btb_io_branch),
    .io_btb_taken(btb_io_btb_taken)
  );
  Icache icache ( // @[fetch.scala 30:22]
    .clock(icache_clock),
    .io_pc(icache_io_pc),
    .io_inst(icache_io_inst)
  );
  assign io_id_pc = idPcReg; // @[fetch.scala 79:12]
  assign io_inst = instReg; // @[fetch.scala 80:11]
  assign bht_clock = clock;
  assign bht_io_pc = pcReg; // @[fetch.scala 38:13]
  assign bht_io_mem_pc = io_mem_pc; // @[fetch.scala 39:17]
  assign bht_io_pcsrc = io_pcsrc; // @[fetch.scala 40:16]
  assign bht_io_target_pc = io_target_pc; // @[fetch.scala 41:20]
  assign btb_clock = clock;
  assign btb_io_pc = pcReg; // @[fetch.scala 43:13]
  assign btb_io_mem_pc = io_mem_pc; // @[fetch.scala 44:17]
  assign btb_io_pcsrc = io_pcsrc; // @[fetch.scala 45:16]
  assign btb_io_branch = io_branch; // @[fetch.scala 46:17]
  assign icache_clock = clock;
  assign icache_io_pc = pcReg; // @[fetch.scala 48:16]
  always @(posedge clock) begin
    if (reset) begin // @[fetch.scala 33:22]
      pcReg <= 32'h8; // @[fetch.scala 33:22]
    end else if (io_trap) begin // @[fetch.scala 51:17]
      pcReg <= io_trap_vector; // @[fetch.scala 52:11]
    end else if (io_mret) begin // @[fetch.scala 53:23]
      pcReg <= io_mret_vector; // @[fetch.scala 54:11]
    end else if (io_pcsrc & ~io_predict) begin // @[fetch.scala 55:39]
      pcReg <= io_target_pc; // @[fetch.scala 56:11]
    end else begin
      pcReg <= _GEN_1;
    end
    if (reset) begin // @[fetch.scala 34:24]
      idPcReg <= 32'h0; // @[fetch.scala 34:24]
    end else if (io_if_id_flush) begin // @[fetch.scala 74:24]
      idPcReg <= 32'h0; // @[fetch.scala 75:13]
    end else if (!(io_if_id_stall)) begin // @[fetch.scala 66:24]
      idPcReg <= pcReg; // @[fetch.scala 70:13]
    end
    if (reset) begin // @[fetch.scala 35:24]
      instReg <= 32'h0; // @[fetch.scala 35:24]
    end else if (io_if_id_flush) begin // @[fetch.scala 74:24]
      instReg <= 32'h13; // @[fetch.scala 76:13]
    end else if (!(io_if_id_stall)) begin // @[fetch.scala 66:24]
      instReg <= icache_io_inst; // @[fetch.scala 71:13]
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
  pcReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  idPcReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  instReg = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
