import chisel3._
import chisel3.util._

class Memory extends Module {
  val io = IO(new Bundle {
    // Inputs from Execute stage
    val csr_read_data_in = Input(UInt(32.W))
    val csr_write_enable_in = Input(Bool())
    val csr_write_address_in = Input(UInt(12.W))
    val csr_write_data_in = Input(UInt(32.W))
    val ecause_in = Input(UInt(4.W))
    val exception_in = Input(Bool())
    val mret_in = Input(Bool())
    val wfi_in = Input(Bool())
    val reg_pc = Input(UInt(32.W))
    val mem_isbranch = Input(Bool())
    val mem_isjump = Input(Bool())
    val mem_memread = Input(Bool())
    val mem_memwrite = Input(Bool())
    val mem_regwrite = Input(Bool())
    val mem_memtoreg = Input(UInt(2.W))
    val mem_zero = Input(Bool())
    val mem_aluresult = Input(UInt(32.W))
    val mem_rs2_data = Input(UInt(32.W))
    val mem_funct3 = Input(UInt(3.W))
    val mem_rd = Input(UInt(5.W))
    // Inputs from CSR module
    val sip = Input(Bool())
    val tip = Input(Bool())
    val eip = Input(Bool())
    // Outputs to CSR module
    val csr_write_enable_out = Output(Bool())
    val csr_write_address_out = Output(UInt(12.W))
    val csr_write_data_out = Output(UInt(32.W))
    val ecause_out = Output(UInt(4.W))
    val trapped = Output(Bool())
    val interrupt = Output(Bool())
    val inst_retired = Output(Bool())
    val mret_out = Output(Bool())
    // Outputs to Writeback stage
    val csr_read_data_out = Output(UInt(32.W))
    val wfi_out = Output(Bool())
    val wb_reg_pc = Output(UInt(32.W))
    val wb_readdata = Output(UInt(32.W))
    val wb_aluresult = Output(UInt(32.W))
    val wb_memtoreg = Output(UInt(2.W))
    // Outputs to Decode stage
    val wb_regwrite = Output(Bool())
    val wb_rd = Output(UInt(5.W))
    // Outputs to Fetch stage
    val pcsrc = Output(Bool())
    val branch = Output(Bool())
    val mem_wb_flush = Input(Bool())
    // Input from Top module
    val memory_read_data = Input(UInt(32.W))
    // Outputs to Top module
    val load_store_unsigned = Output(Bool())
    val memory_size = Output(UInt(2.W))
    val memory_address = Output(UInt(32.W))
    val memory_write_data = Output(UInt(32.W))
    val memory_read = Output(Bool())
    val memory_write = Output(Bool())
  })

   // Handle exceptions and generate outputs
  val load_exception = io.mem_memread && (io.mem_rd =/= 0.U)
  val mem_misaligned_exception = (io.mem_memread || io.mem_memwrite) && (io.mem_aluresult(1, 0) =/= 0.U)
  val exception = WireInit(false.B)
  val ecause_out = Wire(UInt(4.W))
  val interrupt = WireInit(false.B)
  val trapped = WireInit(false.B)
  val retired = WireInit(false.B)

  when(io.eip) {
    ecause_out := 11.U
    interrupt := true.B
  }.elsewhen(io.tip) {
    ecause_out := 7.U
    interrupt := true.B
  }.elsewhen(io.sip) {
    ecause_out := 3.U
    interrupt := true.B
  }.elsewhen(!io.exception_in && load_exception) {
    exception := true.B
    ecause_out := 5.U
    interrupt := false.B
  }.elsewhen(!io.exception_in && mem_misaligned_exception) {
    exception := true.B
    ecause_out := Mux(io.mem_memread, 4.U, 6.U)
    interrupt := false.B
  }.otherwise {
    exception := io.exception_in
    ecause_out := io.ecause_in
    interrupt := false.B
  }

  trapped := (io.sip || io.tip || io.eip || exception)
  retired := !trapped && !io.wfi_in

  // Implement the Memory stage functionality here
  // Instantiate the Branch submodule
  val branch = Module(new Branch)
  branch.io.mem_zero := io.mem_zero
  branch.io.mem_aluresult := io.mem_aluresult
  branch.io.mem_funct3 := io.mem_funct3
  branch.io.mem_isbranch := io.mem_isbranch
  branch.io.mem_isjump := io.mem_isjump

