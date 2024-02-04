module BTB(
  input         clock,
  input         reset,
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
