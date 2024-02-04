import chisel3._
import chisel3.util._

class Execute extends Module {
  val io = IO(new Bundle {
    // from decode
    val csr_read = Input(Bool())
    val csr_write = Input(Bool())
    val csr_address = Input(UInt(12.W))
    val ecause_in = Input(UInt(4.W))
    val exception_in = Input(Bool())
    val mret_in = Input(Bool())
    val wfi_in = Input(Bool())
    val ex_pc = Input(UInt(32.W))
    val aluop = Input(UInt(4.W))
    val immsrc = Input(Bool())
    val isbranch = Input(Bool())
    val memread = Input(Bool())
    val memwrite = Input(Bool())
    val regwrite = Input(Bool())
    val memtoreg = Input(UInt(2.W))
    val pcsel = Input(Bool())
    val rdsel = Input(Bool())
    val isjump = Input(Bool())
    val islui = Input(Bool())
    val rs1_data = Input(UInt(32.W))
    val rs2_data = Input(UInt(32.W))
    val imm = Input(UInt(32.W))
    val funct3 = Input(UInt(32.W))
    val ex_rs1 = Input(UInt(5.W))
    val ex_rd = Input(UInt(5.W))
    // to fetch
    val mem_pc = Output(UInt(32.W))
    val target_pc = Output(UInt(32.W))
    // from csr
    val csr_read_data = Input(UInt(32.W))
    val readable = Input(Bool())
    val writeable = Input(Bool())
    // to memory
    val csr_read_data_out = Output(UInt(32.W))
    val csr_write_enable_out = Output(Bool())
    val csr_write_address_out = Output(UInt(12.W))
    val csr_write_data_out = Output(UInt(32.W))
    val ecause_out = Output(UInt(4.W))
    val exception_out = Output(Bool())
    val mret_out = Output(Bool())
    val wfi_out = Output(Bool())
    val reg_pc = Output(UInt(32.W))
    val mem_isbranch = Output(Bool())
    val mem_isjump = Output(Bool())
    val mem_memread = Output(Bool())
    val mem_memwrite = Output(Bool())
    val mem_regwrite = Output(Bool())
    val mem_memtoreg = Output(UInt(2.W))
    val mem_zero = Output(Bool())
    val mem_aluresult = Output(UInt(32.W))
    val mem_rs2_data = Output(UInt(32.W))
    val mem_funct3 = Output(UInt(3.W))
    val mem_rd = Output(UInt(5.W))
    // from writeback
    val writedata = Input(UInt(32.W))
    // from hazard
    val forward1 = Input(UInt(2.W))
    val forward2 = Input(UInt(2.W))
    val ex_mem_flush = Input(Bool())
  })

  // Instantiate submodules
  val aluSelect = Module(new AluSelect)
  val alu = Module(new ALU)
  val targetGen = Module(new TargetGen)

  // Instantiate registers for outputs
  val mret_out_reg = RegInit(0.U(1.W))
  val wfi_out_reg = RegInit(0.U(1.W))
  val ecause_out_reg = RegInit(0.U(4.W))
  val exception_out_reg = RegInit(false.B)
  val csr_read_data_out_reg = RegInit(0.U(32.W))
  val csr_write_enable_out_reg = RegInit(false.B)
  val csr_write_address_out_reg = RegInit(0.U(12.W))
  val csr_write_data_out_reg = RegInit(0.U(32.W))
  val reg_pc_reg = RegInit(0.U(32.W))
  val target_pc_reg = RegInit(0.U(32.W))
  val mem_pc_reg = RegInit(0.U(32.W))
  val mem_isbranch_reg = RegInit(false.B)
  val mem_isjump_reg = RegInit(false.B)
  val mem_memread_reg = RegInit(false.B)
  val mem_memwrite_reg = RegInit(false.B)
  val mem_regwrite_reg = RegInit(false.B)
  val mem_memtoreg_reg = RegInit(0.U(2.W))
  val mem_zero_reg = RegInit(false.B)
  val mem_aluresult_reg = RegInit(0.U(32.W))
  val mem_rs2_data_reg = RegInit(0.U(32.W))
  val mem_funct3_reg = RegInit(0.U(3.W))
  val mem_rd_reg = RegInit(0.U(5.W))



  // Connect submodules
  aluSelect.io.rs1_data := io.rs1_data
  aluSelect.io.rs2_data := io.rs2_data
  aluSelect.io.imm := io.imm
  aluSelect.io.mem_aluresult := MuxCase(mem_aluresult_reg, Array(
  (mem_memtoreg_reg === "b00".U) -> reg_pc_reg,
  (mem_memtoreg_reg === "b11".U) -> csr_read_data_out_reg
  ))
  aluSelect.io.writedata := io.writedata
  aluSelect.io.immsrc := io.immsrc
  aluSelect.io.islui := io.islui
  aluSelect.io.forward1 := io.forward1
  aluSelect.io.forward2 := io.forward2
  alu.io.alu_in1 := aluSelect.io.alu_in1
  alu.io.alu_in2 := aluSelect.io.alu_in2
  alu.io.aluop := io.aluop
  targetGen.io.ex_pc := io.ex_pc
  targetGen.io.imm := io.imm
  targetGen.io.alu_result := alu.io.alu_result
  targetGen.io.pcsel := io.pcsel
  targetGen.io.rdsel := io.rdsel
  
  

