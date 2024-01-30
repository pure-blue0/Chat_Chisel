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
  reg [1:0] btbTable [0:15]; // @[cmd2.sc 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[cmd2.sc 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[cmd2.sc 14:21]
  wire [1:0] btbTable_MPORT_data; // @[cmd2.sc 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[cmd2.sc 14:21]
  wire  btbTable_MPORT_mask; // @[cmd2.sc 14:21]
  wire  btbTable_MPORT_en; // @[cmd2.sc 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[cmd2.sc 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[cmd2.sc 14:21]
  wire  btbTable_MPORT_1_mask; // @[cmd2.sc 14:21]
  wire  btbTable_MPORT_1_en; // @[cmd2.sc 14:21]
  wire  _T_3 = btbTable_btbEntry_data < 2'h3; // @[cmd2.sc 26:21]
  wire  _T_7 = btbTable_btbEntry_data > 2'h0; // @[cmd2.sc 31:21]
  wire  _GEN_12 = io_pcsrc & _T_3; // @[cmd2.sc 24:28 cmd2.sc 14:21]
  wire  _GEN_17 = io_pcsrc ? 1'h0 : _T_7; // @[cmd2.sc 24:28 cmd2.sc 14:21]
  assign btbTable_btbEntry_addr = io_pc[3:0];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[cmd2.sc 14:21]
  assign btbTable_MPORT_data = btbTable_btbEntry_data + 2'h1;
  assign btbTable_MPORT_addr = io_mem_pc[3:0];
  assign btbTable_MPORT_mask = 1'h1;
  assign btbTable_MPORT_en = io_branch & _GEN_12;
  assign btbTable_MPORT_1_data = btbTable_btbEntry_data - 2'h1;
  assign btbTable_MPORT_1_addr = io_mem_pc[3:0];
  assign btbTable_MPORT_1_mask = 1'h1;
  assign btbTable_MPORT_1_en = io_branch & _GEN_17;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[cmd2.sc 20:28]
  always @(posedge clock) begin
    if(btbTable_MPORT_en & btbTable_MPORT_mask) begin
      btbTable[btbTable_MPORT_addr] <= btbTable_MPORT_data; // @[cmd2.sc 14:21]
    end
    if(btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[cmd2.sc 14:21]
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
