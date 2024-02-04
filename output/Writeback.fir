circuit Writeback :
  module Writeback :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip csr_read_data_in : UInt<32>, flip wb_reg_pc : UInt<32>, flip wb_readdata : UInt<32>, flip wb_aluresult : UInt<32>, flip wb_memtoreg : UInt<2>, writedata : UInt<32>}

    node _io_writedata_T = eq(UInt<1>("h1"), io.wb_memtoreg) @[Mux.scala 81:61]
    node _io_writedata_T_1 = mux(_io_writedata_T, io.wb_readdata, io.wb_reg_pc) @[Mux.scala 81:58]
    node _io_writedata_T_2 = eq(UInt<2>("h2"), io.wb_memtoreg) @[Mux.scala 81:61]
    node _io_writedata_T_3 = mux(_io_writedata_T_2, io.wb_aluresult, _io_writedata_T_1) @[Mux.scala 81:58]
    node _io_writedata_T_4 = eq(UInt<2>("h3"), io.wb_memtoreg) @[Mux.scala 81:61]
    node _io_writedata_T_5 = mux(_io_writedata_T_4, io.csr_read_data_in, _io_writedata_T_3) @[Mux.scala 81:58]
    io.writedata <= _io_writedata_T_5 @[writeback.scala 15:16]

