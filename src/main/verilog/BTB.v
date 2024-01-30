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
  reg [1:0] btbTable [0:15]; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_2_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_3_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_5_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[cmd4.sc 14:21]
  wire  btbTable_MPORT_1_mask; // @[cmd4.sc 14:21]
  wire  btbTable_MPORT_1_en; // @[cmd4.sc 14:21]
  wire [1:0] btbTable_MPORT_4_data; // @[cmd4.sc 14:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[cmd4.sc 14:21]
  wire  btbTable_MPORT_4_mask; // @[cmd4.sc 14:21]
  wire  btbTable_MPORT_4_en; // @[cmd4.sc 14:21]
  wire  _T_4 = btbTable_MPORT_data < 2'h3; // @[cmd4.sc 26:38]
  wire  _T_10 = btbTable_MPORT_3_data > 2'h0; // @[cmd4.sc 31:38]
  wire  _GEN_17 = io_pcsrc & _T_4; // @[cmd4.sc 24:28 cmd4.sc 14:21]
  wire  _GEN_23 = io_pcsrc ? 1'h0 : 1'h1; // @[cmd4.sc 24:28 cmd4.sc 14:21 cmd4.sc 31:20]
  wire  _GEN_26 = io_pcsrc ? 1'h0 : _T_10; // @[cmd4.sc 24:28 cmd4.sc 14:21]
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[cmd4.sc 14:21]
  assign btbTable_MPORT_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_data = btbTable[btbTable_MPORT_addr]; // @[cmd4.sc 14:21]
  assign btbTable_MPORT_2_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_2_data = btbTable[btbTable_MPORT_2_addr]; // @[cmd4.sc 14:21]
  assign btbTable_MPORT_3_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_3_data = btbTable[btbTable_MPORT_3_addr]; // @[cmd4.sc 14:21]
  assign btbTable_MPORT_5_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_5_data = btbTable[btbTable_MPORT_5_addr]; // @[cmd4.sc 14:21]
  assign btbTable_MPORT_1_data = btbTable_MPORT_2_data + 2'h1;
  assign btbTable_MPORT_1_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_1_mask = 1'h1;
  assign btbTable_MPORT_1_en = io_branch & _GEN_17;
  assign btbTable_MPORT_4_data = btbTable_MPORT_5_data - 2'h1;
  assign btbTable_MPORT_4_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_4_mask = 1'h1;
  assign btbTable_MPORT_4_en = io_branch & _GEN_26;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[cmd4.sc 20:28]
  always @(posedge clock) begin
    if(btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[cmd4.sc 14:21]
    end
    if(btbTable_MPORT_4_en & btbTable_MPORT_4_mask) begin
      btbTable[btbTable_MPORT_4_addr] <= btbTable_MPORT_4_data; // @[cmd4.sc 14:21]
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
