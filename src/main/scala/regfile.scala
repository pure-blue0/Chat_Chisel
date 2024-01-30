import chisel3._

class Regfile extends Module {
  val io = IO(new Bundle {
    val id_rs1 = Input(UInt(5.W))
    val id_rs2 = Input(UInt(5.W))
    val wb_rd = Input(UInt(5.W))
    val writedata = Input(UInt(32.W))
    val wb_regwrite = Input(Bool())
    val rs1_data = Output(UInt(32.W))
    val rs2_data = Output(UInt(32.W))
  })

  val numRegisters = 32 // Number of registers in the regfile
  val dataWidth = 32 // Width of each register

  val registers = RegInit(VecInit(Seq.fill(numRegisters)(0.U(dataWidth.W))))

  // Read ports
  io.rs1_data := Mux(io.id_rs1 === 0.U, 0.U, registers(io.id_rs1))
  io.rs2_data := Mux(io.id_rs2 === 0.U, 0.U, registers(io.id_rs2))

  // Write port
  when(io.wb_regwrite && io.wb_rd =/= 0.U) {
    registers(io.wb_rd) := io.writedata
  }
}

