import chisel3._

class Fetch extends Module {
  val io = IO(new Bundle {
    // from csr
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // from execute
    val target_pc = Input(UInt(32.W))
    // from memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // from writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    // from hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    val predict = Input(Bool())
    // to decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
  })

  // Define submodules
  val bht = Module(new BHT)
  val btb = Module(new BTB)
  val icache = Module(new Icache)

  // Define registers
  val pcReg = RegInit("b1000".U(32.W)) // Program Counter register
  val idPcReg = RegInit(0.U(32.W)) // ID_PC register
  val instReg = RegInit(0.U(32.W)) // Instruction register

  // Connect submodule interfaces
  bht.io.pc := pcReg
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc
  bht.io.target_pc := io.target_pc

  btb.io.pc := pcReg
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc
  btb.io.branch := io.branch

  icache.io.pc := pcReg

  // Fetch stage logic
  when(io.trap) {
    pcReg := io.trap_vector
  }.elsewhen(io.mert) {
    pcReg := io.mert_vector
  }.elsewhen(io.pcsrc && !io.predict) {
    pcReg := io.target_pc
  }.elsewhen(io.pc_stall) {
    pcReg := pcReg
  }.elsewhen((btb.io.btb_taken & bht.io.valid & bht.io.`match`) =/= 0.U) {
    pcReg := bht.io.bht_pred_pc
  }.otherwise {
    pcReg := pcReg + 4.U
  }

  // Output to decode stage
  when(io.if_id_stall) {
    idPcReg := idPcReg
    instReg := instReg
  }.otherwise {
    idPcReg := pcReg
    instReg := icache.io.inst
  }

  when(io.if_id_flush) {
    idPcReg := 0.U
    instReg := "b00000000000000000000000000010011".U // addi x0, x0, 0
  }

  io.id_pc := idPcReg
  io.inst := instReg
}



// Let's now generate modules with different widths
object fetchstage extends App {
  println((new chisel3.stage.ChiselStage).emitVerilog(new ImmGen))
}