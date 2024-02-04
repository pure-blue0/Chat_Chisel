import chisel3._
import chisel3.util._
class Icache extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val inst = Output(UInt(32.W))
  })

  // Define internal components and signals
  val cacheData = Mem(1048576, UInt(32.W)) // Assuming 1MB entries in the cache
  val cacheIndex = io.pc(17, 2) // Extract bits 17 to 2 from the pc as the cache index
  //val cacheTag = io.pc(31, 18) // Extract bits 31 to 18 from the pc as the cache tag

  // Read instruction from the cache based on the tag and index
  val cacheEntry = cacheData(cacheIndex)
  io.inst := cacheEntry
  //val cacheTagMatch = cacheEntry(31, 10) === cacheTag
  //io.inst := Mux(cacheTagMatch, cacheEntry, 0.U)

  // Update cache (not shown in this simplified example)
  // ...

}