import chisel3._
import chisel3.util._

class Decode extends Module {
  val io = IO(new Bundle {
    // from fetch stage
    val id_pc = Input(UInt(32.W))
    val inst = Input(UInt(32.W))
    // to execute stage
    val csr_read = Output(Bool())
    val csr_write = Output(Bool())
    val csr_address = Output(UInt(12.W))
    val ecause_out = Output(UInt(4.W))
    val exception_out = Output(Bool())
    val mret_out = Output(Bool())
    val wfi_out = Output(Bool())
    val ex_pc = Output(UInt(32.W))
    val aluop = Output(UInt(4.W))
    val immsrc = Output(Bool())
    val isbranch = Output(Bool())
    val memread = Output(Bool())
    val memwrite = Output(Bool())
    val regwrite = Output(Bool())
    val memtoreg = Output(UInt(2.W))
    val pcsel = Output(Bool())
    val rdsel = Output(Bool())
    val isjump = Output(Bool())
    val islui = Output(Bool())
    val rs1_data = Output(UInt(32.W))
    val rs2_data = Output(UInt(32.W))
    val imm = Output(UInt(32.W))
    val funct3 = Output(UInt(32.W))
    val ex_rs1 = Output(UInt(5.W))
    val ex_rs2 = Output(UInt(5.W))
    val ex_rd = Output(UInt(5.W))
    val ex_use_rs1 = Output(Bool())
    val ex_use_rs2 = Output(Bool())
    // from memory stage
    val wb_rd = Input(UInt(5.W))
    val wb_regwrite = Input(Bool())
    // from writeback stage
    val writedata = Input(UInt(32.W))
    // from hazard detection
    val id_ex_flush = Input(Bool())
    // to hazard detection
    val id_rs1 = Output(UInt(5.W))
    val id_rs2 = Output(UInt(5.W))
    val use_rs1 = Output(Bool())
    val use_rs2 = Output(Bool())
  })
  // Submodules
  val control = Module(new Control)
  val regfile = Module(new Regfile)
  val immGen = Module(new ImmGen)
  
  // Define registers
  val csr_read_reg = RegInit(false.B)
  val csr_write_reg = RegInit(false.B)
  val csr_address_reg = RegInit(0.U(12.W))
  val ecause_out_reg = RegInit(0.U(4.W))
  val exception_out_reg = RegInit(false.B)
  val mret_out_reg = RegInit(false.B)
  val wfi_out_reg = RegInit(false.B)
  val id_ex_pc_reg = RegInit(0.U(32.W))
  val id_ex_aluop_reg = RegInit(0.U(4.W))
  val id_ex_immsrc_reg = RegInit(false.B)
  val id_ex_isbranch_reg = RegInit(false.B)
  val id_ex_memread_reg = RegInit(false.B)
  val id_ex_memwrite_reg = RegInit(false.B)
  val id_ex_regwrite_reg = RegInit(false.B)
  val id_ex_memtoreg_reg = RegInit(0.U(2.W))
  val id_ex_pcsel_reg = RegInit(false.B)
  val id_ex_rdsel_reg = RegInit(false.B)
  val id_ex_isjump_reg = RegInit(false.B)
  val id_ex_islui_reg = RegInit(false.B)
  val id_ex_rs1_data_reg = RegInit(0.U(32.W))
  val id_ex_rs2_data_reg = RegInit(0.U(32.W))
  val id_ex_imm_reg = RegInit(0.U(32.W))
  val id_ex_funct3_reg = RegInit(0.U(3.W))
  val id_ex_ex_rs1_reg = RegInit(0.U(5.W))
  val id_ex_ex_rs2_reg = RegInit(0.U(5.W))
  val id_ex_ex_rd_reg = RegInit(0.U(5.W))
  val id_ex_ex_use_rs1_reg = RegInit(false.B)
  val id_ex_ex_use_rs2_reg = RegInit(false.B)

  // Connect submodules
  control.io.opcode := io.inst(6, 0)
  control.io.funct7 := io.inst(31, 25)
  control.io.funct3 := io.inst(14, 12)

  regfile.io.id_rs1 := io.inst(19, 15)
  regfile.io.id_rs2 := io.inst(24, 20)
  regfile.io.wb_rd := io.wb_rd
  regfile.io.writedata := io.writedata
  regfile.io.wb_regwrite := io.wb_regwrite

