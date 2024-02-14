import chisel3._
import chisel3.util._

class core extends Module {
  val io = IO(new Bundle {
      val meip = Input(Bool())
      val fetch_data = Input(UInt(32.W))
      val fetch_address = Output(UInt(32.W))
      val load_store_unsigned = Output(Bool())
      val memory_size = Output(UInt(2.W))
      val memory_address = Output(UInt(32.W))
      val memory_write_data = Output(UInt(32.W))
      val memory_read_data = Input(UInt(32.W))
      val memory_read = Output(Bool())
      val memory_write = Output(Bool())
  })

  val fetch = Module(new Fetch)
  val decode = Module(new Decode)
  val execute = Module(new Execute)
  val memory = Module(new Memory)
  val writeback = Module(new Writeback)
  val csr = Module(new CSR)
  val hazard = Module(new Hazard)

  // Connect the modules
  fetch.io.trap_vector := csr.io.trap_vector
  fetch.io.mret_vector := csr.io.mret_vector
  fetch.io.target_pc := execute.io.target_pc
  fetch.io.mem_pc := execute.io.mem_pc
  fetch.io.pcsrc := memory.io.pcsrc
  fetch.io.branch := memory.io.branch
  fetch.io.trap := memory.io.trapped
  fetch.io.mret := memory.io.mret_out
  fetch.io.pc_stall := hazard.io.pc_stall
  fetch.io.if_id_stall := hazard.io.if_id_stall
  fetch.io.if_id_flush := hazard.io.if_id_flush
  fetch.io.predict := hazard.io.predict
  fetch.io.fetch_data := io.fetch_data

  decode.io.id_pc := fetch.io.id_pc
  decode.io.inst := fetch.io.inst
  decode.io.wb_rd := memory.io.wb_rd
  decode.io.wb_regwrite := memory.io.wb_regwrite
  decode.io.writedata := writeback.io.writedata
  decode.io.id_ex_flush := hazard.io.id_ex_flush

  execute.io.csr_read := decode.io.csr_read
  execute.io.csr_write := decode.io.csr_write
  execute.io.csr_address := decode.io.csr_address
  execute.io.ecause_in := decode.io.ecause_out
  execute.io.exception_in := decode.io.exception_out
  execute.io.mret_in := decode.io.mret_out
  execute.io.wfi_in := decode.io.wfi_out
  execute.io.ex_pc := decode.io.ex_pc
  execute.io.aluop := decode.io.aluop
  execute.io.immsrc := decode.io.immsrc
  execute.io.isbranch := decode.io.isbranch
  execute.io.memread := decode.io.memread
  execute.io.memwrite := decode.io.memwrite
  execute.io.regwrite := decode.io.regwrite
  execute.io.memtoreg := decode.io.memtoreg
  execute.io.pcsel := decode.io.pcsel
  execute.io.rdsel := decode.io.rdsel
  execute.io.isjump := decode.io.isjump
  execute.io.islui := decode.io.islui
  execute.io.rs1_data := decode.io.rs1_data
  execute.io.rs2_data := decode.io.rs2_data
  execute.io.imm := decode.io.imm
  execute.io.funct3 := decode.io.funct3
  execute.io.ex_rs1 := decode.io.ex_rs1
  execute.io.ex_rd := decode.io.ex_rd
  execute.io.csr_read_data := csr.io.csr_read_data
  execute.io.readable := csr.io.readable
  execute.io.writeable := csr.io.writeable
  execute.io.writedata := writeback.io.writedata
  execute.io.forward1 := hazard.io.forward1
  execute.io.forward2 := hazard.io.forward2
  execute.io.ex_mem_flush := hazard.io.ex_mem_flush