  // Generate csr_write_data using the provided table
  val csr_write_temp = Mux(io.immsrc, Cat(0.U(27.W), io.ex_rs1), io.rs1_data)
  val csr_write_out = MuxLookup(io.funct3, csr_write_temp, Seq(
    "b001".U -> csr_write_temp,
    "b101".U -> csr_write_temp,
    "b010".U -> (io.csr_read_data | csr_write_temp),
    "b110".U -> (io.csr_read_data | csr_write_temp),
    "b011".U -> (io.csr_read_data & ~csr_write_temp),
    "b111".U -> (io.csr_read_data & ~csr_write_temp)
  ))       

  // Handle exceptions
  val csr_exception = (io.csr_read =/= io.readable) || (io.csr_write =/= io.writeable)

// Update registers on positive edge of ex_mem_flush
  when(io.ex_mem_flush) {
    mret_out_reg := 0.U
    wfi_out_reg := 0.U  
	ecause_out_reg := 0.U  
	exception_out_reg := false.B  
	csr_read_data_out_reg := 0.U  
	csr_write_enable_out_reg := false.B  
	csr_write_address_out_reg := 0.U  
	csr_write_data_out_reg := 0.U  
	reg_pc_reg := 0.U  
	target_pc_reg := 0.U  
	mem_pc_reg := 0.U  
	mem_isbranch_reg := false.B  
	mem_isjump_reg := false.B  
	mem_memread_reg := false.B  
	mem_memwrite_reg := false.B  
	mem_regwrite_reg := false.B  
	mem_memtoreg_reg := 0.U  
	mem_zero_reg := false.B  
	mem_aluresult_reg := 0.U  
	mem_rs2_data_reg := 0.U  
	mem_funct3_reg := 0.U  
	mem_rd_reg := 0.U  
  }.otherwise {  
	mret_out_reg := io.mret_in  
	wfi_out_reg := io.wfi_in  
	ecause_out_reg := Mux(!io.exception_in && csr_exception, 2.U, io.ecause_in)  
	exception_out_reg := Mux(!io.exception_in && csr_exception, true.B, io.exception_in)  
	csr_read_data_out_reg := io.csr_read_data  
	csr_write_enable_out_reg := io.csr_write  
	csr_write_address_out_reg := io.csr_address  
	csr_write_data_out_reg := csr_write_out  
	reg_pc_reg := targetGen.io.reg_pc  
	target_pc_reg := targetGen.io.target_pc  
	mem_pc_reg := io.ex_pc  
	mem_isbranch_reg := io.isbranch  
	mem_isjump_reg := io.isjump  
	mem_memread_reg := io.memread  
	mem_memwrite_reg := io.memwrite  
	mem_regwrite_reg := io.regwrite  
	mem_memtoreg_reg := io.memtoreg  
	mem_zero_reg := alu.io.zero  
	mem_aluresult_reg := alu.io.alu_result  
	mem_rs2_data_reg := io.rs2_data  
	mem_funct3_reg := io.funct3  
	mem_rd_reg := io.ex_rd  
}

	// Assign output signals from registers  
	io.mret_out := mret_out_reg  
	io.wfi_out := wfi_out_reg  
	io.ecause_out := ecause_out_reg  
	io.exception_out := exception_out_reg  
	io.csr_read_data_out := csr_read_data_out_reg  
	io.csr_write_enable_out := csr_write_enable_out_reg  
	io.csr_write_address_out := csr_write_address_out_reg  
	io.csr_write_data_out := csr_write_data_out_reg  
	io.reg_pc := reg_pc_reg  
	io.target_pc := target_pc_reg  
	io.mem_pc := mem_pc_reg  
	io.mem_isbranch := mem_isbranch_reg  
	io.mem_isjump := mem_isjump_reg  
	io.mem_memread := mem_memread_reg  
	io.mem_memwrite := mem_memwrite_reg  
	io.mem_regwrite := mem_regwrite_reg  
	io.mem_memtoreg := mem_memtoreg_reg  
	io.mem_zero := mem_zero_reg  
	io.mem_aluresult := mem_aluresult_reg  
	io.mem_rs2_data := mem_rs2_data_reg  
	io.mem_funct3 := mem_funct3_reg  
	io.mem_rd := mem_rd_reg  
   
}

