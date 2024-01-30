module BHT(
  input         clock,
  input         reset,
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
  reg [27:0] bhtTable_tag [0:15]; // @[cmd5.sc 24:21]
  wire [27:0] bhtTable_tag_bhtEntry_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[cmd5.sc 24:21]
  wire [27:0] bhtTable_tag_MPORT_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[cmd5.sc 24:21]
  wire  bhtTable_tag_MPORT_mask; // @[cmd5.sc 24:21]
  wire  bhtTable_tag_MPORT_en; // @[cmd5.sc 24:21]
  reg  bhtTable_valid [0:15]; // @[cmd5.sc 24:21]
  wire  bhtTable_valid_bhtEntry_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[cmd5.sc 24:21]
  wire  bhtTable_valid_MPORT_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[cmd5.sc 24:21]
  wire  bhtTable_valid_MPORT_mask; // @[cmd5.sc 24:21]
  wire  bhtTable_valid_MPORT_en; // @[cmd5.sc 24:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[cmd5.sc 24:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[cmd5.sc 24:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[cmd5.sc 24:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[cmd5.sc 24:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[cmd5.sc 24:21]
  wire  bhtTable_target_pc_MPORT_en; // @[cmd5.sc 24:21]
  assign bhtTable_tag_bhtEntry_addr = io_pc[3:0];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[cmd5.sc 24:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:4];
  assign bhtTable_tag_MPORT_addr = io_pc[3:0];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_addr = io_pc[3:0];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[cmd5.sc 24:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_pc[3:0];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[3:0];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[cmd5.sc 24:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_pc[3:0];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_match = bhtTable_tag_bhtEntry_data == io_pc[31:4]; // @[cmd5.sc 30:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[cmd5.sc 31:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[cmd5.sc 32:18]
  always @(posedge clock) begin
    if(bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[cmd5.sc 24:21]
    end
    if(bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[cmd5.sc 24:21]
    end
    if(bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[cmd5.sc 24:21]
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
    bhtTable_tag[initvar] = _RAND_0[27:0];
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
