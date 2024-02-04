circuit Icache :
  module Icache :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, inst : UInt<32>}

    cmem cacheData : UInt<32> [1048576] @[Icache.scala 10:22]
    node cacheIndex = bits(io.pc, 17, 2) @[Icache.scala 11:25]
    infer mport cacheEntry = cacheData[cacheIndex], clock @[Icache.scala 15:29]
    io.inst <= cacheEntry @[Icache.scala 16:11]

