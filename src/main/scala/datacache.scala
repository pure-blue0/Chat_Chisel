import chisel3._
import chisel3.util._
class DataCache extends Module {
  val io = IO(new Bundle {
    val mem_aluresult = Input(UInt(32.W)) // address
    val mem_rs2_data = Input(UInt(32.W)) // write data
    val mem_memread = Input(UInt(1.W)) // read enable
    val mem_funct3 = Input(UInt(3.W)) // indicates the type of load/store instruction
    val mem_memwrite = Input(UInt(1.W)) // write enable
    val read_data = Output(UInt(32.W)) // read data
  })

  val mem = Mem(1024, UInt(32.W)) // Data cache memory with 1024 entries, each entry is 32 bits wide

  val address = io.mem_aluresult(9, 2) // Extract bits 9 to 2 from the address for indexing the cache

  when(io.mem_memread === 1.U) {
    // Load operations
    val cacheData = mem.read(address) // Read data from the cache using the address

    // Perform the required operation based on the funct3 value
    val result = Wire(UInt(32.W))
    when(io.mem_funct3 === "b000".U) { // load byte
      result := Cat(Fill(24, cacheData(7)), cacheData(7, 0)) // Perform msb-extend on the lower 8 bits
    }.elsewhen(io.mem_funct3 === "b001".U) { // load half
      result := Cat(Fill(16, cacheData(15)), cacheData(15, 0)) // Perform msb-extend on the lower 16 bits
    }.elsewhen(io.mem_funct3 === "b010".U) { // load word
      result := cacheData // No extension needed for a 32-bit word
    }.elsewhen(io.mem_funct3 === "b100".U) { // load byte unsigned
      result := Cat(0.U(24.W), cacheData(7, 0)) // Perform zero-extension on the lower 8 bits
    }.elsewhen(io.mem_funct3 === "b101".U) { // load half unsigned
      result := Cat(0.U(16.W), cacheData(15, 0)) // Perform zero-extension on the lower 16 bits
    }.otherwise {
      result := 0.U // Invalid funct3, set the result to 0
    }

    io.read_data := result
  }.otherwise {
    // Store operation
    when(io.mem_memwrite === 1.U) {
      // Perform the required operation based on the funct3 value
      val writeData = Wire(UInt(32.W))
      when(io.mem_funct3 === "b000".U) {
        // store byte: store lower 8-bit data to lower 8 bits of assigned address
        writeData := Cat(mem.read(address)(31, 8), io.mem_rs2_data(7, 0))
      }.elsewhen(io.mem_funct3 === "b001".U) {
        // store half: store lower 16-bit data to lower 16 bits of assigned address
        writeData := Cat(mem.read(address)(31, 16), io.mem_rs2_data(15, 0))
      }.elsewhen(io.mem_funct3 === "b010".U) {
        // store: store 32-bit data to assigned address
        writeData := io.mem_rs2_data
      }.otherwise {
        writeData := 0.U // Invalid funct3, store 0
      }

      mem.write(address, writeData) // Write data to the cache using the address
    }

    io.read_data := 0.U // Set read data to 0 for store operations
  }
}

