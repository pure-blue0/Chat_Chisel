module Fetch(
  input         clock,
  input         reset,
  input  [31:0] io_trap_vector,
  input  [31:0] io_mert_vector,
  input  [31:0] io_target_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  input         io_trap,
  input         io_mert,
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
    end else if (io_mert) begin // @[fetch.scala 53:23]
      pcReg <= io_mert_vector; // @[fetch.scala 54:11]
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