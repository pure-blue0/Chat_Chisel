circuit Branch :
  module Branch :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip mem_zero : UInt<1>, flip mem_aluresult : UInt<32>, flip mem_funct3 : UInt<3>, flip mem_isbranch : UInt<1>, flip mem_isjump : UInt<1>, branch : UInt<1>, pcsrc : UInt<1>}

    node _branchEq_T = eq(io.mem_funct3, UInt<1>("h0")) @[branch.scala 18:27]
    node branchEq = and(_branchEq_T, io.mem_zero) @[branch.scala 18:41]
    node _branchNe_T = eq(io.mem_funct3, UInt<1>("h1")) @[branch.scala 19:27]
    node _branchNe_T_1 = eq(io.mem_zero, UInt<1>("h0")) @[branch.scala 19:44]
    node branchNe = and(_branchNe_T, _branchNe_T_1) @[branch.scala 19:41]
    node _branchLt_T = eq(io.mem_funct3, UInt<3>("h4")) @[branch.scala 20:27]
    node _branchLt_T_1 = bits(io.mem_aluresult, 0, 0) @[branch.scala 20:60]
    node branchLt = and(_branchLt_T, _branchLt_T_1) @[branch.scala 20:41]
    node _branchGe_T = eq(io.mem_funct3, UInt<3>("h5")) @[branch.scala 21:27]
    node _branchGe_T_1 = bits(io.mem_aluresult, 0, 0) @[branch.scala 21:61]
    node _branchGe_T_2 = eq(_branchGe_T_1, UInt<1>("h0")) @[branch.scala 21:44]
    node branchGe = and(_branchGe_T, _branchGe_T_2) @[branch.scala 21:41]
    node _branchLtu_T = eq(io.mem_funct3, UInt<3>("h6")) @[branch.scala 22:27]
    node _branchLtu_T_1 = bits(io.mem_aluresult, 0, 0) @[branch.scala 22:60]
    node branchLtu = and(_branchLtu_T, _branchLtu_T_1) @[branch.scala 22:41]
    node _branchGeu_T = eq(io.mem_funct3, UInt<3>("h7")) @[branch.scala 23:27]
    node _branchGeu_T_1 = bits(io.mem_aluresult, 0, 0) @[branch.scala 23:61]
    node _branchGeu_T_2 = eq(_branchGeu_T_1, UInt<1>("h0")) @[branch.scala 23:44]
    node branchGeu = and(_branchGeu_T, _branchGeu_T_2) @[branch.scala 23:41]
    io.branch <= io.mem_isbranch @[branch.scala 25:13]
    node _io_pcsrc_T = or(branchEq, branchNe) @[branch.scala 26:35]
    node _io_pcsrc_T_1 = or(_io_pcsrc_T, branchLt) @[branch.scala 26:47]
    node _io_pcsrc_T_2 = or(_io_pcsrc_T_1, branchGe) @[branch.scala 26:59]
    node _io_pcsrc_T_3 = or(_io_pcsrc_T_2, branchLtu) @[branch.scala 26:71]
    node _io_pcsrc_T_4 = or(_io_pcsrc_T_3, branchGeu) @[branch.scala 26:84]
    node _io_pcsrc_T_5 = and(_io_pcsrc_T_4, io.mem_isbranch) @[branch.scala 26:98]
    node _io_pcsrc_T_6 = or(io.mem_isjump, _io_pcsrc_T_5) @[branch.scala 26:22]
    io.pcsrc <= _io_pcsrc_T_6 @[branch.scala 26:12]

