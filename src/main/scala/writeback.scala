import chisel3._
import chisel3.util._
class Writeback extends Module {
  val io = IO(new Bundle {
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

  // Select the writeback data based on wb_memtoreg signal
  io.writedata := MuxCase(0.U, Array(
    (io.wb_memtoreg === "b00".U) -> io.wb_reg_pc,
    (io.wb_memtoreg === "b01".U) -> io.wb_readdata,
    (io.wb_memtoreg === "b10".U) -> io.wb_aluresult
  ))
}


