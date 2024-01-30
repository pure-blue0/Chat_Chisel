import chisel3._

class Branch extends Module {
  val io = IO(new Bundle {
    val mem_zero = Input(Bool())
    val mem_aluresult = Input(UInt(32.W))
    val mem_funct3 = Input(UInt(3.W))
    val mem_isbranch = Input(Bool())
    val mem_isjump = Input(Bool())
    val branch = Output(Bool())
    val pcsrc = Output(Bool())
  })

  val funct3 = io.mem_funct3
  val isBranch = io.mem_isbranch
  val isJump = io.mem_isjump

  val branchEq  = (funct3 === "b000".U) && io.mem_zero
  val branchNe  = (funct3 === "b001".U) && !io.mem_zero
  val branchLt  = (funct3 === "b100".U) && io.mem_aluresult(0)
  val branchGe  = (funct3 === "b101".U) && !io.mem_aluresult(0)
  val branchLtu = (funct3 === "b110".U) && io.mem_aluresult(0)
  val branchGeu = (funct3 === "b111".U) && !io.mem_aluresult(0)

  io.branch := isBranch
  io.pcsrc := isJump || (branchEq || branchNe || branchLt || branchGe || branchLtu || branchGeu) && isBranch
}

