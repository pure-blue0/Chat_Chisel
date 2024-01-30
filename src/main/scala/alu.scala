import chisel3._
import chisel3.util._

class ALU extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))
    val alu_in2 = Input(UInt(32.W))
    val aluop = Input(UInt(4.W))
    val zero = Output(UInt(1.W))
    val alu_result = Output(UInt(32.W))
  })

  val add_result = io.alu_in1 + io.alu_in2
  val sub_result = io.alu_in1 - io.alu_in2
  val xor_result = io.alu_in1 ^ io.alu_in2
  val or_result = io.alu_in1 | io.alu_in2
  val and_result = io.alu_in1 & io.alu_in2
  val sll_result = io.alu_in1 << io.alu_in2(4, 0)
  val srl_result = io.alu_in1 >> io.alu_in2(4, 0)
  val sra_result = (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt
  val slt_result = io.alu_in1.asSInt < io.alu_in2.asSInt
  val sltu_result = io.alu_in1 < io.alu_in2

  io.zero := (io.alu_in1 === io.alu_in2)

  io.alu_result := MuxLookup(io.aluop, 0.U, Seq(
    "b0000".U -> add_result,
    "b0001".U -> sub_result,
    "b0010".U -> xor_result,
    "b0011".U -> or_result,
    "b0100".U -> and_result,
    "b0101".U -> sll_result,
    "b0110".U -> srl_result,
    "b0111".U -> sra_result,
    "b1000".U -> slt_result.asUInt,
    "b1001".U -> sltu_result
  ))
}