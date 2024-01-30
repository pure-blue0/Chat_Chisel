import chisel3._
import chisel3.util._

class AluSelect extends Module {
  val io = IO(new Bundle {
    val rs1_data = Input(UInt(32.W))
    val rs2_data = Input(UInt(32.W))
    val imm = Input(UInt(32.W))
    val mem_aluresult = Input(UInt(32.W))
    val writedata = Input(UInt(32.W))
    val immsrc = Input(UInt(1.W))
    val islui = Input(UInt(1.W))
    val forward1 = Input(UInt(2.W))
    val forward2 = Input(UInt(2.W))
    val alu_in1 = Output(UInt(32.W))
    val alu_in2 = Output(UInt(32.W))
  })
  
  // Logic for selecting alu_in1
  val select1 = MuxCase(io.rs1_data, Array(
    (io.forward1 === "b00".U) -> io.rs1_data,
    (io.forward1 === "b01".U) -> io.mem_aluresult,
    (io.forward1 === "b10".U) -> io.writedata
  ))
  val alu_in1 = Mux(io.islui === 1.U, 0.U, select1)
  
  // Logic for selecting alu_in2
  val select2 = MuxCase(io.rs2_data, Array(
    (io.forward2 === "b00".U) -> io.rs2_data,
    (io.forward2 === "b01".U) -> io.mem_aluresult,
    (io.forward2 === "b10".U) -> io.writedata
  ))
  val alu_in2 = Mux(io.immsrc === 1.U, io.imm, select2)
  
  // Assign outputs
  io.alu_in1 := alu_in1
  io.alu_in2 := alu_in2
}

