circuit ImmGen :
  module ImmGen :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inst : UInt<32>, imm : UInt<32>}

    node opcode = bits(io.inst, 6, 0) @[immgen.scala 11:23]
    wire fmt : UInt<3>
    fmt <= UInt<3>("h0")
    node _T = eq(UInt<6>("h33"), opcode) @[immgen.scala 14:19]
    when _T : @[immgen.scala 14:19]
      fmt <= UInt<1>("h0") @[immgen.scala 15:29]
    else :
      node _T_1 = eq(UInt<5>("h13"), opcode) @[immgen.scala 14:19]
      when _T_1 : @[immgen.scala 14:19]
        fmt <= UInt<1>("h1") @[immgen.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h3"), opcode) @[immgen.scala 14:19]
        when _T_2 : @[immgen.scala 14:19]
          fmt <= UInt<1>("h1") @[immgen.scala 17:29]
        else :
          node _T_3 = eq(UInt<6>("h23"), opcode) @[immgen.scala 14:19]
          when _T_3 : @[immgen.scala 14:19]
            fmt <= UInt<2>("h2") @[immgen.scala 18:29]
          else :
            node _T_4 = eq(UInt<7>("h63"), opcode) @[immgen.scala 14:19]
            when _T_4 : @[immgen.scala 14:19]
              fmt <= UInt<2>("h3") @[immgen.scala 19:29]
            else :
              node _T_5 = eq(UInt<7>("h6f"), opcode) @[immgen.scala 14:19]
              when _T_5 : @[immgen.scala 14:19]
                fmt <= UInt<3>("h4") @[immgen.scala 20:29]
              else :
                node _T_6 = eq(UInt<7>("h67"), opcode) @[immgen.scala 14:19]
                when _T_6 : @[immgen.scala 14:19]
                  fmt <= UInt<3>("h5") @[immgen.scala 21:29]
                else :
                  node _T_7 = eq(UInt<6>("h37"), opcode) @[immgen.scala 14:19]
                  when _T_7 : @[immgen.scala 14:19]
                    fmt <= UInt<3>("h6") @[immgen.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<5>("h17"), opcode) @[immgen.scala 14:19]
                    when _T_8 : @[immgen.scala 14:19]
                      fmt <= UInt<3>("h7") @[immgen.scala 23:29]
    wire imm : UInt<32>
    imm <= UInt<32>("h0")
    node _T_9 = eq(UInt<1>("h0"), fmt) @[immgen.scala 28:16]
    when _T_9 : @[immgen.scala 28:16]
      imm <= UInt<1>("h0") @[immgen.scala 29:25]
    else :
      node _T_10 = eq(UInt<1>("h1"), fmt) @[immgen.scala 28:16]
      when _T_10 : @[immgen.scala 28:16]
        node _imm_T = bits(io.inst, 31, 31) @[immgen.scala 30:48]
        node _imm_T_1 = bits(_imm_T, 0, 0) @[Bitwise.scala 74:15]
        node _imm_T_2 = mux(_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
        node _imm_T_3 = bits(io.inst, 31, 20) @[immgen.scala 30:62]
        node _imm_T_4 = cat(_imm_T_2, _imm_T_3) @[Cat.scala 31:58]
        imm <= _imm_T_4 @[immgen.scala 30:25]
      else :
        node _T_11 = eq(UInt<2>("h2"), fmt) @[immgen.scala 28:16]
        when _T_11 : @[immgen.scala 28:16]
          node _imm_T_5 = bits(io.inst, 31, 31) @[immgen.scala 31:48]
          node _imm_T_6 = bits(_imm_T_5, 0, 0) @[Bitwise.scala 74:15]
          node _imm_T_7 = mux(_imm_T_6, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
          node _imm_T_8 = bits(io.inst, 31, 25) @[immgen.scala 31:62]
          node _imm_T_9 = bits(io.inst, 11, 7) @[immgen.scala 31:79]
          node imm_hi = cat(_imm_T_7, _imm_T_8) @[Cat.scala 31:58]
          node _imm_T_10 = cat(imm_hi, _imm_T_9) @[Cat.scala 31:58]
          imm <= _imm_T_10 @[immgen.scala 31:25]
        else :
          node _T_12 = eq(UInt<2>("h3"), fmt) @[immgen.scala 28:16]
          when _T_12 : @[immgen.scala 28:16]
            node _imm_T_11 = bits(io.inst, 31, 31) @[immgen.scala 32:48]
            node _imm_T_12 = bits(_imm_T_11, 0, 0) @[Bitwise.scala 74:15]
            node _imm_T_13 = mux(_imm_T_12, UInt<19>("h7ffff"), UInt<19>("h0")) @[Bitwise.scala 74:12]
            node _imm_T_14 = bits(io.inst, 7, 7) @[immgen.scala 32:62]
            node _imm_T_15 = bits(io.inst, 30, 25) @[immgen.scala 32:74]
            node _imm_T_16 = bits(io.inst, 11, 8) @[immgen.scala 32:91]
            node imm_lo = cat(_imm_T_16, UInt<1>("h0")) @[Cat.scala 31:58]
            node imm_hi_hi = cat(_imm_T_13, _imm_T_14) @[Cat.scala 31:58]
            node imm_hi_1 = cat(imm_hi_hi, _imm_T_15) @[Cat.scala 31:58]
            node _imm_T_17 = cat(imm_hi_1, imm_lo) @[Cat.scala 31:58]
            imm <= _imm_T_17 @[immgen.scala 32:25]
          else :
            node _T_13 = eq(UInt<3>("h4"), fmt) @[immgen.scala 28:16]
            when _T_13 : @[immgen.scala 28:16]
              node _imm_T_18 = bits(io.inst, 31, 31) @[immgen.scala 33:48]
              node _imm_T_19 = bits(_imm_T_18, 0, 0) @[Bitwise.scala 74:15]
              node _imm_T_20 = mux(_imm_T_19, UInt<11>("h7ff"), UInt<11>("h0")) @[Bitwise.scala 74:12]
              node _imm_T_21 = bits(io.inst, 19, 12) @[immgen.scala 33:62]
              node _imm_T_22 = bits(io.inst, 20, 20) @[immgen.scala 33:79]
              node _imm_T_23 = bits(io.inst, 30, 21) @[immgen.scala 33:92]
              node imm_lo_1 = cat(_imm_T_23, UInt<1>("h0")) @[Cat.scala 31:58]
              node imm_hi_hi_1 = cat(_imm_T_20, _imm_T_21) @[Cat.scala 31:58]
              node imm_hi_2 = cat(imm_hi_hi_1, _imm_T_22) @[Cat.scala 31:58]
              node _imm_T_24 = cat(imm_hi_2, imm_lo_1) @[Cat.scala 31:58]
              imm <= _imm_T_24 @[immgen.scala 33:25]
            else :
              node _T_14 = eq(UInt<3>("h5"), fmt) @[immgen.scala 28:16]
              when _T_14 : @[immgen.scala 28:16]
                node _imm_T_25 = bits(io.inst, 31, 31) @[immgen.scala 34:48]
                node _imm_T_26 = bits(_imm_T_25, 0, 0) @[Bitwise.scala 74:15]
                node _imm_T_27 = mux(_imm_T_26, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
                node _imm_T_28 = bits(io.inst, 31, 20) @[immgen.scala 34:62]
                node _imm_T_29 = cat(_imm_T_27, _imm_T_28) @[Cat.scala 31:58]
                imm <= _imm_T_29 @[immgen.scala 34:25]
              else :
                node _T_15 = eq(UInt<3>("h6"), fmt) @[immgen.scala 28:16]
                when _T_15 : @[immgen.scala 28:16]
                  node _imm_T_30 = bits(io.inst, 31, 12) @[immgen.scala 35:39]
                  node _imm_T_31 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
                  node _imm_T_32 = cat(_imm_T_30, _imm_T_31) @[Cat.scala 31:58]
                  imm <= _imm_T_32 @[immgen.scala 35:25]
                else :
                  node _T_16 = eq(UInt<3>("h7"), fmt) @[immgen.scala 28:16]
                  when _T_16 : @[immgen.scala 28:16]
                    node _imm_T_33 = bits(io.inst, 31, 12) @[immgen.scala 36:39]
                    node _imm_T_34 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
                    node _imm_T_35 = cat(_imm_T_33, _imm_T_34) @[Cat.scala 31:58]
                    imm <= _imm_T_35 @[immgen.scala 36:25]
    io.imm <= imm @[immgen.scala 40:10]

