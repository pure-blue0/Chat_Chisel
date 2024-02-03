import chisel3._

class TargetGen extends Module {
  val io = IO(new Bundle {
    val ex_pc = Input(UInt(32.W))
    val imm = Input(UInt(32.W))
    val alu_result = Input(UInt(32.W))
    val pcsel = Input(UInt(1.W))
    val rdsel = Input(UInt(1.W))
    val reg_pc = Output(UInt(32.W))
    val target_pc = Output(UInt(32.W))
  })

  when(io.pcsel === 1.U) {
    io.target_pc := io.alu_result
  }.otherwise {
    io.target_pc := io.ex_pc + io.imm
  }

  when(io.rdsel === 1.U) {
    io.reg_pc := io.ex_pc + io.imm
  }.otherwise {
    io.reg_pc := io.ex_pc + 4.U
  }
}


