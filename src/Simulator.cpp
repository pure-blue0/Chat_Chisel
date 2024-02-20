#include <cstring>
#include <fstream>
#include <sstream>
#include <string>

#include "Simulator.h"

namespace RISCV {

const char *REGNAME[32] = {
    "zero", // x0
    "ra",   // x1
    "sp",   // x2
    "gp",   // x3
    "tp",   // x4
    "t0",   // x5
    "t1",   // x6
    "t2",   // x7
    "s0",   // x8
    "s1",   // x9
    "a0",   // x10
    "a1",   // x11
    "a2",   // x12
    "a3",   // x13
    "a4",   // x14
    "a5",   // x15
    "a6",   // x16
    "a7",   // x17
    "s2",   // x18
    "s3",   // x19
    "s4",   // x20
    "s5",   // x21
    "s6",   // x22
    "s7",   // x23
    "s8",   // x24
    "s9",   // x25
    "s10",  // x26
    "s11",  // x27
    "t3",   // x28
    "t4",   // x29
    "t5",   // x30
    "t6",   // x31
};

const char *INSTNAME[]{
    "lui"  , "auipc", "jal"  , "jalr" , "beq"  ,   "bne",  "blt",  "bge",  "bltu",
    "bgeu" , "lb"   , "lh"   , "lw"   , "lbu"  ,   "lhu",  "sb",   "sh" ,   "sw" , 
    "addi" , "slti" , "sltiu", "xori" , "ori"  ,  "andi",  "slli", "srli", "srai",
    "add"  , "sub"  , "sll"  , "slt"  , "sltu" , "xor",  "srl", "sra",  "or", "and",
    "csrrw", "csrrs", "csrrc","csrrwi","csrrsi","csrrci","ecall", 
    
};

} // namespace RISCV

using namespace RISCV;

Simulator::Simulator(MemoryManager *memory, BranchPredictor *predictor) {
  this->memory = memory;
  this->branchPredictor = predictor;
  this->pc = 0;
  this->pcNew=0;
  this->pcWrite = true;
  //default get value is pc+4
  this->BP_mux  = false;
  this->ispcsrc = false;
  this->history.retried_Count=0;
  for (int i = 0; i < REGNUM; ++i) {
    this->reg[i] = 0;
  }
}

Simulator::~Simulator() {}

void Simulator::initStack(uint32_t baseaddr, uint32_t maxSize) {
  this->reg[REG_SP] = baseaddr;
  this->stackBase = baseaddr;
  this->maximumStackSize = maxSize;
  for (uint32_t addr = baseaddr; addr > baseaddr - maxSize; addr--) {
    if (!this->memory->isPageExist(addr)) {
      this->memory->addPage(addr);
    }
    this->memory->setByte(addr, 0);
  }
}

void Simulator::simulate() {
  // Initialize pipeline registers
  memset(&this->IF_IDReg,    0, sizeof(this->IF_IDReg));
  memset(&this->IF_IDRegNew, 0, sizeof(this->IF_IDRegNew));
  memset(&this->ID_EXReg,    0, sizeof(this->ID_EXReg));
  memset(&this->ID_EXRegNew, 0, sizeof(this->ID_EXReg));
  memset(&this->EX_MEMReg,   0, sizeof(this->EX_MEMReg));
  memset(&this->EX_MEMRegNew,0, sizeof(this->EX_MEMRegNew));
  memset(&this->MEM_WBReg,   0, sizeof(this->MEM_WBReg));
  memset(&this->MEM_WBNew,   0, sizeof(this->MEM_WBNew));
  //debug test
  this->BHT_verify=false;
  this->write_data_back_verify=false;
  this->immGen_verify=false;
  this->hazard_verify=false;
  this->dcache_verify=false;
  this->targetGen_verify=false;
  // Insert Bubble to later pipeline stages
  IF_IDReg.bubble = true;
  ID_EXReg.bubble = true;
  EX_MEMReg.bubble = true;
  MEM_WBReg.bubble = true;
  
  // Main Simulation Loop
  while (true) {
    if (this->reg[0] != 0) {
      this->reg[0] = 0;
      this->panic("Register 0's value is not zero!\n");
    }

    if (this->reg[REG_SP] < this->stackBase - this->maximumStackSize) {
      this->panic("Stack Overflow!\n");
    }

    this->executeWriteBack = false;
    this->executeWBReg = -1;
    this->memoryWriteBack  = false;
    this->memoryWBReg = -1;
    
    if (this->verbose) {
      printf("-----------------------------------\n");
      printf("----------CYCLE %d----------------\n",this->history.cycleCount);
      printf("-----------------------------------\n");
    }

    this->fetch();
    this->decode();
    this->execute();
    this->memoryAccess();
    this->writeBack();
    this->csr();

    if (!this->IF_IDReg.stall) this->IF_IDReg = this->IF_IDRegNew;
    else this->IF_IDReg.stall--;
    if (!this->ID_EXReg.stall) this->ID_EXReg = this->ID_EXRegNew;
    else this->ID_EXReg.stall--;
    this->EX_MEMReg = this->EX_MEMRegNew;
    this->MEM_WBReg = this->MEM_WBNew;
    memset(&this->IF_IDRegNew, 0, sizeof(this->IF_IDRegNew));
    memset(&this->ID_EXRegNew, 0, sizeof(this->ID_EXRegNew));
    memset(&this->EX_MEMRegNew,0, sizeof(this->EX_MEMRegNew));
    memset(&this->MEM_WBNew,   0, sizeof(this->MEM_WBNew));
    if(!this->IF_IDReg.stall)this->pcWrite=true;
    this->history.cycleCount++;

    if (verbose) this->printInfo();

    if (this->isSingleStep) {
      printf("Type d to dump memory in dump.txt, press ENTER to continue: ");
      char ch;
      while ((ch = getchar()) != '\n') ;
    }
  }
}

void Simulator::fetch() {

  //printf("trapped:%d,mret:%d\n",this->MEM_WBReg.csr_trapped,this->MEM_WBReg.mret_out);
  /*if(this->MEM_WBReg.csr_trapped)this->pc=this->IF_IDReg.trap_vector;
  else if(this->MEM_WBReg.mret_out)this->pc=this->IF_IDReg.mret_vector;*/
  if(this->pcWrite)this->pc=this->pcNew;
  else this->pc=this->pc;
  
  if (this->pc % 2 != 0) this->panic("Illegal PC 0x%x!\n", this->pc);
  //get fetch(The process of getting the finger from the Icache is also in the function)
  uint32_t inst = this->memory->getInt(this->pc);
  //Prediction Next PC
  bool predictedBranch = this->branchPredictor->BTB_Predict(this->pc);
  //BHT
  bool BHT_match=this->branchPredictor->bht_match(this->pc);
  bool BHT_valid=this->branchPredictor->get_bht_valid(this->pc);
  uint32_t BHT_target_pc=this->branchPredictor->get_bht_address(this->pc);
  //Select PC
  this->BP_mux=predictedBranch&&BHT_match&&BHT_valid;
  if (BP_mux) {
    this->pcNew = BHT_target_pc;
    this->IF_IDRegNew.prediction_jump=true;
  } 
  else 
  {
    this->pcNew = this->pc + 4; 
    this->IF_IDRegNew.prediction_jump=false;
  }

  if(this->BHT_verify)printf("Module:BHT  match %d, valid %d ,bht_pred_pc 0x%.8x\n",BHT_match,BHT_valid,BHT_target_pc);
  if (this->verbose) printf("Fetched instruction 0x%.8x at address 0x%x\n", inst, this->pc);
  
  this->IF_IDRegNew.bubble = false;
  this->IF_IDRegNew.stall = false;
  this->IF_IDRegNew.inst = inst;
  this->IF_IDRegNew.id_pc = this->pc;
  
}


