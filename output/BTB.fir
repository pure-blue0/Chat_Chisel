circuit BTB :
  module BTB :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    cmem btbTable : UInt<2> [16] @[btb.scala 14:21]
    node _btbEntry_T = bits(io.pc, 5, 2) @[btb.scala 17:32]
    infer mport btbEntry = btbTable[_btbEntry_T], clock @[btb.scala 17:26]
    node btbPredict = bits(btbEntry, 1, 1) @[btb.scala 20:28]
    node _T = eq(io.branch, UInt<1>("h1")) @[btb.scala 23:18]
    when _T : @[btb.scala 23:27]
      node _T_1 = eq(io.pcsrc, UInt<1>("h1")) @[btb.scala 24:19]
      when _T_1 : @[btb.scala 24:28]
        node _T_2 = bits(io.mem_pc, 5, 2) @[btb.scala 26:30]
        infer mport MPORT = btbTable[_T_2], clock @[btb.scala 26:20]
        node _T_3 = lt(MPORT, UInt<2>("h3")) @[btb.scala 26:38]
        when _T_3 : @[btb.scala 26:45]
          node _T_4 = bits(io.mem_pc, 5, 2) @[btb.scala 27:33]
          node _T_5 = bits(io.mem_pc, 5, 2) @[btb.scala 27:59]
          infer mport MPORT_1 = btbTable[_T_5], clock @[btb.scala 27:49]
          node _T_6 = add(MPORT_1, UInt<1>("h1")) @[btb.scala 27:67]
          node _T_7 = tail(_T_6, 1) @[btb.scala 27:67]
          write mport MPORT_2 = btbTable[_T_4], clock
          MPORT_2 <= _T_7
      else :
        node _T_8 = bits(io.mem_pc, 5, 2) @[btb.scala 31:30]
        infer mport MPORT_3 = btbTable[_T_8], clock @[btb.scala 31:20]
        node _T_9 = gt(MPORT_3, UInt<1>("h0")) @[btb.scala 31:38]
        when _T_9 : @[btb.scala 31:45]
          node _T_10 = bits(io.mem_pc, 5, 2) @[btb.scala 32:33]
          node _T_11 = bits(io.mem_pc, 5, 2) @[btb.scala 32:59]
          infer mport MPORT_4 = btbTable[_T_11], clock @[btb.scala 32:49]
          node _T_12 = sub(MPORT_4, UInt<1>("h1")) @[btb.scala 32:67]
          node _T_13 = tail(_T_12, 1) @[btb.scala 32:67]
          write mport MPORT_5 = btbTable[_T_10], clock
          MPORT_5 <= _T_13
    io.btb_taken <= btbPredict @[btb.scala 37:16]

