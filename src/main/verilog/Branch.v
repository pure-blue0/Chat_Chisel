module Branch(
  input         clock,
  input         reset,
  input         io_mem_zero,
  input  [31:0] io_mem_aluresult,
  input  [2:0]  io_mem_funct3,
  input         io_mem_isbranch,
  input         io_mem_isjump,
  output        io_branch,
  output        io_pcsrc
);
  wire  branchEq = io_mem_funct3 == 3'h0 & io_mem_zero; // @[cmd4.sc 18:41]
  wire  branchNe = io_mem_funct3 == 3'h1 & ~io_mem_zero; // @[cmd4.sc 19:41]
  wire  branchLt = io_mem_funct3 == 3'h4 & io_mem_aluresult[0]; // @[cmd4.sc 20:41]
  wire  _T_7 = ~io_mem_aluresult[0]; // @[cmd4.sc 21:44]
  wire  branchGe = io_mem_funct3 == 3'h5 & ~io_mem_aluresult[0]; // @[cmd4.sc 21:41]
  wire  branchLtu = io_mem_funct3 == 3'h6 & io_mem_aluresult[0]; // @[cmd4.sc 22:41]
  wire  branchGeu = io_mem_funct3 == 3'h7 & _T_7; // @[cmd4.sc 23:41]
  assign io_branch = io_mem_isbranch; // @[cmd4.sc 25:13]
  assign io_pcsrc = io_mem_isjump | (branchEq | branchNe | branchLt | branchGe | branchLtu | branchGeu) &
    io_mem_isbranch; // @[cmd4.sc 26:22]
endmodule