void Simulator::decode() {
  if (this->IF_IDReg.stall) {
    if (verbose) printf("Decode: Stall\n");

    return;
  }
  if (this->IF_IDReg.bubble || this->IF_IDReg.inst == 0) {
    if (verbose) printf("Decode: Bubble\n");
    this->ID_EXRegNew.bubble = true;
    return;
  }

  std::string instname = "";
  std::string inststr = "";
  std::string deststr, op1str, op2str, offsetstr;
  Inst insttype = Inst::UNKNOWN;

  uint32_t inst = this->IF_IDReg.inst;
  int32_t  Rs1_op = 0, Rs2_op = 0, imm = 0; 
  
  //CSR
  bool csr_read=false,csr_write=false;
  uint32_t ecause_out=0,exception_out=0;
  uint32_t csr_address=0;
  uint32_t mret_out=false;
  uint32_t wfi_out=false;
  
  RegId dest = 0, reg1 = -1, reg2 = -1;   // rd and reg name

  // Decode the instructions to obtain: opcode, funct3, funct7, rd, rs1, rs2
  uint32_t opcode = inst & 0x7F;
  uint32_t funct3 = (inst >> 12) & 0x7;
  uint32_t funct7 = (inst >> 25) & 0x7F;
  RegId rd  = (inst >> 7 ) & 0x1F;
  RegId rs1 = (inst >> 15) & 0x1F;
  RegId rs2 = (inst >> 20) & 0x1F;
  
  Rs1_op = this->reg[rs1];
  Rs2_op = this->reg[rs2];
  imm=imm_gen(inst);
  reg1 = rs1;
  reg2 = rs2;
  dest = rd;
  //get control signals
  control(opcode,funct3,funct7);
  //Decode
  switch (opcode) {
  case OP_REG:
    switch (funct3) {
    case 0x0: // add,sub
      if (funct7 == 0x00) {
        instname = "add";
        insttype = ADD;
      } else if (funct7 == 0x20) {
        instname = "sub";
        insttype = SUB;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x1: // sll
      if (funct7 == 0x00) {
        instname = "sll";
        insttype = SLL;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x2: // slt
      if (funct7 == 0x00) {
        instname = "slt";
        insttype = SLT;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x3: // sltu
      if (funct7 == 0x00)
      {
        instname = "sltu";
        insttype = SLTU;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x4: // xor
      if (funct7 == 0x00) {
        instname = "xor";
        insttype = XOR;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x5: // srl, sra
      if (funct7 == 0x00) {
        instname = "srl";
        insttype = SRL;
      } else if (funct7 == 0x20) {
        instname = "sra";
        insttype = SRA;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x6: // or
      if (funct7 == 0x00) {
        instname = "or";
        insttype = OR;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    case 0x7: // and
      if (funct7 == 0x00) {
        instname = "and";
        insttype = AND;
      } 
      else this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
      break;
    default: 
      this->panic("Unknown Funct3 field %x\n", funct3);
    }
    op1str = REGNAME[rs1];
    op2str = REGNAME[rs2];
    deststr = REGNAME[rd];
    inststr = instname + " " + deststr + "," + op1str + "," + op2str;
    break;
  case OP_IMM:
    switch (funct3) {
    case 0x0:
      instname = "addi";
      insttype = ADDI;
      break;
    case 0x1:
      instname = "slli";
      insttype = SLLI;
      break;
    case 0x2:
      instname = "slti";
      insttype = SLTI;
      break;
    case 0x3:
      instname = "sltiu";
      insttype = SLTIU;
      break;
    case 0x4:
      instname = "xori";
      insttype = XORI;
      break;
    case 0x5:
      if (((inst >> 26) & 0x3F) == 0x0) {
        instname = "srli";
        insttype = SRLI;
      } else if (((inst >> 26) & 0x3F) == 0x10) {
        instname = "srai";
        insttype = SRAI;
      } 
      else this->panic("Unknown funct7 0x%x for OP_IMM\n", (inst >> 26) & 0x3F);
      break;
    case 0x6:
      instname = "ori";
      insttype = ORI;
      break;
    case 0x7:
      instname = "andi";
      insttype = ANDI;
      break;
    default:
      this->panic("Unknown Funct3 field %x\n", funct3);
    }
    op1str = REGNAME[rs1];
    offsetstr = std::to_string(imm);
    deststr = REGNAME[dest];
    inststr = instname + " " + deststr + "," + op1str + "," + offsetstr;
    break;
  case OP_LUI:
    instname = "lui";
    insttype = LUI;
    offsetstr = std::to_string(imm);
    deststr = REGNAME[dest];
    inststr = instname + " " + deststr + "," + offsetstr;
    break;
  case OP_AUIPC:
    instname = "auipc";
    insttype = AUIPC;
    offsetstr = std::to_string(imm);
    deststr = REGNAME[dest];
    inststr = instname + " " + deststr + "," + offsetstr;
    break;
  case OP_JAL:
    instname = "jal";
    insttype = JAL;
    offsetstr = std::to_string(imm);
    deststr = REGNAME[dest];
    inststr = instname + " " + deststr + "," + offsetstr;
    break;
  case OP_JALR:
    instname = "jalr";
    insttype = JALR;
    op1str = REGNAME[rs1];
    offsetstr = std::to_string(imm);
    deststr = REGNAME[dest];
    inststr = instname + " " + deststr + "," +offsetstr+"(" +op1str+ ")" ;
    break;
  case OP_BRANCH:
    switch (funct3) {
    case 0x0:
      instname = "beq"; 
      insttype = BEQ;
      break;
    case 0x1:
      instname = "bne";
      insttype = BNE;
      break;
    case 0x4:
      instname = "blt";
      insttype = BLT;
      break;
    case 0x5:
      instname = "bge";
      insttype = BGE;
      break;
    case 0x6:
      instname = "bltu";
      insttype = BLTU;
      break;
    case 0x7:
      instname = "bgeu";
      insttype = BGEU;
      break;
    default:
      this->panic("Unknown funct3 0x%x at OP_BRANCH\n", funct3);
    }
    op1str = REGNAME[rs1];
    op2str = REGNAME[rs2];
    offsetstr = std::to_string(imm);
    inststr = instname + " " + op1str + "," + op2str + "," + offsetstr;
    break;
  case OP_STORE:
    switch (funct3) {
    case 0x0:
      instname = "sb";
      insttype = SB;
      break;
    case 0x1:
      instname = "sh";
      insttype = SH;
      break;
    case 0x2:
      instname = "sw";
      insttype = SW;
      break;
    default:
      this->panic("Unknown funct3 0x%x for OP_STORE\n", funct3);
    }
    op1str = REGNAME[rs1];
    op2str = REGNAME[rs2];
    offsetstr = std::to_string(imm);
    inststr = instname + " " + op2str + "," + offsetstr + "(" + op1str + ")";
    break;
  case OP_LOAD:
    switch (funct3) {
    case 0x0:
      instname = "lb";
      insttype = LB;
      break;
    case 0x1:
      instname = "lh";
      insttype = LH;
      break;
    case 0x2:
      instname = "lw";
      insttype = LW;
      break;
    case 0x4:
      instname = "lbu";
      insttype = LBU;
      break;
    case 0x5:
      instname = "lhu";
      insttype = LHU;
      break;
    default:
      this->panic("Unknown funct3 0x%x for OP_LOAD\n", funct3);
    }
    op1str = REGNAME[rs1];
    offsetstr = std::to_string(imm);
    deststr = REGNAME[rd];
    inststr = instname + " " + deststr + "," + offsetstr + "(" + op1str + ")";
    break;
  case OP_CSR:
    csr_address=(inst>>20) &0XFFF;
    csr_read=true;
    csr_write=true;
    imm=rs1;
    switch (funct3) {
    case 0x1:
      instname = "csrrw";
      insttype = CSRRW;
      if(rd==0)csr_read=false; //don not need read csr data,because des is zero reg
      break;
    case 0x2:
      instname = "csrrs";
      insttype = CSRRS;
      if(rs1==0)csr_write=false; //operate with 0,the result is same,so don not need write
      break;
    case 0x3:
      instname = "csrrc";
      insttype = CSRRC;
      if(rs1==0)csr_write=false;
      break;
    case 0x5:
      instname = "csrrwi";
      insttype = CSRRWI;
      if(rd==0)csr_read=false;
      imm=imm&&0x1F;
      break;
    case 0x6:
      instname = "csrrsi";
      insttype = CSRRSI;
      if(rs1==0)csr_write=false;
      imm=imm&&0x1F;
      break;
    case 0x7:
      instname = "csrrci";
      insttype = CSRRCI;
      if(rs1==0)csr_write=false;
      imm=imm&&0x1F;
      break;
    default:;
      //this->panic("Unknown funct3 0x%x for OP_CSR\n", funct3);
    }

    if (funct3 == 0x0 && funct7 == 0x0) {
      
      instname = "ecall";
      Rs1_op = this->reg[REG_A0];
      Rs2_op = this->reg[REG_A7];
      reg1 = REG_A0;
      reg2 = REG_A7;
      dest = REG_A0;
      insttype = ECALL;
    } 
    else this->panic("Unknown OP_CSR inst with funct3 0x%x and funct7 0x%x\n",funct3, funct7);
    inststr = instname;
    break;
  default:  this->panic("Unsupported opcode 0x%x!\n", opcode);
  }
  if(inst==0x30200073) mret_out=true; //mret inst
  else  mret_out=false;
  if(inst==0x10500073)wfi_out=true;   //WFI inst
  else wfi_out=false;
  //judgement inst legal
  if(insttype==UNKNOWN){//The commands are not matched
    exception_out=true;
    ecause_out=2;
  }
  else{
    exception_out=false;
    ecause_out=0;
  }
  
  
  //save info
  char buf[4096];
  sprintf(buf, "0x%x: %s\n", this->IF_IDReg.id_pc, inststr.c_str());
  if (verbose)  printf("Decoded instruction 0x%.8x as %s\n", inst, inststr.c_str());
    
  if (instname != INSTNAME[insttype]) this->panic("Unmatch instname %s with insttype %d\n", instname.c_str(), insttype);
  //calculate branch address and save the back-end redirection address

  this->ID_EXRegNew.stall =  false;
  this->ID_EXRegNew.bubble = false;

  this->ID_EXRegNew.rs1 = reg1;
  this->ID_EXRegNew.rs2 = reg2;
  this->ID_EXRegNew.rd = dest;

  this->ID_EXRegNew.insttype = insttype;//execute inst name
  this->ID_EXRegNew.Rs1_op   = Rs1_op;
  this->ID_EXRegNew.Rs2_op   = Rs2_op;
  this->ID_EXRegNew.imm      = imm;
  this->ID_EXRegNew.funct3   =funct3;

  this->ID_EXRegNew.ex_pc = this->IF_IDReg.id_pc;
  this->ID_EXRegNew.prediction_jump=this->IF_IDReg.prediction_jump;

  //csr
  this->ID_EXRegNew.csr_read=csr_read;
  this->ID_EXRegNew.csr_write=csr_write;
  this->ID_EXRegNew.csr_address=csr_address;
  this->ID_EXRegNew.mret_out=mret_out;
  this->ID_EXRegNew.wfi_out=wfi_out;
  this->ID_EXRegNew.ecause_out=ecause_out;
  this->ID_EXRegNew.exception_out=exception_out;

}
//The reason for [logic module]  executing in execute is the program is order running,
//But the real RISCV CPU running is parallel,so these data must be prepared One cycle ahead
void Simulator::execute() {
  if (this->ID_EXReg.stall) {
    if (verbose) printf("Execute: Stall\n");
    this->EX_MEMRegNew.bubble = true;
    return;
  }
  if (this->ID_EXReg.bubble) {
    if (verbose) printf("Execute: Bubble\n");
    this->EX_MEMRegNew.bubble = true;
    return;
  }
  if (verbose) printf("Execute: %s\n ALUOP is:%d", INSTNAME[this->ID_EXReg.insttype],this->ID_EXReg.ALUOp);

  this->history.instCount++;//PMU

  Inst insttype  = this->ID_EXReg.insttype;
  int32_t Rs1_op = this->ID_EXReg.Rs1_op;
  int32_t Rs2_op = this->ID_EXReg.Rs2_op;
  int32_t offset = this->ID_EXReg.imm;
  //CSR data read
  bool readable=false,writeable=false;
  int32_t csr_read_data=this->csr_reg[this->ID_EXReg.csr_address];
  readable =this->ID_EXReg.csr_address==0XC00||this->ID_EXReg.csr_address==0XC80||this->ID_EXReg.csr_address==0XC02
          ||this->ID_EXReg.csr_address==0XC82||this->ID_EXReg.csr_address==Mvendorid||this->ID_EXReg.csr_address==Marchid
          ||this->ID_EXReg.csr_address==Mimpid ||this->ID_EXReg.csr_address==Mhartid||this->ID_EXReg.csr_address==Mstatus
          ||this->ID_EXReg.csr_address==Misa||this->ID_EXReg.csr_address==Mie ||this->ID_EXReg.csr_address==Mtvec
          ||this->ID_EXReg.csr_address==Mscratch||this->ID_EXReg.csr_address==Mepc||this->ID_EXReg.csr_address==Mcause
          ||this->ID_EXReg.csr_address==Mtval||this->ID_EXReg.csr_address==Mip||this->ID_EXReg.csr_address==Mcycle
          ||this->ID_EXReg.csr_address==Mcycleh||this->ID_EXReg.csr_address==Minstret||this->ID_EXReg.csr_address==Minstreth;
  writeable=this->ID_EXReg.csr_address==Mstatus||this->ID_EXReg.csr_address==Misa||this->ID_EXReg.csr_address==Mie
          ||this->ID_EXReg.csr_address==Mtvec||this->ID_EXReg.csr_address==Mscratch||this->ID_EXReg.csr_address==Mepc
          ||this->ID_EXReg.csr_address==Mcause||this->ID_EXReg.csr_address==Mtval||this->ID_EXReg.csr_address==Mip
          ||this->ID_EXReg.csr_address==Mcycle||this->ID_EXReg.csr_address==Mcycleh||this->ID_EXReg.csr_address==Minstret
          ||this->ID_EXReg.csr_address==Minstreth;
  
  uint32_t ecause_in=this->ID_EXReg.ecause_out;
  uint32_t exception_in=this->ID_EXReg.exception_out;
  uint32_t ecause_out=0,exception_out=0;
  //handle exception
  bool csr_exception=(this->ID_EXReg.csr_read!=readable)||(this->ID_EXReg.csr_write!=writeable);//check csr operate whether legal
  if(!exception_in &&csr_exception){//The exception is not handled and the CSR operation is illegal
    exception_out=1;
    ecause_out=2;
  }
  else{
    exception_out=exception_in;
    ecause_out=ecause_in;
  }

  uint32_t ex_pc = this->ID_EXReg.ex_pc;
  uint32_t target_pc = 0;
  RegId ex_rd   = this->ID_EXReg.rd;
  int32_t result  = 0,csr_write_out;
  bool branch = false;
  switch (insttype) {
  case LUI:  result = offset;break;
  case AUIPC:result = ex_pc + offset; break;
  case JAL:  branch = true; break;
  case JALR:      
    result = (Rs1_op + offset) & (~(uint32_t)1);  
    branch = true;
    break;
  case BEQ:if (Rs1_op == Rs2_op) branch = true; break;
  case BNE:if (Rs1_op != Rs2_op) branch = true; break;
  case BLT:if (Rs1_op <  Rs2_op) branch = true; break;
  case BGE:if (Rs1_op >= Rs2_op) branch = true; break;
  case BLTU:if ((uint32_t)Rs1_op <  (uint32_t)Rs2_op) branch = true; break; 
  case BGEU:if ((uint32_t)Rs1_op >= (uint32_t)Rs2_op) branch = true; break;
    
  case LB: result = Rs1_op + offset; break;
  case LH: result = Rs1_op + offset; break;
  case LW: result = Rs1_op + offset; break;
  case LBU:result = Rs1_op + offset; break;
  case LHU:result = Rs1_op + offset; break;

  case SB: result = Rs1_op + offset; break;
  case SH: result = Rs1_op + offset; break;
  case SW: result = Rs1_op + offset; break;

  case ADD:   result = Rs1_op + Rs2_op;  break;
  case ADDI:  result = Rs1_op + offset;  break;
  case SUB:   result = Rs1_op - Rs2_op;  break;
  case SLTI:  result = Rs1_op < offset?1:0;      break;
  case SLT:   result = Rs1_op < Rs2_op ? 1 : 0;  break;
  case SLTIU: result = (uint32_t)Rs1_op < (uint32_t)offset ? 1 : 0;  break;
  case SLTU:  result = (uint32_t)Rs1_op < (uint32_t)Rs2_op ? 1 : 0;  break;
  case XORI:  result = Rs1_op ^ offset; break;
  case XOR:   result = Rs1_op ^ Rs2_op; break;
  case ORI:   result = Rs1_op | offset; break;
  case OR:    result = Rs1_op | Rs2_op; break;
  case ANDI:  result = Rs1_op & offset; break;
  case AND:   result = Rs1_op & Rs2_op; break;
  case SLLI:  result = Rs1_op << offset;break;
  case SLL:   result = Rs1_op << Rs2_op;break;
  case SRLI:  result = (uint32_t)Rs1_op >> (uint32_t)offset; break;
  case SRL:   result = (uint32_t)Rs1_op >> (uint32_t)Rs2_op; break;
  case SRAI:  result = Rs1_op >> offset; break;
  case SRA:   result = Rs1_op >> Rs2_op; break;
  case CSRRW: csr_write_out=Rs1_op;break;
  case CSRRS: csr_write_out=csr_read_data|Rs1_op;break;
  case CSRRC: csr_write_out=csr_read_data&(~Rs1_op);break;
  case CSRRWI:csr_write_out=offset;break;
  case CSRRSI:csr_write_out=csr_read_data|offset;break;
  case CSRRCI:csr_write_out=csr_read_data&(~offset);break;
  case ECALL: result = handleSystemCall(Rs1_op, Rs2_op); break;
  default:    this->panic("Unknown instruction type %d\n", insttype);
  }
  
  

  if (this->ID_EXReg.isJump||(this->ID_EXReg.isBranch &&branch)) this->ispcsrc=true;
  else this->ispcsrc=false;
  
  //target_gen
  if(this->ID_EXReg.rdsel)this->EX_MEMRegNew.reg_pc=ex_pc+ offset;//inst：auipc，rdsel=1
  else this->EX_MEMRegNew.reg_pc=ex_pc+ 4;

  if(this->ID_EXReg.pcsel)target_pc=result; //jalr
  else 
  {
    if(branch)target_pc=ex_pc+offset;      //jal | prediction jump
    else if(!branch)target_pc=ex_pc+4;     //prediction not jump
  }
  if(targetGen_verify){
    printf("-----------------------------------Target_Gen module------------ ------------------------\n");
    if(this->ID_EXReg.rdsel)printf("-->Reg_PC=EX_PC+imm  [auipc]\n");
    else  printf("-->Reg_PC=EX_PC+4 [jal/jalr]\n");  
    printf("Input :RdSel:%d ,EX_PC:0x%.5x ,imm:0x%x\n",this->ID_EXReg.rdsel,ex_pc,offset);
    printf("OutPUT:Reg_PC:0x%.5x \n",this->EX_MEMRegNew.reg_pc);
    if(this->ID_EXReg.pcsel)printf("-->Target_PC=Alu_Result\n");
    else
    {
      if(branch)printf("-->Target_PC=EX_PC+imm [Prediction right]\n");
      else  printf("-->Target_PC=EX_PC+4 [Prediction fault]\n");
    }
    printf("Input :PCSel:%d ,EX_PC:0x%.5x ,imm:0x%x ,Alu_Result:0x%x\n",this->ID_EXReg.rdsel,ex_pc,offset,result);
    printf("OutPUT:Reg_PC:0x%.5x \n",this->EX_MEMRegNew.reg_pc);
  }

  // Control Hazard 
  if (this->ID_EXReg.isBranch) {
    if (this->ID_EXReg.prediction_jump == branch) {
      this->history.predictedBranch++;
    } 
    else {
      //Branch prediction error, 
      this->pcNew = target_pc;//可以理解为后端重定向的那个mux

      this->IF_IDRegNew.bubble = true;
      this->ID_EXRegNew.bubble = true;
      this->history.unpredictedBranch++;
      this->history.controlHazardCount++;
    }
    // this->ID_EXReg.id_pc: fetch original inst addr, not the modified one
    this->branchPredictor->update(this->ID_EXReg.ex_pc, branch);//update_btb
  }
  if (this->ID_EXReg.isJump) {
    // Control hazard here
    this->pcNew = target_pc; //可以理解为后端重定向的那个mux
    this->IF_IDRegNew.bubble = true;
    this->ID_EXRegNew.bubble = true;
    this->history.controlHazardCount++;
  }

  //BHT_update
  if(branch==true)
  { 
    this->EX_MEMRegNew.target_pc=target_pc;
    this->branchPredictor->update_bht(this->ID_EXReg.ex_pc,this->EX_MEMRegNew.target_pc);
    
    if(this->BHT_verify){
      this->branchPredictor->print_bht();
    }
  }

  //DataHazard
  this->DataHazard(this->ID_EXReg.MemRead,this->ID_EXRegNew.rs1,this->ID_EXRegNew.rs2,ex_rd);

  //forward data
  if (this->ID_EXReg.RegWrite && ex_rd != 0 && !this->ID_EXReg.MemRead) {
    if (this->ID_EXRegNew.rs1 == ex_rd) {
      this->ID_EXRegNew.Rs1_op = result;
      this->executeWBReg = ex_rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op1\n", REGNAME[ex_rd]);
    }
    if (this->ID_EXRegNew.rs2 == ex_rd) {
      this->ID_EXRegNew.Rs2_op = result;
      this->executeWBReg = ex_rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op2\n", REGNAME[ex_rd]);
    }
  }

  this->EX_MEMRegNew.bubble = false;
  this->EX_MEMRegNew.stall = false;
 
  //control
  this->EX_MEMRegNew.mem_pc  =this->ID_EXReg.ex_pc;
  this->EX_MEMRegNew.isBranch=this->ID_EXReg.isBranch;
  this->EX_MEMRegNew.isJump  =this->ID_EXReg.isJump;
  this->EX_MEMRegNew.MemRead =this->ID_EXReg.MemRead;
  this->EX_MEMRegNew.MemWrite=this->ID_EXReg.MemWrite;
  this->EX_MEMRegNew.RegWrite=this->ID_EXReg.RegWrite;
  this->EX_MEMRegNew.MemtoReg=this->ID_EXReg.MemtoReg;
  this->EX_MEMRegNew.funct3  =this->ID_EXReg.funct3;

  this->EX_MEMRegNew.insttype = insttype;   //no need later
  this->EX_MEMRegNew.rd  = ex_rd;
  this->EX_MEMRegNew.AluResult   = result; 
  this->EX_MEMRegNew.Rs2_op = Rs2_op;     // for store
  //csr
  this->EX_MEMRegNew.csr_Readdata=csr_read_data;
  this->EX_MEMRegNew.csr_WriteEnable=writeable;
  this->EX_MEMRegNew.csr_address=this->ID_EXReg.csr_address;
  this->EX_MEMRegNew.csr_writedata=csr_write_out;
  this->EX_MEMRegNew.mret_out=this->ID_EXReg.mret_out;
  this->EX_MEMRegNew.wfi_out=this->ID_EXReg.wfi_out;
  this->EX_MEMRegNew.exception_out=exception_out;
  this->EX_MEMRegNew.ecause_out=ecause_out;

}

void Simulator::memoryAccess() {
  if (this->EX_MEMReg.stall) {
    if (verbose) printf("Memory Access: Stall\n");
    return;
  }
  if (this->EX_MEMReg.bubble) {
    if (verbose) printf("Memory Access: Bubble\n");
    this->MEM_WBNew.bubble = true;
    return;
  }

  Inst insttype = this->EX_MEMReg.insttype;
  RegId rd = this->EX_MEMReg.rd;
  int32_t Rs2_op = this->EX_MEMReg.Rs2_op; // for store
  int32_t ALU_Result = this->EX_MEMReg.AluResult;
  int32_t Mem_Result =0;

  //csr
  bool exception_in=this->EX_MEMReg.exception_out;
  bool ecause_in=this->EX_MEMReg.ecause_out;
  bool wfi_in=this->EX_MEMReg.wfi_out;
  bool sip=this->csr_reg[Mip] & 1?true:false;
  bool tip=this->csr_reg[Mip] & 2?true:false;
  bool eip=this->csr_reg[Mip] & 4?true:false;
  bool load_exception=this->EX_MEMReg.MemRead &&(rd==0);

  bool misaligned_exception=(this->EX_MEMReg.MemRead||this->EX_MEMReg.MemWrite)&&(ALU_Result&&0x3?true:false);
  bool exception_out=false;
  uint32_t ecause_out=0;
  bool interrupt=false;
  bool trapped=false;
  bool retried=false;
  if(eip){
    ecause_out=11;
    interrupt=true;
  }
  else if(tip){
    ecause_out=7;
    interrupt=true;
  }
  else if(sip){
    ecause_out=3;
    interrupt=true;
  }
  else if(!exception_in&&load_exception){
    exception_out=true;
    ecause_out=5;
    interrupt=false;
    printf("exception_in=0,load_exception=1\n");
  }
  else if(!exception_in&&misaligned_exception){
    exception_out=true;
    ecause_out=this->EX_MEMReg.MemRead?4:6;
    interrupt=false;
   // printf("exception_in=0,misaligned_exception=1\n");
  }
  else{
    exception_out=exception_in;
    ecause_out=ecause_in;
    interrupt=false;
  }
  //printf("sip:%d,tip:%d,eip:%d,exception:%d,exception_in:%d\n",sip,tip,eip,exception_out,exception_in);
  trapped=sip||tip||eip||exception_out;
  retried=!trapped&&!wfi_in;
  if(retried)this->history.retried_Count++;
  /*if((this->EX_MEMReg.MemRead||this->EX_MEMReg.MemWrite)){
    if(ALU_Result&&0x3)printf("mis:address is 0x%x\n",ALU_Result);
    
  }*/
  uint32_t cycles = 0;
  //Dcache Write and read
  bool good= this->Dcache_Write(this->EX_MEMReg.MemWrite,this->EX_MEMReg.funct3,ALU_Result,Rs2_op,&cycles);
  Mem_Result=this->Dcache_Read(this->EX_MEMReg.MemRead,this->EX_MEMReg.funct3,ALU_Result,&cycles);
  
  if (!good) this->panic("Invalid Mem Access!\n");
  if (verbose) printf("Memory Access: %s\n", INSTNAME[insttype]);
  
  //00:write this->MEM_WBNew.reg_pc to rd
  uint32_t forward_data=0;
  if(this->EX_MEMReg.MemtoReg==0x0)       forward_data = this->EX_MEMReg.reg_pc;
  else if(this->EX_MEMReg.MemtoReg==0x1)  forward_data = Mem_Result;
  else if(this->EX_MEMReg.MemtoReg==0x2)  forward_data = ALU_Result;
  //forward data
  if (this->EX_MEMReg.RegWrite && rd != 0) {
    if (this->ID_EXRegNew.rs1 == rd) {
      // Avoid overwriting recent values.if exe stage don't forward 
      //or exe stage forward but the destreg is not same as this one 
      if (this->executeWriteBack == false ||
          (this->executeWriteBack && this->executeWBReg != rd)) {
        this->ID_EXRegNew.Rs1_op = forward_data;
        this->memoryWriteBack = true;
        this->memoryWBReg = rd;
        this->history.dataHazardCount++;
        if (verbose) printf("  Forward Data %s to Decode op1\n", REGNAME[rd]);
          
      }
    }
    if (this->ID_EXRegNew.rs2 == rd) {
      // Avoid overwriting recent values
      if (this->executeWriteBack == false ||
          (this->executeWriteBack && this->executeWBReg != rd)) {
        this->ID_EXRegNew.Rs2_op = forward_data;
        this->memoryWriteBack = true;
        this->memoryWBReg = rd;
        this->history.dataHazardCount++;
        if (verbose)
          printf("  Forward Data %s to Decode op2\n", REGNAME[rd]);
      }
    }
    // Corner case of forwarding mem load data to stalled decode reg
    if (this->ID_EXReg.stall) {
      if (this->ID_EXReg.rs1 == rd) this->ID_EXReg.Rs1_op = forward_data;
      if (this->ID_EXReg.rs2 == rd) this->ID_EXReg.Rs2_op = forward_data;
      this->memoryWriteBack = true;
      this->memoryWBReg = rd;
      this->history.dataHazardCount++;
      if (verbose)
          printf("  Forward Data %s to Decode op2\n", REGNAME[rd]);
    }
  }

  this->MEM_WBNew.bubble = false;
  this->MEM_WBNew.stall = false;
  this->MEM_WBNew.insttype = insttype;

  this->MEM_WBNew.rd = rd;
  //data
  this->MEM_WBNew.reg_pc  =this->EX_MEMReg.reg_pc;
  this->MEM_WBNew.RegWrite=this->EX_MEMReg.RegWrite;
  this->MEM_WBNew.MemtoReg=this->EX_MEMReg.MemtoReg;
  //control
  this->MEM_WBNew.ALU_Result = ALU_Result;
  this->MEM_WBNew.Mem_Result = Mem_Result;
  //csr
  this->MEM_WBNew.mret_out=this->EX_MEMReg.mret_out;
  this->MEM_WBNew.csr_WriteEnable=this->EX_MEMReg.csr_WriteEnable;
  this->MEM_WBNew.csr_address=this->EX_MEMReg.csr_address;
  this->MEM_WBNew.csr_writedata=this->EX_MEMReg.csr_writedata;
  this->MEM_WBNew.csr_Readdata=this->EX_MEMReg.csr_Readdata;
  this->MEM_WBNew.csr_ecause=ecause_out;
  this->MEM_WBNew.csr_trapped=trapped;
  this->MEM_WBNew.csr_interrupt=interrupt;
  
}

void Simulator::writeBack() {
  if (this->MEM_WBReg.stall) {
    if (verbose) printf("WriteBack: stall\n");
    return;
  }
  if (this->MEM_WBReg.bubble) {
    if (verbose) printf("WriteBack: Bubble\n");
    return;
  }
  if (verbose) printf("WriteBack: %s\n", INSTNAME[this->MEM_WBReg.insttype]);
  
  if (this->MEM_WBReg.RegWrite && this->MEM_WBReg.rd != 0) {
    //Select the data to be written to the rd
    uint32_t writedata=this->Writedata_back(this->MEM_WBReg.reg_pc,
                                            this->MEM_WBReg.Mem_Result,
                                            this->MEM_WBReg.ALU_Result,
                                            this->MEM_WBReg.csr_Readdata,
                                            this->MEM_WBReg.MemtoReg);
    //writeback the data to update regfile value
    this->reg[this->MEM_WBReg.rd] = writedata;
    //forward data
    //在实际的riscv-cpu 中，WB产生的数据一旦写入reg，那么同一时刻，ID中读取到的数据就是新写入的这个reg
    //（因为规定在一个周期内对一个reg操作，总是先写后读）,因此这个数据前递就被硬件自动解决了。
    //但是在model中，由于流水线的本质还是线性进行，因此上面的操作无法自动实现，所以也需要在WB阶段实现数据前递
    if (this->ID_EXRegNew.rs1 == this->MEM_WBReg.rd) {
      // Avoid overwriting recent data
      if (!this->executeWriteBack  ||(this->executeWriteBack && this->executeWBReg != this->MEM_WBReg.rd)) {
        if (!this->memoryWriteBack ||(this->memoryWriteBack  && this->memoryWBReg != this->MEM_WBReg.rd)) {
          this->ID_EXRegNew.Rs1_op = writedata;
          this->history.dataHazardCount++;
          if (verbose) printf("  Forward Data %s to Decode op1\n",REGNAME[this->MEM_WBReg.rd]);
        }
      }
    }
    if (this->ID_EXRegNew.rs2 == this->MEM_WBReg.rd) {
      // Avoid overwriting recent data
      if (!this->executeWriteBack || (this->executeWriteBack && this->executeWBReg != this->MEM_WBReg.rd)) {
        if (!this->memoryWriteBack || (this->memoryWriteBack && this->memoryWBReg != this->MEM_WBReg.rd)) {
          this->ID_EXRegNew.Rs2_op = writedata;
          this->history.dataHazardCount++;
          if (verbose) printf("  Forward Data %s to Decode op2\n",REGNAME[this->MEM_WBReg.rd]);
        }
      }
    }
  }
}
void Simulator::csr(){
  this->IF_IDRegNew.trap_vector=this->csr_reg[Mtvec];
  this->IF_IDRegNew.mret_vector=this->csr_reg[Mepc];
  //---update reg data
  //cycle
  this->csr_reg[Mcycleh]= (uint32_t)(this->history.cycleCount>>32);
  this->csr_reg[Mcycle]= (uint32_t)(this->history.cycleCount);
  //retired inst
  this->csr_reg[Minstret]= (uint32_t)(this->history.retried_Count>>32);
  this->csr_reg[Minstreth]= (uint32_t)(this->history.retried_Count);
  //other csr reg
  uint32_t csr_writedata=this->MEM_WBNew.csr_writedata;
  bool csr_trapped=this->MEM_WBNew.csr_trapped;
  bool csr_interrupt=this->MEM_WBNew.csr_interrupt;
  uint32_t csr_ecause=this->MEM_WBNew.csr_ecause;
  bool csr_mret=this->MEM_WBNew.mret_out;
  uint32_t meip=0;//from top

  if(csr_trapped){
    //update pie
    this->csr_reg[Mstatus]&= ~(0x1 << 7);//clean
    this->csr_reg[Mstatus]|= ((this->csr_reg[Mstatus]&0x8))<<4;
    //update ie to 0
    this->csr_reg[Mstatus]&= ~(0x8);
    //update mepc
    this->csr_reg[Mepc]=this->EX_MEMReg.mem_pc;
    //update minterrupt
    this->csr_reg[Mcause]&= ~(0x1 << 31);
    this->csr_reg[Mcause]|= csr_interrupt<<31;
    //update mcause[3:0]
    this->csr_reg[Mcause]&= ~0xF ;
    this->csr_reg[Mcause]|= csr_ecause;
  }
  else if(csr_mret){
    //update ie
    this->csr_reg[Mstatus]&= ~(0x1 << 3);//clean
    this->csr_reg[Mstatus]|= ((this->csr_reg[Mstatus]&0x80))>>4;
    //update pie
    this->csr_reg[Mstatus]|= 0x80;
  }

  if(this->MEM_WBNew.csr_WriteEnable)
  {
    switch (this->MEM_WBNew.csr_address)
    {
    case Mstatus:
      this->csr_reg[Mstatus]&= ~(0x88);//clean
      this->csr_reg[Mstatus]=this->csr_reg[Mstatus]|(csr_writedata&0x88);break;//update ie and pie
    case Mie:
      this->csr_reg[Mie]&= ~(0x888);//clean
      this->csr_reg[Mie]=this->csr_reg[Mie]|(csr_writedata&0x888);break;//update msie,mtie,meie
    case Mtvec:
      this->csr_reg[Mtvec]=csr_writedata&0xFFFFFFFC;break;//update mtvec
    case Mscratch:
      this->csr_reg[Mscratch]=csr_writedata;break;//update Mscratch
    case Mepc:
      this->csr_reg[Mepc]=csr_writedata;break;//update Mepc      
    case Mcause:
      this->csr_reg[Mcause]&=~(0x8000000F);//clean
      this->csr_reg[Mcause]=this->csr_reg[Mcause]|(csr_writedata&0x8000000F);break;//update minterrupt,mcause
    case Mtval:
      this->csr_reg[Mtval]=csr_writedata;break;//update Mtval
    case Mip:
      this->csr_reg[Mip]&=~(0x8);//clean
      this->csr_reg[Mip]=this->csr_reg[Mip]|(csr_writedata&0x8);break;//update minterrupt,mcause
    case Mcycle:
      this->csr_reg[Mcycle]=csr_writedata|this->csr_reg[Mcycle];break;//update Mcycle
    case Mcycleh:
      this->csr_reg[Mcycleh]=csr_writedata|this->csr_reg[Mcycleh];break;//update Mcycle
    case Minstret:
      this->csr_reg[Minstret]=csr_writedata|this->csr_reg[Minstret];break;//update Minstret
    case Minstreth:
      this->csr_reg[Minstreth]=csr_writedata|this->csr_reg[Minstreth];break;//update Minstreth
    default:
      break;
    }
  } 
  this->csr_reg[Mip]&=~(0x880);//clean
  this->csr_reg[Mip]=this->csr_reg[Mip]|(meip<<11);
  this->csr_reg[Mip]=this->csr_reg[Mip]|((this->csr_reg[Mcycle]>=0X7FFFFFFF)<<7);
}

int32_t Simulator::handleSystemCall(int32_t op1, int32_t op2) {
  int32_t type = op2; // reg a7
  int32_t arg1 = op1; // reg a0
  switch (type) {
  case 0: { // print string
    uint32_t addr = arg1;
    char ch = this->memory->getByte(addr);
    while (ch != '\0') {
      printf("%c", ch);
      ch = this->memory->getByte(++addr);
    }
    break;
  }
  case 1: // print char
    printf("%c", (char)arg1);
    break;
  case 2: // print num
    printf("%d", (int32_t)arg1);
    break;
  case 3:
  case 93: // exit
    printf("Program exit from an exit() system call\n");
    this->printStatistics();
    exit(0);
  case 4: // read char
    scanf(" %c", (char*)&op1);
    break;
  case 5: // read num
    scanf(" %d", &op1);
    break;
  default:
    this->panic("Unknown syscall type %d\n", type);
  }
  return op1;
}

void Simulator::printInfo() {
  printf("------------ CPU STATE ------------\n");
  printf("PC: 0x%x\n", this->pc);
  for (uint32_t i = 0; i < 32; ++i) {
    printf("%s: 0x%.8x(%d) ", REGNAME[i], this->reg[i], this->reg[i]);
    if (i % 4 == 3)
      printf("\n");
  }
  printf("-----------------------------------\n");
}

void Simulator::printStatistics() {
  printf("------------ STATISTICS -----------\n");
  printf("Number of Instructions: %u\n", this->history.instCount);
  printf("Number of Cycles: %u\n", this->history.cycleCount);
  printf("Avg Cycles per Instrcution: %.4f\n",
         (float)this->history.cycleCount / this->history.instCount);
  printf("Branch Perdiction Accuacy: %.4f (Strategy: %s)\n",
         (float)this->history.predictedBranch /
             (this->history.predictedBranch + this->history.unpredictedBranch),
         this->branchPredictor->strategyName().c_str());
  printf("Number of Control Hazards: %u\n",
         this->history.controlHazardCount);
  printf("Number of Data Hazards: %u\n", this->history.dataHazardCount);
  printf("Number of Memory Hazards: %u\n",
         this->history.memoryHazardCount);
  printf("-----------------------------------\n");
  //this->memory->printStatistics();
}

std::string Simulator::getRegInfoStr() {
  std::string str;
  char buf[65536];

  str += "------------ CPU STATE ------------\n";
  sprintf(buf, "PC: 0x%x\n", this->pc);
  str += buf;
  for (uint32_t i = 0; i < 32; ++i) {
    sprintf(buf, "%s: 0x%.8x(%d) ", REGNAME[i], this->reg[i], this->reg[i]);
    str += buf;
    if (i % 4 == 3) {
      str += "\n";
    }
  }
  str += "-----------------------------------\n";

  return str;
}


//decode module
uint32_t Simulator::imm_gen(uint32_t inst){
  uint32_t imm_gen__opcode = inst & 0x7F;
  InstType imm_gen__type=NULL_TYPE;
  //decode the type
  printf("inst is %x,opcode is:%x\n",inst,imm_gen__opcode);
  switch(imm_gen__opcode)
  {
    case OP_REG:    imm_gen__type=R_TYPE; break; //0X33
    case OP_IMM:    imm_gen__type=I_TYPE; break; //0X13
    case OP_LUI:    imm_gen__type=U_TYPE; break; //0X37
    case OP_AUIPC:  imm_gen__type=U_TYPE; break; //0X17
    case OP_JAL:    imm_gen__type=UJ_TYPE;break; //0X6F
    case OP_JALR:   imm_gen__type=I_TYPE; break; //0X67
    case OP_BRANCH: imm_gen__type=SB_TYPE;break; //0X63
    case OP_STORE:  imm_gen__type=S_TYPE; break; //0X23
    case OP_LOAD:   imm_gen__type=I_TYPE; break; //0X03
    case OP_CSR: imm_gen__type=R_TYPE; break; //0X73
  }
  //generate the imm
  int32_t imm_data=0;
  if(imm_gen__type==I_TYPE)        imm_data=int32_t(inst) >> 20;
  else if(imm_gen__type==S_TYPE)   imm_data=int32_t(((inst >> 7) & 0x1F) | ((inst >> 20) & 0xFE0)) << 20 >> 20;
  else if(imm_gen__type==SB_TYPE)  imm_data=int32_t(((inst >> 7) & 0x1E) | ((inst >> 20) & 0x7E0) |
                                        ((inst << 4) & 0x800) | ((inst >> 19) & 0x1000))<< 19 >>19;
  else if(imm_gen__type==U_TYPE)   imm_data=int32_t(inst) >> 12<<12;
  else if(imm_gen__type==UJ_TYPE)  imm_data=int32_t(((inst >> 21) & 0x3FF) | ((inst >> 10) & 0x400) |
                                        ((inst >> 1) & 0x7F800) | ((inst >> 12) & 0x80000))<< 12 >>11;
  else if(imm_gen__type==R_TYPE)        imm_data=0;
  else  this->panic("Illegal Inst type!!! 0x%x!,%d\n", inst,imm_gen__type);
  if(this->immGen_verify){
    printf("----------------------------------imm_gen module----------------------------------\n");
    printf("Input :instruction:0x%.8x\n",inst);
    printf("Output:imm_data   :%d\n",imm_data);
  }
  return imm_data;
}

void Simulator::control(uint32_t opcode,uint32_t funct3,uint32_t funct7){
  //printf("inst is 0x%x,funct3 is 0x%x,funct 7 is 0x%x\n",opcode,funct3,funct7);
  if(opcode==OP_REG)
  {
      switch (funct3)
      {
        case 0x0:if(funct7==0x00){this->ID_EXRegNew.ALUOp=0;}         //ADD
                 else if(funct7==0x20){this->ID_EXRegNew.ALUOp=1;}    //SUB
                 else if(funct7==0x04){this->ID_EXRegNew.ALUOp=2;}    //XOR
                 break;
        case 0x1:if(funct7==0x00){this->ID_EXRegNew.ALUOp=5;}break;   //SLL
        case 0x2:if(funct7==0x00){this->ID_EXRegNew.ALUOp=8;}break;   //SLT
        case 0x3:if(funct7==0x00){this->ID_EXRegNew.ALUOp=9;}break;   //SLTU
        case 0x5:if(funct7==0x00){this->ID_EXRegNew.ALUOp=6;}         //SRL
                 else if(funct7==0x20){this->ID_EXRegNew.ALUOp=7;}    //SRA
                 break;
        case 0x6:if(funct7==0x00){this->ID_EXRegNew.ALUOp=3;}break;   //OR
        case 0x7:if(funct7==0x00){this->ID_EXRegNew.ALUOp=4;}break;   //AND
        default:this->panic("Die in control_OP_REG");
      }
      this->ID_EXRegNew.ImmSrc   = 0;
      this->ID_EXRegNew.isBranch = 0;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 1;
      this->ID_EXRegNew.MemtoReg = 2;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 0;
      this->ID_EXRegNew.isJump   = 0;
      this->ID_EXRegNew.islui    = 0;
  }
  else if(opcode==OP_IMM)
  {
      
      switch (funct3)
      {
        case 0x0:this->ID_EXRegNew.ALUOp=0;break;                    //ADDI
        case 0x1:if(funct7==0x00){this->ID_EXRegNew.ALUOp=5;}break;  //SLLI
        case 0x2:this->ID_EXRegNew.ALUOp=8;break;                    //SLTI
        case 0x3:this->ID_EXRegNew.ALUOp=9;break;                    //SLTIU
        case 0x4:this->ID_EXRegNew.ALUOp=2;break;                    //XORI
        case 0x5:if(funct7==0x00){this->ID_EXRegNew.ALUOp=6;}        //SRLI
                 else if(funct7==0x20){this->ID_EXRegNew.ALUOp=7;}   //SRAI
                 break;                                              
        case 0x6:this->ID_EXRegNew.ALUOp=3;break;                    //ORI
        case 0x7:this->ID_EXRegNew.ALUOp=4;break;                    //ANDI
        default:this->panic("Die in control_OP_IMM");
      }
      this->ID_EXRegNew.ImmSrc   = 1;
      this->ID_EXRegNew.isBranch = 0;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 1;
      this->ID_EXRegNew.MemtoReg = 2;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 0;
      this->ID_EXRegNew.isJump   = 0;
      this->ID_EXRegNew.islui    = 0;
  }
  else if(opcode==OP_LOAD)
  {
      if(funct3==0x0||funct3==0x1||funct3==0x2||funct3==0x4||funct3==0x5||funct3==0x3||funct3==0x6)   //LB,LH,LW,LBU,LHU,<LD,LWU>
      {
        this->ID_EXRegNew.ALUOp    = 0;
        this->ID_EXRegNew.ImmSrc   = 1;
        this->ID_EXRegNew.isBranch = 0;
        this->ID_EXRegNew.MemRead  = 1;
        this->ID_EXRegNew.MemWrite = 0;
        this->ID_EXRegNew.RegWrite = 1;
        this->ID_EXRegNew.MemtoReg = 1;
        this->ID_EXRegNew.pcsel    = 0;
        this->ID_EXRegNew.rdsel    = 0;
        this->ID_EXRegNew.isJump   = 0;
        this->ID_EXRegNew.islui    = 0;
      }
      else this->panic("Die in control_OP_LOAD");
  }
  else if(opcode==OP_STORE)
  {
      if(funct3==0x0||funct3==0x1||funct3==0x2) //SB,SH,SW
      {
        this->ID_EXRegNew.ALUOp    = 0;
        this->ID_EXRegNew.ImmSrc   = 1;
        this->ID_EXRegNew.isBranch = 0;
        this->ID_EXRegNew.MemRead  = 0;
        this->ID_EXRegNew.MemWrite = 1;
        this->ID_EXRegNew.RegWrite = 0;
        this->ID_EXRegNew.MemtoReg = 0;
        this->ID_EXRegNew.pcsel    = 0;
        this->ID_EXRegNew.rdsel    = 0;
        this->ID_EXRegNew.isJump   = 0;
        this->ID_EXRegNew.islui    = 0;
      }
      else this->panic("Die in control_OP_STORE");
  }
  else if(opcode==OP_BRANCH)
  {
      if(funct3==0x0||funct3==0x1||funct3==0x4||funct3==0X5) //BEQ,BNE,BLT,BGE
      {
        this->ID_EXRegNew.ALUOp    = 8;
      }
      else if(funct3==0x6||funct3==0x7)//BLTU,BGEU
      {
        this->ID_EXRegNew.ALUOp    = 9;
      }
      else this->panic("Die in control_OP_BRANCH");
      this->ID_EXRegNew.ImmSrc   = 0;
      this->ID_EXRegNew.isBranch = 1;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 0;
      this->ID_EXRegNew.MemtoReg = 0;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 0;
      this->ID_EXRegNew.isJump   = 0;
      this->ID_EXRegNew.islui    = 0;
  }
  else if(opcode==OP_JAL)
  {
      this->ID_EXRegNew.ALUOp    = 0;
      this->ID_EXRegNew.ImmSrc   = 1;
      this->ID_EXRegNew.isBranch = 0;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 1;
      this->ID_EXRegNew.MemtoReg = 0;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 0;
      this->ID_EXRegNew.isJump   = 1;
      this->ID_EXRegNew.islui    = 0;
  }
  else if(opcode==OP_JALR )
  {
      if(funct3==0X0)
      {
        this->ID_EXRegNew.ALUOp    = 0;
        this->ID_EXRegNew.ImmSrc   = 1;
        this->ID_EXRegNew.isBranch = 0;
        this->ID_EXRegNew.MemRead  = 0;
        this->ID_EXRegNew.MemWrite = 0;
        this->ID_EXRegNew.RegWrite = 1;
        this->ID_EXRegNew.MemtoReg = 0;
        this->ID_EXRegNew.pcsel    = 1;
        this->ID_EXRegNew.rdsel    = 0;
        this->ID_EXRegNew.isJump   = 1;
        this->ID_EXRegNew.islui    = 0;
      }
      else this->panic("Die in control_OP_JALR");
      
  }
  else if(opcode==OP_LUI)
  {
      this->ID_EXRegNew.ALUOp    = 0;
      this->ID_EXRegNew.ImmSrc   = 1;
      this->ID_EXRegNew.isBranch = 0;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 1;
      this->ID_EXRegNew.MemtoReg = 2;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 0;
      this->ID_EXRegNew.isJump   = 0;
      this->ID_EXRegNew.islui    = 1;
  }
  else if(opcode==OP_AUIPC)
  {
      this->ID_EXRegNew.ALUOp    = 0;
      this->ID_EXRegNew.ImmSrc   = 1;
      this->ID_EXRegNew.isBranch = 0;
      this->ID_EXRegNew.MemRead  = 0;
      this->ID_EXRegNew.MemWrite = 0;
      this->ID_EXRegNew.RegWrite = 1;
      this->ID_EXRegNew.MemtoReg = 0;
      this->ID_EXRegNew.pcsel    = 0;
      this->ID_EXRegNew.rdsel    = 1;
      this->ID_EXRegNew.isJump   = 0;
      this->ID_EXRegNew.islui    = 0;
  }
  else if(opcode==OP_CSR)
  {
    switch (funct3)
    {
      case 0x0:break;                //ECALL,EBREAK,MRET,WFI
      case 0x1:this->ID_EXRegNew.ImmSrc   = 0;break;  //SLLI
      case 0x2:this->ID_EXRegNew.ImmSrc   = 0;break;                    //SLTI
      case 0x3:this->ID_EXRegNew.ImmSrc   = 0;break;                    //SLTIU
      
      case 0x5:this->ID_EXRegNew.ImmSrc   = 1;break;                                              
      case 0x6:this->ID_EXRegNew.ImmSrc   = 1;break;                    //ORI
      case 0x7:this->ID_EXRegNew.ImmSrc   = 1;break;                    //ANDI
      default:this->panic("Die in control_OP_IMM");
    }

    this->ID_EXRegNew.ALUOp    = 0;
    this->ID_EXRegNew.isBranch = 0;
    this->ID_EXRegNew.MemRead  = 0;
    this->ID_EXRegNew.MemWrite = 0;
    this->ID_EXRegNew.RegWrite = 1;
    this->ID_EXRegNew.MemtoReg = 3;
    this->ID_EXRegNew.pcsel    = 0;
    this->ID_EXRegNew.rdsel    = 0;
    this->ID_EXRegNew.isJump   = 0;
    this->ID_EXRegNew.islui    = 0;
  }
}

//Hazard
void Simulator::DataHazard(uint32_t memRead,RISCV::RegId id_rs1,RISCV::RegId id_rs2,RISCV::RegId ex_rd){
  if (memRead&&(id_rs1 == ex_rd || id_rs2 == ex_rd)) {
    //如果当前指令是读指令，且下一个指令的rs1或rs2等于当前指令的目的寄存器，那么fetch和decode需要停顿1个周期
      this->IF_IDRegNew.stall = 1;
      this->ID_EXRegNew.stall = 1;//as same as set id_ex_flush=1(clean all the control signal)
      this->pcWrite=false;
      this->history.memoryHazardCount++;
  }
  if(false){
  //if(this->hazard_verify){
    printf("--------------------------------------hazard module--------------------------------------\n");
    printf("-->DataHazard\n");
    printf("Input :MemRead :%d ,ID_RS1:%s ,ID_RS2:%s ,EX_RD:%s \n",memRead,REGNAME[id_rs1],REGNAME[id_rs2],REGNAME[ex_rd]);
    printf("Output:PC_Stall:%d ,IF_ID_Stall:%d ,ID_EX_Flush:%d \n",this->pcWrite,this->IF_IDRegNew.stall,this->ID_EXRegNew.stall);
  }
}

void Simulator::ForwardData(){
  if (this->ID_EXReg.RegWrite && this->ID_EXReg.rd != 0 && !this->ID_EXReg.MemRead) {
    if (this->ID_EXRegNew.rs1 == this->ID_EXReg.rd) {
      this->ID_EXRegNew.Rs1_op = this->EX_MEMRegNew.AluResult;//Current cycle EXE stage ALU calculation result
      this->executeWBReg = this->ID_EXReg.rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op1\n", REGNAME[this->ID_EXReg.rd]);
    }
    if (this->ID_EXRegNew.rs2 == this->ID_EXReg.rd) {
      this->ID_EXRegNew.Rs2_op = this->EX_MEMRegNew.AluResult;//Current cycle EXE stage ALU calculation result;
      this->executeWBReg = this->ID_EXReg.rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op2\n", REGNAME[this->ID_EXReg.rd]);
    }
  }
}
//MEM
//Dcache_Write
bool Simulator::Dcache_Write(uint32_t mem_write, int32_t funct3,int32_t AluResult,int32_t RS2_op,uint32_t *cycles){
  bool good=true;
  if (mem_write) {
    switch (funct3) {
    case 0:good = this->memory->setByte(AluResult, RS2_op& 0xFF, cycles); break;
    case 1:good = this->memory->setShort(AluResult,RS2_op& 0xFFFF, cycles); break;
    case 2:good = this->memory->setInt(AluResult, RS2_op& 0xFFFFFFFF, cycles); break;
    default:this->panic("Unknown funct3 %d\n", this->EX_MEMReg.funct3);
    }
    if(this->dcache_verify){
      printf("-----------------------------------Dcache Write module-----------------------------------\n");
      printf("Input :mem_write:%d ,funct3:0x%.2x ,AluResult:0x%x ,RS2_op:%d \n",mem_write,funct3,AluResult,RS2_op);
    }
  }
  
  return good;
}
//Dcache_Read
int32_t Simulator::Dcache_Read(uint32_t mem_read, int32_t funct3,int32_t AluResult,uint32_t *cycles){
  int32_t Mem_Result;
  if (mem_read) {
    switch (funct3) {
    case 0: Mem_Result = (int32_t)this->memory->getByte(AluResult, cycles);break;
    case 1: Mem_Result = (int32_t)this->memory->getShort(AluResult, cycles);break;
    case 2: Mem_Result = (int32_t)this->memory->getInt(AluResult, cycles);break;
    case 4: Mem_Result = (uint32_t)this->memory->getByte(AluResult, cycles);break;
    case 5: Mem_Result = (uint32_t)this->memory->getShort(AluResult, cycles);break;
    default:this->panic("Unknown funct3 %d\n", this->EX_MEMReg.funct3);
    }
    if(this->dcache_verify){
      printf("-----------------------------------Dcache Read module----------- ------------------------\n");
      printf("Input :mem_write:%d ,funct3:0x%.2x ,AluResult:0x%x \n",mem_read,funct3,AluResult);
      printf("OutPUT:Mem_Result:%d \n",Mem_Result);
    }
  }
  
  return Mem_Result;
}
//WB
uint32_t Simulator::Writedata_back(uint32_t wb_reg_pc,uint32_t wb_readdata,uint32_t wb_AluResult,uint32_t wb_csrReadData,uint32_t wb_memtoreg){
  uint32_t writedata=0;
  if(this->MEM_WBReg.MemtoReg==0x0)       writedata = wb_reg_pc;
  else if(this->MEM_WBReg.MemtoReg==0x1)  writedata = wb_readdata;
  else if(this->MEM_WBReg.MemtoReg==0x2)  writedata = wb_AluResult;
  else if(this->MEM_WBReg.MemtoReg==0x3)  writedata = wb_csrReadData;
  if(this->write_data_back_verify){
    printf("----------------------------------writedata_back module----------------------------------\n");
    printf("Input :wb_reg_pc:0x%x ,wb_readdata:0x%x ,wb_AluResult:0x%x ,wb_memtoreg:0x%.2x\n",wb_reg_pc,
                                                                                              wb_readdata,
                                                                                              wb_AluResult,
                                                                                              wb_memtoreg);
    printf("Output:writedata:0x%x\n",writedata);
  }
  return writedata;
}

void Simulator::panic(const char *format, ...) {
  char buf[BUFSIZ];
  va_list args;
  va_start(args, format);
  vsprintf(buf, format, args);
  fprintf(stderr, "%s", buf);
  va_end(args);
  fprintf(stderr, "Execution history and memory dump in dump.txt\n");
  exit(-1);
}