  immGen.io.inst := io.inst

  // Decode signals
  val csrInst = io.inst(6, 0).asUInt === "b1110011".U
  val csrrwInst = csrInst && io.inst(14, 12).asUInt === "b001".U
  val csrrsInst = csrInst && io.inst(14, 12).asUInt === "b010".U
  val csrrcInst = csrInst && io.inst(14, 12).asUInt === "b011".U
  val csrrwiInst = csrInst && io.inst(14, 12).asUInt === "b101".U
  val csrrsiInst = csrInst && io.inst(14, 12).asUInt === "b110".U
  val csrrciInst = csrInst && io.inst(14, 12).asUInt === "b111".U

  val csr_read = WireInit(csrInst)
  val csr_write = WireInit(csrInst)

when((csrrwInst || csrrwiInst) && io.inst(11, 7).asUInt === 0.U) {
  csr_read := false.B
}
when((csrrsInst || csrrcInst || csrrsiInst || csrrciInst) && io.inst(19, 15).asUInt === 0.U) {
  csr_write := false.B
}

  val mret_out = io.inst === "b00110000001000000000000001110011".U //Control.mret_INSTRUCTION
  val wfi_out = io.inst ===  "b00010000010100000000000001110011".U //Control.WFI_INSTRUCTION


  val opcode = io.inst(6, 0)
  val funct7 = io.inst(31, 25)
  val funct3 = io.inst(14, 12)
  val isLegalInstruction = Wire(Bool())
  isLegalInstruction := MuxCase(false.B, Array(
    (opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0100000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b100".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b110".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b111".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b001".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0100000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b010".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0110011".U && funct3 === "b011".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b000".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b100".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b110".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b111".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b001".U && funct7 === "b0000000".U)-> true.B,
    (opcode === "b0010011".U && funct3 === "b101".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b101".U && funct7 === "b0100000".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b010".U) -> true.B,
    (opcode === "b0010011".U && funct3 === "b011".U) -> true.B,
    (opcode === "b0000011".U && funct3 === "b000".U) -> true.B,
    (opcode === "b0000011".U && funct3 === "b001".U) -> true.B,
    (opcode === "b0000011".U && funct3 === "b010".U) -> true.B,
    (opcode === "b0000011".U && funct3 === "b100".U) -> true.B,
    (opcode === "b0000011".U && funct3 === "b101".U) -> true.B,
    (opcode === "b0100011".U && funct3 === "b000".U) -> true.B,
    (opcode === "b0100011".U && funct3 === "b001".U) -> true.B,
    (opcode === "b0100011".U && funct3 === "b010".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b000".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b001".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b100".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b101".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b110".U) -> true.B,
    (opcode === "b1100011".U && funct3 === "b111".U) -> true.B,
    (opcode === "b1101111".U) -> true.B,
    (opcode === "b1100111".U && funct3 === "b000".U) -> true.B,
    (opcode === "b0110111".U) -> true.B,
    (opcode === "b0010111".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b000".U && funct7 === "b0000000".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b000".U && funct7 === "b0000001".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b000".U && funct7 === "b0011000".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b000".U && funct7 === "b0001000".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b001".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b010".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b011".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b101".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b110".U) -> true.B,
    (opcode === "b1110011".U && funct3 === "b111".U) -> true.B,
    (opcode === "b0001111".U && funct3 === "b000".U) -> true.B,
    (opcode === "b0001111".U && funct3 === "b001".U) -> true.B,
  ))

  val exception_out = Mux(isLegalInstruction, false.B, true.B)
  val ecause_out = Mux(isLegalInstruction, 0.U, 2.U)


   when(io.id_ex_flush) {
    id_ex_pc_reg := 0.U
    id_ex_aluop_reg := 0.U
    id_ex_immsrc_reg := false.B
    id_ex_isbranch_reg := false.B
    id_ex_memread_reg := false.B
    id_ex_memwrite_reg := false.B
    id_ex_regwrite_reg := false.B
    id_ex_memtoreg_reg := 0.U
    id_ex_pcsel_reg := false.B
    id_ex_rdsel_reg := false.B
    id_ex_isjump_reg := false.B
    id_ex_islui_reg := false.B
    id_ex_rs1_data_reg := 0.U
    id_ex_rs2_data_reg := 0.U
    id_ex_imm_reg := 0.U
    id_ex_funct3_reg := 0.U
    id_ex_ex_rs1_reg := 0.U
    id_ex_ex_rs2_reg := 0.U
    id_ex_ex_rd_reg := 0.U
    id_ex_ex_use_rs1_reg := false.B
    id_ex_ex_use_rs2_reg := false.B
    csr_read_reg := false.B
    csr_write_reg := false.B
    csr_address_reg := 0.U
    ecause_out_reg := 0.U
    exception_out_reg := false.B
    mret_out_reg := false.B
    wfi_out_reg := false.B
  }.otherwise {
    csr_read_reg := csr_read
    csr_write_reg := csr_write
    csr_address_reg := io.inst(31, 20)
    ecause_out_reg := ecause_out
    exception_out_reg := exception_out
    mret_out_reg := mret_out
    wfi_out_reg := wfi_out
    id_ex_pc_reg := io.id_pc
    id_ex_aluop_reg := control.io.aluop
    id_ex_immsrc_reg := control.io.immsrc
    id_ex_isbranch_reg := control.io.isbranch
    id_ex_memread_reg := control.io.memread
    id_ex_memwrite_reg := control.io.memwrite
    id_ex_regwrite_reg := control.io.regwrite
    id_ex_memtoreg_reg := control.io.memtoreg
    id_ex_pcsel_reg := control.io.pcsel
    id_ex_rdsel_reg := control.io.rdsel
    id_ex_isjump_reg := control.io.isjump
    id_ex_islui_reg := control.io.islui
    id_ex_rs1_data_reg := regfile.io.rs1_data
    id_ex_rs2_data_reg := regfile.io.rs2_data
    id_ex_imm_reg := immGen.io.imm
    id_ex_funct3_reg := io.inst(14, 12)
    id_ex_ex_rs1_reg := io.inst(19, 15)
    id_ex_ex_rs2_reg := io.inst(24, 20)
    id_ex_ex_rd_reg := io.inst(11, 7)
    id_ex_ex_use_rs1_reg := control.io.use_rs1
    id_ex_ex_use_rs2_reg := control.io.use_rs2

  }



  // Set output signals
  io.csr_read := csr_read_reg
  io.csr_write := csr_write_reg
  io.csr_address := csr_address_reg
  io.ecause_out := ecause_out_reg
  io.exception_out := exception_out_reg
  io.mret_out := mret_out_reg
  io.wfi_out := wfi_out_reg
  io.ex_pc := id_ex_pc_reg
  io.aluop := id_ex_aluop_reg
  io.immsrc := id_ex_immsrc_reg
  io.isbranch := id_ex_isbranch_reg
  io.memread := id_ex_memread_reg
  io.memwrite := id_ex_memwrite_reg
  io.regwrite := id_ex_regwrite_reg
  io.memtoreg := id_ex_memtoreg_reg
  io.pcsel := id_ex_pcsel_reg
  io.rdsel := id_ex_rdsel_reg
  io.isjump := id_ex_isjump_reg
  io.islui := id_ex_islui_reg
  io.rs1_data := id_ex_rs1_data_reg
  io.rs2_data := id_ex_rs2_data_reg
  io.imm := id_ex_imm_reg
  io.funct3 := id_ex_funct3_reg
  io.ex_rs1 := id_ex_ex_rs1_reg
  io.ex_rs2 := id_ex_ex_rs2_reg
  io.ex_rd := id_ex_ex_rd_reg
  io.ex_use_rs1 := id_ex_ex_use_rs1_reg
  io.ex_use_rs2 := id_ex_ex_use_rs2_reg

  // Hazard detection signals
  io.id_rs1 := io.inst(19, 15)
  io.id_rs2 := io.inst(24, 20)
  io.use_rs1 := control.io.use_rs1
  io.use_rs2 := control.io.use_rs2
}

// object decodestage extends App {
//   //println(getVerilogString(new Decode))
//   println((new chisel3.stage.ChiselStage).emitVerilog(new Decode))
// }