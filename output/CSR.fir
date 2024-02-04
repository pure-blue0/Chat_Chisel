circuit CSR :
  module CSR :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip meip : UInt<1>, flip csr_address : UInt<12>, csr_read_data : UInt<32>, readable : UInt<1>, writeable : UInt<1>, flip csr_write_enable : UInt<1>, flip csr_write_address : UInt<1>, flip csr_write_data : UInt<32>, flip inst_retired : UInt<1>, flip trapped : UInt<1>, flip interrupt : UInt<1>, flip mret : UInt<1>, flip ecause : UInt<4>, sip : UInt<1>, tip : UInt<1>, eip : UInt<1>, trap_vector : UInt<32>, mret_vector : UInt<32>}

    reg cycle : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 33:22]
    reg time : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 34:21]
    reg instret : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 35:24]
    reg mvendorid : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 36:26]
    reg marchid : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 37:24]
    reg mimpid : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 38:23]
    reg mhartid : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 39:24]
    reg mstatus : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 42:24]
    reg misa : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 43:21]
    reg mip : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 44:20]
    reg mie : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 45:20]
    reg mtvec : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 46:22]
    reg mscratch : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 47:25]
    reg mepc : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 48:21]
    reg mcause : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 49:23]
    reg mtval : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 50:22]
    reg mcycle : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 51:23]
    reg mtime : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 52:22]
    reg minstret : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[csr.scala 53:25]
    node _T = eq(io.csr_address, UInt<11>("h780")) @[csr.scala 56:23]
    when _T : @[csr.scala 56:37]
      when io.csr_write_enable : @[csr.scala 57:31]
        mstatus <= io.csr_write_data @[csr.scala 58:15]
      io.csr_read_data <= mstatus @[csr.scala 60:22]
    else :
      node _T_1 = eq(io.csr_address, UInt<10>("h301")) @[csr.scala 61:29]
      when _T_1 : @[csr.scala 61:43]
        when io.csr_write_enable : @[csr.scala 62:31]
          misa <= io.csr_write_data @[csr.scala 63:12]
        io.csr_read_data <= misa @[csr.scala 65:22]
      else :
        node _T_2 = eq(io.csr_address, UInt<10>("h344")) @[csr.scala 66:29]
        when _T_2 : @[csr.scala 66:43]
          when io.csr_write_enable : @[csr.scala 67:31]
            mip <= io.csr_write_data @[csr.scala 68:11]
          io.csr_read_data <= mip @[csr.scala 70:22]
        else :
          node _T_3 = eq(io.csr_address, UInt<10>("h304")) @[csr.scala 71:29]
          when _T_3 : @[csr.scala 71:43]
            when io.csr_write_enable : @[csr.scala 72:31]
              mie <= io.csr_write_data @[csr.scala 73:11]
            io.csr_read_data <= mie @[csr.scala 75:22]
          else :
            node _T_4 = eq(io.csr_address, UInt<10>("h305")) @[csr.scala 76:29]
            when _T_4 : @[csr.scala 76:43]
              when io.csr_write_enable : @[csr.scala 77:31]
                mtvec <= io.csr_write_data @[csr.scala 78:13]
              io.csr_read_data <= mtvec @[csr.scala 80:22]
            else :
              node _T_5 = eq(io.csr_address, UInt<10>("h340")) @[csr.scala 81:29]
              when _T_5 : @[csr.scala 81:43]
                when io.csr_write_enable : @[csr.scala 82:31]
                  mscratch <= io.csr_write_data @[csr.scala 83:16]
                io.csr_read_data <= mscratch @[csr.scala 85:22]
              else :
                node _T_6 = eq(io.csr_address, UInt<10>("h341")) @[csr.scala 86:29]
                when _T_6 : @[csr.scala 86:43]
                  when io.csr_write_enable : @[csr.scala 87:31]
                    mepc <= io.csr_write_data @[csr.scala 88:12]
                  io.csr_read_data <= mepc @[csr.scala 90:22]
                else :
                  node _T_7 = eq(io.csr_address, UInt<10>("h342")) @[csr.scala 91:29]
                  when _T_7 : @[csr.scala 91:43]
                    when io.csr_write_enable : @[csr.scala 92:31]
                      mcause <= io.csr_write_data @[csr.scala 93:14]
                    io.csr_read_data <= mcause @[csr.scala 95:22]
                  else :
                    node _T_8 = eq(io.csr_address, UInt<10>("h343")) @[csr.scala 96:29]
                    when _T_8 : @[csr.scala 96:43]
                      when io.csr_write_enable : @[csr.scala 97:31]
                        mtval <= io.csr_write_data @[csr.scala 98:13]
                      io.csr_read_data <= mtval @[csr.scala 100:22]
                    else :
                      node _T_9 = eq(io.csr_address, UInt<12>("hb00")) @[csr.scala 101:29]
                      when _T_9 : @[csr.scala 101:43]
                        io.csr_read_data <= mcycle @[csr.scala 102:22]
                      else :
                        node _T_10 = eq(io.csr_address, UInt<12>("hc00")) @[csr.scala 103:27]
                        when _T_10 : @[csr.scala 103:41]
                          io.csr_read_data <= mtime @[csr.scala 104:22]
                        else :
                          node _T_11 = eq(io.csr_address, UInt<12>("hb02")) @[csr.scala 105:29]
                          when _T_11 : @[csr.scala 105:43]
                            io.csr_read_data <= minstret @[csr.scala 106:22]
                          else :
                            node _T_12 = eq(io.csr_address, UInt<12>("hc02")) @[csr.scala 107:29]
                            when _T_12 : @[csr.scala 107:43]
                              io.csr_read_data <= instret @[csr.scala 108:22]
                            else :
                              node _T_13 = eq(io.csr_address, UInt<9>("h100")) @[csr.scala 109:29]
                              when _T_13 : @[csr.scala 109:43]
                                io.csr_read_data <= cycle @[csr.scala 110:22]
                              else :
                                node _T_14 = eq(io.csr_address, UInt<12>("hc01")) @[csr.scala 111:29]
                                when _T_14 : @[csr.scala 111:43]
                                  io.csr_read_data <= time @[csr.scala 112:22]
                                else :
                                  node _T_15 = eq(io.csr_address, UInt<12>("hf11")) @[csr.scala 113:29]
                                  when _T_15 : @[csr.scala 113:43]
                                    io.csr_read_data <= mvendorid @[csr.scala 114:22]
                                  else :
                                    node _T_16 = eq(io.csr_address, UInt<12>("hf12")) @[csr.scala 115:29]
                                    when _T_16 : @[csr.scala 115:43]
                                      io.csr_read_data <= marchid @[csr.scala 116:22]
                                    else :
                                      node _T_17 = eq(io.csr_address, UInt<12>("hf13")) @[csr.scala 117:29]
                                      when _T_17 : @[csr.scala 117:43]
                                        io.csr_read_data <= mimpid @[csr.scala 118:22]
                                      else :
                                        node _T_18 = eq(io.csr_address, UInt<12>("hf14")) @[csr.scala 119:29]
                                        when _T_18 : @[csr.scala 119:43]
                                          io.csr_read_data <= mhartid @[csr.scala 120:22]
                                        else :
                                          io.csr_read_data <= UInt<1>("h0") @[csr.scala 122:22]
    node _io_readable_T = eq(io.csr_address, UInt<12>("hb00")) @[csr.scala 126:34]
    node _io_readable_T_1 = eq(io.csr_address, UInt<12>("hc00")) @[csr.scala 126:65]
    node _io_readable_T_2 = or(_io_readable_T, _io_readable_T_1) @[csr.scala 126:47]
    node _io_readable_T_3 = eq(io.csr_address, UInt<12>("hb02")) @[csr.scala 126:96]
    node _io_readable_T_4 = or(_io_readable_T_2, _io_readable_T_3) @[csr.scala 126:78]
    node _io_readable_T_5 = eq(io.csr_address, UInt<12>("hc02")) @[csr.scala 126:127]
    node _io_readable_T_6 = or(_io_readable_T_4, _io_readable_T_5) @[csr.scala 126:109]
    node _io_readable_T_7 = eq(io.csr_address, UInt<9>("h100")) @[csr.scala 127:20]
    node _io_readable_T_8 = or(_io_readable_T_6, _io_readable_T_7) @[csr.scala 126:140]
    node _io_readable_T_9 = eq(io.csr_address, UInt<12>("hc01")) @[csr.scala 127:51]
    node _io_readable_T_10 = or(_io_readable_T_8, _io_readable_T_9) @[csr.scala 127:33]
    node _io_readable_T_11 = eq(io.csr_address, UInt<12>("hf11")) @[csr.scala 127:82]
    node _io_readable_T_12 = or(_io_readable_T_10, _io_readable_T_11) @[csr.scala 127:64]
    node _io_readable_T_13 = eq(io.csr_address, UInt<12>("hf12")) @[csr.scala 127:113]
    node _io_readable_T_14 = or(_io_readable_T_12, _io_readable_T_13) @[csr.scala 127:95]
    node _io_readable_T_15 = eq(io.csr_address, UInt<12>("hf13")) @[csr.scala 128:20]
    node _io_readable_T_16 = or(_io_readable_T_14, _io_readable_T_15) @[csr.scala 127:126]
    node _io_readable_T_17 = eq(io.csr_address, UInt<12>("hf14")) @[csr.scala 128:51]
    node _io_readable_T_18 = or(_io_readable_T_16, _io_readable_T_17) @[csr.scala 128:33]
    io.readable <= _io_readable_T_18 @[csr.scala 126:15]
    node _io_writeable_T = eq(io.csr_address, UInt<11>("h780")) @[csr.scala 129:35]
    node _io_writeable_T_1 = eq(io.csr_address, UInt<10>("h301")) @[csr.scala 129:66]
    node _io_writeable_T_2 = or(_io_writeable_T, _io_writeable_T_1) @[csr.scala 129:48]
    node _io_writeable_T_3 = eq(io.csr_address, UInt<10>("h344")) @[csr.scala 129:97]
    node _io_writeable_T_4 = or(_io_writeable_T_2, _io_writeable_T_3) @[csr.scala 129:79]
    node _io_writeable_T_5 = eq(io.csr_address, UInt<10>("h304")) @[csr.scala 130:20]
    node _io_writeable_T_6 = or(_io_writeable_T_4, _io_writeable_T_5) @[csr.scala 129:110]
    node _io_writeable_T_7 = eq(io.csr_address, UInt<10>("h305")) @[csr.scala 130:51]
    node _io_writeable_T_8 = or(_io_writeable_T_6, _io_writeable_T_7) @[csr.scala 130:33]
    node _io_writeable_T_9 = eq(io.csr_address, UInt<10>("h340")) @[csr.scala 130:82]
    node _io_writeable_T_10 = or(_io_writeable_T_8, _io_writeable_T_9) @[csr.scala 130:64]
    node _io_writeable_T_11 = eq(io.csr_address, UInt<10>("h341")) @[csr.scala 130:113]
    node _io_writeable_T_12 = or(_io_writeable_T_10, _io_writeable_T_11) @[csr.scala 130:95]
    node _io_writeable_T_13 = eq(io.csr_address, UInt<10>("h342")) @[csr.scala 131:20]
    node _io_writeable_T_14 = or(_io_writeable_T_12, _io_writeable_T_13) @[csr.scala 130:126]
    node _io_writeable_T_15 = eq(io.csr_address, UInt<10>("h343")) @[csr.scala 131:51]
    node _io_writeable_T_16 = or(_io_writeable_T_14, _io_writeable_T_15) @[csr.scala 131:33]
    io.writeable <= _io_writeable_T_16 @[csr.scala 129:16]
    when io.trapped : @[csr.scala 134:20]
      node _mstatus_T = bits(mstatus, 31, 3) @[csr.scala 135:27]
      node _mstatus_T_1 = cat(_mstatus_T, io.ecause) @[Cat.scala 31:58]
      mstatus <= _mstatus_T_1 @[csr.scala 135:13]
      mepc <= io.trap_vector @[csr.scala 136:10]
      mscratch <= io.csr_read_data @[csr.scala 137:14]
    else :
      when io.mret : @[csr.scala 138:23]
        node _mstatus_T_2 = not(UInt<4>("h8")) @[csr.scala 139:26]
        node _mstatus_T_3 = and(mstatus, _mstatus_T_2) @[csr.scala 139:24]
        mstatus <= _mstatus_T_3 @[csr.scala 139:13]
        node _mstatus_T_4 = bits(mstatus, 4, 4) @[csr.scala 140:34]
        node _mstatus_T_5 = shl(_mstatus_T_4, 3) @[csr.scala 140:41]
        node _mstatus_T_6 = or(mstatus, _mstatus_T_5) @[csr.scala 140:24]
        mstatus <= _mstatus_T_6 @[csr.scala 140:13]
        node _mstatus_T_7 = not(UInt<8>("h80")) @[csr.scala 141:26]
        node _mstatus_T_8 = and(mstatus, _mstatus_T_7) @[csr.scala 141:24]
        mstatus <= _mstatus_T_8 @[csr.scala 141:13]
        mepc <= mscratch @[csr.scala 142:10]
    when io.inst_retired : @[csr.scala 146:25]
      node _cycle_T = add(cycle, UInt<1>("h1")) @[csr.scala 147:20]
      node _cycle_T_1 = tail(_cycle_T, 1) @[csr.scala 147:20]
      cycle <= _cycle_T_1 @[csr.scala 147:11]
      node _instret_T = add(instret, UInt<1>("h1")) @[csr.scala 148:24]
      node _instret_T_1 = tail(_instret_T, 1) @[csr.scala 148:24]
      instret <= _instret_T_1 @[csr.scala 148:13]
    node _io_sip_T = and(mip, UInt<1>("h1")) @[csr.scala 152:18]
    node _io_sip_T_1 = neq(_io_sip_T, UInt<1>("h0")) @[csr.scala 152:25]
    io.sip <= _io_sip_T_1 @[csr.scala 152:10]
    node _io_tip_T = and(mip, UInt<2>("h2")) @[csr.scala 153:18]
    node _io_tip_T_1 = neq(_io_tip_T, UInt<1>("h0")) @[csr.scala 153:25]
    io.tip <= _io_tip_T_1 @[csr.scala 153:10]
    node _io_eip_T = and(mip, UInt<3>("h4")) @[csr.scala 154:18]
    node _io_eip_T_1 = neq(_io_eip_T, UInt<1>("h0")) @[csr.scala 154:25]
    io.eip <= _io_eip_T_1 @[csr.scala 154:10]
    io.trap_vector <= mepc @[csr.scala 157:18]
    io.mret_vector <= mtvec @[csr.scala 158:18]

