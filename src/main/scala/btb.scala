import chisel3._
import chisel3.util._

class BTB extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))      // Index to predict
    val mem_pc = Input(UInt(32.W))  // Index to update
    val pcsrc = Input(UInt(1.W))    // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))   // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

  // Define the BTB table with 16 entries (indexed by the lower 4 bits of pc)
  val btbTable = Mem(16, UInt(2.W))

  // Read the BTB table at the index specified by mem_pc
  val btbEntry = btbTable(io.pc(5, 2))

  // Predict the target based on the saturating counter value
  val btbPredict = btbEntry(1)

  // Update the BTB table when a branch instruction is encountered
  when(io.branch === 1.U) {
    when(io.pcsrc === 1.U) {
      // If the branch is taken, increment the saturating counter
      when(btbTable(io.mem_pc(5, 2)) < 3.U) {
        btbTable.write(io.mem_pc(5, 2), btbTable(io.mem_pc(5, 2)) + 1.U)
      }
    }.otherwise {
      // If the branch is not taken, decrement the saturating counter
      when(btbTable(io.mem_pc(5, 2)) > 0.U) {
        btbTable.write(io.mem_pc(5, 2), btbTable(io.mem_pc(5, 2)) - 1.U)
      }
    }
  }
  // Output the prediction result
  io.btb_taken := btbPredict
}