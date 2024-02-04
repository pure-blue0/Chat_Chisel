circuit BHT :
  module BHT :
    input clock : Clock
    input reset : UInt<1>
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

