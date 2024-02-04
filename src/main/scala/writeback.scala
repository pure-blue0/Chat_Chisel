import chisel3._
import chisel3.util._

class Writeback extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

  // Generate the writedata signal based on wb_memtoreg
  io.writedata := MuxLookup(io.wb_memtoreg, io.csr_read_data_in, Seq(
    "b00".U -> io.wb_reg_pc,
    "b01".U -> io.wb_readdata,
    "b10".U -> io.wb_aluresult,
    "b11".U -> io.csr_read_data_in
  ))
}

// object writebackstage extends App {
//   println((new chisel3.stage.ChiselStage).emitVerilog(new Writeback))
// }