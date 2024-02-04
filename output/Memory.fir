circuit Memory :
  module Branch :
    input clock : Clock
    input reset : Reset
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

  module DataCache :
    input clock : Clock
    input reset : Reset
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

  module Memory :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip csr_read_data_in : UInt<32>, flip csr_write_enable_in : UInt<1>, flip csr_write_address_in : UInt<12>, flip csr_write_data_in : UInt<32>, flip ecause_in : UInt<4>, flip exception_in : UInt<1>, flip mret_in : UInt<1>, flip wfi_in : UInt<1>, flip reg_pc : UInt<32>, flip mem_isbranch : UInt<1>, flip mem_isjump : UInt<1>, flip mem_memread : UInt<1>, flip mem_memwrite : UInt<1>, flip mem_regwrite : UInt<1>, flip mem_memtoreg : UInt<2>, flip mem_zero : UInt<1>, flip mem_aluresult : UInt<32>, flip mem_rs2_data : UInt<32>, flip mem_funct3 : UInt<3>, flip mem_rd : UInt<5>, flip sip : UInt<1>, flip tip : UInt<1>, flip eip : UInt<1>, csr_write_enable_out : UInt<1>, csr_write_address_out : UInt<12>, csr_write_data_out : UInt<32>, ecause_out : UInt<4>, trapped : UInt<1>, interrupt : UInt<1>, inst_retired : UInt<1>, mret_out : UInt<1>, csr_read_data_out : UInt<32>, wfi_out : UInt<1>, wb_reg_pc : UInt<32>, wb_readdata : UInt<32>, wb_aluresult : UInt<32>, wb_memtoreg : UInt<2>, wb_regwrite : UInt<1>, wb_rd : UInt<5>, pcsrc : UInt<1>, branch : UInt<1>, flip mem_wb_flush : UInt<1>}

    node _load_exception_T = neq(io.mem_rd, UInt<1>("h0")) @[memory.scala 57:53]
    node load_exception = and(io.mem_memread, _load_exception_T) @[memory.scala 57:39]
    node _mem_misaligned_exception_T = or(io.mem_memread, io.mem_memwrite) @[memory.scala 58:50]
    node _mem_misaligned_exception_T_1 = bits(io.mem_aluresult, 1, 0) @[memory.scala 58:90]
    node _mem_misaligned_exception_T_2 = neq(_mem_misaligned_exception_T_1, UInt<1>("h0")) @[memory.scala 58:97]
    node mem_misaligned_exception = and(_mem_misaligned_exception_T, _mem_misaligned_exception_T_2) @[memory.scala 58:70]
    wire exception : UInt<1>
    exception <= UInt<1>("h0")
    wire ecause_out : UInt<4> @[memory.scala 60:24]
    wire interrupt : UInt<1>
    interrupt <= UInt<1>("h0")
    wire trapped : UInt<1>
    trapped <= UInt<1>("h0")
    wire retired : UInt<1>
    retired <= UInt<1>("h0")
    when io.eip : @[memory.scala 65:16]
      ecause_out <= UInt<4>("hb") @[memory.scala 66:16]
      interrupt <= UInt<1>("h1") @[memory.scala 67:15]
    else :
      when io.tip : @[memory.scala 68:22]
        ecause_out <= UInt<3>("h7") @[memory.scala 69:16]
        interrupt <= UInt<1>("h1") @[memory.scala 70:15]
      else :
        when io.sip : @[memory.scala 71:22]
          ecause_out <= UInt<2>("h3") @[memory.scala 72:16]
          interrupt <= UInt<1>("h1") @[memory.scala 73:15]
        else :
          node _T = eq(io.exception_in, UInt<1>("h0")) @[memory.scala 74:14]
          node _T_1 = and(_T, load_exception) @[memory.scala 74:31]
          when _T_1 : @[memory.scala 74:50]
            exception <= UInt<1>("h1") @[memory.scala 75:15]
            ecause_out <= UInt<3>("h5") @[memory.scala 76:16]
            interrupt <= UInt<1>("h0") @[memory.scala 77:15]
          else :
            node _T_2 = eq(io.exception_in, UInt<1>("h0")) @[memory.scala 78:14]
            node _T_3 = and(_T_2, mem_misaligned_exception) @[memory.scala 78:31]
            when _T_3 : @[memory.scala 78:60]
              exception <= UInt<1>("h1") @[memory.scala 79:15]
              node _ecause_out_T = mux(io.mem_memread, UInt<3>("h4"), UInt<3>("h6")) @[memory.scala 80:22]
              ecause_out <= _ecause_out_T @[memory.scala 80:16]
              interrupt <= UInt<1>("h0") @[memory.scala 81:15]
            else :
              exception <= io.exception_in @[memory.scala 83:15]
              ecause_out <= io.ecause_in @[memory.scala 84:16]
              interrupt <= UInt<1>("h0") @[memory.scala 85:15]
    node _trapped_T = or(io.sip, io.tip) @[memory.scala 88:22]
    node _trapped_T_1 = or(_trapped_T, io.eip) @[memory.scala 88:32]
    node _trapped_T_2 = or(_trapped_T_1, exception) @[memory.scala 88:42]
    trapped <= _trapped_T_2 @[memory.scala 88:11]
    node _retired_T = eq(trapped, UInt<1>("h0")) @[memory.scala 89:14]
    node _retired_T_1 = eq(io.wfi_in, UInt<1>("h0")) @[memory.scala 89:26]
    node _retired_T_2 = and(_retired_T, _retired_T_1) @[memory.scala 89:23]
    retired <= _retired_T_2 @[memory.scala 89:11]
    inst branch of Branch @[memory.scala 93:22]
    branch.clock <= clock
    branch.reset <= reset
    branch.io.mem_zero <= io.mem_zero @[memory.scala 94:22]
    branch.io.mem_aluresult <= io.mem_aluresult @[memory.scala 95:27]
    branch.io.mem_funct3 <= io.mem_funct3 @[memory.scala 96:24]
    branch.io.mem_isbranch <= io.mem_isbranch @[memory.scala 97:26]
    branch.io.mem_isjump <= io.mem_isjump @[memory.scala 98:24]
    inst dataCache of DataCache @[memory.scala 101:25]
    dataCache.clock <= clock
    dataCache.reset <= reset
    dataCache.io.mem_aluresult <= io.mem_aluresult @[memory.scala 102:30]
    dataCache.io.mem_rs2_data <= io.mem_rs2_data @[memory.scala 103:29]
    dataCache.io.mem_memread <= io.mem_memread @[memory.scala 104:28]
    dataCache.io.mem_funct3 <= io.mem_funct3 @[memory.scala 105:27]
    node _dataCache_io_mem_memwrite_T = and(io.mem_memwrite, trapped) @[memory.scala 106:48]
    dataCache.io.mem_memwrite <= _dataCache_io_mem_memwrite_T @[memory.scala 106:29]
    reg csr_write_enable_out_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 109:41]
    reg csr_write_address_out_reg : UInt<12>, clock with :
      reset => (reset, UInt<12>("h0")) @[memory.scala 110:42]
    reg csr_write_data_out_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[memory.scala 111:39]
    reg ecause_out_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[memory.scala 112:31]
    reg trapped_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 113:28]
    reg interrupt_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 114:30]
    reg inst_retired_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 115:33]
    reg csr_read_data_out_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[memory.scala 116:38]
    reg mret_out_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 117:29]
    reg wfi_out_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 118:28]
    reg wb_reg_pc_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[memory.scala 119:30]
    reg wb_readdata_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[memory.scala 120:32]
    reg wb_aluresult_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[memory.scala 121:33]
    reg wb_memtoreg_reg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[memory.scala 122:32]
    reg wb_regwrite_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 123:32]
    reg wb_rd_reg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[memory.scala 124:26]
    reg pcsrc_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 125:26]
    reg branch_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[memory.scala 126:27]
    node _T_4 = eq(io.mem_wb_flush, UInt<1>("h0")) @[memory.scala 130:8]
    when _T_4 : @[memory.scala 130:26]
      csr_write_enable_out_reg <= io.csr_write_enable_in @[memory.scala 131:30]
      csr_write_address_out_reg <= io.csr_write_address_in @[memory.scala 132:31]
      csr_write_data_out_reg <= io.csr_write_data_in @[memory.scala 133:28]
      ecause_out_reg <= ecause_out @[memory.scala 134:20]
      trapped_reg <= trapped @[memory.scala 135:17]
      interrupt_reg <= interrupt @[memory.scala 136:19]
      inst_retired_reg <= retired @[memory.scala 137:22]
      mret_out_reg <= io.mret_in @[memory.scala 138:18]
    else :
      csr_write_enable_out_reg <= UInt<1>("h0") @[memory.scala 140:30]
      csr_write_address_out_reg <= UInt<1>("h0") @[memory.scala 141:31]
      csr_write_data_out_reg <= UInt<1>("h0") @[memory.scala 142:28]
      ecause_out_reg <= UInt<1>("h0") @[memory.scala 143:20]
      trapped_reg <= UInt<1>("h0") @[memory.scala 144:17]
      interrupt_reg <= UInt<1>("h0") @[memory.scala 145:19]
      inst_retired_reg <= UInt<1>("h0") @[memory.scala 146:22]
      mret_out_reg <= UInt<1>("h0") @[memory.scala 147:18]
    node _T_5 = eq(io.mem_wb_flush, UInt<1>("h0")) @[memory.scala 151:8]
    when _T_5 : @[memory.scala 151:26]
      csr_read_data_out_reg <= io.csr_read_data_in @[memory.scala 152:27]
      wfi_out_reg <= io.wfi_in @[memory.scala 153:17]
      wb_reg_pc_reg <= io.reg_pc @[memory.scala 154:19]
      wb_readdata_reg <= dataCache.io.read_data @[memory.scala 155:21]
      wb_aluresult_reg <= io.mem_aluresult @[memory.scala 156:22]
      wb_memtoreg_reg <= io.mem_memtoreg @[memory.scala 157:21]
      wb_regwrite_reg <= io.mem_regwrite @[memory.scala 158:21]
      wb_rd_reg <= io.mem_rd @[memory.scala 159:15]
    else :
      csr_read_data_out_reg <= UInt<1>("h0") @[memory.scala 161:27]
      wfi_out_reg <= UInt<1>("h0") @[memory.scala 162:17]
      wb_reg_pc_reg <= UInt<1>("h0") @[memory.scala 163:19]
      wb_readdata_reg <= UInt<1>("h0") @[memory.scala 164:21]
      wb_aluresult_reg <= UInt<1>("h0") @[memory.scala 165:22]
      wb_memtoreg_reg <= UInt<1>("h0") @[memory.scala 166:21]
      wb_regwrite_reg <= UInt<1>("h0") @[memory.scala 167:21]
      wb_rd_reg <= UInt<1>("h0") @[memory.scala 168:15]
    node _T_6 = eq(io.mem_wb_flush, UInt<1>("h0")) @[memory.scala 172:8]
    when _T_6 : @[memory.scala 172:26]
      pcsrc_reg <= branch.io.pcsrc @[memory.scala 173:15]
      branch_reg <= branch.io.branch @[memory.scala 174:16]
    else :
      pcsrc_reg <= UInt<1>("h0") @[memory.scala 176:15]
      branch_reg <= UInt<1>("h0") @[memory.scala 177:16]
    io.csr_write_enable_out <= csr_write_enable_out_reg @[memory.scala 181:27]
    io.csr_write_address_out <= csr_write_address_out_reg @[memory.scala 182:28]
    io.csr_write_data_out <= csr_write_data_out_reg @[memory.scala 183:25]
    io.ecause_out <= ecause_out_reg @[memory.scala 184:17]
    io.trapped <= trapped_reg @[memory.scala 185:14]
    io.interrupt <= interrupt_reg @[memory.scala 186:16]
    io.inst_retired <= inst_retired_reg @[memory.scala 187:19]
    io.csr_read_data_out <= csr_read_data_out_reg @[memory.scala 188:24]
    io.mret_out <= mret_out_reg @[memory.scala 189:15]
    io.wfi_out <= wfi_out_reg @[memory.scala 190:14]
    io.wb_reg_pc <= wb_reg_pc_reg @[memory.scala 191:16]
    io.wb_readdata <= wb_readdata_reg @[memory.scala 192:18]
    io.wb_aluresult <= wb_aluresult_reg @[memory.scala 193:19]
    io.wb_memtoreg <= wb_memtoreg_reg @[memory.scala 194:18]
    io.wb_regwrite <= wb_regwrite_reg @[memory.scala 195:18]
    io.wb_rd <= wb_rd_reg @[memory.scala 196:12]
    io.pcsrc <= pcsrc_reg @[memory.scala 197:12]
    io.branch <= branch_reg @[memory.scala 198:13]

