import chisel3._
import chisel3.util._

class ImmGen extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val imm = Output(UInt(32.W))
  })

  // Implementation goes here
  val opcode = io.inst(6, 0)
  val fmt = WireDefault(0.U(3.W)) // Default format, will be overridden in the following statements

  switch (opcode) {
    is ("b0110011".U) { fmt := "b000".U }
    is ("b0010011".U) { fmt := "b001".U }
    is ("b0000011".U) { fmt := "b001".U }
    is ("b0100011".U) { fmt := "b010".U }
    is ("b1100011".U) { fmt := "b011".U }
    is ("b1101111".U) { fmt := "b100".U }
    is ("b1100111".U) { fmt := "b101".U }
    is ("b0110111".U) { fmt := "b110".U }
    is ("b0010111".U) { fmt := "b111".U }
  }

  val imm = WireDefault(0.U(32.W))

  switch (fmt) {
    is ("b000".U) { imm := 0.U } // R-type
    is ("b001".U) { imm := Cat(Fill(20, io.inst(31)), io.inst(31, 20)) } // I-type
    is ("b010".U) { imm := Cat(Fill(20, io.inst(31)), io.inst(31, 25), io.inst(11, 7)) } // S-type
    is ("b011".U) { imm := Cat(Fill(19, io.inst(31)), io.inst(7), io.inst(30, 25), io.inst(11, 8), 0.U) } // B-type
    is ("b100".U) { imm := Cat(Fill(11, io.inst(31)), io.inst(19, 12), io.inst(20), io.inst(30, 21), 0.U) } // J-type
    is ("b101".U) { imm := Cat(Fill(20, io.inst(31)), io.inst(31, 20)) } // I-type
    is ("b110".U) { imm := Cat(io.inst(31, 12), Fill(12, 0.U)) } // U-type
    is ("b111".U) { imm := Cat(io.inst(31, 12), Fill(12, 0.U)) } // U-type
  
  }

  io.imm := imm
}