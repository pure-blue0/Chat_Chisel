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
