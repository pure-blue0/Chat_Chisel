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
  output [31:0] io_inst,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bht_clock; // @[fetch.scala 32:19]
  wire [31:0] bht_io_pc; // @[fetch.scala 32:19]
  wire [31:0] bht_io_mem_pc; // @[fetch.scala 32:19]
  wire  bht_io_pcsrc; // @[fetch.scala 32:19]
  wire [31:0] bht_io_target_pc; // @[fetch.scala 32:19]
  wire  bht_io_match; // @[fetch.scala 32:19]
  wire  bht_io_valid; // @[fetch.scala 32:19]
  wire [31:0] bht_io_bht_pred_pc; // @[fetch.scala 32:19]
  wire  btb_clock; // @[fetch.scala 33:19]
  wire [31:0] btb_io_pc; // @[fetch.scala 33:19]
  wire [31:0] btb_io_mem_pc; // @[fetch.scala 33:19]
  wire  btb_io_pcsrc; // @[fetch.scala 33:19]
  wire  btb_io_branch; // @[fetch.scala 33:19]
  wire  btb_io_btb_taken; // @[fetch.scala 33:19]
  reg [31:0] pcReg; // @[fetch.scala 36:22]
  reg [31:0] idPcReg; // @[fetch.scala 37:24]
  reg [31:0] instReg; // @[fetch.scala 38:24]
  wire [31:0] _pcReg_T_1 = pcReg + 32'h4; // @[fetch.scala 65:20]
  wire [31:0] _GEN_0 = btb_io_btb_taken & bht_io_valid & bht_io_match ? bht_io_bht_pred_pc : _pcReg_T_1; // @[fetch.scala 62:74 63:11 65:11]
  wire [31:0] _GEN_1 = io_pc_stall ? pcReg : _GEN_0; // @[fetch.scala 60:27 61:11]
  BHT bht ( // @[fetch.scala 32:19]
    .clock(bht_clock),
    .io_pc(bht_io_pc),
    .io_mem_pc(bht_io_mem_pc),
    .io_pcsrc(bht_io_pcsrc),
    .io_target_pc(bht_io_target_pc),
    .io_match(bht_io_match),
    .io_valid(bht_io_valid),
    .io_bht_pred_pc(bht_io_bht_pred_pc)
  );
  BTB btb ( // @[fetch.scala 33:19]
    .clock(btb_clock),
    .io_pc(btb_io_pc),
    .io_mem_pc(btb_io_mem_pc),
    .io_pcsrc(btb_io_pcsrc),
    .io_branch(btb_io_branch),
    .io_btb_taken(btb_io_btb_taken)
  );
  assign io_id_pc = idPcReg; // @[fetch.scala 83:12]
  assign io_inst = instReg; // @[fetch.scala 84:11]
  assign io_fetch_address = pcReg; // @[fetch.scala 82:20]
  assign bht_clock = clock;
  assign bht_io_pc = pcReg; // @[fetch.scala 41:13]
  assign bht_io_mem_pc = io_mem_pc; // @[fetch.scala 42:17]
  assign bht_io_pcsrc = io_pcsrc; // @[fetch.scala 43:16]
  assign bht_io_target_pc = io_target_pc; // @[fetch.scala 44:20]
  assign btb_clock = clock;
  assign btb_io_pc = pcReg; // @[fetch.scala 46:13]
  assign btb_io_mem_pc = io_mem_pc; // @[fetch.scala 47:17]
  assign btb_io_pcsrc = io_pcsrc; // @[fetch.scala 48:16]
  assign btb_io_branch = io_branch; // @[fetch.scala 49:17]
  always @(posedge clock) begin
    if (reset) begin // @[fetch.scala 36:22]
      pcReg <= 32'h8; // @[fetch.scala 36:22]
    end else if (io_trap) begin // @[fetch.scala 54:17]
      pcReg <= io_trap_vector; // @[fetch.scala 55:11]
    end else if (io_mret) begin // @[fetch.scala 56:23]
      pcReg <= io_mret_vector; // @[fetch.scala 57:11]
    end else if (io_pcsrc & ~io_predict) begin // @[fetch.scala 58:39]
      pcReg <= io_target_pc; // @[fetch.scala 59:11]
    end else begin
      pcReg <= _GEN_1;
    end
    if (reset) begin // @[fetch.scala 37:24]
      idPcReg <= 32'h0; // @[fetch.scala 37:24]
    end else if (io_if_id_flush) begin // @[fetch.scala 77:24]
      idPcReg <= 32'h0; // @[fetch.scala 78:13]
    end else if (!(io_if_id_stall)) begin // @[fetch.scala 69:24]
      idPcReg <= pcReg; // @[fetch.scala 73:13]
    end
    if (reset) begin // @[fetch.scala 38:24]
      instReg <= 32'h0; // @[fetch.scala 38:24]
    end else if (io_if_id_flush) begin // @[fetch.scala 77:24]
      instReg <= 32'h13; // @[fetch.scala 79:13]
    end else if (!(io_if_id_stall)) begin // @[fetch.scala 69:24]
      instReg <= io_fetch_data; // @[fetch.scala 74:13]
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
  wire  _isLegalInstruction_T_14 = _isLegalInstruction_T_2 & io_inst[31:25] == 7'h4; // @[decode.scala 129:53]
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
  wire  _isLegalInstruction_T_54 = io_inst[14:12] == 3'h4; // @[decode.scala 138:40]
  wire  _isLegalInstruction_T_55 = _isLegalInstruction_T_50 & io_inst[14:12] == 3'h4; // @[decode.scala 138:30]
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
  wire  _isLegalInstruction_T_94 = _isLegalInstruction_T_83 & _isLegalInstruction_T_54; // @[decode.scala 149:30]
  wire  _isLegalInstruction_T_97 = _isLegalInstruction_T_83 & _csrrwiInst_T_1; // @[decode.scala 150:30]
  wire  _isLegalInstruction_T_98 = io_inst[6:0] == 7'h23; // @[decode.scala 151:13]
  wire  _isLegalInstruction_T_100 = io_inst[6:0] == 7'h23 & _isLegalInstruction_T_1; // @[decode.scala 151:30]
  wire  _isLegalInstruction_T_103 = _isLegalInstruction_T_98 & _csrrwInst_T_1; // @[decode.scala 152:30]
  wire  _isLegalInstruction_T_106 = _isLegalInstruction_T_98 & _csrrsInst_T_1; // @[decode.scala 153:30]
  wire  _isLegalInstruction_T_107 = io_inst[6:0] == 7'h63; // @[decode.scala 154:13]
  wire  _isLegalInstruction_T_109 = io_inst[6:0] == 7'h63 & _isLegalInstruction_T_1; // @[decode.scala 154:30]
  wire  _isLegalInstruction_T_112 = _isLegalInstruction_T_107 & _csrrwInst_T_1; // @[decode.scala 155:30]
  wire  _isLegalInstruction_T_115 = _isLegalInstruction_T_107 & _isLegalInstruction_T_54; // @[decode.scala 156:30]
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
  wire  _isLegalInstruction_T_199 = _isLegalInstruction_T_76 | (_isLegalInstruction_T_79 | (_isLegalInstruction_T_82 | (
    _isLegalInstruction_T_85 | (_isLegalInstruction_T_88 | (_isLegalInstruction_T_91 | (_isLegalInstruction_T_94 | (
    _isLegalInstruction_T_97 | (_isLegalInstruction_T_100 | (_isLegalInstruction_T_103 | (_isLegalInstruction_T_106 | (
    _isLegalInstruction_T_109 | (_isLegalInstruction_T_112 | (_isLegalInstruction_T_115 | (_isLegalInstruction_T_118 | (
    _isLegalInstruction_T_121 | (_isLegalInstruction_T_124 | (_isLegalInstruction_T_125 | (_isLegalInstruction_T_128 | (
    _isLegalInstruction_T_129 | (_isLegalInstruction_T_130 | (_isLegalInstruction_T_135 | (_isLegalInstruction_T_140 | (
    _isLegalInstruction_T_145 | (_isLegalInstruction_T_150 | (csrrwInst | (csrrsInst | (csrrcInst | (csrrwiInst | (
    csrrsiInst | csrrciInst))))))))))))))))))))))))))))); // @[Mux.scala 101:16]
  wire  isLegalInstruction = _isLegalInstruction_T_4 | (_isLegalInstruction_T_9 | (_isLegalInstruction_T_14 | (
    _isLegalInstruction_T_19 | (_isLegalInstruction_T_24 | (_isLegalInstruction_T_29 | (_isLegalInstruction_T_34 | (
    _isLegalInstruction_T_39 | (_isLegalInstruction_T_44 | (_isLegalInstruction_T_49 | (_isLegalInstruction_T_52 | (
    _isLegalInstruction_T_55 | (_isLegalInstruction_T_58 | (_isLegalInstruction_T_61 | (_isLegalInstruction_T_66 | (
    _isLegalInstruction_T_71 | _isLegalInstruction_T_199))))))))))))))); // @[Mux.scala 101:16]
  wire [1:0] ecause_out = isLegalInstruction ? 2'h0 : 2'h2; // @[decode.scala 177:23]
  wire [1:0] _GEN_26 = io_id_ex_flush ? 2'h0 : ecause_out; // @[decode.scala 180:25 205:20 213:20]
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
  assign io_csr_read = csr_read_reg; // @[decode.scala 244:15]
  assign io_csr_write = csr_write_reg; // @[decode.scala 245:16]
  assign io_csr_address = csr_address_reg; // @[decode.scala 246:18]
  assign io_ecause_out = ecause_out_reg; // @[decode.scala 247:17]
  assign io_exception_out = exception_out_reg; // @[decode.scala 248:20]
  assign io_mret_out = mret_out_reg; // @[decode.scala 249:15]
  assign io_wfi_out = wfi_out_reg; // @[decode.scala 250:14]
  assign io_ex_pc = id_ex_pc_reg; // @[decode.scala 251:12]
  assign io_aluop = id_ex_aluop_reg; // @[decode.scala 252:12]
  assign io_immsrc = id_ex_immsrc_reg; // @[decode.scala 253:13]
  assign io_isbranch = id_ex_isbranch_reg; // @[decode.scala 254:15]
  assign io_memread = id_ex_memread_reg; // @[decode.scala 255:14]
  assign io_memwrite = id_ex_memwrite_reg; // @[decode.scala 256:15]
  assign io_regwrite = id_ex_regwrite_reg; // @[decode.scala 257:15]
  assign io_memtoreg = id_ex_memtoreg_reg; // @[decode.scala 258:15]
  assign io_pcsel = id_ex_pcsel_reg; // @[decode.scala 259:12]
  assign io_rdsel = id_ex_rdsel_reg; // @[decode.scala 260:12]
  assign io_isjump = id_ex_isjump_reg; // @[decode.scala 261:13]
  assign io_islui = id_ex_islui_reg; // @[decode.scala 262:12]
  assign io_rs1_data = id_ex_rs1_data_reg; // @[decode.scala 263:15]
  assign io_rs2_data = id_ex_rs2_data_reg; // @[decode.scala 264:15]
  assign io_imm = id_ex_imm_reg; // @[decode.scala 265:10]
  assign io_funct3 = {{29'd0}, id_ex_funct3_reg}; // @[decode.scala 266:13]
  assign io_ex_rs1 = id_ex_ex_rs1_reg; // @[decode.scala 267:13]
  assign io_ex_rs2 = id_ex_ex_rs2_reg; // @[decode.scala 268:13]
  assign io_ex_rd = id_ex_ex_rd_reg; // @[decode.scala 269:12]
  assign io_ex_use_rs1 = id_ex_ex_use_rs1_reg; // @[decode.scala 270:17]
  assign io_ex_use_rs2 = id_ex_ex_use_rs2_reg; // @[decode.scala 271:17]
  assign io_id_rs1 = io_inst[19:15]; // @[decode.scala 274:23]
  assign io_id_rs2 = io_inst[24:20]; // @[decode.scala 275:23]
  assign io_use_rs1 = control_io_use_rs1; // @[decode.scala 276:14]
  assign io_use_rs2 = control_io_use_rs2; // @[decode.scala 277:14]
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
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      csr_read_reg <= 1'h0; // @[decode.scala 202:18]
    end else if ((csrrwInst | csrrwiInst) & io_inst[11:7] == 5'h0) begin // @[decode.scala 111:66]
      csr_read_reg <= 1'h0; // @[decode.scala 112:12]
    end else begin
      csr_read_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 58:30]
      csr_write_reg <= 1'h0; // @[decode.scala 58:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      csr_write_reg <= 1'h0; // @[decode.scala 203:19]
    end else if ((csrrsInst | csrrcInst | csrrsiInst | csrrciInst) & io_inst[19:15] == 5'h0) begin // @[decode.scala 114:94]
      csr_write_reg <= 1'h0; // @[decode.scala 115:13]
    end else begin
      csr_write_reg <= csrInst;
    end
    if (reset) begin // @[decode.scala 59:32]
      csr_address_reg <= 12'h0; // @[decode.scala 59:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      csr_address_reg <= 12'h0; // @[decode.scala 204:21]
    end else begin
      csr_address_reg <= io_inst[31:20]; // @[decode.scala 212:21]
    end
    if (reset) begin // @[decode.scala 60:31]
      ecause_out_reg <= 4'h0; // @[decode.scala 60:31]
    end else begin
      ecause_out_reg <= {{2'd0}, _GEN_26};
    end
    if (reset) begin // @[decode.scala 61:34]
      exception_out_reg <= 1'h0; // @[decode.scala 61:34]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      exception_out_reg <= 1'h0; // @[decode.scala 206:23]
    end else if (isLegalInstruction) begin // @[decode.scala 176:26]
      exception_out_reg <= 1'h0;
    end else begin
      exception_out_reg <= 1'h1;
    end
    if (reset) begin // @[decode.scala 62:29]
      mret_out_reg <= 1'h0; // @[decode.scala 62:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      mret_out_reg <= 1'h0; // @[decode.scala 207:18]
    end else begin
      mret_out_reg <= mret_out; // @[decode.scala 215:18]
    end
    if (reset) begin // @[decode.scala 63:28]
      wfi_out_reg <= 1'h0; // @[decode.scala 63:28]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      wfi_out_reg <= 1'h0; // @[decode.scala 208:17]
    end else begin
      wfi_out_reg <= wfi_out; // @[decode.scala 216:17]
    end
    if (reset) begin // @[decode.scala 64:29]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 64:29]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_pc_reg <= 32'h0; // @[decode.scala 181:18]
    end else begin
      id_ex_pc_reg <= io_id_pc; // @[decode.scala 217:18]
    end
    if (reset) begin // @[decode.scala 65:32]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 65:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_aluop_reg <= 4'h0; // @[decode.scala 182:21]
    end else begin
      id_ex_aluop_reg <= control_io_aluop; // @[decode.scala 218:21]
    end
    if (reset) begin // @[decode.scala 66:33]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 66:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_immsrc_reg <= 1'h0; // @[decode.scala 183:22]
    end else begin
      id_ex_immsrc_reg <= control_io_immsrc; // @[decode.scala 219:22]
    end
    if (reset) begin // @[decode.scala 67:35]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 67:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_isbranch_reg <= 1'h0; // @[decode.scala 184:24]
    end else begin
      id_ex_isbranch_reg <= control_io_isbranch; // @[decode.scala 220:24]
    end
    if (reset) begin // @[decode.scala 68:34]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 68:34]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_memread_reg <= 1'h0; // @[decode.scala 185:23]
    end else begin
      id_ex_memread_reg <= control_io_memread; // @[decode.scala 221:23]
    end
    if (reset) begin // @[decode.scala 69:35]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 69:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_memwrite_reg <= 1'h0; // @[decode.scala 186:24]
    end else begin
      id_ex_memwrite_reg <= control_io_memwrite; // @[decode.scala 222:24]
    end
    if (reset) begin // @[decode.scala 70:35]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 70:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_regwrite_reg <= 1'h0; // @[decode.scala 187:24]
    end else begin
      id_ex_regwrite_reg <= control_io_regwrite; // @[decode.scala 223:24]
    end
    if (reset) begin // @[decode.scala 71:35]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 71:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_memtoreg_reg <= 2'h0; // @[decode.scala 188:24]
    end else begin
      id_ex_memtoreg_reg <= control_io_memtoreg; // @[decode.scala 224:24]
    end
    if (reset) begin // @[decode.scala 72:32]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 72:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_pcsel_reg <= 1'h0; // @[decode.scala 189:21]
    end else begin
      id_ex_pcsel_reg <= control_io_pcsel; // @[decode.scala 225:21]
    end
    if (reset) begin // @[decode.scala 73:32]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 73:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_rdsel_reg <= 1'h0; // @[decode.scala 190:21]
    end else begin
      id_ex_rdsel_reg <= control_io_rdsel; // @[decode.scala 226:21]
    end
    if (reset) begin // @[decode.scala 74:33]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 74:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_isjump_reg <= 1'h0; // @[decode.scala 191:22]
    end else begin
      id_ex_isjump_reg <= control_io_isjump; // @[decode.scala 227:22]
    end
    if (reset) begin // @[decode.scala 75:32]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 75:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_islui_reg <= 1'h0; // @[decode.scala 192:21]
    end else begin
      id_ex_islui_reg <= control_io_islui; // @[decode.scala 228:21]
    end
    if (reset) begin // @[decode.scala 76:35]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 76:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_rs1_data_reg <= 32'h0; // @[decode.scala 193:24]
    end else begin
      id_ex_rs1_data_reg <= regfile_io_rs1_data; // @[decode.scala 229:24]
    end
    if (reset) begin // @[decode.scala 77:35]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 77:35]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_rs2_data_reg <= 32'h0; // @[decode.scala 194:24]
    end else begin
      id_ex_rs2_data_reg <= regfile_io_rs2_data; // @[decode.scala 230:24]
    end
    if (reset) begin // @[decode.scala 78:30]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 78:30]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_imm_reg <= 32'h0; // @[decode.scala 195:19]
    end else begin
      id_ex_imm_reg <= immGen_io_imm; // @[decode.scala 231:19]
    end
    if (reset) begin // @[decode.scala 79:33]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 79:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_funct3_reg <= 3'h0; // @[decode.scala 196:22]
    end else begin
      id_ex_funct3_reg <= io_inst[14:12]; // @[decode.scala 232:22]
    end
    if (reset) begin // @[decode.scala 80:33]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 80:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_ex_rs1_reg <= 5'h0; // @[decode.scala 197:22]
    end else begin
      id_ex_ex_rs1_reg <= io_inst[19:15]; // @[decode.scala 233:22]
    end
    if (reset) begin // @[decode.scala 81:33]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 81:33]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_ex_rs2_reg <= 5'h0; // @[decode.scala 198:22]
    end else begin
      id_ex_ex_rs2_reg <= io_inst[24:20]; // @[decode.scala 234:22]
    end
    if (reset) begin // @[decode.scala 82:32]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 82:32]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_ex_rd_reg <= 5'h0; // @[decode.scala 199:21]
    end else begin
      id_ex_ex_rd_reg <= io_inst[11:7]; // @[decode.scala 235:21]
    end
    if (reset) begin // @[decode.scala 83:37]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 83:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_ex_use_rs1_reg <= 1'h0; // @[decode.scala 200:26]
    end else begin
      id_ex_ex_use_rs1_reg <= control_io_use_rs1; // @[decode.scala 236:26]
    end
    if (reset) begin // @[decode.scala 84:37]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 84:37]
    end else if (io_id_ex_flush) begin // @[decode.scala 180:25]
      id_ex_ex_use_rs2_reg <= 1'h0; // @[decode.scala 201:26]
    end else begin
      id_ex_ex_use_rs2_reg <= control_io_use_rs2; // @[decode.scala 237:26]
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
module AluSelect(
  input  [31:0] io_rs1_data,
  input  [31:0] io_rs2_data,
  input  [31:0] io_imm,
  input  [31:0] io_mem_aluresult,
  input  [31:0] io_writedata,
  input         io_immsrc,
  input         io_islui,
  input  [1:0]  io_forward1,
  input  [1:0]  io_forward2,
  output [31:0] io_alu_in1,
  output [31:0] io_alu_in2
);
  wire  _select1_T = io_forward1 == 2'h0; // @[aluselect.scala 21:18]
  wire  _select1_T_1 = io_forward1 == 2'h1; // @[aluselect.scala 22:18]
  wire  _select1_T_2 = io_forward1 == 2'h2; // @[aluselect.scala 23:18]
  wire [31:0] _select1_T_3 = _select1_T_2 ? io_writedata : io_rs1_data; // @[Mux.scala 101:16]
  wire [31:0] _select1_T_4 = _select1_T_1 ? io_mem_aluresult : _select1_T_3; // @[Mux.scala 101:16]
  wire [31:0] select1 = _select1_T ? io_rs1_data : _select1_T_4; // @[Mux.scala 101:16]
  wire  _select2_T = io_forward2 == 2'h0; // @[aluselect.scala 29:18]
  wire  _select2_T_1 = io_forward2 == 2'h1; // @[aluselect.scala 30:18]
  wire  _select2_T_2 = io_forward2 == 2'h2; // @[aluselect.scala 31:18]
  wire [31:0] _select2_T_3 = _select2_T_2 ? io_writedata : io_rs2_data; // @[Mux.scala 101:16]
  wire [31:0] _select2_T_4 = _select2_T_1 ? io_mem_aluresult : _select2_T_3; // @[Mux.scala 101:16]
  wire [31:0] select2 = _select2_T ? io_rs2_data : _select2_T_4; // @[Mux.scala 101:16]
  assign io_alu_in1 = io_islui ? 32'h0 : select1; // @[aluselect.scala 25:20]
  assign io_alu_in2 = io_immsrc ? io_imm : select2; // @[aluselect.scala 33:20]
endmodule
module ALU(
  input  [31:0] io_alu_in1,
  input  [31:0] io_alu_in2,
  input  [3:0]  io_aluop,
  output        io_zero,
  output [31:0] io_alu_result
);
  wire [31:0] add_result = io_alu_in1 + io_alu_in2; // @[alu.scala 13:31]
  wire [31:0] sub_result = io_alu_in1 - io_alu_in2; // @[alu.scala 14:31]
  wire [31:0] xor_result = io_alu_in1 ^ io_alu_in2; // @[alu.scala 15:31]
  wire [31:0] or_result = io_alu_in1 | io_alu_in2; // @[alu.scala 16:30]
  wire [31:0] and_result = io_alu_in1 & io_alu_in2; // @[alu.scala 17:31]
  wire [62:0] _GEN_0 = {{31'd0}, io_alu_in1}; // @[alu.scala 18:31]
  wire [62:0] sll_result = _GEN_0 << io_alu_in2[4:0]; // @[alu.scala 18:31]
  wire [31:0] srl_result = io_alu_in1 >> io_alu_in2[4:0]; // @[alu.scala 19:31]
  wire [31:0] sra_result = $signed(io_alu_in1) >>> io_alu_in2[4:0]; // @[alu.scala 20:60]
  wire  slt_result = $signed(io_alu_in1) < $signed(io_alu_in2); // @[alu.scala 21:38]
  wire  sltu_result = io_alu_in1 < io_alu_in2; // @[alu.scala 22:32]
  wire [31:0] _io_alu_result_T_1 = 4'h0 == io_aluop ? add_result : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_3 = 4'h1 == io_aluop ? sub_result : _io_alu_result_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_5 = 4'h2 == io_aluop ? xor_result : _io_alu_result_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_7 = 4'h3 == io_aluop ? or_result : _io_alu_result_T_5; // @[Mux.scala 81:58]
  wire [31:0] _io_alu_result_T_9 = 4'h4 == io_aluop ? and_result : _io_alu_result_T_7; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_11 = 4'h5 == io_aluop ? sll_result : {{31'd0}, _io_alu_result_T_9}; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_13 = 4'h6 == io_aluop ? {{31'd0}, srl_result} : _io_alu_result_T_11; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_15 = 4'h7 == io_aluop ? {{31'd0}, sra_result} : _io_alu_result_T_13; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_17 = 4'h8 == io_aluop ? {{62'd0}, slt_result} : _io_alu_result_T_15; // @[Mux.scala 81:58]
  wire [62:0] _io_alu_result_T_19 = 4'h9 == io_aluop ? {{62'd0}, sltu_result} : _io_alu_result_T_17; // @[Mux.scala 81:58]
  assign io_zero = io_alu_in1 == io_alu_in2; // @[alu.scala 24:26]
  assign io_alu_result = _io_alu_result_T_19[31:0]; // @[alu.scala 26:17]
endmodule
module TargetGen(
  input  [31:0] io_ex_pc,
  input  [31:0] io_imm,
  input  [31:0] io_alu_result,
  input         io_pcsel,
  input         io_rdsel,
  output [31:0] io_reg_pc,
  output [31:0] io_target_pc
);
  wire [31:0] _io_target_pc_T_1 = io_ex_pc + io_imm; // @[targetgen.scala 17:30]
  wire [31:0] _io_reg_pc_T_3 = io_ex_pc + 32'h4; // @[targetgen.scala 23:27]
  assign io_reg_pc = io_rdsel ? _io_target_pc_T_1 : _io_reg_pc_T_3; // @[targetgen.scala 20:26 21:15 23:15]
  assign io_target_pc = io_pcsel ? io_alu_result : _io_target_pc_T_1; // @[targetgen.scala 14:26 15:18 17:18]
endmodule
module Execute(
  input         clock,
  input         reset,
  input         io_csr_read,
  input         io_csr_write,
  input  [11:0] io_csr_address,
  input  [3:0]  io_ecause_in,
  input         io_exception_in,
  input         io_mret_in,
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
  output        io_mret_out,
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
  wire [31:0] aluSelect_io_rs1_data; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_rs2_data; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_imm; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_mem_aluresult; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_writedata; // @[execute.scala 69:25]
  wire  aluSelect_io_immsrc; // @[execute.scala 69:25]
  wire  aluSelect_io_islui; // @[execute.scala 69:25]
  wire [1:0] aluSelect_io_forward1; // @[execute.scala 69:25]
  wire [1:0] aluSelect_io_forward2; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_alu_in1; // @[execute.scala 69:25]
  wire [31:0] aluSelect_io_alu_in2; // @[execute.scala 69:25]
  wire [31:0] alu_io_alu_in1; // @[execute.scala 70:19]
  wire [31:0] alu_io_alu_in2; // @[execute.scala 70:19]
  wire [3:0] alu_io_aluop; // @[execute.scala 70:19]
  wire  alu_io_zero; // @[execute.scala 70:19]
  wire [31:0] alu_io_alu_result; // @[execute.scala 70:19]
  wire [31:0] targetGen_io_ex_pc; // @[execute.scala 71:25]
  wire [31:0] targetGen_io_imm; // @[execute.scala 71:25]
  wire [31:0] targetGen_io_alu_result; // @[execute.scala 71:25]
  wire  targetGen_io_pcsel; // @[execute.scala 71:25]
  wire  targetGen_io_rdsel; // @[execute.scala 71:25]
  wire [31:0] targetGen_io_reg_pc; // @[execute.scala 71:25]
  wire [31:0] targetGen_io_target_pc; // @[execute.scala 71:25]
  reg  mret_out_reg; // @[execute.scala 74:29]
  reg  wfi_out_reg; // @[execute.scala 75:28]
  reg [3:0] ecause_out_reg; // @[execute.scala 76:31]
  reg  exception_out_reg; // @[execute.scala 77:34]
  reg [31:0] csr_read_data_out_reg; // @[execute.scala 78:38]
  reg  csr_write_enable_out_reg; // @[execute.scala 79:41]
  reg [11:0] csr_write_address_out_reg; // @[execute.scala 80:42]
  reg [31:0] csr_write_data_out_reg; // @[execute.scala 81:39]
  reg [31:0] reg_pc_reg; // @[execute.scala 82:27]
  reg [31:0] target_pc_reg; // @[execute.scala 83:30]
  reg [31:0] mem_pc_reg; // @[execute.scala 84:27]
  reg  mem_isbranch_reg; // @[execute.scala 85:33]
  reg  mem_isjump_reg; // @[execute.scala 86:31]
  reg  mem_memread_reg; // @[execute.scala 87:32]
  reg  mem_memwrite_reg; // @[execute.scala 88:33]
  reg  mem_regwrite_reg; // @[execute.scala 89:33]
  reg [1:0] mem_memtoreg_reg; // @[execute.scala 90:33]
  reg  mem_zero_reg; // @[execute.scala 91:29]
  reg [31:0] mem_aluresult_reg; // @[execute.scala 92:34]
  reg [31:0] mem_rs2_data_reg; // @[execute.scala 93:33]
  reg [2:0] mem_funct3_reg; // @[execute.scala 94:31]
  reg [4:0] mem_rd_reg; // @[execute.scala 95:27]
  wire  _aluSelect_io_mem_aluresult_T = mem_memtoreg_reg == 2'h0; // @[execute.scala 104:21]
  wire  _aluSelect_io_mem_aluresult_T_1 = mem_memtoreg_reg == 2'h3; // @[execute.scala 105:21]
  wire [31:0] _aluSelect_io_mem_aluresult_T_2 = _aluSelect_io_mem_aluresult_T_1 ? csr_read_data_out_reg :
    mem_aluresult_reg; // @[Mux.scala 101:16]
  wire [31:0] _csr_write_temp_T = {27'h0,io_ex_rs1}; // @[Cat.scala 31:58]
  wire [31:0] csr_write_temp = io_immsrc ? _csr_write_temp_T : io_rs1_data; // @[execute.scala 124:27]
  wire [31:0] _csr_write_out_T = io_csr_read_data | csr_write_temp; // @[execute.scala 128:35]
  wire [31:0] _csr_write_out_T_2 = ~csr_write_temp; // @[execute.scala 130:37]
  wire [31:0] _csr_write_out_T_3 = io_csr_read_data & _csr_write_out_T_2; // @[execute.scala 130:35]
  wire [31:0] _csr_write_out_T_11 = 32'h2 == io_funct3 ? _csr_write_out_T : csr_write_temp; // @[Mux.scala 81:58]
  wire [31:0] _csr_write_out_T_13 = 32'h6 == io_funct3 ? _csr_write_out_T : _csr_write_out_T_11; // @[Mux.scala 81:58]
  wire  csr_exception = io_csr_read != io_readable | io_csr_write != io_writeable; // @[execute.scala 135:53]
  wire  _ecause_out_reg_T_1 = ~io_exception_in & csr_exception; // @[execute.scala 164:48]
  wire [31:0] _GEN_20 = io_ex_mem_flush ? 32'h0 : io_funct3; // @[execute.scala 138:25 159:24 182:24]
  wire [31:0] _GEN_22 = reset ? 32'h0 : _GEN_20; // @[execute.scala 94:{31,31}]
  AluSelect aluSelect ( // @[execute.scala 69:25]
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
  ALU alu ( // @[execute.scala 70:19]
    .io_alu_in1(alu_io_alu_in1),
    .io_alu_in2(alu_io_alu_in2),
    .io_aluop(alu_io_aluop),
    .io_zero(alu_io_zero),
    .io_alu_result(alu_io_alu_result)
  );
  TargetGen targetGen ( // @[execute.scala 71:25]
    .io_ex_pc(targetGen_io_ex_pc),
    .io_imm(targetGen_io_imm),
    .io_alu_result(targetGen_io_alu_result),
    .io_pcsel(targetGen_io_pcsel),
    .io_rdsel(targetGen_io_rdsel),
    .io_reg_pc(targetGen_io_reg_pc),
    .io_target_pc(targetGen_io_target_pc)
  );
  assign io_mem_pc = mem_pc_reg; // @[execute.scala 197:19]
  assign io_target_pc = target_pc_reg; // @[execute.scala 196:22]
  assign io_csr_read_data_out = csr_read_data_out_reg; // @[execute.scala 191:30]
  assign io_csr_write_enable_out = csr_write_enable_out_reg; // @[execute.scala 192:33]
  assign io_csr_write_address_out = csr_write_address_out_reg; // @[execute.scala 193:34]
  assign io_csr_write_data_out = csr_write_data_out_reg; // @[execute.scala 194:31]
  assign io_ecause_out = ecause_out_reg; // @[execute.scala 189:23]
  assign io_exception_out = exception_out_reg; // @[execute.scala 190:26]
  assign io_mret_out = mret_out_reg; // @[execute.scala 187:21]
  assign io_wfi_out = wfi_out_reg; // @[execute.scala 188:20]
  assign io_reg_pc = reg_pc_reg; // @[execute.scala 195:19]
  assign io_mem_isbranch = mem_isbranch_reg; // @[execute.scala 198:25]
  assign io_mem_isjump = mem_isjump_reg; // @[execute.scala 199:23]
  assign io_mem_memread = mem_memread_reg; // @[execute.scala 200:24]
  assign io_mem_memwrite = mem_memwrite_reg; // @[execute.scala 201:25]
  assign io_mem_regwrite = mem_regwrite_reg; // @[execute.scala 202:25]
  assign io_mem_memtoreg = mem_memtoreg_reg; // @[execute.scala 203:25]
  assign io_mem_zero = mem_zero_reg; // @[execute.scala 204:21]
  assign io_mem_aluresult = mem_aluresult_reg; // @[execute.scala 205:26]
  assign io_mem_rs2_data = mem_rs2_data_reg; // @[execute.scala 206:25]
  assign io_mem_funct3 = mem_funct3_reg; // @[execute.scala 207:23]
  assign io_mem_rd = mem_rd_reg; // @[execute.scala 208:19]
  assign aluSelect_io_rs1_data = io_rs1_data; // @[execute.scala 100:25]
  assign aluSelect_io_rs2_data = io_rs2_data; // @[execute.scala 101:25]
  assign aluSelect_io_imm = io_imm; // @[execute.scala 102:20]
  assign aluSelect_io_mem_aluresult = _aluSelect_io_mem_aluresult_T ? reg_pc_reg : _aluSelect_io_mem_aluresult_T_2; // @[Mux.scala 101:16]
  assign aluSelect_io_writedata = io_writedata; // @[execute.scala 107:26]
  assign aluSelect_io_immsrc = io_immsrc; // @[execute.scala 108:23]
  assign aluSelect_io_islui = io_islui; // @[execute.scala 109:22]
  assign aluSelect_io_forward1 = io_forward1; // @[execute.scala 110:25]
  assign aluSelect_io_forward2 = io_forward2; // @[execute.scala 111:25]
  assign alu_io_alu_in1 = aluSelect_io_alu_in1; // @[execute.scala 112:18]
  assign alu_io_alu_in2 = aluSelect_io_alu_in2; // @[execute.scala 113:18]
  assign alu_io_aluop = io_aluop; // @[execute.scala 114:16]
  assign targetGen_io_ex_pc = io_ex_pc; // @[execute.scala 115:22]
  assign targetGen_io_imm = io_imm; // @[execute.scala 116:20]
  assign targetGen_io_alu_result = alu_io_alu_result; // @[execute.scala 117:27]
  assign targetGen_io_pcsel = io_pcsel; // @[execute.scala 118:22]
  assign targetGen_io_rdsel = io_rdsel; // @[execute.scala 119:22]
  always @(posedge clock) begin
    if (reset) begin // @[execute.scala 74:29]
      mret_out_reg <= 1'h0; // @[execute.scala 74:29]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mret_out_reg <= 1'h0; // @[execute.scala 139:18]
    end else begin
      mret_out_reg <= io_mret_in; // @[execute.scala 162:22]
    end
    if (reset) begin // @[execute.scala 75:28]
      wfi_out_reg <= 1'h0; // @[execute.scala 75:28]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      wfi_out_reg <= 1'h0; // @[execute.scala 140:17]
    end else begin
      wfi_out_reg <= io_wfi_in; // @[execute.scala 163:21]
    end
    if (reset) begin // @[execute.scala 76:31]
      ecause_out_reg <= 4'h0; // @[execute.scala 76:31]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      ecause_out_reg <= 4'h0; // @[execute.scala 141:24]
    end else if (~io_exception_in & csr_exception) begin // @[execute.scala 164:30]
      ecause_out_reg <= 4'h2;
    end else begin
      ecause_out_reg <= io_ecause_in;
    end
    if (reset) begin // @[execute.scala 77:34]
      exception_out_reg <= 1'h0; // @[execute.scala 77:34]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      exception_out_reg <= 1'h0; // @[execute.scala 142:27]
    end else begin
      exception_out_reg <= _ecause_out_reg_T_1 | io_exception_in; // @[execute.scala 165:27]
    end
    if (reset) begin // @[execute.scala 78:38]
      csr_read_data_out_reg <= 32'h0; // @[execute.scala 78:38]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      csr_read_data_out_reg <= 32'h0; // @[execute.scala 143:31]
    end else begin
      csr_read_data_out_reg <= io_csr_read_data; // @[execute.scala 166:31]
    end
    if (reset) begin // @[execute.scala 79:41]
      csr_write_enable_out_reg <= 1'h0; // @[execute.scala 79:41]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      csr_write_enable_out_reg <= 1'h0; // @[execute.scala 144:34]
    end else begin
      csr_write_enable_out_reg <= io_csr_write; // @[execute.scala 167:34]
    end
    if (reset) begin // @[execute.scala 80:42]
      csr_write_address_out_reg <= 12'h0; // @[execute.scala 80:42]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      csr_write_address_out_reg <= 12'h0; // @[execute.scala 145:35]
    end else begin
      csr_write_address_out_reg <= io_csr_address; // @[execute.scala 168:35]
    end
    if (reset) begin // @[execute.scala 81:39]
      csr_write_data_out_reg <= 32'h0; // @[execute.scala 81:39]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      csr_write_data_out_reg <= 32'h0; // @[execute.scala 146:32]
    end else if (32'h7 == io_funct3) begin // @[Mux.scala 81:58]
      csr_write_data_out_reg <= _csr_write_out_T_3;
    end else if (32'h3 == io_funct3) begin // @[Mux.scala 81:58]
      csr_write_data_out_reg <= _csr_write_out_T_3;
    end else begin
      csr_write_data_out_reg <= _csr_write_out_T_13;
    end
    if (reset) begin // @[execute.scala 82:27]
      reg_pc_reg <= 32'h0; // @[execute.scala 82:27]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      reg_pc_reg <= 32'h0; // @[execute.scala 147:20]
    end else begin
      reg_pc_reg <= targetGen_io_reg_pc; // @[execute.scala 170:20]
    end
    if (reset) begin // @[execute.scala 83:30]
      target_pc_reg <= 32'h0; // @[execute.scala 83:30]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      target_pc_reg <= 32'h0; // @[execute.scala 148:23]
    end else begin
      target_pc_reg <= targetGen_io_target_pc; // @[execute.scala 171:23]
    end
    if (reset) begin // @[execute.scala 84:27]
      mem_pc_reg <= 32'h0; // @[execute.scala 84:27]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_pc_reg <= 32'h0; // @[execute.scala 149:20]
    end else begin
      mem_pc_reg <= io_ex_pc; // @[execute.scala 172:20]
    end
    if (reset) begin // @[execute.scala 85:33]
      mem_isbranch_reg <= 1'h0; // @[execute.scala 85:33]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_isbranch_reg <= 1'h0; // @[execute.scala 150:26]
    end else begin
      mem_isbranch_reg <= io_isbranch; // @[execute.scala 173:26]
    end
    if (reset) begin // @[execute.scala 86:31]
      mem_isjump_reg <= 1'h0; // @[execute.scala 86:31]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_isjump_reg <= 1'h0; // @[execute.scala 151:24]
    end else begin
      mem_isjump_reg <= io_isjump; // @[execute.scala 174:24]
    end
    if (reset) begin // @[execute.scala 87:32]
      mem_memread_reg <= 1'h0; // @[execute.scala 87:32]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_memread_reg <= 1'h0; // @[execute.scala 152:25]
    end else begin
      mem_memread_reg <= io_memread; // @[execute.scala 175:25]
    end
    if (reset) begin // @[execute.scala 88:33]
      mem_memwrite_reg <= 1'h0; // @[execute.scala 88:33]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_memwrite_reg <= 1'h0; // @[execute.scala 153:26]
    end else begin
      mem_memwrite_reg <= io_memwrite; // @[execute.scala 176:26]
    end
    if (reset) begin // @[execute.scala 89:33]
      mem_regwrite_reg <= 1'h0; // @[execute.scala 89:33]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_regwrite_reg <= 1'h0; // @[execute.scala 154:26]
    end else begin
      mem_regwrite_reg <= io_regwrite; // @[execute.scala 177:26]
    end
    if (reset) begin // @[execute.scala 90:33]
      mem_memtoreg_reg <= 2'h0; // @[execute.scala 90:33]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_memtoreg_reg <= 2'h0; // @[execute.scala 155:26]
    end else begin
      mem_memtoreg_reg <= io_memtoreg; // @[execute.scala 178:26]
    end
    if (reset) begin // @[execute.scala 91:29]
      mem_zero_reg <= 1'h0; // @[execute.scala 91:29]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_zero_reg <= 1'h0; // @[execute.scala 156:22]
    end else begin
      mem_zero_reg <= alu_io_zero; // @[execute.scala 179:22]
    end
    if (reset) begin // @[execute.scala 92:34]
      mem_aluresult_reg <= 32'h0; // @[execute.scala 92:34]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_aluresult_reg <= 32'h0; // @[execute.scala 157:27]
    end else begin
      mem_aluresult_reg <= alu_io_alu_result; // @[execute.scala 180:27]
    end
    if (reset) begin // @[execute.scala 93:33]
      mem_rs2_data_reg <= 32'h0; // @[execute.scala 93:33]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_rs2_data_reg <= 32'h0; // @[execute.scala 158:26]
    end else begin
      mem_rs2_data_reg <= io_rs2_data; // @[execute.scala 181:26]
    end
    mem_funct3_reg <= _GEN_22[2:0]; // @[execute.scala 94:{31,31}]
    if (reset) begin // @[execute.scala 95:27]
      mem_rd_reg <= 5'h0; // @[execute.scala 95:27]
    end else if (io_ex_mem_flush) begin // @[execute.scala 138:25]
      mem_rd_reg <= 5'h0; // @[execute.scala 160:20]
    end else begin
      mem_rd_reg <= io_ex_rd; // @[execute.scala 183:20]
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
  mret_out_reg = _RAND_0[0:0];
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
  wb_reg_pc_reg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  wb_readdata_reg = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  wb_aluresult_reg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  wb_memtoreg_reg = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  wb_regwrite_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  wb_rd_reg = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  pcsrc_reg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  branch_reg = _RAND_16[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Writeback(
  input  [31:0] io_csr_read_data_in,
  input  [31:0] io_wb_reg_pc,
  input  [31:0] io_wb_readdata,
  input  [31:0] io_wb_aluresult,
  input  [1:0]  io_wb_memtoreg,
  output [31:0] io_writedata
);
  wire [31:0] _io_writedata_T_1 = 2'h1 == io_wb_memtoreg ? io_wb_readdata : io_wb_reg_pc; // @[Mux.scala 81:58]
  wire [31:0] _io_writedata_T_3 = 2'h2 == io_wb_memtoreg ? io_wb_aluresult : _io_writedata_T_1; // @[Mux.scala 81:58]
  assign io_writedata = 2'h3 == io_wb_memtoreg ? io_csr_read_data_in : _io_writedata_T_3; // @[Mux.scala 81:58]
endmodule
module CSR(
  input         clock,
  input         reset,
  input         io_meip,
  input  [11:0] io_csr_address,
  input  [31:0] io_mem_pc,
  output [31:0] io_csr_read_data,
  output        io_readable,
  output        io_writeable,
  input         io_csr_write_enable,
  input  [11:0] io_csr_write_address,
  input  [31:0] io_csr_write_data,
  input         io_inst_retired,
  input         io_trapped,
  input         io_mret,
  input  [2:0]  io_ecause,
  input         io_interrupt,
  output        io_eip,
  output        io_tip,
  output        io_sip,
  output [31:0] io_trap_vector,
  output [31:0] io_mret_vector
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
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
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mcycle; // @[csr.scala 41:23]
  reg [63:0] minstret; // @[csr.scala 42:25]
  reg [31:0] mepc; // @[csr.scala 44:21]
  reg [31:0] mscratch; // @[csr.scala 45:25]
  reg [31:0] mtvec; // @[csr.scala 46:22]
  reg [3:0] mcause; // @[csr.scala 47:23]
  reg  minterrupt; // @[csr.scala 48:27]
  reg  pie; // @[csr.scala 50:20]
  reg  ie; // @[csr.scala 51:19]
  reg  meie; // @[csr.scala 52:21]
  reg  msie; // @[csr.scala 53:21]
  reg  msip; // @[csr.scala 54:21]
  reg  mtie; // @[csr.scala 55:21]
  reg  mtip; // @[csr.scala 56:21]
  wire [31:0] _csr_read_data_T_3 = {21'h0,3'h0,pie,2'h0,1'h0,ie,1'h0,2'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_5 = {20'h0,io_meip,2'h0,1'h0,mtip,1'h0,2'h0,msip,3'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_6 = {20'h0,meie,2'h0,1'h0,mtie,1'h0,2'h0,msie,3'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_8 = {mtvec[31:2],2'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_9 = {minterrupt,27'h0,mcause}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = 12'hb02 == io_csr_address ? minstret[31:0] : 32'h0; // @[csr.scala 141:21 69:26]
  wire [31:0] _GEN_2 = 12'hb00 == io_csr_address | 12'hb01 == io_csr_address ? mcycle[31:0] : _GEN_0; // @[csr.scala 136:21 69:26]
  wire  _GEN_3 = 12'hb00 == io_csr_address | 12'hb01 == io_csr_address | 12'hb02 == io_csr_address; // @[csr.scala 137:16 69:26]
  wire [31:0] _GEN_4 = 12'h343 == io_csr_address ? 32'h0 : _GEN_2; // @[csr.scala 131:21 69:26]
  wire  _GEN_5 = 12'h343 == io_csr_address | _GEN_3; // @[csr.scala 132:16 69:26]
  wire [31:0] _GEN_6 = 12'h342 == io_csr_address ? _csr_read_data_T_9 : _GEN_4; // @[csr.scala 126:21 69:26]
  wire  _GEN_7 = 12'h342 == io_csr_address | _GEN_5; // @[csr.scala 127:16 69:26]
  wire [31:0] _GEN_8 = 12'h341 == io_csr_address ? mepc : _GEN_6; // @[csr.scala 121:21 69:26]
  wire  _GEN_9 = 12'h341 == io_csr_address | _GEN_7; // @[csr.scala 122:16 69:26]
  wire [31:0] _GEN_10 = 12'h340 == io_csr_address ? mscratch : _GEN_8; // @[csr.scala 116:21 69:26]
  wire  _GEN_11 = 12'h340 == io_csr_address | _GEN_9; // @[csr.scala 117:16 69:26]
  wire [31:0] _GEN_12 = 12'h305 == io_csr_address ? _csr_read_data_T_8 : _GEN_10; // @[csr.scala 111:21 69:26]
  wire  _GEN_13 = 12'h305 == io_csr_address | _GEN_11; // @[csr.scala 112:16 69:26]
  wire [31:0] _GEN_14 = 12'h304 == io_csr_address ? _csr_read_data_T_6 : _GEN_12; // @[csr.scala 106:21 69:26]
  wire  _GEN_15 = 12'h304 == io_csr_address | _GEN_13; // @[csr.scala 107:16 69:26]
  wire [31:0] _GEN_16 = 12'h344 == io_csr_address ? _csr_read_data_T_5 : _GEN_14; // @[csr.scala 101:21 69:26]
  wire  _GEN_17 = 12'h344 == io_csr_address | _GEN_15; // @[csr.scala 102:16 69:26]
  wire [31:0] _GEN_18 = 12'h301 == io_csr_address ? 32'h40000100 : _GEN_16; // @[csr.scala 69:26 96:21]
  wire  _GEN_19 = 12'h301 == io_csr_address | _GEN_17; // @[csr.scala 69:26 97:16]
  wire [31:0] _GEN_20 = 12'h300 == io_csr_address ? _csr_read_data_T_3 : _GEN_18; // @[csr.scala 69:26 91:21]
  wire  _GEN_21 = 12'h300 == io_csr_address | _GEN_19; // @[csr.scala 69:26 92:16]
  wire [31:0] _GEN_22 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address ? 32'h0 : _GEN_20; // @[csr.scala 69:26 86:21]
  wire  _GEN_23 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address | _GEN_21; // @[csr.scala 69:26 87:16]
  wire  _GEN_24 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address ? 1'h0 : _GEN_21; // @[csr.scala 69:26 88:17]
  wire [31:0] _GEN_25 = 12'hc82 == io_csr_address ? minstret[63:32] : _GEN_22; // @[csr.scala 69:26 81:21]
  wire  _GEN_26 = 12'hc82 == io_csr_address | _GEN_23; // @[csr.scala 69:26 82:16]
  wire  _GEN_27 = 12'hc82 == io_csr_address ? 1'h0 : _GEN_24; // @[csr.scala 69:26 83:17]
  wire [31:0] _GEN_28 = 12'hc02 == io_csr_address ? minstret[31:0] : _GEN_25; // @[csr.scala 69:26 76:21]
  wire  _GEN_29 = 12'hc02 == io_csr_address | _GEN_26; // @[csr.scala 69:26 77:16]
  wire  _GEN_30 = 12'hc02 == io_csr_address ? 1'h0 : _GEN_27; // @[csr.scala 69:26 78:17]
  wire  _GEN_34 = io_mret ? pie : ie; // @[csr.scala 156:24 157:8 51:19]
  wire  _GEN_35 = io_mret | pie; // @[csr.scala 156:24 158:9 50:20]
  wire  _GEN_36 = io_trapped ? ie : _GEN_35; // @[csr.scala 150:20 151:9]
  wire  _GEN_37 = io_trapped ? 1'h0 : _GEN_34; // @[csr.scala 150:20 152:8]
  wire [31:0] _GEN_38 = io_trapped ? io_mem_pc : mepc; // @[csr.scala 150:20 153:10 44:21]
  wire  _GEN_39 = io_trapped ? io_interrupt : minterrupt; // @[csr.scala 150:20 154:16 48:27]
  wire [3:0] _GEN_40 = io_trapped ? {{1'd0}, io_ecause} : mcause; // @[csr.scala 150:20 155:12 47:23]
  wire [63:0] _mcycle_T_1 = mcycle + 64'h1; // @[csr.scala 161:20]
  wire [63:0] _minstret_T_1 = minstret + 64'h1; // @[csr.scala 163:26]
  wire [63:0] _GEN_41 = io_inst_retired ? _minstret_T_1 : minstret; // @[csr.scala 162:25 163:14 42:25]
  wire [31:0] _mtvec_T_1 = {io_csr_write_data[31:2],2'h0}; // @[Cat.scala 31:58]
  wire [63:0] _mcycle_T_2 = {32'h0,io_csr_write_data}; // @[Cat.scala 31:58]
  wire [63:0] _mcycle_T_3 = _mcycle_T_2 | mcycle; // @[csr.scala 198:52]
  wire [63:0] _minstret_T_3 = _mcycle_T_2 | minstret; // @[csr.scala 201:54]
  wire [63:0] _GEN_42 = 12'hb02 == io_csr_write_address ? _minstret_T_3 : _GEN_41; // @[csr.scala 168:34 201:18]
  wire [63:0] _GEN_43 = 12'hb00 == io_csr_write_address | 12'hb01 == io_csr_write_address ? _mcycle_T_3 : _mcycle_T_1; // @[csr.scala 161:10 168:34 198:16]
  wire [63:0] _GEN_44 = 12'hb00 == io_csr_write_address | 12'hb01 == io_csr_write_address ? _GEN_41 : _GEN_42; // @[csr.scala 168:34]
  wire [63:0] _GEN_46 = 12'h343 == io_csr_write_address ? _mcycle_T_1 : _GEN_43; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_47 = 12'h343 == io_csr_write_address ? _GEN_41 : _GEN_44; // @[csr.scala 168:34]
  wire  _GEN_48 = 12'h342 == io_csr_write_address ? io_csr_write_data[31] : _GEN_39; // @[csr.scala 168:34 191:20]
  wire [3:0] _GEN_49 = 12'h342 == io_csr_write_address ? io_csr_write_data[3:0] : _GEN_40; // @[csr.scala 168:34 192:16]
  wire [63:0] _GEN_51 = 12'h342 == io_csr_write_address ? _mcycle_T_1 : _GEN_46; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_52 = 12'h342 == io_csr_write_address ? _GEN_41 : _GEN_47; // @[csr.scala 168:34]
  wire [31:0] _GEN_53 = 12'h341 == io_csr_write_address ? io_csr_write_data : _GEN_38; // @[csr.scala 168:34 188:14]
  wire  _GEN_54 = 12'h341 == io_csr_write_address ? _GEN_39 : _GEN_48; // @[csr.scala 168:34]
  wire [3:0] _GEN_55 = 12'h341 == io_csr_write_address ? _GEN_40 : _GEN_49; // @[csr.scala 168:34]
  wire [63:0] _GEN_57 = 12'h341 == io_csr_write_address ? _mcycle_T_1 : _GEN_51; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_58 = 12'h341 == io_csr_write_address ? _GEN_41 : _GEN_52; // @[csr.scala 168:34]
  wire [31:0] _GEN_59 = 12'h340 == io_csr_write_address ? io_csr_write_data : mscratch; // @[csr.scala 168:34 185:18 45:25]
  wire [31:0] _GEN_60 = 12'h340 == io_csr_write_address ? _GEN_38 : _GEN_53; // @[csr.scala 168:34]
  wire  _GEN_61 = 12'h340 == io_csr_write_address ? _GEN_39 : _GEN_54; // @[csr.scala 168:34]
  wire [3:0] _GEN_62 = 12'h340 == io_csr_write_address ? _GEN_40 : _GEN_55; // @[csr.scala 168:34]
  wire [63:0] _GEN_64 = 12'h340 == io_csr_write_address ? _mcycle_T_1 : _GEN_57; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_65 = 12'h340 == io_csr_write_address ? _GEN_41 : _GEN_58; // @[csr.scala 168:34]
  wire [31:0] _GEN_66 = 12'h305 == io_csr_write_address ? _mtvec_T_1 : mtvec; // @[csr.scala 168:34 182:15 46:22]
  wire [31:0] _GEN_67 = 12'h305 == io_csr_write_address ? mscratch : _GEN_59; // @[csr.scala 168:34 45:25]
  wire [31:0] _GEN_68 = 12'h305 == io_csr_write_address ? _GEN_38 : _GEN_60; // @[csr.scala 168:34]
  wire  _GEN_69 = 12'h305 == io_csr_write_address ? _GEN_39 : _GEN_61; // @[csr.scala 168:34]
  wire [3:0] _GEN_70 = 12'h305 == io_csr_write_address ? _GEN_40 : _GEN_62; // @[csr.scala 168:34]
  wire [63:0] _GEN_72 = 12'h305 == io_csr_write_address ? _mcycle_T_1 : _GEN_64; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_73 = 12'h305 == io_csr_write_address ? _GEN_41 : _GEN_65; // @[csr.scala 168:34]
  wire  _GEN_74 = 12'h304 == io_csr_write_address ? io_csr_write_data[3] : msie; // @[csr.scala 168:34 177:14 53:21]
  wire  _GEN_75 = 12'h304 == io_csr_write_address ? io_csr_write_data[7] : mtie; // @[csr.scala 168:34 178:14 55:21]
  wire  _GEN_76 = 12'h304 == io_csr_write_address ? io_csr_write_data[11] : meie; // @[csr.scala 168:34 179:14 52:21]
  wire [31:0] _GEN_77 = 12'h304 == io_csr_write_address ? mtvec : _GEN_66; // @[csr.scala 168:34 46:22]
  wire [31:0] _GEN_78 = 12'h304 == io_csr_write_address ? mscratch : _GEN_67; // @[csr.scala 168:34 45:25]
  wire [31:0] _GEN_79 = 12'h304 == io_csr_write_address ? _GEN_38 : _GEN_68; // @[csr.scala 168:34]
  wire  _GEN_80 = 12'h304 == io_csr_write_address ? _GEN_39 : _GEN_69; // @[csr.scala 168:34]
  wire [3:0] _GEN_81 = 12'h304 == io_csr_write_address ? _GEN_40 : _GEN_70; // @[csr.scala 168:34]
  wire [63:0] _GEN_83 = 12'h304 == io_csr_write_address ? _mcycle_T_1 : _GEN_72; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_84 = 12'h304 == io_csr_write_address ? _GEN_41 : _GEN_73; // @[csr.scala 168:34]
  assign io_csr_read_data = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address ? mcycle[31:0] : _GEN_28; // @[csr.scala 69:26 71:21]
  assign io_readable = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address | _GEN_29; // @[csr.scala 69:26 72:16]
  assign io_writeable = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address ? 1'h0 : _GEN_30; // @[csr.scala 69:26 73:17]
  assign io_eip = ie & meie & io_meip; // @[csr.scala 58:24]
  assign io_tip = ie & mtie & mtip; // @[csr.scala 59:24]
  assign io_sip = ie & msie & msip; // @[csr.scala 60:24]
  assign io_trap_vector = mtvec; // @[csr.scala 62:18]
  assign io_mret_vector = mepc; // @[csr.scala 63:18]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 41:23]
      mcycle <= 64'h0; // @[csr.scala 41:23]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
      end else begin
        mcycle <= _GEN_83;
      end
    end else begin
      mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
    end
    if (reset) begin // @[csr.scala 42:25]
      minstret <= 64'h0; // @[csr.scala 42:25]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        minstret <= _GEN_41;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        minstret <= _GEN_41;
      end else begin
        minstret <= _GEN_84;
      end
    end else begin
      minstret <= _GEN_41;
    end
    if (reset) begin // @[csr.scala 44:21]
      mepc <= 32'h0; // @[csr.scala 44:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mepc <= _GEN_38;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mepc <= _GEN_38;
      end else begin
        mepc <= _GEN_79;
      end
    end else begin
      mepc <= _GEN_38;
    end
    if (reset) begin // @[csr.scala 45:25]
      mscratch <= 32'h0; // @[csr.scala 45:25]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mscratch <= _GEN_78;
        end
      end
    end
    if (reset) begin // @[csr.scala 46:22]
      mtvec <= 32'h0; // @[csr.scala 46:22]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mtvec <= _GEN_77;
        end
      end
    end
    if (reset) begin // @[csr.scala 47:23]
      mcause <= 4'h0; // @[csr.scala 47:23]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcause <= _GEN_40;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcause <= _GEN_40;
      end else begin
        mcause <= _GEN_81;
      end
    end else begin
      mcause <= _GEN_40;
    end
    if (reset) begin // @[csr.scala 48:27]
      minterrupt <= 1'h0; // @[csr.scala 48:27]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        minterrupt <= _GEN_39;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        minterrupt <= _GEN_39;
      end else begin
        minterrupt <= _GEN_80;
      end
    end else begin
      minterrupt <= _GEN_39;
    end
    if (reset) begin // @[csr.scala 50:20]
      pie <= 1'h0; // @[csr.scala 50:20]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        pie <= io_csr_write_data[7]; // @[csr.scala 171:13]
      end else begin
        pie <= _GEN_36;
      end
    end else begin
      pie <= _GEN_36;
    end
    if (reset) begin // @[csr.scala 51:19]
      ie <= 1'h0; // @[csr.scala 51:19]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        ie <= io_csr_write_data[3]; // @[csr.scala 170:12]
      end else begin
        ie <= _GEN_37;
      end
    end else begin
      ie <= _GEN_37;
    end
    if (reset) begin // @[csr.scala 52:21]
      meie <= 1'h0; // @[csr.scala 52:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          meie <= _GEN_76;
        end
      end
    end
    if (reset) begin // @[csr.scala 53:21]
      msie <= 1'h0; // @[csr.scala 53:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          msie <= _GEN_74;
        end
      end
    end
    if (reset) begin // @[csr.scala 54:21]
      msip <= 1'h0; // @[csr.scala 54:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
          msip <= io_csr_write_data[3]; // @[csr.scala 174:14]
        end
      end
    end
    if (reset) begin // @[csr.scala 55:21]
      mtie <= 1'h0; // @[csr.scala 55:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mtie <= _GEN_75;
        end
      end
    end
    if (reset) begin // @[csr.scala 56:21]
      mtip <= 1'h0; // @[csr.scala 56:21]
    end else begin
      mtip <= mcycle >= 64'h7fffffff; // @[csr.scala 205:8]
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
  _RAND_0 = {2{`RANDOM}};
  mcycle = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  minstret = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mscratch = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  mtvec = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mcause = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  minterrupt = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  pie = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  ie = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  meie = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  msie = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  msip = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mtie = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mtip = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Hazard(
  output        io_predict,
  output        io_pc_stall,
  output        io_if_id_stall,
  output        io_if_id_flush,
  input         io_memread,
  input         io_use_rs1,
  input         io_use_rs2,
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_ex_rd,
  input         io_ex_use_rs1,
  input         io_ex_use_rs2,
  input  [4:0]  io_ex_rs1,
  input  [4:0]  io_ex_rs2,
  input  [31:0] io_ex_pc,
  output        io_id_ex_flush,
  input  [4:0]  io_mem_rd,
  input         io_mem_regwrite,
  input  [31:0] io_mem_pc,
  input  [31:0] io_target_pc,
  output [1:0]  io_forward1,
  output [1:0]  io_forward2,
  output        io_ex_mem_flush,
  input  [4:0]  io_wb_rd,
  input         io_wb_regwrite,
  input         io_pcsrc,
  input         io_trapped,
  input         io_mret,
  output        io_mem_wb_flush
);
  wire  _T_5 = io_mem_rd != 5'h0; // @[hazard.scala 48:97]
  wire  _T_12 = io_wb_rd != 5'h0; // @[hazard.scala 50:100]
  wire [1:0] _GEN_0 = io_ex_use_rs1 & io_ex_rs1 == io_wb_rd & io_wb_regwrite & io_wb_rd != 5'h0 ? 2'h2 : 2'h0; // @[hazard.scala 50:109 51:14 53:14]
  wire [1:0] _GEN_2 = io_ex_use_rs2 & io_ex_rs2 == io_wb_rd & io_wb_regwrite & _T_12 ? 2'h2 : 2'h0; // @[hazard.scala 58:109 59:14 61:14]
  wire  hazard = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  wire  _T_30 = io_pcsrc & io_target_pc != io_ex_pc; // @[hazard.scala 79:25]
  wire [31:0] _T_33 = io_mem_pc + 32'h4; // @[hazard.scala 83:52]
  wire  controlHazard = ~io_pcsrc & io_ex_pc != _T_33 | _T_30; // @[hazard.scala 83:60 84:19]
  wire  _io_if_id_flush_T_1 = controlHazard | io_trapped; // @[hazard.scala 92:35]
  assign io_predict = io_pcsrc & io_target_pc == io_ex_pc; // @[hazard.scala 87:25]
  assign io_pc_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  assign io_if_id_stall = io_memread & (io_use_rs1 & io_id_rs1 == io_ex_rd | io_use_rs2 & io_id_rs2 == io_ex_rd); // @[hazard.scala 69:35]
  assign io_if_id_flush = controlHazard | io_trapped | io_mret; // @[hazard.scala 92:57]
  assign io_id_ex_flush = hazard | controlHazard | io_trapped | io_mret; // @[hazard.scala 95:67]
  assign io_forward1 = io_ex_use_rs1 & io_ex_rs1 == io_mem_rd & io_mem_regwrite & io_mem_rd != 5'h0 ? 2'h1 : _GEN_0; // @[hazard.scala 48:106 49:14]
  assign io_forward2 = io_ex_use_rs2 & io_ex_rs2 == io_mem_rd & io_mem_regwrite & _T_5 ? 2'h1 : _GEN_2; // @[hazard.scala 56:106 57:14]
  assign io_ex_mem_flush = _io_if_id_flush_T_1 | io_mret; // @[hazard.scala 93:58]
  assign io_mem_wb_flush = io_trapped | io_mret; // @[hazard.scala 96:41]
endmodule
module core(
  input         clock,
  input         reset,
  input         io_meip,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address,
  output        io_load_store_unsigned,
  output [1:0]  io_memory_size,
  output [31:0] io_memory_address,
  output [31:0] io_memory_write_data,
  input  [31:0] io_memory_read_data,
  output        io_memory_read,
  output        io_memory_write
);
  wire  fetch_clock; // @[core.scala 18:21]
  wire  fetch_reset; // @[core.scala 18:21]
  wire [31:0] fetch_io_trap_vector; // @[core.scala 18:21]
  wire [31:0] fetch_io_mret_vector; // @[core.scala 18:21]
  wire [31:0] fetch_io_target_pc; // @[core.scala 18:21]
  wire [31:0] fetch_io_mem_pc; // @[core.scala 18:21]
  wire  fetch_io_pcsrc; // @[core.scala 18:21]
  wire  fetch_io_branch; // @[core.scala 18:21]
  wire  fetch_io_trap; // @[core.scala 18:21]
  wire  fetch_io_mret; // @[core.scala 18:21]
  wire  fetch_io_pc_stall; // @[core.scala 18:21]
  wire  fetch_io_if_id_stall; // @[core.scala 18:21]
  wire  fetch_io_if_id_flush; // @[core.scala 18:21]
  wire  fetch_io_predict; // @[core.scala 18:21]
  wire [31:0] fetch_io_id_pc; // @[core.scala 18:21]
  wire [31:0] fetch_io_inst; // @[core.scala 18:21]
  wire [31:0] fetch_io_fetch_data; // @[core.scala 18:21]
  wire [31:0] fetch_io_fetch_address; // @[core.scala 18:21]
  wire  decode_clock; // @[core.scala 19:22]
  wire  decode_reset; // @[core.scala 19:22]
  wire [31:0] decode_io_id_pc; // @[core.scala 19:22]
  wire [31:0] decode_io_inst; // @[core.scala 19:22]
  wire  decode_io_csr_read; // @[core.scala 19:22]
  wire  decode_io_csr_write; // @[core.scala 19:22]
  wire [11:0] decode_io_csr_address; // @[core.scala 19:22]
  wire [3:0] decode_io_ecause_out; // @[core.scala 19:22]
  wire  decode_io_exception_out; // @[core.scala 19:22]
  wire  decode_io_mret_out; // @[core.scala 19:22]
  wire  decode_io_wfi_out; // @[core.scala 19:22]
  wire [31:0] decode_io_ex_pc; // @[core.scala 19:22]
  wire [3:0] decode_io_aluop; // @[core.scala 19:22]
  wire  decode_io_immsrc; // @[core.scala 19:22]
  wire  decode_io_isbranch; // @[core.scala 19:22]
  wire  decode_io_memread; // @[core.scala 19:22]
  wire  decode_io_memwrite; // @[core.scala 19:22]
  wire  decode_io_regwrite; // @[core.scala 19:22]
  wire [1:0] decode_io_memtoreg; // @[core.scala 19:22]
  wire  decode_io_pcsel; // @[core.scala 19:22]
  wire  decode_io_rdsel; // @[core.scala 19:22]
  wire  decode_io_isjump; // @[core.scala 19:22]
  wire  decode_io_islui; // @[core.scala 19:22]
  wire [31:0] decode_io_rs1_data; // @[core.scala 19:22]
  wire [31:0] decode_io_rs2_data; // @[core.scala 19:22]
  wire [31:0] decode_io_imm; // @[core.scala 19:22]
  wire [31:0] decode_io_funct3; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rs1; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rs2; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rd; // @[core.scala 19:22]
  wire  decode_io_ex_use_rs1; // @[core.scala 19:22]
  wire  decode_io_ex_use_rs2; // @[core.scala 19:22]
  wire [4:0] decode_io_wb_rd; // @[core.scala 19:22]
  wire  decode_io_wb_regwrite; // @[core.scala 19:22]
  wire [31:0] decode_io_writedata; // @[core.scala 19:22]
  wire  decode_io_id_ex_flush; // @[core.scala 19:22]
  wire [4:0] decode_io_id_rs1; // @[core.scala 19:22]
  wire [4:0] decode_io_id_rs2; // @[core.scala 19:22]
  wire  decode_io_use_rs1; // @[core.scala 19:22]
  wire  decode_io_use_rs2; // @[core.scala 19:22]
  wire  execute_clock; // @[core.scala 20:23]
  wire  execute_reset; // @[core.scala 20:23]
  wire  execute_io_csr_read; // @[core.scala 20:23]
  wire  execute_io_csr_write; // @[core.scala 20:23]
  wire [11:0] execute_io_csr_address; // @[core.scala 20:23]
  wire [3:0] execute_io_ecause_in; // @[core.scala 20:23]
  wire  execute_io_exception_in; // @[core.scala 20:23]
  wire  execute_io_mret_in; // @[core.scala 20:23]
  wire  execute_io_wfi_in; // @[core.scala 20:23]
  wire [31:0] execute_io_ex_pc; // @[core.scala 20:23]
  wire [3:0] execute_io_aluop; // @[core.scala 20:23]
  wire  execute_io_immsrc; // @[core.scala 20:23]
  wire  execute_io_isbranch; // @[core.scala 20:23]
  wire  execute_io_memread; // @[core.scala 20:23]
  wire  execute_io_memwrite; // @[core.scala 20:23]
  wire  execute_io_regwrite; // @[core.scala 20:23]
  wire [1:0] execute_io_memtoreg; // @[core.scala 20:23]
  wire  execute_io_pcsel; // @[core.scala 20:23]
  wire  execute_io_rdsel; // @[core.scala 20:23]
  wire  execute_io_isjump; // @[core.scala 20:23]
  wire  execute_io_islui; // @[core.scala 20:23]
  wire [31:0] execute_io_rs1_data; // @[core.scala 20:23]
  wire [31:0] execute_io_rs2_data; // @[core.scala 20:23]
  wire [31:0] execute_io_imm; // @[core.scala 20:23]
  wire [31:0] execute_io_funct3; // @[core.scala 20:23]
  wire [4:0] execute_io_ex_rs1; // @[core.scala 20:23]
  wire [4:0] execute_io_ex_rd; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_pc; // @[core.scala 20:23]
  wire [31:0] execute_io_target_pc; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_read_data; // @[core.scala 20:23]
  wire  execute_io_readable; // @[core.scala 20:23]
  wire  execute_io_writeable; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_read_data_out; // @[core.scala 20:23]
  wire  execute_io_csr_write_enable_out; // @[core.scala 20:23]
  wire [11:0] execute_io_csr_write_address_out; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_write_data_out; // @[core.scala 20:23]
  wire [3:0] execute_io_ecause_out; // @[core.scala 20:23]
  wire  execute_io_exception_out; // @[core.scala 20:23]
  wire  execute_io_mret_out; // @[core.scala 20:23]
  wire  execute_io_wfi_out; // @[core.scala 20:23]
  wire [31:0] execute_io_reg_pc; // @[core.scala 20:23]
  wire  execute_io_mem_isbranch; // @[core.scala 20:23]
  wire  execute_io_mem_isjump; // @[core.scala 20:23]
  wire  execute_io_mem_memread; // @[core.scala 20:23]
  wire  execute_io_mem_memwrite; // @[core.scala 20:23]
  wire  execute_io_mem_regwrite; // @[core.scala 20:23]
  wire [1:0] execute_io_mem_memtoreg; // @[core.scala 20:23]
  wire  execute_io_mem_zero; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_aluresult; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_rs2_data; // @[core.scala 20:23]
  wire [2:0] execute_io_mem_funct3; // @[core.scala 20:23]
  wire [4:0] execute_io_mem_rd; // @[core.scala 20:23]
  wire [31:0] execute_io_writedata; // @[core.scala 20:23]
  wire [1:0] execute_io_forward1; // @[core.scala 20:23]
  wire [1:0] execute_io_forward2; // @[core.scala 20:23]
  wire  execute_io_ex_mem_flush; // @[core.scala 20:23]
  wire  memory_clock; // @[core.scala 21:22]
  wire  memory_reset; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_read_data_in; // @[core.scala 21:22]
  wire  memory_io_csr_write_enable_in; // @[core.scala 21:22]
  wire [11:0] memory_io_csr_write_address_in; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_write_data_in; // @[core.scala 21:22]
  wire [3:0] memory_io_ecause_in; // @[core.scala 21:22]
  wire  memory_io_exception_in; // @[core.scala 21:22]
  wire  memory_io_mret_in; // @[core.scala 21:22]
  wire  memory_io_wfi_in; // @[core.scala 21:22]
  wire [31:0] memory_io_reg_pc; // @[core.scala 21:22]
  wire  memory_io_mem_isbranch; // @[core.scala 21:22]
  wire  memory_io_mem_isjump; // @[core.scala 21:22]
  wire  memory_io_mem_memread; // @[core.scala 21:22]
  wire  memory_io_mem_memwrite; // @[core.scala 21:22]
  wire  memory_io_mem_regwrite; // @[core.scala 21:22]
  wire [1:0] memory_io_mem_memtoreg; // @[core.scala 21:22]
  wire  memory_io_mem_zero; // @[core.scala 21:22]
  wire [31:0] memory_io_mem_aluresult; // @[core.scala 21:22]
  wire [31:0] memory_io_mem_rs2_data; // @[core.scala 21:22]
  wire [2:0] memory_io_mem_funct3; // @[core.scala 21:22]
  wire [4:0] memory_io_mem_rd; // @[core.scala 21:22]
  wire  memory_io_sip; // @[core.scala 21:22]
  wire  memory_io_tip; // @[core.scala 21:22]
  wire  memory_io_eip; // @[core.scala 21:22]
  wire  memory_io_csr_write_enable_out; // @[core.scala 21:22]
  wire [11:0] memory_io_csr_write_address_out; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_write_data_out; // @[core.scala 21:22]
  wire [3:0] memory_io_ecause_out; // @[core.scala 21:22]
  wire  memory_io_trapped; // @[core.scala 21:22]
  wire  memory_io_interrupt; // @[core.scala 21:22]
  wire  memory_io_inst_retired; // @[core.scala 21:22]
  wire  memory_io_mret_out; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_read_data_out; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_reg_pc; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_readdata; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_aluresult; // @[core.scala 21:22]
  wire [1:0] memory_io_wb_memtoreg; // @[core.scala 21:22]
  wire  memory_io_wb_regwrite; // @[core.scala 21:22]
  wire [4:0] memory_io_wb_rd; // @[core.scala 21:22]
  wire  memory_io_pcsrc; // @[core.scala 21:22]
  wire  memory_io_branch; // @[core.scala 21:22]
  wire  memory_io_mem_wb_flush; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_read_data; // @[core.scala 21:22]
  wire  memory_io_load_store_unsigned; // @[core.scala 21:22]
  wire [1:0] memory_io_memory_size; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_address; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_write_data; // @[core.scala 21:22]
  wire  memory_io_memory_read; // @[core.scala 21:22]
  wire  memory_io_memory_write; // @[core.scala 21:22]
  wire [31:0] writeback_io_csr_read_data_in; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_reg_pc; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_readdata; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_aluresult; // @[core.scala 22:25]
  wire [1:0] writeback_io_wb_memtoreg; // @[core.scala 22:25]
  wire [31:0] writeback_io_writedata; // @[core.scala 22:25]
  wire  csr_clock; // @[core.scala 23:19]
  wire  csr_reset; // @[core.scala 23:19]
  wire  csr_io_meip; // @[core.scala 23:19]
  wire [11:0] csr_io_csr_address; // @[core.scala 23:19]
  wire [31:0] csr_io_mem_pc; // @[core.scala 23:19]
  wire [31:0] csr_io_csr_read_data; // @[core.scala 23:19]
  wire  csr_io_readable; // @[core.scala 23:19]
  wire  csr_io_writeable; // @[core.scala 23:19]
  wire  csr_io_csr_write_enable; // @[core.scala 23:19]
  wire [11:0] csr_io_csr_write_address; // @[core.scala 23:19]
  wire [31:0] csr_io_csr_write_data; // @[core.scala 23:19]
  wire  csr_io_inst_retired; // @[core.scala 23:19]
  wire  csr_io_trapped; // @[core.scala 23:19]
  wire  csr_io_mret; // @[core.scala 23:19]
  wire [2:0] csr_io_ecause; // @[core.scala 23:19]
  wire  csr_io_interrupt; // @[core.scala 23:19]
  wire  csr_io_eip; // @[core.scala 23:19]
  wire  csr_io_tip; // @[core.scala 23:19]
  wire  csr_io_sip; // @[core.scala 23:19]
  wire [31:0] csr_io_trap_vector; // @[core.scala 23:19]
  wire [31:0] csr_io_mret_vector; // @[core.scala 23:19]
  wire  hazard_io_predict; // @[core.scala 24:22]
  wire  hazard_io_pc_stall; // @[core.scala 24:22]
  wire  hazard_io_if_id_stall; // @[core.scala 24:22]
  wire  hazard_io_if_id_flush; // @[core.scala 24:22]
  wire  hazard_io_memread; // @[core.scala 24:22]
  wire  hazard_io_use_rs1; // @[core.scala 24:22]
  wire  hazard_io_use_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_id_rs1; // @[core.scala 24:22]
  wire [4:0] hazard_io_id_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rd; // @[core.scala 24:22]
  wire  hazard_io_ex_use_rs1; // @[core.scala 24:22]
  wire  hazard_io_ex_use_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rs1; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rs2; // @[core.scala 24:22]
  wire [31:0] hazard_io_ex_pc; // @[core.scala 24:22]
  wire  hazard_io_id_ex_flush; // @[core.scala 24:22]
  wire [4:0] hazard_io_mem_rd; // @[core.scala 24:22]
  wire  hazard_io_mem_regwrite; // @[core.scala 24:22]
  wire [31:0] hazard_io_mem_pc; // @[core.scala 24:22]
  wire [31:0] hazard_io_target_pc; // @[core.scala 24:22]
  wire [1:0] hazard_io_forward1; // @[core.scala 24:22]
  wire [1:0] hazard_io_forward2; // @[core.scala 24:22]
  wire  hazard_io_ex_mem_flush; // @[core.scala 24:22]
  wire [4:0] hazard_io_wb_rd; // @[core.scala 24:22]
  wire  hazard_io_wb_regwrite; // @[core.scala 24:22]
  wire  hazard_io_pcsrc; // @[core.scala 24:22]
  wire  hazard_io_trapped; // @[core.scala 24:22]
  wire  hazard_io_mret; // @[core.scala 24:22]
  wire  hazard_io_mem_wb_flush; // @[core.scala 24:22]
  Fetch fetch ( // @[core.scala 18:21]
    .clock(fetch_clock),
    .reset(fetch_reset),
    .io_trap_vector(fetch_io_trap_vector),
    .io_mret_vector(fetch_io_mret_vector),
    .io_target_pc(fetch_io_target_pc),
    .io_mem_pc(fetch_io_mem_pc),
    .io_pcsrc(fetch_io_pcsrc),
    .io_branch(fetch_io_branch),
    .io_trap(fetch_io_trap),
    .io_mret(fetch_io_mret),
    .io_pc_stall(fetch_io_pc_stall),
    .io_if_id_stall(fetch_io_if_id_stall),
    .io_if_id_flush(fetch_io_if_id_flush),
    .io_predict(fetch_io_predict),
    .io_id_pc(fetch_io_id_pc),
    .io_inst(fetch_io_inst),
    .io_fetch_data(fetch_io_fetch_data),
    .io_fetch_address(fetch_io_fetch_address)
  );
  Decode decode ( // @[core.scala 19:22]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_id_pc(decode_io_id_pc),
    .io_inst(decode_io_inst),
    .io_csr_read(decode_io_csr_read),
    .io_csr_write(decode_io_csr_write),
    .io_csr_address(decode_io_csr_address),
    .io_ecause_out(decode_io_ecause_out),
    .io_exception_out(decode_io_exception_out),
    .io_mret_out(decode_io_mret_out),
    .io_wfi_out(decode_io_wfi_out),
    .io_ex_pc(decode_io_ex_pc),
    .io_aluop(decode_io_aluop),
    .io_immsrc(decode_io_immsrc),
    .io_isbranch(decode_io_isbranch),
    .io_memread(decode_io_memread),
    .io_memwrite(decode_io_memwrite),
    .io_regwrite(decode_io_regwrite),
    .io_memtoreg(decode_io_memtoreg),
    .io_pcsel(decode_io_pcsel),
    .io_rdsel(decode_io_rdsel),
    .io_isjump(decode_io_isjump),
    .io_islui(decode_io_islui),
    .io_rs1_data(decode_io_rs1_data),
    .io_rs2_data(decode_io_rs2_data),
    .io_imm(decode_io_imm),
    .io_funct3(decode_io_funct3),
    .io_ex_rs1(decode_io_ex_rs1),
    .io_ex_rs2(decode_io_ex_rs2),
    .io_ex_rd(decode_io_ex_rd),
    .io_ex_use_rs1(decode_io_ex_use_rs1),
    .io_ex_use_rs2(decode_io_ex_use_rs2),
    .io_wb_rd(decode_io_wb_rd),
    .io_wb_regwrite(decode_io_wb_regwrite),
    .io_writedata(decode_io_writedata),
    .io_id_ex_flush(decode_io_id_ex_flush),
    .io_id_rs1(decode_io_id_rs1),
    .io_id_rs2(decode_io_id_rs2),
    .io_use_rs1(decode_io_use_rs1),
    .io_use_rs2(decode_io_use_rs2)
  );
  Execute execute ( // @[core.scala 20:23]
    .clock(execute_clock),
    .reset(execute_reset),
    .io_csr_read(execute_io_csr_read),
    .io_csr_write(execute_io_csr_write),
    .io_csr_address(execute_io_csr_address),
    .io_ecause_in(execute_io_ecause_in),
    .io_exception_in(execute_io_exception_in),
    .io_mret_in(execute_io_mret_in),
    .io_wfi_in(execute_io_wfi_in),
    .io_ex_pc(execute_io_ex_pc),
    .io_aluop(execute_io_aluop),
    .io_immsrc(execute_io_immsrc),
    .io_isbranch(execute_io_isbranch),
    .io_memread(execute_io_memread),
    .io_memwrite(execute_io_memwrite),
    .io_regwrite(execute_io_regwrite),
    .io_memtoreg(execute_io_memtoreg),
    .io_pcsel(execute_io_pcsel),
    .io_rdsel(execute_io_rdsel),
    .io_isjump(execute_io_isjump),
    .io_islui(execute_io_islui),
    .io_rs1_data(execute_io_rs1_data),
    .io_rs2_data(execute_io_rs2_data),
    .io_imm(execute_io_imm),
    .io_funct3(execute_io_funct3),
    .io_ex_rs1(execute_io_ex_rs1),
    .io_ex_rd(execute_io_ex_rd),
    .io_mem_pc(execute_io_mem_pc),
    .io_target_pc(execute_io_target_pc),
    .io_csr_read_data(execute_io_csr_read_data),
    .io_readable(execute_io_readable),
    .io_writeable(execute_io_writeable),
    .io_csr_read_data_out(execute_io_csr_read_data_out),
    .io_csr_write_enable_out(execute_io_csr_write_enable_out),
    .io_csr_write_address_out(execute_io_csr_write_address_out),
    .io_csr_write_data_out(execute_io_csr_write_data_out),
    .io_ecause_out(execute_io_ecause_out),
    .io_exception_out(execute_io_exception_out),
    .io_mret_out(execute_io_mret_out),
    .io_wfi_out(execute_io_wfi_out),
    .io_reg_pc(execute_io_reg_pc),
    .io_mem_isbranch(execute_io_mem_isbranch),
    .io_mem_isjump(execute_io_mem_isjump),
    .io_mem_memread(execute_io_mem_memread),
    .io_mem_memwrite(execute_io_mem_memwrite),
    .io_mem_regwrite(execute_io_mem_regwrite),
    .io_mem_memtoreg(execute_io_mem_memtoreg),
    .io_mem_zero(execute_io_mem_zero),
    .io_mem_aluresult(execute_io_mem_aluresult),
    .io_mem_rs2_data(execute_io_mem_rs2_data),
    .io_mem_funct3(execute_io_mem_funct3),
    .io_mem_rd(execute_io_mem_rd),
    .io_writedata(execute_io_writedata),
    .io_forward1(execute_io_forward1),
    .io_forward2(execute_io_forward2),
    .io_ex_mem_flush(execute_io_ex_mem_flush)
  );
  Memory memory ( // @[core.scala 21:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_csr_read_data_in(memory_io_csr_read_data_in),
    .io_csr_write_enable_in(memory_io_csr_write_enable_in),
    .io_csr_write_address_in(memory_io_csr_write_address_in),
    .io_csr_write_data_in(memory_io_csr_write_data_in),
    .io_ecause_in(memory_io_ecause_in),
    .io_exception_in(memory_io_exception_in),
    .io_mret_in(memory_io_mret_in),
    .io_wfi_in(memory_io_wfi_in),
    .io_reg_pc(memory_io_reg_pc),
    .io_mem_isbranch(memory_io_mem_isbranch),
    .io_mem_isjump(memory_io_mem_isjump),
    .io_mem_memread(memory_io_mem_memread),
    .io_mem_memwrite(memory_io_mem_memwrite),
    .io_mem_regwrite(memory_io_mem_regwrite),
    .io_mem_memtoreg(memory_io_mem_memtoreg),
    .io_mem_zero(memory_io_mem_zero),
    .io_mem_aluresult(memory_io_mem_aluresult),
    .io_mem_rs2_data(memory_io_mem_rs2_data),
    .io_mem_funct3(memory_io_mem_funct3),
    .io_mem_rd(memory_io_mem_rd),
    .io_sip(memory_io_sip),
    .io_tip(memory_io_tip),
    .io_eip(memory_io_eip),
    .io_csr_write_enable_out(memory_io_csr_write_enable_out),
    .io_csr_write_address_out(memory_io_csr_write_address_out),
    .io_csr_write_data_out(memory_io_csr_write_data_out),
    .io_ecause_out(memory_io_ecause_out),
    .io_trapped(memory_io_trapped),
    .io_interrupt(memory_io_interrupt),
    .io_inst_retired(memory_io_inst_retired),
    .io_mret_out(memory_io_mret_out),
    .io_csr_read_data_out(memory_io_csr_read_data_out),
    .io_wb_reg_pc(memory_io_wb_reg_pc),
    .io_wb_readdata(memory_io_wb_readdata),
    .io_wb_aluresult(memory_io_wb_aluresult),
    .io_wb_memtoreg(memory_io_wb_memtoreg),
    .io_wb_regwrite(memory_io_wb_regwrite),
    .io_wb_rd(memory_io_wb_rd),
    .io_pcsrc(memory_io_pcsrc),
    .io_branch(memory_io_branch),
    .io_mem_wb_flush(memory_io_mem_wb_flush),
    .io_memory_read_data(memory_io_memory_read_data),
    .io_load_store_unsigned(memory_io_load_store_unsigned),
    .io_memory_size(memory_io_memory_size),
    .io_memory_address(memory_io_memory_address),
    .io_memory_write_data(memory_io_memory_write_data),
    .io_memory_read(memory_io_memory_read),
    .io_memory_write(memory_io_memory_write)
  );
  Writeback writeback ( // @[core.scala 22:25]
    .io_csr_read_data_in(writeback_io_csr_read_data_in),
    .io_wb_reg_pc(writeback_io_wb_reg_pc),
    .io_wb_readdata(writeback_io_wb_readdata),
    .io_wb_aluresult(writeback_io_wb_aluresult),
    .io_wb_memtoreg(writeback_io_wb_memtoreg),
    .io_writedata(writeback_io_writedata)
  );
  CSR csr ( // @[core.scala 23:19]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_meip(csr_io_meip),
    .io_csr_address(csr_io_csr_address),
    .io_mem_pc(csr_io_mem_pc),
    .io_csr_read_data(csr_io_csr_read_data),
    .io_readable(csr_io_readable),
    .io_writeable(csr_io_writeable),
    .io_csr_write_enable(csr_io_csr_write_enable),
    .io_csr_write_address(csr_io_csr_write_address),
    .io_csr_write_data(csr_io_csr_write_data),
    .io_inst_retired(csr_io_inst_retired),
    .io_trapped(csr_io_trapped),
    .io_mret(csr_io_mret),
    .io_ecause(csr_io_ecause),
    .io_interrupt(csr_io_interrupt),
    .io_eip(csr_io_eip),
    .io_tip(csr_io_tip),
    .io_sip(csr_io_sip),
    .io_trap_vector(csr_io_trap_vector),
    .io_mret_vector(csr_io_mret_vector)
  );
  Hazard hazard ( // @[core.scala 24:22]
    .io_predict(hazard_io_predict),
    .io_pc_stall(hazard_io_pc_stall),
    .io_if_id_stall(hazard_io_if_id_stall),
    .io_if_id_flush(hazard_io_if_id_flush),
    .io_memread(hazard_io_memread),
    .io_use_rs1(hazard_io_use_rs1),
    .io_use_rs2(hazard_io_use_rs2),
    .io_id_rs1(hazard_io_id_rs1),
    .io_id_rs2(hazard_io_id_rs2),
    .io_ex_rd(hazard_io_ex_rd),
    .io_ex_use_rs1(hazard_io_ex_use_rs1),
    .io_ex_use_rs2(hazard_io_ex_use_rs2),
    .io_ex_rs1(hazard_io_ex_rs1),
    .io_ex_rs2(hazard_io_ex_rs2),
    .io_ex_pc(hazard_io_ex_pc),
    .io_id_ex_flush(hazard_io_id_ex_flush),
    .io_mem_rd(hazard_io_mem_rd),
    .io_mem_regwrite(hazard_io_mem_regwrite),
    .io_mem_pc(hazard_io_mem_pc),
    .io_target_pc(hazard_io_target_pc),
    .io_forward1(hazard_io_forward1),
    .io_forward2(hazard_io_forward2),
    .io_ex_mem_flush(hazard_io_ex_mem_flush),
    .io_wb_rd(hazard_io_wb_rd),
    .io_wb_regwrite(hazard_io_wb_regwrite),
    .io_pcsrc(hazard_io_pcsrc),
    .io_trapped(hazard_io_trapped),
    .io_mret(hazard_io_mret),
    .io_mem_wb_flush(hazard_io_mem_wb_flush)
  );
  assign io_fetch_address = fetch_io_fetch_address; // @[core.scala 146:20]
  assign io_load_store_unsigned = memory_io_load_store_unsigned; // @[core.scala 147:26]
  assign io_memory_size = memory_io_memory_size; // @[core.scala 148:18]
  assign io_memory_address = memory_io_memory_address; // @[core.scala 149:21]
  assign io_memory_write_data = memory_io_memory_write_data; // @[core.scala 150:24]
  assign io_memory_read = memory_io_memory_read; // @[core.scala 151:18]
  assign io_memory_write = memory_io_memory_write; // @[core.scala 152:19]
  assign fetch_clock = clock;
  assign fetch_reset = reset;
  assign fetch_io_trap_vector = csr_io_trap_vector; // @[core.scala 27:24]
  assign fetch_io_mret_vector = csr_io_mret_vector; // @[core.scala 28:24]
  assign fetch_io_target_pc = execute_io_target_pc; // @[core.scala 29:22]
  assign fetch_io_mem_pc = execute_io_mem_pc; // @[core.scala 30:19]
  assign fetch_io_pcsrc = memory_io_pcsrc; // @[core.scala 31:18]
  assign fetch_io_branch = memory_io_branch; // @[core.scala 32:19]
  assign fetch_io_trap = memory_io_trapped; // @[core.scala 33:17]
  assign fetch_io_mret = memory_io_mret_out; // @[core.scala 34:17]
  assign fetch_io_pc_stall = hazard_io_pc_stall; // @[core.scala 35:21]
  assign fetch_io_if_id_stall = hazard_io_if_id_stall; // @[core.scala 36:24]
  assign fetch_io_if_id_flush = hazard_io_if_id_flush; // @[core.scala 37:24]
  assign fetch_io_predict = hazard_io_predict; // @[core.scala 38:20]
  assign fetch_io_fetch_data = io_fetch_data; // @[core.scala 39:23]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_id_pc = fetch_io_id_pc; // @[core.scala 41:19]
  assign decode_io_inst = fetch_io_inst; // @[core.scala 42:18]
  assign decode_io_wb_rd = memory_io_wb_rd; // @[core.scala 43:19]
  assign decode_io_wb_regwrite = memory_io_wb_regwrite; // @[core.scala 44:25]
  assign decode_io_writedata = writeback_io_writedata; // @[core.scala 45:23]
  assign decode_io_id_ex_flush = hazard_io_id_ex_flush; // @[core.scala 46:25]
  assign execute_clock = clock;
  assign execute_reset = reset;
  assign execute_io_csr_read = decode_io_csr_read; // @[core.scala 48:23]
  assign execute_io_csr_write = decode_io_csr_write; // @[core.scala 49:24]
  assign execute_io_csr_address = decode_io_csr_address; // @[core.scala 50:26]
  assign execute_io_ecause_in = decode_io_ecause_out; // @[core.scala 51:24]
  assign execute_io_exception_in = decode_io_exception_out; // @[core.scala 52:27]
  assign execute_io_mret_in = decode_io_mret_out; // @[core.scala 53:22]
  assign execute_io_wfi_in = decode_io_wfi_out; // @[core.scala 54:21]
  assign execute_io_ex_pc = decode_io_ex_pc; // @[core.scala 55:20]
  assign execute_io_aluop = decode_io_aluop; // @[core.scala 56:20]
  assign execute_io_immsrc = decode_io_immsrc; // @[core.scala 57:21]
  assign execute_io_isbranch = decode_io_isbranch; // @[core.scala 58:23]
  assign execute_io_memread = decode_io_memread; // @[core.scala 59:22]
  assign execute_io_memwrite = decode_io_memwrite; // @[core.scala 60:23]
  assign execute_io_regwrite = decode_io_regwrite; // @[core.scala 61:23]
  assign execute_io_memtoreg = decode_io_memtoreg; // @[core.scala 62:23]
  assign execute_io_pcsel = decode_io_pcsel; // @[core.scala 63:20]
  assign execute_io_rdsel = decode_io_rdsel; // @[core.scala 64:20]
  assign execute_io_isjump = decode_io_isjump; // @[core.scala 65:21]
  assign execute_io_islui = decode_io_islui; // @[core.scala 66:20]
  assign execute_io_rs1_data = decode_io_rs1_data; // @[core.scala 67:23]
  assign execute_io_rs2_data = decode_io_rs2_data; // @[core.scala 68:23]
  assign execute_io_imm = decode_io_imm; // @[core.scala 69:18]
  assign execute_io_funct3 = decode_io_funct3; // @[core.scala 70:21]
  assign execute_io_ex_rs1 = decode_io_ex_rs1; // @[core.scala 71:21]
  assign execute_io_ex_rd = decode_io_ex_rd; // @[core.scala 72:20]
  assign execute_io_csr_read_data = csr_io_csr_read_data; // @[core.scala 73:28]
  assign execute_io_readable = csr_io_readable; // @[core.scala 74:23]
  assign execute_io_writeable = csr_io_writeable; // @[core.scala 75:24]
  assign execute_io_writedata = writeback_io_writedata; // @[core.scala 76:24]
  assign execute_io_forward1 = hazard_io_forward1; // @[core.scala 77:23]
  assign execute_io_forward2 = hazard_io_forward2; // @[core.scala 78:23]
  assign execute_io_ex_mem_flush = hazard_io_ex_mem_flush; // @[core.scala 79:27]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_csr_read_data_in = execute_io_csr_read_data_out; // @[core.scala 81:30]
  assign memory_io_csr_write_enable_in = execute_io_csr_write_enable_out; // @[core.scala 82:33]
  assign memory_io_csr_write_address_in = execute_io_csr_write_address_out; // @[core.scala 83:34]
  assign memory_io_csr_write_data_in = execute_io_csr_write_data_out; // @[core.scala 84:31]
  assign memory_io_ecause_in = execute_io_ecause_out; // @[core.scala 85:23]
  assign memory_io_exception_in = execute_io_exception_out; // @[core.scala 86:26]
  assign memory_io_mret_in = execute_io_mret_out; // @[core.scala 87:21]
  assign memory_io_wfi_in = execute_io_wfi_out; // @[core.scala 88:20]
  assign memory_io_reg_pc = execute_io_reg_pc; // @[core.scala 89:20]
  assign memory_io_mem_isbranch = execute_io_mem_isbranch; // @[core.scala 90:26]
  assign memory_io_mem_isjump = execute_io_mem_isjump; // @[core.scala 91:24]
  assign memory_io_mem_memread = execute_io_mem_memread; // @[core.scala 92:25]
  assign memory_io_mem_memwrite = execute_io_mem_memwrite; // @[core.scala 93:26]
  assign memory_io_mem_regwrite = execute_io_mem_regwrite; // @[core.scala 94:26]
  assign memory_io_mem_memtoreg = execute_io_mem_memtoreg; // @[core.scala 95:26]
  assign memory_io_mem_zero = execute_io_mem_zero; // @[core.scala 96:22]
  assign memory_io_mem_aluresult = execute_io_mem_aluresult; // @[core.scala 97:27]
  assign memory_io_mem_rs2_data = execute_io_mem_rs2_data; // @[core.scala 98:26]
  assign memory_io_mem_funct3 = execute_io_mem_funct3; // @[core.scala 99:24]
  assign memory_io_mem_rd = execute_io_mem_rd; // @[core.scala 100:20]
  assign memory_io_sip = csr_io_sip; // @[core.scala 101:17]
  assign memory_io_tip = csr_io_tip; // @[core.scala 102:17]
  assign memory_io_eip = csr_io_eip; // @[core.scala 103:17]
  assign memory_io_mem_wb_flush = hazard_io_mem_wb_flush; // @[core.scala 104:26]
  assign memory_io_memory_read_data = io_memory_read_data; // @[core.scala 105:30]
  assign writeback_io_csr_read_data_in = memory_io_csr_read_data_out; // @[core.scala 107:33]
  assign writeback_io_wb_reg_pc = memory_io_wb_reg_pc; // @[core.scala 108:26]
  assign writeback_io_wb_readdata = memory_io_wb_readdata; // @[core.scala 109:28]
  assign writeback_io_wb_aluresult = memory_io_wb_aluresult; // @[core.scala 110:29]
  assign writeback_io_wb_memtoreg = memory_io_wb_memtoreg; // @[core.scala 111:28]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_meip = io_meip; // @[core.scala 113:15]
  assign csr_io_csr_address = decode_io_csr_address; // @[core.scala 115:22]
  assign csr_io_mem_pc = execute_io_mem_pc; // @[core.scala 114:17]
  assign csr_io_csr_write_enable = memory_io_csr_write_enable_out; // @[core.scala 116:27]
  assign csr_io_csr_write_address = memory_io_csr_write_address_out; // @[core.scala 117:28]
  assign csr_io_csr_write_data = memory_io_csr_write_data_out; // @[core.scala 118:25]
  assign csr_io_inst_retired = memory_io_inst_retired; // @[core.scala 119:23]
  assign csr_io_trapped = memory_io_trapped; // @[core.scala 120:18]
  assign csr_io_mret = memory_io_mret_out; // @[core.scala 122:15]
  assign csr_io_ecause = memory_io_ecause_out[2:0]; // @[core.scala 123:17]
  assign csr_io_interrupt = memory_io_interrupt; // @[core.scala 121:20]
  assign hazard_io_memread = decode_io_memread; // @[core.scala 125:21]
  assign hazard_io_use_rs1 = decode_io_use_rs1; // @[core.scala 126:21]
  assign hazard_io_use_rs2 = decode_io_use_rs2; // @[core.scala 127:21]
  assign hazard_io_id_rs1 = decode_io_id_rs1; // @[core.scala 128:20]
  assign hazard_io_id_rs2 = decode_io_id_rs2; // @[core.scala 129:20]
  assign hazard_io_ex_rd = decode_io_ex_rd; // @[core.scala 130:19]
  assign hazard_io_ex_use_rs1 = decode_io_ex_use_rs1; // @[core.scala 131:24]
  assign hazard_io_ex_use_rs2 = decode_io_ex_use_rs2; // @[core.scala 132:24]
  assign hazard_io_ex_rs1 = decode_io_ex_rs1; // @[core.scala 133:20]
  assign hazard_io_ex_rs2 = decode_io_ex_rs2; // @[core.scala 134:20]
  assign hazard_io_ex_pc = decode_io_ex_pc; // @[core.scala 135:19]
  assign hazard_io_mem_rd = execute_io_mem_rd; // @[core.scala 136:20]
  assign hazard_io_mem_regwrite = execute_io_mem_regwrite; // @[core.scala 137:26]
  assign hazard_io_mem_pc = execute_io_mem_pc; // @[core.scala 138:20]
  assign hazard_io_target_pc = execute_io_target_pc; // @[core.scala 139:23]
  assign hazard_io_wb_rd = memory_io_wb_rd; // @[core.scala 140:19]
  assign hazard_io_wb_regwrite = memory_io_wb_regwrite; // @[core.scala 141:25]
  assign hazard_io_pcsrc = memory_io_pcsrc; // @[core.scala 142:19]
  assign hazard_io_trapped = memory_io_trapped; // @[core.scala 143:21]
  assign hazard_io_mret = memory_io_mret_out; // @[core.scala 144:18]
endmodule
