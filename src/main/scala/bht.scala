import chisel3._
import chisel3.util._

class BHT extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val `match` = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })

  val numEntries = 16
  val tagWidth = 28

  class BHTEntry extends Bundle {
    val tag = UInt(tagWidth.W)
    val valid = UInt(1.W)
    val target_pc = UInt(32.W)
  }

  val bhtTable = Mem(numEntries, new BHTEntry)

  val index = io.pc(3, 0)

  val bhtEntry = bhtTable.read(index)

  io.`match` := bhtEntry.tag === io.pc(31, 4)
  io.valid := bhtEntry.valid
  io.bht_pred_pc := bhtEntry.target_pc

  when(io.pcsrc === 1.U) {
    val newEntry = Wire(new BHTEntry)
    newEntry.tag := io.mem_pc(31, 4)
    newEntry.valid := 1.U
    newEntry.target_pc := io.target_pc
    bhtTable.write(index, newEntry)
  }
}
