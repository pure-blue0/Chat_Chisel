circuit Fetch :
  module BHT :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, match : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}

    cmem bhtTable : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} [16] @[bht.scala 24:21]
    node index = bits(io.pc, 5, 2) @[bht.scala 26:20]
    read mport bhtEntry = bhtTable[index], clock @[bht.scala 28:31]
    node _io_match_T = bits(io.pc, 31, 6) @[bht.scala 30:39]
    node _io_match_T_1 = eq(bhtEntry.tag, _io_match_T) @[bht.scala 30:30]
    io.match <= _io_match_T_1 @[bht.scala 30:14]
    io.valid <= bhtEntry.valid @[bht.scala 31:12]
    io.bht_pred_pc <= bhtEntry.target_pc @[bht.scala 32:18]
    node _T = eq(io.pcsrc, UInt<1>("h1")) @[bht.scala 34:17]
    when _T : @[bht.scala 34:26]
      wire newEntry : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} @[bht.scala 35:24]
      node _newEntry_tag_T = bits(io.mem_pc, 31, 6) @[bht.scala 36:30]
      newEntry.tag <= _newEntry_tag_T @[bht.scala 36:18]
      newEntry.valid <= UInt<1>("h1") @[bht.scala 37:20]
      newEntry.target_pc <= io.target_pc @[bht.scala 38:24]
      node _T_1 = bits(io.mem_pc, 5, 2) @[bht.scala 39:29]
      write mport MPORT = bhtTable[_T_1], clock
      MPORT.target_pc <= newEntry.target_pc
      MPORT.valid <= newEntry.valid
      MPORT.tag <= newEntry.tag

  module BTB :
    input clock : Clock
    input reset : Reset
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

  module Icache :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, inst : UInt<32>}

    cmem cacheData : UInt<32> [1048576] @[Icache.scala 10:22]
    node cacheIndex = bits(io.pc, 17, 2) @[Icache.scala 11:25]
    infer mport cacheEntry = cacheData[cacheIndex], clock @[Icache.scala 15:29]
    io.inst <= cacheEntry @[Icache.scala 16:11]

  module Fetch :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip trap_vector : UInt<32>, flip mret_vector : UInt<32>, flip target_pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, flip trap : UInt<1>, flip mret : UInt<1>, flip pc_stall : UInt<1>, flip if_id_stall : UInt<1>, flip if_id_flush : UInt<1>, flip predict : UInt<1>, id_pc : UInt<32>, inst : UInt<32>}

    inst bht of BHT @[fetch.scala 28:19]
    bht.clock <= clock
    bht.reset <= reset
    inst btb of BTB @[fetch.scala 29:19]
    btb.clock <= clock
    btb.reset <= reset
    inst icache of Icache @[fetch.scala 30:22]
    icache.clock <= clock
    icache.reset <= reset
    reg pcReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h8")) @[fetch.scala 33:22]
    reg idPcReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[fetch.scala 34:24]
    reg instReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[fetch.scala 35:24]
    bht.io.pc <= pcReg @[fetch.scala 38:13]
    bht.io.mem_pc <= io.mem_pc @[fetch.scala 39:17]
    bht.io.pcsrc <= io.pcsrc @[fetch.scala 40:16]
    bht.io.target_pc <= io.target_pc @[fetch.scala 41:20]
    btb.io.pc <= pcReg @[fetch.scala 43:13]
    btb.io.mem_pc <= io.mem_pc @[fetch.scala 44:17]
    btb.io.pcsrc <= io.pcsrc @[fetch.scala 45:16]
    btb.io.branch <= io.branch @[fetch.scala 46:17]
    icache.io.pc <= pcReg @[fetch.scala 48:16]
    when io.trap : @[fetch.scala 51:17]
      pcReg <= io.trap_vector @[fetch.scala 52:11]
    else :
      when io.mret : @[fetch.scala 53:23]
        pcReg <= io.mret_vector @[fetch.scala 54:11]
      else :
        node _T = eq(io.predict, UInt<1>("h0")) @[fetch.scala 55:26]
        node _T_1 = and(io.pcsrc, _T) @[fetch.scala 55:23]
        when _T_1 : @[fetch.scala 55:39]
          pcReg <= io.target_pc @[fetch.scala 56:11]
        else :
          when io.pc_stall : @[fetch.scala 57:27]
            pcReg <= pcReg @[fetch.scala 58:11]
          else :
            node _T_2 = and(btb.io.btb_taken, bht.io.valid) @[fetch.scala 59:32]
            node _T_3 = and(_T_2, bht.io.match) @[fetch.scala 59:47]
            node _T_4 = neq(_T_3, UInt<1>("h0")) @[fetch.scala 59:65]
            when _T_4 : @[fetch.scala 59:74]
              pcReg <= bht.io.bht_pred_pc @[fetch.scala 60:11]
            else :
              node _pcReg_T = add(pcReg, UInt<3>("h4")) @[fetch.scala 62:20]
              node _pcReg_T_1 = tail(_pcReg_T, 1) @[fetch.scala 62:20]
              pcReg <= _pcReg_T_1 @[fetch.scala 62:11]
    when io.if_id_stall : @[fetch.scala 66:24]
      idPcReg <= idPcReg @[fetch.scala 67:13]
      instReg <= instReg @[fetch.scala 68:13]
    else :
      idPcReg <= pcReg @[fetch.scala 70:13]
      instReg <= icache.io.inst @[fetch.scala 71:13]
    when io.if_id_flush : @[fetch.scala 74:24]
      idPcReg <= UInt<1>("h0") @[fetch.scala 75:13]
      instReg <= UInt<5>("h13") @[fetch.scala 76:13]
    io.id_pc <= idPcReg @[fetch.scala 79:12]
    io.inst <= instReg @[fetch.scala 80:11]