  memory.io.csr_read_data_in := execute.io.csr_read_data_out
  memory.io.csr_write_enable_in := execute.io.csr_write_enable_out
  memory.io.csr_write_address_in := execute.io.csr_write_address_out
  memory.io.csr_write_data_in := execute.io.csr_write_data_out
  memory.io.ecause_in := execute.io.ecause_out
  memory.io.exception_in := execute.io.exception_out
  memory.io.mret_in := execute.io.mret_out
  memory.io.wfi_in := execute.io.wfi_out
  memory.io.reg_pc := execute.io.reg_pc
  memory.io.mem_isbranch := execute.io.mem_isbranch
  memory.io.mem_isjump := execute.io.mem_isjump
  memory.io.mem_memread := execute.io.mem_memread
  memory.io.mem_memwrite := execute.io.mem_memwrite
  memory.io.mem_regwrite := execute.io.mem_regwrite
  memory.io.mem_memtoreg := execute.io.mem_memtoreg
  memory.io.mem_zero := execute.io.mem_zero
  memory.io.mem_aluresult := execute.io.mem_aluresult
  memory.io.mem_rs2_data := execute.io.mem_rs2_data
  memory.io.mem_funct3 := execute.io.mem_funct3
  memory.io.mem_rd := execute.io.mem_rd
  memory.io.sip := csr.io.sip
  memory.io.tip := csr.io.tip
  memory.io.eip := csr.io.eip
  memory.io.mem_wb_flush := hazard.io.mem_wb_flush
  memory.io.memory_read_data := io.memory_read_data

  writeback.io.csr_read_data_in := memory.io.csr_read_data_out
  writeback.io.wb_reg_pc := memory.io.wb_reg_pc
  writeback.io.wb_readdata := memory.io.wb_readdata
  writeback.io.wb_aluresult := memory.io.wb_aluresult
  writeback.io.wb_memtoreg := memory.io.wb_memtoreg

  csr.io.meip := io.meip
  csr.io.mem_pc := execute.io.mem_pc
  csr.io.csr_address := decode.io.csr_address
  csr.io.csr_write_enable := memory.io.csr_write_enable_out
  csr.io.csr_write_address := memory.io.csr_write_address_out
  csr.io.csr_write_data := memory.io.csr_write_data_out
  csr.io.inst_retired := memory.io.inst_retired
  csr.io.trapped := memory.io.trapped
  csr.io.interrupt := memory.io.interrupt
  csr.io.mret := memory.io.mret_out
  csr.io.ecause := memory.io.ecause_out

  hazard.io.memread := decode.io.memread
  hazard.io.use_rs1 := decode.io.use_rs1
  hazard.io.use_rs2 := decode.io.use_rs2
  hazard.io.id_rs1 := decode.io.id_rs1
  hazard.io.id_rs2 := decode.io.id_rs2
  hazard.io.ex_rd := decode.io.ex_rd
  hazard.io.ex_use_rs1 := decode.io.ex_use_rs1
  hazard.io.ex_use_rs2 := decode.io.ex_use_rs2
  hazard.io.ex_rs1 := decode.io.ex_rs1
  hazard.io.ex_rs2 := decode.io.ex_rs2
  hazard.io.ex_pc := decode.io.ex_pc
  hazard.io.mem_rd := execute.io.mem_rd
  hazard.io.mem_regwrite := execute.io.mem_regwrite
  hazard.io.mem_pc := execute.io.mem_pc
  hazard.io.target_pc := execute.io.target_pc
  hazard.io.wb_rd := memory.io.wb_rd
  hazard.io.wb_regwrite := memory.io.wb_regwrite
  hazard.io.pcsrc := memory.io.pcsrc
  hazard.io.trapped := memory.io.trapped
  hazard.io.mret := memory.io.mret_out

  io.fetch_address := fetch.io.fetch_address
  io.load_store_unsigned := memory.io.load_store_unsigned
  io.memory_size := memory.io.memory_size
  io.memory_address := memory.io.memory_address
  io.memory_write_data := memory.io.memory_write_data
  io.memory_read := memory.io.memory_read
  io.memory_write := memory.io.memory_write
  
}


object ChiselCore extends App {
  println((new chisel3.stage.ChiselStage).emitVerilog(new core))
  println((new chisel3.stage.ChiselStage).emitVerilog(new Fetch))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Decode))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Execute))
  println((new chisel3.stage.ChiselStage).emitVerilog(new Memory))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Writeback))
  println((new chisel3.stage.ChiselStage).emitVerilog(new CSR))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Hazard))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new AluSelect))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new BHT))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Branch))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new BTB))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Control))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new DataCache))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Icache))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new ImmGen))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new Regfile))
  // println((new chisel3.stage.ChiselStage).emitVerilog(new TargetGen))


}