  // Assign the signal to the output ports
  io.memory_address := io.mem_aluresult
  io.memory_write_data := io.mem_rs2_data
  io.memory_read := io.mem_memread
  io.load_store_unsigned := io.mem_funct3(2)
  io.memory_size := io.mem_funct3(1,0)
  io.memory_write := io.mem_memwrite && trapped

  // Define registers for the outputs
  val csr_write_enable_out_reg = RegInit(false.B)
  val csr_write_address_out_reg = RegInit(0.U(12.W))
  val csr_write_data_out_reg = RegInit(0.U(32.W))
  val ecause_out_reg = RegInit(0.U(4.W))
  val trapped_reg = RegInit(false.B)
  val interrupt_reg = RegInit(false.B)
  val inst_retired_reg = RegInit(false.B)
  val csr_read_data_out_reg = RegInit(0.U(32.W))
  val mret_out_reg = RegInit(false.B)
  val wfi_out_reg = RegInit(false.B)
  val wb_reg_pc_reg = RegInit(0.U(32.W))
  val wb_readdata_reg = RegInit(0.U(32.W))
  val wb_aluresult_reg = RegInit(0.U(32.W))
  val wb_memtoreg_reg = RegInit(0.U(2.W))
  val wb_regwrite_reg = RegInit(false.B)
  val wb_rd_reg = RegInit(0.U(5.W))
  val pcsrc_reg = RegInit(false.B)
  val branch_reg = RegInit(false.B)


  // Connect the outputs to the respective registers
  when(!io.mem_wb_flush) {
    csr_write_enable_out_reg := io.csr_write_enable_in
    csr_write_address_out_reg := io.csr_write_address_in
    csr_write_data_out_reg := io.csr_write_data_in
    ecause_out_reg := ecause_out
    trapped_reg := trapped
    interrupt_reg := interrupt
    inst_retired_reg := retired
    mret_out_reg := io.mret_in
  } .otherwise {
    csr_write_enable_out_reg := false.B
    csr_write_address_out_reg := 0.U
    csr_write_data_out_reg := 0.U
    ecause_out_reg := 0.U
    trapped_reg := false.B
    interrupt_reg := false.B
    inst_retired_reg := false.B
    mret_out_reg := false.B
  }

  // Connect the outputs to the Writeback stage registers
  when(!io.mem_wb_flush) {
    csr_read_data_out_reg := io.csr_read_data_in
    wfi_out_reg := io.wfi_in
    wb_reg_pc_reg := io.reg_pc
    wb_readdata_reg := io.memory_read_data
    wb_aluresult_reg := io.mem_aluresult
    wb_memtoreg_reg := io.mem_memtoreg
    wb_regwrite_reg := io.mem_regwrite
    wb_rd_reg := io.mem_rd
  } .otherwise {
    csr_read_data_out_reg := 0.U
    wfi_out_reg := false.B
    wb_reg_pc_reg := 0.U
    wb_readdata_reg := 0.U
    wb_aluresult_reg := 0.U
    wb_memtoreg_reg := 0.U
    wb_regwrite_reg := false.B
    wb_rd_reg := 0.U
  }

  // Connect the outputs to the Decode stage registers
  when(!io.mem_wb_flush) {
    pcsrc_reg := branch.io.pcsrc
    branch_reg := branch.io.branch
  } .otherwise {
    pcsrc_reg := false.B
    branch_reg := false.B
  }

  // Assign the registers to the output ports
  io.csr_write_enable_out := csr_write_enable_out_reg
  io.csr_write_address_out := csr_write_address_out_reg
  io.csr_write_data_out := csr_write_data_out_reg
  io.ecause_out := ecause_out_reg
  io.trapped := trapped_reg
  io.interrupt := interrupt_reg
  io.inst_retired := inst_retired_reg
  io.csr_read_data_out := csr_read_data_out_reg
  io.mret_out := mret_out_reg
  io.wfi_out := wfi_out_reg
  io.wb_reg_pc := wb_reg_pc_reg
  io.wb_readdata := wb_readdata_reg
  io.wb_aluresult := wb_aluresult_reg
  io.wb_memtoreg := wb_memtoreg_reg
  io.wb_regwrite := wb_regwrite_reg
  io.wb_rd := wb_rd_reg
  io.pcsrc := pcsrc_reg
  io.branch := branch_reg
}

// object memorystage extends App {
//   //println(getVerilogString(new Execute))
//   println((new chisel3.stage.ChiselStage).emitVerilog(new Memory))
// }


