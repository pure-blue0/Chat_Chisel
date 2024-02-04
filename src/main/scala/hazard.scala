import chisel3._
import chisel3.util._
class Hazard extends Module {
  val io = IO(new Bundle {
    //to fetch
    val predict = Output(UInt(1.W))
    val pc_stall = Output(UInt(1.W))
    val if_id_stall = Output(UInt(1.W))
    val if_id_flush = Output(UInt(1.W))
    //from decode
    val memread = Input(UInt(1.W))
    val use_rs1 = Input(UInt(1.W))
    val use_rs2 = Input(UInt(1.W))
    val id_rs1 = Input(UInt(5.W))
    val id_rs2 = Input(UInt(5.W))
    val ex_rd = Input(UInt(5.W))
    val ex_use_rs1 = Input(UInt(1.W))
    val ex_use_rs2 = Input(UInt(1.W))
    val ex_rs1 = Input(UInt(5.W))
    val ex_rs2 = Input(UInt(5.W))
    val ex_pc = Input(UInt(32.W))
    //to decode
    val id_ex_flush = Output(UInt(1.W))
    //from execute
    val mem_rd = Input(UInt(5.W))
    val mem_regwrite = Input(UInt(1.W))
    val mem_pc = Input(UInt(32.W))
    val target_pc = Input(UInt(32.W))
    //to execute
    val forward1 = Output(UInt(2.W))
    val forward2 = Output(UInt(2.W))
    val ex_mem_flush = Output(UInt(1.W))
    //from memory
    val wb_rd = Input(UInt(5.W))
    val wb_regwrite = Input(UInt(1.W))
    val pcsrc = Input(UInt(1.W))
    val trapped = Input(UInt(1.W))
    val mret = Input(UInt(1.W))
    //to memory
    val mem_wb_flush = Output(UInt(1.W))
    
  })

  // Check if data hazard occurs and determine the forward values
  val forward1 = Wire(UInt(2.W))
  val forward2 = Wire(UInt(2.W))

  when(io.ex_use_rs1 === 1.U && io.ex_rs1 === io.mem_rd && io.mem_regwrite === 1.U && io.mem_rd =/= 0.U) {
    forward1 := "b01".U
  }.elsewhen(io.ex_use_rs1 === 1.U && io.ex_rs1 === io.wb_rd && io.wb_regwrite === 1.U && io.wb_rd =/= 0.U) {
    forward1 := "b10".U
  }.otherwise {
    forward1 := "b00".U
  }

  when(io.ex_use_rs2 === 1.U && io.ex_rs2 === io.mem_rd && io.mem_regwrite === 1.U && io.mem_rd =/= 0.U) {
    forward2 := "b01".U
  }.elsewhen(io.ex_use_rs2 === 1.U && io.ex_rs2 === io.wb_rd && io.wb_regwrite === 1.U && io.wb_rd =/= 0.U) {
    forward2 := "b10".U
  }.otherwise {
    forward2 := "b00".U
  }

  // Assign the forward values to the output ports
  io.forward1 := forward1
  io.forward2 := forward2

  // Detect data hazard condition
  val hazard = io.memread === 1.U && ((io.use_rs1 === 1.U && io.id_rs1 === io.ex_rd) || (io.use_rs2 === 1.U &&io.id_rs2 === io.ex_rd))

  // Generate control signals
  io.pc_stall := hazard
  io.if_id_stall := hazard

  // Logic for control hazard detection
  val controlHazard = WireDefault(false.B)
  val predict = WireDefault(false.B)

  when(io.pcsrc === 1.U && io.target_pc =/= io.ex_pc) {
    controlHazard := true.B
  }

  when(io.pcsrc === 0.U && io.ex_pc =/= (io.mem_pc + 4.U)) {
    controlHazard := true.B
  }

  when(io.pcsrc === 1.U && io.target_pc === io.ex_pc) {
    predict := true.B
  }
  // Output control signals for flushing instruct

  io.if_id_flush := controlHazard || io.trapped === 1.U || io.mret === 1.U
  io.ex_mem_flush := controlHazard || io.trapped === 1.U || io.mret === 1.U
  // Set id_ex_flush when either data hazard or control hazard occurs
  io.id_ex_flush := hazard || controlHazard || io.trapped === 1.U || io.mret === 1.U
  io.mem_wb_flush := io.trapped === 1.U || io.mret === 1.U

  io.predict := predict
}