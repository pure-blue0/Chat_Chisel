`include  "Fetch.v"
`include  "Decode.v"
`include  "Execute.v"
`include  "Memory.v"
`include  "Writeback.v"
`include  "CSR.v"
`include  "Hazard.v"
module core(
  input         clock,
  input         reset,
  input         io_meip,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address,
  output        io_load_store_unsigned,
  output [1:0]  io_memory_size,
  output [31:0] io_memory_address,
  output [31:0] io_memory_write_data,
  input  [31:0] io_memory_read_data,
  output        io_memory_read,
  output        io_memory_write
);
  wire  fetch_clock; // @[core.scala 18:21]
  wire  fetch_reset; // @[core.scala 18:21]
  wire [31:0] fetch_io_trap_vector; // @[core.scala 18:21]
  wire [31:0] fetch_io_mret_vector; // @[core.scala 18:21]
  wire [31:0] fetch_io_target_pc; // @[core.scala 18:21]
  wire [31:0] fetch_io_mem_pc; // @[core.scala 18:21]
  wire  fetch_io_pcsrc; // @[core.scala 18:21]
  wire  fetch_io_branch; // @[core.scala 18:21]
  wire  fetch_io_trap; // @[core.scala 18:21]
  wire  fetch_io_mret; // @[core.scala 18:21]
  wire  fetch_io_pc_stall; // @[core.scala 18:21]
  wire  fetch_io_if_id_stall; // @[core.scala 18:21]
  wire  fetch_io_if_id_flush; // @[core.scala 18:21]
  wire  fetch_io_predict; // @[core.scala 18:21]
  wire [31:0] fetch_io_id_pc; // @[core.scala 18:21]
  wire [31:0] fetch_io_inst; // @[core.scala 18:21]
  wire [31:0] fetch_io_fetch_data; // @[core.scala 18:21]
  wire [31:0] fetch_io_fetch_address; // @[core.scala 18:21]
  wire  decode_clock; // @[core.scala 19:22]
  wire  decode_reset; // @[core.scala 19:22]
  wire [31:0] decode_io_id_pc; // @[core.scala 19:22]
  wire [31:0] decode_io_inst; // @[core.scala 19:22]
  wire  decode_io_csr_read; // @[core.scala 19:22]
  wire  decode_io_csr_write; // @[core.scala 19:22]
  wire [11:0] decode_io_csr_address; // @[core.scala 19:22]
  wire [3:0] decode_io_ecause_out; // @[core.scala 19:22]
  wire  decode_io_exception_out; // @[core.scala 19:22]
  wire  decode_io_mret_out; // @[core.scala 19:22]
  wire  decode_io_wfi_out; // @[core.scala 19:22]
  wire [31:0] decode_io_ex_pc; // @[core.scala 19:22]
  wire [3:0] decode_io_aluop; // @[core.scala 19:22]
  wire  decode_io_immsrc; // @[core.scala 19:22]
  wire  decode_io_isbranch; // @[core.scala 19:22]
  wire  decode_io_memread; // @[core.scala 19:22]
  wire  decode_io_memwrite; // @[core.scala 19:22]
  wire  decode_io_regwrite; // @[core.scala 19:22]
  wire [1:0] decode_io_memtoreg; // @[core.scala 19:22]
  wire  decode_io_pcsel; // @[core.scala 19:22]
  wire  decode_io_rdsel; // @[core.scala 19:22]
  wire  decode_io_isjump; // @[core.scala 19:22]
  wire  decode_io_islui; // @[core.scala 19:22]
  wire [31:0] decode_io_rs1_data; // @[core.scala 19:22]
  wire [31:0] decode_io_rs2_data; // @[core.scala 19:22]
  wire [31:0] decode_io_imm; // @[core.scala 19:22]
  wire [31:0] decode_io_funct3; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rs1; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rs2; // @[core.scala 19:22]
  wire [4:0] decode_io_ex_rd; // @[core.scala 19:22]
  wire  decode_io_ex_use_rs1; // @[core.scala 19:22]
  wire  decode_io_ex_use_rs2; // @[core.scala 19:22]
  wire [4:0] decode_io_wb_rd; // @[core.scala 19:22]
  wire  decode_io_wb_regwrite; // @[core.scala 19:22]
  wire [31:0] decode_io_writedata; // @[core.scala 19:22]
  wire  decode_io_id_ex_flush; // @[core.scala 19:22]
  wire [4:0] decode_io_id_rs1; // @[core.scala 19:22]
  wire [4:0] decode_io_id_rs2; // @[core.scala 19:22]
  wire  decode_io_use_rs1; // @[core.scala 19:22]
  wire  decode_io_use_rs2; // @[core.scala 19:22]
  wire  execute_clock; // @[core.scala 20:23]
  wire  execute_reset; // @[core.scala 20:23]
  wire  execute_io_csr_read; // @[core.scala 20:23]
  wire  execute_io_csr_write; // @[core.scala 20:23]
  wire [11:0] execute_io_csr_address; // @[core.scala 20:23]
  wire [3:0] execute_io_ecause_in; // @[core.scala 20:23]
  wire  execute_io_exception_in; // @[core.scala 20:23]
  wire  execute_io_mret_in; // @[core.scala 20:23]
  wire  execute_io_wfi_in; // @[core.scala 20:23]
  wire [31:0] execute_io_ex_pc; // @[core.scala 20:23]
  wire [3:0] execute_io_aluop; // @[core.scala 20:23]
  wire  execute_io_immsrc; // @[core.scala 20:23]
  wire  execute_io_isbranch; // @[core.scala 20:23]
  wire  execute_io_memread; // @[core.scala 20:23]
  wire  execute_io_memwrite; // @[core.scala 20:23]
  wire  execute_io_regwrite; // @[core.scala 20:23]
  wire [1:0] execute_io_memtoreg; // @[core.scala 20:23]
  wire  execute_io_pcsel; // @[core.scala 20:23]
  wire  execute_io_rdsel; // @[core.scala 20:23]
  wire  execute_io_isjump; // @[core.scala 20:23]
  wire  execute_io_islui; // @[core.scala 20:23]
  wire [31:0] execute_io_rs1_data; // @[core.scala 20:23]
  wire [31:0] execute_io_rs2_data; // @[core.scala 20:23]
  wire [31:0] execute_io_imm; // @[core.scala 20:23]
  wire [31:0] execute_io_funct3; // @[core.scala 20:23]
  wire [4:0] execute_io_ex_rs1; // @[core.scala 20:23]
  wire [4:0] execute_io_ex_rd; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_pc; // @[core.scala 20:23]
  wire [31:0] execute_io_target_pc; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_read_data; // @[core.scala 20:23]
  wire  execute_io_readable; // @[core.scala 20:23]
  wire  execute_io_writeable; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_read_data_out; // @[core.scala 20:23]
  wire  execute_io_csr_write_enable_out; // @[core.scala 20:23]
  wire [11:0] execute_io_csr_write_address_out; // @[core.scala 20:23]
  wire [31:0] execute_io_csr_write_data_out; // @[core.scala 20:23]
  wire [3:0] execute_io_ecause_out; // @[core.scala 20:23]
  wire  execute_io_exception_out; // @[core.scala 20:23]
  wire  execute_io_mret_out; // @[core.scala 20:23]
  wire  execute_io_wfi_out; // @[core.scala 20:23]
  wire [31:0] execute_io_reg_pc; // @[core.scala 20:23]
  wire  execute_io_mem_isbranch; // @[core.scala 20:23]
  wire  execute_io_mem_isjump; // @[core.scala 20:23]
  wire  execute_io_mem_memread; // @[core.scala 20:23]
  wire  execute_io_mem_memwrite; // @[core.scala 20:23]
  wire  execute_io_mem_regwrite; // @[core.scala 20:23]
  wire [1:0] execute_io_mem_memtoreg; // @[core.scala 20:23]
  wire  execute_io_mem_zero; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_aluresult; // @[core.scala 20:23]
  wire [31:0] execute_io_mem_rs2_data; // @[core.scala 20:23]
  wire [2:0] execute_io_mem_funct3; // @[core.scala 20:23]
  wire [4:0] execute_io_mem_rd; // @[core.scala 20:23]
  wire [31:0] execute_io_writedata; // @[core.scala 20:23]
  wire [1:0] execute_io_forward1; // @[core.scala 20:23]
  wire [1:0] execute_io_forward2; // @[core.scala 20:23]
  wire  execute_io_ex_mem_flush; // @[core.scala 20:23]
  wire  memory_clock; // @[core.scala 21:22]
  wire  memory_reset; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_read_data_in; // @[core.scala 21:22]
  wire  memory_io_csr_write_enable_in; // @[core.scala 21:22]
  wire [11:0] memory_io_csr_write_address_in; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_write_data_in; // @[core.scala 21:22]
  wire [3:0] memory_io_ecause_in; // @[core.scala 21:22]
  wire  memory_io_exception_in; // @[core.scala 21:22]
  wire  memory_io_mret_in; // @[core.scala 21:22]
  wire  memory_io_wfi_in; // @[core.scala 21:22]
  wire [31:0] memory_io_reg_pc; // @[core.scala 21:22]
  wire  memory_io_mem_isbranch; // @[core.scala 21:22]
  wire  memory_io_mem_isjump; // @[core.scala 21:22]
  wire  memory_io_mem_memread; // @[core.scala 21:22]
  wire  memory_io_mem_memwrite; // @[core.scala 21:22]
  wire  memory_io_mem_regwrite; // @[core.scala 21:22]
  wire [1:0] memory_io_mem_memtoreg; // @[core.scala 21:22]
  wire  memory_io_mem_zero; // @[core.scala 21:22]
  wire [31:0] memory_io_mem_aluresult; // @[core.scala 21:22]
  wire [31:0] memory_io_mem_rs2_data; // @[core.scala 21:22]
  wire [2:0] memory_io_mem_funct3; // @[core.scala 21:22]
  wire [4:0] memory_io_mem_rd; // @[core.scala 21:22]
  wire  memory_io_sip; // @[core.scala 21:22]
  wire  memory_io_tip; // @[core.scala 21:22]
  wire  memory_io_eip; // @[core.scala 21:22]
  wire  memory_io_csr_write_enable_out; // @[core.scala 21:22]
  wire [11:0] memory_io_csr_write_address_out; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_write_data_out; // @[core.scala 21:22]
  wire [3:0] memory_io_ecause_out; // @[core.scala 21:22]
  wire  memory_io_trapped; // @[core.scala 21:22]
  wire  memory_io_interrupt; // @[core.scala 21:22]
  wire  memory_io_inst_retired; // @[core.scala 21:22]
  wire  memory_io_mret_out; // @[core.scala 21:22]
  wire [31:0] memory_io_csr_read_data_out; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_reg_pc; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_readdata; // @[core.scala 21:22]
  wire [31:0] memory_io_wb_aluresult; // @[core.scala 21:22]
  wire [1:0] memory_io_wb_memtoreg; // @[core.scala 21:22]
  wire  memory_io_wb_regwrite; // @[core.scala 21:22]
  wire [4:0] memory_io_wb_rd; // @[core.scala 21:22]
  wire  memory_io_pcsrc; // @[core.scala 21:22]
  wire  memory_io_branch; // @[core.scala 21:22]
  wire  memory_io_mem_wb_flush; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_read_data; // @[core.scala 21:22]
  wire  memory_io_load_store_unsigned; // @[core.scala 21:22]
  wire [1:0] memory_io_memory_size; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_address; // @[core.scala 21:22]
  wire [31:0] memory_io_memory_write_data; // @[core.scala 21:22]
  wire  memory_io_memory_read; // @[core.scala 21:22]
  wire  memory_io_memory_write; // @[core.scala 21:22]
  wire [31:0] writeback_io_csr_read_data_in; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_reg_pc; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_readdata; // @[core.scala 22:25]
  wire [31:0] writeback_io_wb_aluresult; // @[core.scala 22:25]
  wire [1:0] writeback_io_wb_memtoreg; // @[core.scala 22:25]
  wire [31:0] writeback_io_writedata; // @[core.scala 22:25]
  wire  csr_clock; // @[core.scala 23:19]
  wire  csr_reset; // @[core.scala 23:19]
  wire  csr_io_meip; // @[core.scala 23:19]
  wire [11:0] csr_io_csr_address; // @[core.scala 23:19]
  wire [31:0] csr_io_mem_pc; // @[core.scala 23:19]
  wire [31:0] csr_io_csr_read_data; // @[core.scala 23:19]
  wire  csr_io_readable; // @[core.scala 23:19]
  wire  csr_io_writeable; // @[core.scala 23:19]
  wire  csr_io_csr_write_enable; // @[core.scala 23:19]
  wire [11:0] csr_io_csr_write_address; // @[core.scala 23:19]
  wire [31:0] csr_io_csr_write_data; // @[core.scala 23:19]
  wire  csr_io_inst_retired; // @[core.scala 23:19]
  wire  csr_io_trapped; // @[core.scala 23:19]
  wire  csr_io_mret; // @[core.scala 23:19]
  wire [2:0] csr_io_ecause; // @[core.scala 23:19]
  wire  csr_io_interrupt; // @[core.scala 23:19]
  wire  csr_io_eip; // @[core.scala 23:19]
  wire  csr_io_tip; // @[core.scala 23:19]
  wire  csr_io_sip; // @[core.scala 23:19]
  wire [31:0] csr_io_trap_vector; // @[core.scala 23:19]
  wire [31:0] csr_io_mret_vector; // @[core.scala 23:19]
  wire  hazard_io_predict; // @[core.scala 24:22]
  wire  hazard_io_pc_stall; // @[core.scala 24:22]
  wire  hazard_io_if_id_stall; // @[core.scala 24:22]
  wire  hazard_io_if_id_flush; // @[core.scala 24:22]
  wire  hazard_io_memread; // @[core.scala 24:22]
  wire  hazard_io_use_rs1; // @[core.scala 24:22]
  wire  hazard_io_use_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_id_rs1; // @[core.scala 24:22]
  wire [4:0] hazard_io_id_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rd; // @[core.scala 24:22]
  wire  hazard_io_ex_use_rs1; // @[core.scala 24:22]
  wire  hazard_io_ex_use_rs2; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rs1; // @[core.scala 24:22]
  wire [4:0] hazard_io_ex_rs2; // @[core.scala 24:22]
  wire [31:0] hazard_io_ex_pc; // @[core.scala 24:22]
  wire  hazard_io_id_ex_flush; // @[core.scala 24:22]
  wire [4:0] hazard_io_mem_rd; // @[core.scala 24:22]
  wire  hazard_io_mem_regwrite; // @[core.scala 24:22]
  wire [31:0] hazard_io_mem_pc; // @[core.scala 24:22]
  wire [31:0] hazard_io_target_pc; // @[core.scala 24:22]
  wire [1:0] hazard_io_forward1; // @[core.scala 24:22]
  wire [1:0] hazard_io_forward2; // @[core.scala 24:22]
  wire  hazard_io_ex_mem_flush; // @[core.scala 24:22]
  wire [4:0] hazard_io_wb_rd; // @[core.scala 24:22]
  wire  hazard_io_wb_regwrite; // @[core.scala 24:22]
  wire  hazard_io_pcsrc; // @[core.scala 24:22]
  wire  hazard_io_trapped; // @[core.scala 24:22]
  wire  hazard_io_mret; // @[core.scala 24:22]
  wire  hazard_io_mem_wb_flush; // @[core.scala 24:22]
  Fetch fetch ( // @[core.scala 18:21]
    .clock(fetch_clock),
    .reset(fetch_reset),
    .io_trap_vector(fetch_io_trap_vector),
    .io_mret_vector(fetch_io_mret_vector),
    .io_target_pc(fetch_io_target_pc),
    .io_mem_pc(fetch_io_mem_pc),
    .io_pcsrc(fetch_io_pcsrc),
    .io_branch(fetch_io_branch),
    .io_trap(fetch_io_trap),
    .io_mret(fetch_io_mret),
    .io_pc_stall(fetch_io_pc_stall),
    .io_if_id_stall(fetch_io_if_id_stall),
    .io_if_id_flush(fetch_io_if_id_flush),
    .io_predict(fetch_io_predict),
    .io_id_pc(fetch_io_id_pc),
    .io_inst(fetch_io_inst),
    .io_fetch_data(fetch_io_fetch_data),
    .io_fetch_address(fetch_io_fetch_address)
  );
  Decode decode ( // @[core.scala 19:22]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_id_pc(decode_io_id_pc),
    .io_inst(decode_io_inst),
    .io_csr_read(decode_io_csr_read),
    .io_csr_write(decode_io_csr_write),
    .io_csr_address(decode_io_csr_address),
    .io_ecause_out(decode_io_ecause_out),
    .io_exception_out(decode_io_exception_out),
    .io_mret_out(decode_io_mret_out),
    .io_wfi_out(decode_io_wfi_out),
    .io_ex_pc(decode_io_ex_pc),
    .io_aluop(decode_io_aluop),
    .io_immsrc(decode_io_immsrc),
    .io_isbranch(decode_io_isbranch),
    .io_memread(decode_io_memread),
    .io_memwrite(decode_io_memwrite),
    .io_regwrite(decode_io_regwrite),
    .io_memtoreg(decode_io_memtoreg),
    .io_pcsel(decode_io_pcsel),
    .io_rdsel(decode_io_rdsel),
    .io_isjump(decode_io_isjump),
    .io_islui(decode_io_islui),
    .io_rs1_data(decode_io_rs1_data),
    .io_rs2_data(decode_io_rs2_data),
    .io_imm(decode_io_imm),
    .io_funct3(decode_io_funct3),
    .io_ex_rs1(decode_io_ex_rs1),
    .io_ex_rs2(decode_io_ex_rs2),
    .io_ex_rd(decode_io_ex_rd),
    .io_ex_use_rs1(decode_io_ex_use_rs1),
    .io_ex_use_rs2(decode_io_ex_use_rs2),
    .io_wb_rd(decode_io_wb_rd),
    .io_wb_regwrite(decode_io_wb_regwrite),
    .io_writedata(decode_io_writedata),
    .io_id_ex_flush(decode_io_id_ex_flush),
    .io_id_rs1(decode_io_id_rs1),
    .io_id_rs2(decode_io_id_rs2),
    .io_use_rs1(decode_io_use_rs1),
    .io_use_rs2(decode_io_use_rs2)
  );
  Execute execute ( // @[core.scala 20:23]
    .clock(execute_clock),
    .reset(execute_reset),
    .io_csr_read(execute_io_csr_read),
    .io_csr_write(execute_io_csr_write),
    .io_csr_address(execute_io_csr_address),
    .io_ecause_in(execute_io_ecause_in),
    .io_exception_in(execute_io_exception_in),
    .io_mret_in(execute_io_mret_in),
    .io_wfi_in(execute_io_wfi_in),
    .io_ex_pc(execute_io_ex_pc),
    .io_aluop(execute_io_aluop),
    .io_immsrc(execute_io_immsrc),
    .io_isbranch(execute_io_isbranch),
    .io_memread(execute_io_memread),
    .io_memwrite(execute_io_memwrite),
    .io_regwrite(execute_io_regwrite),
    .io_memtoreg(execute_io_memtoreg),
    .io_pcsel(execute_io_pcsel),
    .io_rdsel(execute_io_rdsel),
    .io_isjump(execute_io_isjump),
    .io_islui(execute_io_islui),
    .io_rs1_data(execute_io_rs1_data),
    .io_rs2_data(execute_io_rs2_data),
    .io_imm(execute_io_imm),
    .io_funct3(execute_io_funct3),
    .io_ex_rs1(execute_io_ex_rs1),
    .io_ex_rd(execute_io_ex_rd),
    .io_mem_pc(execute_io_mem_pc),
    .io_target_pc(execute_io_target_pc),
    .io_csr_read_data(execute_io_csr_read_data),
    .io_readable(execute_io_readable),
    .io_writeable(execute_io_writeable),
    .io_csr_read_data_out(execute_io_csr_read_data_out),
    .io_csr_write_enable_out(execute_io_csr_write_enable_out),
    .io_csr_write_address_out(execute_io_csr_write_address_out),
    .io_csr_write_data_out(execute_io_csr_write_data_out),
    .io_ecause_out(execute_io_ecause_out),
    .io_exception_out(execute_io_exception_out),
    .io_mret_out(execute_io_mret_out),
    .io_wfi_out(execute_io_wfi_out),
    .io_reg_pc(execute_io_reg_pc),
    .io_mem_isbranch(execute_io_mem_isbranch),
    .io_mem_isjump(execute_io_mem_isjump),
    .io_mem_memread(execute_io_mem_memread),
    .io_mem_memwrite(execute_io_mem_memwrite),
    .io_mem_regwrite(execute_io_mem_regwrite),
    .io_mem_memtoreg(execute_io_mem_memtoreg),
    .io_mem_zero(execute_io_mem_zero),
    .io_mem_aluresult(execute_io_mem_aluresult),
    .io_mem_rs2_data(execute_io_mem_rs2_data),
    .io_mem_funct3(execute_io_mem_funct3),
    .io_mem_rd(execute_io_mem_rd),
    .io_writedata(execute_io_writedata),
    .io_forward1(execute_io_forward1),
    .io_forward2(execute_io_forward2),
    .io_ex_mem_flush(execute_io_ex_mem_flush)
  );
  Memory memory ( // @[core.scala 21:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_csr_read_data_in(memory_io_csr_read_data_in),
    .io_csr_write_enable_in(memory_io_csr_write_enable_in),
    .io_csr_write_address_in(memory_io_csr_write_address_in),
    .io_csr_write_data_in(memory_io_csr_write_data_in),
    .io_ecause_in(memory_io_ecause_in),
    .io_exception_in(memory_io_exception_in),
    .io_mret_in(memory_io_mret_in),
    .io_wfi_in(memory_io_wfi_in),
    .io_reg_pc(memory_io_reg_pc),
    .io_mem_isbranch(memory_io_mem_isbranch),
    .io_mem_isjump(memory_io_mem_isjump),
    .io_mem_memread(memory_io_mem_memread),
    .io_mem_memwrite(memory_io_mem_memwrite),
    .io_mem_regwrite(memory_io_mem_regwrite),
    .io_mem_memtoreg(memory_io_mem_memtoreg),
    .io_mem_zero(memory_io_mem_zero),
    .io_mem_aluresult(memory_io_mem_aluresult),
    .io_mem_rs2_data(memory_io_mem_rs2_data),
    .io_mem_funct3(memory_io_mem_funct3),
    .io_mem_rd(memory_io_mem_rd),
    .io_sip(memory_io_sip),
    .io_tip(memory_io_tip),
    .io_eip(memory_io_eip),
    .io_csr_write_enable_out(memory_io_csr_write_enable_out),
    .io_csr_write_address_out(memory_io_csr_write_address_out),
    .io_csr_write_data_out(memory_io_csr_write_data_out),
    .io_ecause_out(memory_io_ecause_out),
    .io_trapped(memory_io_trapped),
    .io_interrupt(memory_io_interrupt),
    .io_inst_retired(memory_io_inst_retired),
    .io_mret_out(memory_io_mret_out),
    .io_csr_read_data_out(memory_io_csr_read_data_out),
    .io_wb_reg_pc(memory_io_wb_reg_pc),
    .io_wb_readdata(memory_io_wb_readdata),
    .io_wb_aluresult(memory_io_wb_aluresult),
    .io_wb_memtoreg(memory_io_wb_memtoreg),
    .io_wb_regwrite(memory_io_wb_regwrite),
    .io_wb_rd(memory_io_wb_rd),
    .io_pcsrc(memory_io_pcsrc),
    .io_branch(memory_io_branch),
    .io_mem_wb_flush(memory_io_mem_wb_flush),
    .io_memory_read_data(memory_io_memory_read_data),
    .io_load_store_unsigned(memory_io_load_store_unsigned),
    .io_memory_size(memory_io_memory_size),
    .io_memory_address(memory_io_memory_address),
    .io_memory_write_data(memory_io_memory_write_data),
    .io_memory_read(memory_io_memory_read),
    .io_memory_write(memory_io_memory_write)
  );
  Writeback writeback ( // @[core.scala 22:25]
    .io_csr_read_data_in(writeback_io_csr_read_data_in),
    .io_wb_reg_pc(writeback_io_wb_reg_pc),
    .io_wb_readdata(writeback_io_wb_readdata),
    .io_wb_aluresult(writeback_io_wb_aluresult),
    .io_wb_memtoreg(writeback_io_wb_memtoreg),
    .io_writedata(writeback_io_writedata)
  );
  CSR csr ( // @[core.scala 23:19]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_meip(csr_io_meip),
    .io_csr_address(csr_io_csr_address),
    .io_mem_pc(csr_io_mem_pc),
    .io_csr_read_data(csr_io_csr_read_data),
    .io_readable(csr_io_readable),
    .io_writeable(csr_io_writeable),
    .io_csr_write_enable(csr_io_csr_write_enable),
    .io_csr_write_address(csr_io_csr_write_address),
    .io_csr_write_data(csr_io_csr_write_data),
    .io_inst_retired(csr_io_inst_retired),
    .io_trapped(csr_io_trapped),
    .io_mret(csr_io_mret),
    .io_ecause(csr_io_ecause),
    .io_interrupt(csr_io_interrupt),
    .io_eip(csr_io_eip),
    .io_tip(csr_io_tip),
    .io_sip(csr_io_sip),
    .io_trap_vector(csr_io_trap_vector),
    .io_mret_vector(csr_io_mret_vector)
  );
  Hazard hazard ( // @[core.scala 24:22]
    .io_predict(hazard_io_predict),
    .io_pc_stall(hazard_io_pc_stall),
    .io_if_id_stall(hazard_io_if_id_stall),
    .io_if_id_flush(hazard_io_if_id_flush),
    .io_memread(hazard_io_memread),
    .io_use_rs1(hazard_io_use_rs1),
    .io_use_rs2(hazard_io_use_rs2),
    .io_id_rs1(hazard_io_id_rs1),
    .io_id_rs2(hazard_io_id_rs2),
    .io_ex_rd(hazard_io_ex_rd),
    .io_ex_use_rs1(hazard_io_ex_use_rs1),
    .io_ex_use_rs2(hazard_io_ex_use_rs2),
    .io_ex_rs1(hazard_io_ex_rs1),
    .io_ex_rs2(hazard_io_ex_rs2),
    .io_ex_pc(hazard_io_ex_pc),
    .io_id_ex_flush(hazard_io_id_ex_flush),
    .io_mem_rd(hazard_io_mem_rd),
    .io_mem_regwrite(hazard_io_mem_regwrite),
    .io_mem_pc(hazard_io_mem_pc),
    .io_target_pc(hazard_io_target_pc),
    .io_forward1(hazard_io_forward1),
    .io_forward2(hazard_io_forward2),
    .io_ex_mem_flush(hazard_io_ex_mem_flush),
    .io_wb_rd(hazard_io_wb_rd),
    .io_wb_regwrite(hazard_io_wb_regwrite),
    .io_pcsrc(hazard_io_pcsrc),
    .io_trapped(hazard_io_trapped),
    .io_mret(hazard_io_mret),
    .io_mem_wb_flush(hazard_io_mem_wb_flush)
  );
  assign io_fetch_address = fetch_io_fetch_address; // @[core.scala 146:20]
  assign io_load_store_unsigned = memory_io_load_store_unsigned; // @[core.scala 147:26]
  assign io_memory_size = memory_io_memory_size; // @[core.scala 148:18]
  assign io_memory_address = memory_io_memory_address; // @[core.scala 149:21]
  assign io_memory_write_data = memory_io_memory_write_data; // @[core.scala 150:24]
  assign io_memory_read = memory_io_memory_read; // @[core.scala 151:18]
  assign io_memory_write = memory_io_memory_write; // @[core.scala 152:19]
  assign fetch_clock = clock;
  assign fetch_reset = reset;
  assign fetch_io_trap_vector = csr_io_trap_vector; // @[core.scala 27:24]
  assign fetch_io_mret_vector = csr_io_mret_vector; // @[core.scala 28:24]
  assign fetch_io_target_pc = execute_io_target_pc; // @[core.scala 29:22]
  assign fetch_io_mem_pc = execute_io_mem_pc; // @[core.scala 30:19]
  assign fetch_io_pcsrc = memory_io_pcsrc; // @[core.scala 31:18]
  assign fetch_io_branch = memory_io_branch; // @[core.scala 32:19]
  assign fetch_io_trap = memory_io_trapped; // @[core.scala 33:17]
  assign fetch_io_mret = memory_io_mret_out; // @[core.scala 34:17]
  assign fetch_io_pc_stall = hazard_io_pc_stall; // @[core.scala 35:21]
  assign fetch_io_if_id_stall = hazard_io_if_id_stall; // @[core.scala 36:24]
  assign fetch_io_if_id_flush = hazard_io_if_id_flush; // @[core.scala 37:24]
  assign fetch_io_predict = hazard_io_predict; // @[core.scala 38:20]
  assign fetch_io_fetch_data = io_fetch_data; // @[core.scala 39:23]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_id_pc = fetch_io_id_pc; // @[core.scala 41:19]
  assign decode_io_inst = fetch_io_inst; // @[core.scala 42:18]
  assign decode_io_wb_rd = memory_io_wb_rd; // @[core.scala 43:19]
  assign decode_io_wb_regwrite = memory_io_wb_regwrite; // @[core.scala 44:25]
  assign decode_io_writedata = writeback_io_writedata; // @[core.scala 45:23]
  assign decode_io_id_ex_flush = hazard_io_id_ex_flush; // @[core.scala 46:25]
  assign execute_clock = clock;
  assign execute_reset = reset;
  assign execute_io_csr_read = decode_io_csr_read; // @[core.scala 48:23]
  assign execute_io_csr_write = decode_io_csr_write; // @[core.scala 49:24]
  assign execute_io_csr_address = decode_io_csr_address; // @[core.scala 50:26]
  assign execute_io_ecause_in = decode_io_ecause_out; // @[core.scala 51:24]
  assign execute_io_exception_in = decode_io_exception_out; // @[core.scala 52:27]
  assign execute_io_mret_in = decode_io_mret_out; // @[core.scala 53:22]
  assign execute_io_wfi_in = decode_io_wfi_out; // @[core.scala 54:21]
  assign execute_io_ex_pc = decode_io_ex_pc; // @[core.scala 55:20]
  assign execute_io_aluop = decode_io_aluop; // @[core.scala 56:20]
  assign execute_io_immsrc = decode_io_immsrc; // @[core.scala 57:21]
  assign execute_io_isbranch = decode_io_isbranch; // @[core.scala 58:23]
  assign execute_io_memread = decode_io_memread; // @[core.scala 59:22]
  assign execute_io_memwrite = decode_io_memwrite; // @[core.scala 60:23]
  assign execute_io_regwrite = decode_io_regwrite; // @[core.scala 61:23]
  assign execute_io_memtoreg = decode_io_memtoreg; // @[core.scala 62:23]
  assign execute_io_pcsel = decode_io_pcsel; // @[core.scala 63:20]
  assign execute_io_rdsel = decode_io_rdsel; // @[core.scala 64:20]
  assign execute_io_isjump = decode_io_isjump; // @[core.scala 65:21]
  assign execute_io_islui = decode_io_islui; // @[core.scala 66:20]
  assign execute_io_rs1_data = decode_io_rs1_data; // @[core.scala 67:23]
  assign execute_io_rs2_data = decode_io_rs2_data; // @[core.scala 68:23]
  assign execute_io_imm = decode_io_imm; // @[core.scala 69:18]
  assign execute_io_funct3 = decode_io_funct3; // @[core.scala 70:21]
  assign execute_io_ex_rs1 = decode_io_ex_rs1; // @[core.scala 71:21]
  assign execute_io_ex_rd = decode_io_ex_rd; // @[core.scala 72:20]
  assign execute_io_csr_read_data = csr_io_csr_read_data; // @[core.scala 73:28]
  assign execute_io_readable = csr_io_readable; // @[core.scala 74:23]
  assign execute_io_writeable = csr_io_writeable; // @[core.scala 75:24]
  assign execute_io_writedata = writeback_io_writedata; // @[core.scala 76:24]
  assign execute_io_forward1 = hazard_io_forward1; // @[core.scala 77:23]
  assign execute_io_forward2 = hazard_io_forward2; // @[core.scala 78:23]
  assign execute_io_ex_mem_flush = hazard_io_ex_mem_flush; // @[core.scala 79:27]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_csr_read_data_in = execute_io_csr_read_data_out; // @[core.scala 81:30]
  assign memory_io_csr_write_enable_in = execute_io_csr_write_enable_out; // @[core.scala 82:33]
  assign memory_io_csr_write_address_in = execute_io_csr_write_address_out; // @[core.scala 83:34]
  assign memory_io_csr_write_data_in = execute_io_csr_write_data_out; // @[core.scala 84:31]
  assign memory_io_ecause_in = execute_io_ecause_out; // @[core.scala 85:23]
  assign memory_io_exception_in = execute_io_exception_out; // @[core.scala 86:26]
  assign memory_io_mret_in = execute_io_mret_out; // @[core.scala 87:21]
  assign memory_io_wfi_in = execute_io_wfi_out; // @[core.scala 88:20]
  assign memory_io_reg_pc = execute_io_reg_pc; // @[core.scala 89:20]
  assign memory_io_mem_isbranch = execute_io_mem_isbranch; // @[core.scala 90:26]
  assign memory_io_mem_isjump = execute_io_mem_isjump; // @[core.scala 91:24]
  assign memory_io_mem_memread = execute_io_mem_memread; // @[core.scala 92:25]
  assign memory_io_mem_memwrite = execute_io_mem_memwrite; // @[core.scala 93:26]
  assign memory_io_mem_regwrite = execute_io_mem_regwrite; // @[core.scala 94:26]
  assign memory_io_mem_memtoreg = execute_io_mem_memtoreg; // @[core.scala 95:26]
  assign memory_io_mem_zero = execute_io_mem_zero; // @[core.scala 96:22]
  assign memory_io_mem_aluresult = execute_io_mem_aluresult; // @[core.scala 97:27]
  assign memory_io_mem_rs2_data = execute_io_mem_rs2_data; // @[core.scala 98:26]
  assign memory_io_mem_funct3 = execute_io_mem_funct3; // @[core.scala 99:24]
  assign memory_io_mem_rd = execute_io_mem_rd; // @[core.scala 100:20]
  assign memory_io_sip = csr_io_sip; // @[core.scala 101:17]
  assign memory_io_tip = csr_io_tip; // @[core.scala 102:17]
  assign memory_io_eip = csr_io_eip; // @[core.scala 103:17]
  assign memory_io_mem_wb_flush = hazard_io_mem_wb_flush; // @[core.scala 104:26]
  assign memory_io_memory_read_data = io_memory_read_data; // @[core.scala 105:30]
  assign writeback_io_csr_read_data_in = memory_io_csr_read_data_out; // @[core.scala 107:33]
  assign writeback_io_wb_reg_pc = memory_io_wb_reg_pc; // @[core.scala 108:26]
  assign writeback_io_wb_readdata = memory_io_wb_readdata; // @[core.scala 109:28]
  assign writeback_io_wb_aluresult = memory_io_wb_aluresult; // @[core.scala 110:29]
  assign writeback_io_wb_memtoreg = memory_io_wb_memtoreg; // @[core.scala 111:28]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_meip = io_meip; // @[core.scala 113:15]
  assign csr_io_csr_address = decode_io_csr_address; // @[core.scala 115:22]
  assign csr_io_mem_pc = execute_io_mem_pc; // @[core.scala 114:17]
  assign csr_io_csr_write_enable = memory_io_csr_write_enable_out; // @[core.scala 116:27]
  assign csr_io_csr_write_address = memory_io_csr_write_address_out; // @[core.scala 117:28]
  assign csr_io_csr_write_data = memory_io_csr_write_data_out; // @[core.scala 118:25]
  assign csr_io_inst_retired = memory_io_inst_retired; // @[core.scala 119:23]
  assign csr_io_trapped = memory_io_trapped; // @[core.scala 120:18]
  assign csr_io_mret = memory_io_mret_out; // @[core.scala 122:15]
  assign csr_io_ecause = memory_io_ecause_out[2:0]; // @[core.scala 123:17]
  assign csr_io_interrupt = memory_io_interrupt; // @[core.scala 121:20]
  assign hazard_io_memread = decode_io_memread; // @[core.scala 125:21]
  assign hazard_io_use_rs1 = decode_io_use_rs1; // @[core.scala 126:21]
  assign hazard_io_use_rs2 = decode_io_use_rs2; // @[core.scala 127:21]
  assign hazard_io_id_rs1 = decode_io_id_rs1; // @[core.scala 128:20]
  assign hazard_io_id_rs2 = decode_io_id_rs2; // @[core.scala 129:20]
  assign hazard_io_ex_rd = decode_io_ex_rd; // @[core.scala 130:19]
  assign hazard_io_ex_use_rs1 = decode_io_ex_use_rs1; // @[core.scala 131:24]
  assign hazard_io_ex_use_rs2 = decode_io_ex_use_rs2; // @[core.scala 132:24]
  assign hazard_io_ex_rs1 = decode_io_ex_rs1; // @[core.scala 133:20]
  assign hazard_io_ex_rs2 = decode_io_ex_rs2; // @[core.scala 134:20]
  assign hazard_io_ex_pc = decode_io_ex_pc; // @[core.scala 135:19]
  assign hazard_io_mem_rd = execute_io_mem_rd; // @[core.scala 136:20]
  assign hazard_io_mem_regwrite = execute_io_mem_regwrite; // @[core.scala 137:26]
  assign hazard_io_mem_pc = execute_io_mem_pc; // @[core.scala 138:20]
  assign hazard_io_target_pc = execute_io_target_pc; // @[core.scala 139:23]
  assign hazard_io_wb_rd = memory_io_wb_rd; // @[core.scala 140:19]
  assign hazard_io_wb_regwrite = memory_io_wb_regwrite; // @[core.scala 141:25]
  assign hazard_io_pcsrc = memory_io_pcsrc; // @[core.scala 142:19]
  assign hazard_io_trapped = memory_io_trapped; // @[core.scala 143:21]
  assign hazard_io_mret = memory_io_mret_out; // @[core.scala 144:18]
endmodule
