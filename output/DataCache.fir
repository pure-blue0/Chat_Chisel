circuit DataCache :
  module DataCache :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip mem_aluresult : UInt<32>, flip mem_rs2_data : UInt<32>, flip mem_memread : UInt<1>, flip mem_funct3 : UInt<3>, flip mem_memwrite : UInt<1>, read_data : UInt<32>}

    cmem mem : UInt<32> [1048576] @[datacache.scala 13:16]
    node address = bits(io.mem_aluresult, 17, 2) @[datacache.scala 15:33]
    node _T = eq(io.mem_memread, UInt<1>("h1")) @[datacache.scala 17:23]
    when _T : @[datacache.scala 17:32]
      read mport cacheData = mem[address], clock @[datacache.scala 19:29]
      wire result : UInt<32> @[datacache.scala 22:22]
      node _T_1 = eq(io.mem_funct3, UInt<1>("h0")) @[datacache.scala 23:24]
      when _T_1 : @[datacache.scala 23:38]
        node _result_T = bits(cacheData, 7, 7) @[datacache.scala 24:39]
        node _result_T_1 = bits(_result_T, 0, 0) @[Bitwise.scala 74:15]
        node _result_T_2 = mux(_result_T_1, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
        node _result_T_3 = bits(cacheData, 7, 0) @[datacache.scala 24:54]
        node _result_T_4 = cat(_result_T_2, _result_T_3) @[Cat.scala 31:58]
        result <= _result_T_4 @[datacache.scala 24:14]
      else :
        node _T_2 = eq(io.mem_funct3, UInt<1>("h1")) @[datacache.scala 25:30]
        when _T_2 : @[datacache.scala 25:44]
          node _result_T_5 = bits(cacheData, 15, 15) @[datacache.scala 26:39]
          node _result_T_6 = bits(_result_T_5, 0, 0) @[Bitwise.scala 74:15]
          node _result_T_7 = mux(_result_T_6, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
          node _result_T_8 = bits(cacheData, 15, 0) @[datacache.scala 26:55]
          node _result_T_9 = cat(_result_T_7, _result_T_8) @[Cat.scala 31:58]
          result <= _result_T_9 @[datacache.scala 26:14]
        else :
          node _T_3 = eq(io.mem_funct3, UInt<2>("h2")) @[datacache.scala 27:30]
          when _T_3 : @[datacache.scala 27:44]
            result <= cacheData @[datacache.scala 28:14]
          else :
            node _T_4 = eq(io.mem_funct3, UInt<3>("h4")) @[datacache.scala 29:30]
            when _T_4 : @[datacache.scala 29:44]
              node _result_T_10 = bits(cacheData, 7, 0) @[datacache.scala 30:41]
              node _result_T_11 = cat(UInt<24>("h0"), _result_T_10) @[Cat.scala 31:58]
              result <= _result_T_11 @[datacache.scala 30:14]
            else :
              node _T_5 = eq(io.mem_funct3, UInt<3>("h5")) @[datacache.scala 31:30]
              when _T_5 : @[datacache.scala 31:44]
                node _result_T_12 = bits(cacheData, 15, 0) @[datacache.scala 32:41]
                node _result_T_13 = cat(UInt<16>("h0"), _result_T_12) @[Cat.scala 31:58]
                result <= _result_T_13 @[datacache.scala 32:14]
              else :
                result <= UInt<1>("h0") @[datacache.scala 34:14]
      io.read_data <= result @[datacache.scala 37:18]
    else :
      node _T_6 = eq(io.mem_memwrite, UInt<1>("h1")) @[datacache.scala 40:26]
      when _T_6 : @[datacache.scala 40:35]
        wire writeData : UInt<32> @[datacache.scala 42:27]
        node _T_7 = eq(io.mem_funct3, UInt<1>("h0")) @[datacache.scala 43:26]
        when _T_7 : @[datacache.scala 43:40]
          read mport writeData_MPORT = mem[address], clock @[datacache.scala 45:34]
          node _writeData_T = bits(writeData_MPORT, 31, 8) @[datacache.scala 45:43]
          node _writeData_T_1 = bits(io.mem_rs2_data, 7, 0) @[datacache.scala 45:67]
          node _writeData_T_2 = cat(_writeData_T, _writeData_T_1) @[Cat.scala 31:58]
          writeData <= _writeData_T_2 @[datacache.scala 45:19]
        else :
          node _T_8 = eq(io.mem_funct3, UInt<1>("h1")) @[datacache.scala 46:32]
          when _T_8 : @[datacache.scala 46:46]
            read mport writeData_MPORT_1 = mem[address], clock @[datacache.scala 48:34]
            node _writeData_T_3 = bits(writeData_MPORT_1, 31, 16) @[datacache.scala 48:43]
            node _writeData_T_4 = bits(io.mem_rs2_data, 15, 0) @[datacache.scala 48:68]
            node _writeData_T_5 = cat(_writeData_T_3, _writeData_T_4) @[Cat.scala 31:58]
            writeData <= _writeData_T_5 @[datacache.scala 48:19]
          else :
            node _T_9 = eq(io.mem_funct3, UInt<2>("h2")) @[datacache.scala 49:32]
            when _T_9 : @[datacache.scala 49:46]
              writeData <= io.mem_rs2_data @[datacache.scala 51:19]
            else :
              writeData <= UInt<1>("h0") @[datacache.scala 53:19]
        write mport MPORT = mem[address], clock
        MPORT <= writeData
      io.read_data <= UInt<1>("h0") @[datacache.scala 59:18]

