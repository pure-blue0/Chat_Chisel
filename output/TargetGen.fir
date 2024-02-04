circuit TargetGen :
  module TargetGen :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip ex_pc : UInt<32>, flip imm : UInt<32>, flip alu_result : UInt<32>, flip pcsel : UInt<1>, flip rdsel : UInt<1>, reg_pc : UInt<32>, target_pc : UInt<32>}

    node _T = eq(io.pcsel, UInt<1>("h1")) @[targetgen.scala 14:17]
    when _T : @[targetgen.scala 14:26]
      io.target_pc <= io.alu_result @[targetgen.scala 15:18]
    else :
      node _io_target_pc_T = add(io.ex_pc, io.imm) @[targetgen.scala 17:30]
      node _io_target_pc_T_1 = tail(_io_target_pc_T, 1) @[targetgen.scala 17:30]
      io.target_pc <= _io_target_pc_T_1 @[targetgen.scala 17:18]
    node _T_1 = eq(io.rdsel, UInt<1>("h1")) @[targetgen.scala 20:17]
    when _T_1 : @[targetgen.scala 20:26]
      node _io_reg_pc_T = add(io.ex_pc, io.imm) @[targetgen.scala 21:27]
      node _io_reg_pc_T_1 = tail(_io_reg_pc_T, 1) @[targetgen.scala 21:27]
      io.reg_pc <= _io_reg_pc_T_1 @[targetgen.scala 21:15]
    else :
      node _io_reg_pc_T_2 = add(io.ex_pc, UInt<3>("h4")) @[targetgen.scala 23:27]
      node _io_reg_pc_T_3 = tail(_io_reg_pc_T_2, 1) @[targetgen.scala 23:27]
      io.reg_pc <= _io_reg_pc_T_3 @[targetgen.scala 23:15]

