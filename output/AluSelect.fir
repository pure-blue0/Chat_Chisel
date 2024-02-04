circuit AluSelect :
  module AluSelect :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rs1_data : UInt<32>, flip rs2_data : UInt<32>, flip imm : UInt<32>, flip mem_aluresult : UInt<32>, flip writedata : UInt<32>, flip immsrc : UInt<1>, flip islui : UInt<1>, flip forward1 : UInt<2>, flip forward2 : UInt<2>, alu_in1 : UInt<32>, alu_in2 : UInt<32>}

    node _select1_T = eq(io.forward1, UInt<1>("h0")) @[aluselect.scala 21:18]
    node _select1_T_1 = eq(io.forward1, UInt<1>("h1")) @[aluselect.scala 22:18]
    node _select1_T_2 = eq(io.forward1, UInt<2>("h2")) @[aluselect.scala 23:18]
    node _select1_T_3 = mux(_select1_T_2, io.writedata, io.rs1_data) @[Mux.scala 101:16]
    node _select1_T_4 = mux(_select1_T_1, io.mem_aluresult, _select1_T_3) @[Mux.scala 101:16]
    node select1 = mux(_select1_T, io.rs1_data, _select1_T_4) @[Mux.scala 101:16]
    node _alu_in1_T = eq(io.islui, UInt<1>("h1")) @[aluselect.scala 25:30]
    node alu_in1 = mux(_alu_in1_T, UInt<1>("h0"), select1) @[aluselect.scala 25:20]
    node _select2_T = eq(io.forward2, UInt<1>("h0")) @[aluselect.scala 29:18]
    node _select2_T_1 = eq(io.forward2, UInt<1>("h1")) @[aluselect.scala 30:18]
    node _select2_T_2 = eq(io.forward2, UInt<2>("h2")) @[aluselect.scala 31:18]
    node _select2_T_3 = mux(_select2_T_2, io.writedata, io.rs2_data) @[Mux.scala 101:16]
    node _select2_T_4 = mux(_select2_T_1, io.mem_aluresult, _select2_T_3) @[Mux.scala 101:16]
    node select2 = mux(_select2_T, io.rs2_data, _select2_T_4) @[Mux.scala 101:16]
    node _alu_in2_T = eq(io.immsrc, UInt<1>("h1")) @[aluselect.scala 33:31]
    node alu_in2 = mux(_alu_in2_T, io.imm, select2) @[aluselect.scala 33:20]
    io.alu_in1 <= alu_in1 @[aluselect.scala 36:14]
    io.alu_in2 <= alu_in2 @[aluselect.scala 37:14]

