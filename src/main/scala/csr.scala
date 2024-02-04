import chisel3._
import chisel3.util._

class CSR extends Module {
  val io = IO(new Bundle {
    // from top
    val meip = Input(Bool())
    // from decode
    val csr_address = Input(UInt(12.W))
    // from execute
    val csr_read_data = Output(UInt(32.W))
    val readable = Output(Bool())
    val writeable = Output(Bool())
    // from memory
    val csr_write_enable = Input(Bool())
    val csr_write_address = Input(Bool())
    val csr_write_data = Input(UInt(32.W))
    val inst_retired = Input(Bool())
    val trapped = Input(Bool())
    val interrupt = Input(Bool())
    val mret = Input(Bool())
    val ecause = Input(UInt(4.W))
    // to memory
    val sip = Output(Bool())
    val tip = Output(Bool())
    val eip = Output(Bool())
    // to fetch
    val trap_vector = Output(UInt(32.W))
    val mret_vector = Output(UInt(32.W))
  })

  // Read-only registers
  val cycle = RegInit(0.U(32.W))
  val time = RegInit(0.U(32.W))
  val instret = RegInit(0.U(32.W))
  val mvendorid = RegInit(0.U(32.W))
  val marchid = RegInit(0.U(32.W))
  val mimpid = RegInit(0.U(32.W))
  val mhartid = RegInit(0.U(32.W))

  // Read and write registers
  val mstatus = RegInit(0.U(32.W))
  val misa = RegInit(0.U(32.W))
  val mip = RegInit(0.U(32.W))
  val mie = RegInit(0.U(32.W))
  val mtvec = RegInit(0.U(32.W))
  val mscratch = RegInit(0.U(32.W))
  val mepc = RegInit(0.U(32.W))
  val mcause = RegInit(0.U(32.W))
  val mtval = RegInit(0.U(32.W))
  val mcycle = RegInit(0.U(32.W))
  val mtime = RegInit(0.U(32.W))
  val minstret = RegInit(0.U(32.W))

  // Update CSR registers based on CSR instructions
  when(io.csr_address === "h780".U) { // mstatus
    when(io.csr_write_enable) {
      mstatus := io.csr_write_data
    }
    io.csr_read_data := mstatus
  }.elsewhen(io.csr_address === "h301".U) { // misa
    when(io.csr_write_enable) {
      misa := io.csr_write_data
    }
    io.csr_read_data := misa
  }.elsewhen(io.csr_address === "h344".U) { // mip
    when(io.csr_write_enable) {
      mip := io.csr_write_data
    }
    io.csr_read_data := mip
  }.elsewhen(io.csr_address === "h304".U) { // mie
    when(io.csr_write_enable) {
      mie := io.csr_write_data
    }
    io.csr_read_data := mie
  }.elsewhen(io.csr_address === "h305".U) { // mtvec
    when(io.csr_write_enable) {
      mtvec := io.csr_write_data
    }
    io.csr_read_data := mtvec
  }.elsewhen(io.csr_address === "h340".U) { // mscratch
    when(io.csr_write_enable) {
      mscratch := io.csr_write_data
    }
    io.csr_read_data := mscratch
  }.elsewhen(io.csr_address === "h341".U) { // mepc
    when(io.csr_write_enable) {
      mepc := io.csr_write_data
    }
    io.csr_read_data := mepc
  }.elsewhen(io.csr_address === "h342".U) { // mcause
    when(io.csr_write_enable) {
      mcause := io.csr_write_data
    }
    io.csr_read_data := mcause
  }.elsewhen(io.csr_address === "h343".U) { // mtval
    when(io.csr_write_enable) {
      mtval := io.csr_write_data
    }
    io.csr_read_data := mtval
  }.elsewhen(io.csr_address === "hB00".U) { // mcycle
    io.csr_read_data := mcycle
}.elsewhen(io.csr_address === "hC00".U) { // mtime
    io.csr_read_data := mtime
  }.elsewhen(io.csr_address === "hB02".U) { // minstret
    io.csr_read_data := minstret
  }.elsewhen(io.csr_address === "hC02".U) { // instret
    io.csr_read_data := instret
  }.elsewhen(io.csr_address === "h100".U) { // cycle
    io.csr_read_data := cycle
  }.elsewhen(io.csr_address === "hC01".U) { // time
    io.csr_read_data := time
  }.elsewhen(io.csr_address === "hF11".U) { // mvendorid
    io.csr_read_data := mvendorid
  }.elsewhen(io.csr_address === "hF12".U) { // marchid
    io.csr_read_data := marchid
  }.elsewhen(io.csr_address === "hF13".U) { // mimpid
    io.csr_read_data := mimpid
  }.elsewhen(io.csr_address === "hF14".U) { // mhartid
    io.csr_read_data := mhartid
  }.otherwise {
    io.csr_read_data := 0.U
  }

  // Determine register readability and writability
  io.readable := (io.csr_address === "hB00".U || io.csr_address === "hC00".U || io.csr_address === "hB02".U || io.csr_address === "hC02".U ||
    io.csr_address === "h100".U || io.csr_address === "hC01".U || io.csr_address === "hF11".U || io.csr_address === "hF12".U ||
    io.csr_address === "hF13".U || io.csr_address === "hF14".U)
  io.writeable := (io.csr_address === "h780".U || io.csr_address === "h301".U || io.csr_address === "h344".U ||
    io.csr_address === "h304".U || io.csr_address === "h305".U || io.csr_address === "h340".U || io.csr_address === "h341".U ||
    io.csr_address === "h342".U || io.csr_address === "h343".U)

  // Update CSR registers based on trap and mret signals
  when(io.trapped) {
    mstatus := Cat(mstatus(31, 3), io.ecause)
    mepc := io.trap_vector
    mscratch := io.csr_read_data
  }.elsewhen(io.mret) {
    mstatus := mstatus & ~"h8".U // Clear MIE bit
    mstatus := mstatus | (mstatus(4, 4) << 3) // Set MPIE bit
    mstatus := mstatus & ~"h80".U // Clear MPP bits
    mepc := mscratch
  }

  // Count cycles and instret
  when(io.inst_retired) {
    cycle := cycle + 1.U
    instret := instret + 1.U
  }

  // Determine interrupt signals
  io.sip := (mip & 1.U) =/= 0.U
  io.tip := (mip & 2.U) =/= 0.U
  io.eip := (mip & 4.U) =/= 0.U

  // Output trap and mret vectors
  io.trap_vector := mepc
  io.mret_vector := mtvec
}
