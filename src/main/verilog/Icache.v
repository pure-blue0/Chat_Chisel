module Icache(
  input         clock,
  input         reset,
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
