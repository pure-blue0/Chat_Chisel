module DataCache(
  input         clock,
  input         reset,
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
  reg [31:0] mem [0:1023]; // @[cmd3.sc 13:16]
  wire [31:0] mem_MPORT_data; // @[cmd3.sc 13:16]
  wire [9:0] mem_MPORT_addr; // @[cmd3.sc 13:16]
  wire [31:0] mem_MPORT_1_data; // @[cmd3.sc 13:16]
  wire [9:0] mem_MPORT_1_addr; // @[cmd3.sc 13:16]
  wire [31:0] mem_MPORT_2_data; // @[cmd3.sc 13:16]
  wire [9:0] mem_MPORT_2_addr; // @[cmd3.sc 13:16]
  wire [31:0] mem_MPORT_3_data; // @[cmd3.sc 13:16]
  wire [9:0] mem_MPORT_3_addr; // @[cmd3.sc 13:16]
  wire  mem_MPORT_3_mask; // @[cmd3.sc 13:16]
  wire  mem_MPORT_3_en; // @[cmd3.sc 13:16]
  wire [7:0] address = io_mem_aluresult[9:2]; // @[cmd3.sc 15:33]
  wire  _T_1 = io_mem_funct3 == 3'h0; // @[cmd3.sc 23:24]
  wire [23:0] _T_4 = mem_MPORT_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_6 = {_T_4,mem_MPORT_data[7:0]}; // @[Cat.scala 30:58]
  wire  _T_7 = io_mem_funct3 == 3'h1; // @[cmd3.sc 25:30]
  wire [15:0] _T_10 = mem_MPORT_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_12 = {_T_10,mem_MPORT_data[15:0]}; // @[Cat.scala 30:58]
  wire  _T_13 = io_mem_funct3 == 3'h2; // @[cmd3.sc 27:30]
  wire [31:0] _T_16 = {24'h0,mem_MPORT_data[7:0]}; // @[Cat.scala 30:58]
  wire [31:0] _T_19 = {16'h0,mem_MPORT_data[15:0]}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_0 = io_mem_funct3 == 3'h5 ? _T_19 : 32'h0; // @[cmd3.sc 31:44 cmd3.sc 32:14 cmd3.sc 34:14]
  wire [31:0] _GEN_1 = io_mem_funct3 == 3'h4 ? _T_16 : _GEN_0; // @[cmd3.sc 29:44 cmd3.sc 30:14]
  wire [31:0] _GEN_2 = io_mem_funct3 == 3'h2 ? mem_MPORT_data : _GEN_1; // @[cmd3.sc 27:44 cmd3.sc 28:14]
  wire [31:0] _GEN_3 = io_mem_funct3 == 3'h1 ? _T_12 : _GEN_2; // @[cmd3.sc 25:44 cmd3.sc 26:14]
  wire [31:0] _GEN_4 = io_mem_funct3 == 3'h0 ? _T_6 : _GEN_3; // @[cmd3.sc 23:38 cmd3.sc 24:14]
  wire [31:0] _T_24 = {mem_MPORT_1_data[31:8],io_mem_rs2_data[7:0]}; // @[Cat.scala 30:58]
  wire [31:0] _T_28 = {mem_MPORT_2_data[31:16],io_mem_rs2_data[15:0]}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_5 = _T_13 ? io_mem_rs2_data : 32'h0; // @[cmd3.sc 49:46 cmd3.sc 51:19 cmd3.sc 53:19]
  wire [31:0] _GEN_9 = _T_7 ? _T_28 : _GEN_5; // @[cmd3.sc 46:46 cmd3.sc 48:19]
  wire  _GEN_16 = _T_1 ? 1'h0 : _T_7; // @[cmd3.sc 43:40 cmd3.sc 13:16]
  wire  _GEN_19 = io_mem_memwrite & _T_1; // @[cmd3.sc 40:35 cmd3.sc 13:16]
  wire  _GEN_22 = io_mem_memwrite & _GEN_16; // @[cmd3.sc 40:35 cmd3.sc 13:16]
  assign mem_MPORT_addr = {{2'd0}, address};
  assign mem_MPORT_data = mem[mem_MPORT_addr]; // @[cmd3.sc 13:16]
  assign mem_MPORT_1_addr = {{2'd0}, address};
  assign mem_MPORT_1_data = mem[mem_MPORT_1_addr]; // @[cmd3.sc 13:16]
  assign mem_MPORT_2_addr = {{2'd0}, address};
  assign mem_MPORT_2_data = mem[mem_MPORT_2_addr]; // @[cmd3.sc 13:16]
  assign mem_MPORT_3_data = _T_1 ? _T_24 : _GEN_9;
  assign mem_MPORT_3_addr = {{2'd0}, address};
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = io_mem_memread ? 1'h0 : io_mem_memwrite;
  assign io_read_data = io_mem_memread ? _GEN_4 : 32'h0; // @[cmd3.sc 17:32 cmd3.sc 37:18 cmd3.sc 59:18]
  always @(posedge clock) begin
    if(mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[cmd3.sc 13:16]
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
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
