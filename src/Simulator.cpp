#include <cstring>
#include <fstream>
#include <sstream>
#include <string>

#include "Debug.h"
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
    "lui",  "auipc", "jal",   "jalr",  "beq",   "bne",  "blt",  "bge",  "bltu",
    "bgeu", "lb",    "lh",    "lw",    "ld",    "lbu",  "lhu",  "sb",   "sh",
    "sw",   "sd",    "addi",  "slti",  "sltiu", "xori", "ori",  "andi", "slli",
    "srli", "srai",  "add",   "sub",   "sll",   "slt",  "sltu", "xor",  "srl",
    "sra",  "or",    "and",   "ecall", "addiw", "mul",  "mulh", "div",  "rem",
    "lwu",  "slliw", "srliw", "sraiw", "addw",  "subw", "sllw", "srlw", "sraw",
};

} // namespace RISCV

using namespace RISCV;

Simulator::Simulator(MemoryManager *memory, BranchPredictor *predictor) {
  this->memory = memory;
  this->branchPredictor = predictor;
  this->pc = 0;
  this->pcNew=0;
  this->pcWrite = true;
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
  this->BHT_verify=false;//debug test
  this->write_data_back_verify=false;
  this->immGen_verify=false;
  // Insert Bubble to later pipeline stages
  IF_IDReg.bubble = true;
  ID_EXReg.bubble = true;
  EX_MEMReg.bubble = true;
  MEM_WBReg.bubble = true;
  int CYCLE=0;
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
      printf("----------CYCLE %d----------------\n",CYCLE);
      printf("-----------------------------------\n");
    }
    CYCLE++;

    

    this->fetch();
    this->decode();
    this->execute();
    this->memoryAccess();
    this->writeBack();

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

    //The back-end redirection is performed at the end
    if (!this->ID_EXReg.bubble && !this->ID_EXReg.stall && !this->IF_IDReg.stall && this->ID_EXReg.predictedBranch) {
    this->pcNew = this->predictedPC;
    }
    
    

    this->history.cycleCount++;
    this->history.regRecord.push_back(this->getRegInfoStr());
    if (this->history.regRecord.size() >= 100000) { //Avoid using too much memory
      this->history.regRecord.clear();
      this->history.instRecord.clear();
    }

    if (verbose) this->printInfo();

    if (this->isSingleStep) {
      printf("Type d to dump memory in dump.txt, press ENTER to continue: ");
      char ch;
      while ((ch = getchar()) != '\n') {
        if (ch == 'd') this->dumpHistory();
      }
    }
  }
}

void Simulator::fetch() {

  if(this->pcWrite)this->pc=this->pcNew;
  else this->pc=this->pc;
  
  if (this->pc % 2 != 0) this->panic("Illegal PC 0x%x!\n", this->pc);
  //get fetch(The process of getting the finger from the Icache is also in the function)
  uint32_t inst = this->memory->getInt(this->pc);
  /*
  bool predictedBranch = false;
  predictedBranch = this->branchPredictor->predict(this->pc);
  bool BHT_match=this->branchPredictor->bht_match(this->IF_IDReg.id_pc);
  bool BHT_valid=this->branchPredictor->get_bht_valid(this->IF_IDReg.id_pc);
  uint32_t BHT_target_pc=this->branchPredictor->get_bht_address(this->IF_IDReg.id_pc);
  if (predictedBranch && BHT_match && BHT_valid) {
    this->predictedPC = BHT_target_pc;
    this->IF_IDRegNew.bubble = true;
    if(this->BHT_verify)printf("Module:BHT  match %d, valid %d ,bht_pred_pc 0x%.8x\n",BHT_match,BHT_valid,BHT_target_pc);
  } */

  if (this->verbose) printf("Fetched instruction 0x%.8x at address 0x%x\n", inst, this->pc);
  
  this->IF_IDRegNew.bubble = false;
  this->IF_IDRegNew.stall = false;
  this->IF_IDRegNew.inst = inst;
  this->IF_IDRegNew.id_pc = this->pc;
  this->pcNew = this->pc + 4; 
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
  InstType type=NULL_TYPE;

  uint32_t inst = this->IF_IDReg.inst;
  int32_t  Rs1_op = 0, Rs2_op = 0, imm = 0; 
  
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
  case OP_SYSTEM:
    if (funct3 == 0x0 && funct7 == 0x0) {
      instname = "ecall";
      Rs1_op = this->reg[REG_A0];
      Rs2_op = this->reg[REG_A7];
      reg1 = REG_A0;
      reg2 = REG_A7;
      dest = REG_A0;
      insttype = ECALL;
    } 
    else this->panic("Unknown OP_SYSTEM inst with funct3 0x%x and funct7 0x%x\n",funct3, funct7);
    inststr = instname;
    break;
  default:  this->panic("Unsupported opcode 0x%x!\n", opcode);
  }
  //save info
  char buf[4096];
  sprintf(buf, "0x%x: %s\n", this->IF_IDReg.id_pc, inststr.c_str());
  this->history.instRecord.push_back(buf);
  if (verbose)  printf("Decoded instruction 0x%.8x as %s\n", inst, inststr.c_str());
    
  if (instname != INSTNAME[insttype]) this->panic("Unmatch instname %s with insttype %d\n", instname.c_str(), insttype);
  //calculate branch address and save the back-end redirection address
  bool predictedBranch = false;
  if (this->ID_EXRegNew.isBranch) {

    predictedBranch = this->branchPredictor->predict(this->IF_IDReg.id_pc);
    if (predictedBranch) {
      //BHT
      bool BHT_match=this->branchPredictor->bht_match(this->IF_IDReg.id_pc);
      uint32_t BHT_target_pc=this->branchPredictor->get_bht_address(this->IF_IDReg.id_pc);
      bool BHT_valid=this->branchPredictor->get_bht_valid(this->IF_IDReg.id_pc);
      if(BHT_match&&BHT_valid){
        if(verbose)printf("the inst is hit bht_entry\n");
        this->predictedPC = BHT_target_pc;
      }
      else 
      {
        if(verbose)printf("the inst is not bht_entry\n");
        this->predictedPC = this->IF_IDReg.id_pc + imm;//当前指令的地址+偏移
      }

      this->IF_IDRegNew.bubble = true;
      if(this->BHT_verify)printf("Module:BHT  match %d, valid %d ,bht_pred_pc 0x%.8x\n",BHT_match,BHT_valid,BHT_target_pc);
    } 
  }

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
  this->ID_EXRegNew.predictedBranch = predictedBranch;
  
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

  uint32_t dRegPC = this->ID_EXReg.ex_pc;
  RegId rd   = this->ID_EXReg.rd;
  int32_t result  = 0;
  
  bool readSignExt = false;
  uint32_t memLen = 0;
  bool branch = false;

  switch (insttype) {
  case LUI:   
    result = offset << 12;
    break;
  case AUIPC: 
    result = dRegPC + (offset << 12); 
    this->EX_MEMRegNew.reg_pc=result;
    
    break;
  case JAL:  
    this->EX_MEMRegNew.reg_pc=dRegPC + 4;
    dRegPC = dRegPC + offset; 
    branch = true;
    break;
  case JALR:      
    this->EX_MEMRegNew.reg_pc=dRegPC + 4;
    dRegPC = (Rs1_op + offset) & (~(uint32_t)1);  
    branch = true;
    break;
  case BEQ:
    if (Rs1_op == Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case BNE:
    if (Rs1_op != Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case BLT:
    if (Rs1_op < Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case BGE:
    if (Rs1_op >= Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case BLTU:
    if ((uint32_t)Rs1_op < (uint32_t)Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case BGEU:
    if ((uint32_t)Rs1_op >= (uint32_t)Rs2_op) {
      branch = true;
      dRegPC = dRegPC + offset; 
    }
    break;
  case LB:
    memLen = 1;
    result = Rs1_op + offset;
    readSignExt = true;
    break;
  case LH:
    memLen = 2;
    result = Rs1_op + offset;
    readSignExt = true;
    break;
  case LW:
    memLen = 4;
    result = Rs1_op + offset;
    readSignExt = true;
    break;
  case LBU:
    memLen = 1;
    result = Rs1_op + offset;
    break;
  case LHU:
    memLen = 2;
    result = Rs1_op + offset;
    break;
  case SB:
    memLen = 1;
    result = Rs1_op + offset;
    Rs2_op = Rs2_op & 0xFF;
    break;
  case SH:
    memLen = 2;
    result = Rs1_op + offset;
    Rs2_op = Rs2_op & 0xFFFF;
    break;
  case SW:
    memLen = 4;
    result = Rs1_op + offset;
    Rs2_op = Rs2_op & 0xFFFFFFFF;
    break;
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
  case ECALL: result = handleSystemCall(Rs1_op, Rs2_op); break;
  default:    this->panic("Unknown instruction type %d\n", insttype);
  }
  //BHT_update
  if(branch==true)
  { 
    this->EX_MEMRegNew.target_pc=dRegPC;
    this->branchPredictor->update_bht(this->ID_EXReg.ex_pc,this->EX_MEMRegNew.target_pc);
    
    if(this->BHT_verify){
      this->branchPredictor->print_bht();
    }
  }

  // branch Related Code
  if (this->ID_EXReg.isBranch) {
    if (this->ID_EXReg.predictedBranch == branch) {
      this->history.predictedBranch++;
    } 
    else {
      // Control Hazard Here
      this->pcNew = dRegPC;//可以理解为后端重定向的那个mux
      this->EX_MEMRegNew.target_pc=dRegPC;

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
    this->pcNew = dRegPC; //可以理解为后端重定向的那个mux
    this->EX_MEMRegNew.target_pc=dRegPC;
    this->IF_IDRegNew.bubble = true;
    this->ID_EXRegNew.bubble = true;
    this->history.controlHazardCount++;
  }
  if (this->ID_EXReg.MemRead) {
    //如果当前指令是读指令，且下一个指令的rs1或rs2等于当前指令的目的寄存器，那么fetch和decode需要停顿两个周期（从内存取数据、写入目标寄存器）
    if (this->ID_EXRegNew.rs1 == rd || this->ID_EXRegNew.rs2 == rd) {
      this->IF_IDRegNew.stall = 2;
      this->ID_EXRegNew.stall = 2;
      this->EX_MEMRegNew.bubble = true;//这里不能忘
      this->pcWrite=false;
      this->history.memoryHazardCount++;
    }
  }

  // Check for data hazard and forward data
  if (this->ID_EXReg.RegWrite && rd != 0 && !this->ID_EXReg.MemRead) {
    if (this->ID_EXRegNew.rs1 == rd) {
      this->ID_EXRegNew.Rs1_op = result;
      this->executeWBReg = rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op1\n", REGNAME[rd]);
    }
    if (this->ID_EXRegNew.rs2 == rd) {
      this->ID_EXRegNew.Rs2_op = result;
      this->executeWBReg = rd;
      this->executeWriteBack = true;
      this->history.dataHazardCount++;
      if (verbose) printf("  Forward Data %s to Decode op2\n", REGNAME[rd]);
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

  this->EX_MEMRegNew.readSignExt = readSignExt;
  this->EX_MEMRegNew.insttype = insttype;   //no need later
  this->EX_MEMRegNew.rd  = rd;
  this->EX_MEMRegNew.result   = result; 
  this->EX_MEMRegNew.memLen = memLen;
  this->EX_MEMRegNew.Rs2_op = Rs2_op;     // for store
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
  int32_t ALU_Result = this->EX_MEMReg.result;
  int32_t Mem_Result =0;
  bool readSignExt = this->EX_MEMReg.readSignExt;
  uint32_t memLen = this->EX_MEMReg.memLen;

  bool good = true;
  uint32_t cycles = 0;

  if (this->EX_MEMReg.MemWrite) {
    switch (memLen) {
    case 1:
      good = this->memory->setByte(ALU_Result, Rs2_op, &cycles);
      break;
    case 2:
      good = this->memory->setShort(ALU_Result,Rs2_op, &cycles);
      break;
    case 4:
      good = this->memory->setInt(ALU_Result, Rs2_op, &cycles);
      break;
      this->panic("Unknown memLen %d\n", memLen);
    }
  }

  if (!good) {
    this->panic("Invalid Mem Access!\n");
  }

  if (this->EX_MEMReg.MemRead) {
    switch (memLen) {
    case 1:
      if (readSignExt) {
        Mem_Result = (int32_t)this->memory->getByte(ALU_Result, &cycles);
        
      } else {
        Mem_Result = (uint32_t)this->memory->getByte(ALU_Result, &cycles);
      }
      break;
    case 2:
      if (readSignExt) {
        Mem_Result = (int32_t)this->memory->getShort(ALU_Result, &cycles);
      } else {
        Mem_Result = (uint32_t)this->memory->getShort(ALU_Result, &cycles);
      }
      break;
    case 4:
      if (readSignExt) {
        Mem_Result = (int32_t)this->memory->getInt(ALU_Result, &cycles);
      } else {
        Mem_Result = (uint32_t)this->memory->getInt(ALU_Result, &cycles);
      }
      break;
    default:
      this->panic("Unknown memLen %d\n", memLen);
    }
  
  }


  if (verbose) {
    printf("Memory Access: %s\n", INSTNAME[insttype]);
  }
  
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
        if (verbose)
          printf("  Forward Data %s to Decode op1\n", REGNAME[rd]);
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
  //control
  this->MEM_WBNew.RegWrite=this->EX_MEMReg.RegWrite;
  this->MEM_WBNew.MemtoReg=this->EX_MEMReg.MemtoReg;
  this->MEM_WBNew.reg_pc  =this->EX_MEMReg.reg_pc;

  this->MEM_WBNew.insttype = insttype;// no need later
  this->MEM_WBNew.rd = rd;
  this->MEM_WBNew.ALU_Result = ALU_Result;
  this->MEM_WBNew.Mem_Result = Mem_Result;
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
  //在实际的riscv-cpu 中，WB产生的数据一旦写入reg，那么同一时刻，ID中读取到的数据就是新写入的这个reg
  //（因为规定在一个周期内对一个reg操作，总是先写后读）,因此这个数据前递就被硬件自动解决了。
  //但是在model中，由于流水线的本质还是线性进行，因此上面的操作无法自动实现，所以也需要在WB阶段实现数据前递
  if (this->MEM_WBReg.RegWrite && this->MEM_WBReg.rd != 0) {// forward data
    uint32_t writedata=this->Writedata_back(this->MEM_WBReg.reg_pc,
                                            this->MEM_WBReg.Mem_Result,
                                            this->MEM_WBReg.ALU_Result,
                                            this->MEM_WBReg.MemtoReg);
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
    // Real Write Back
    this->reg[this->MEM_WBReg.rd] = writedata;
  }
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
    if (shouldDumpHistory) {
      printf("Dumping history to dump.txt...");
      this->dumpHistory();
    }
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

void Simulator::dumpHistory() {
  std::ofstream ofile("dump.txt");
  ofile << "================== Excecution History =================="
        << std::endl;
  for (uint32_t i = 0; i < this->history.instRecord.size(); ++i) {
    ofile << this->history.instRecord[i];
    ofile << this->history.regRecord[i];
  }
  ofile << "========================================================"
        << std::endl;
  ofile << std::endl;

  ofile << "====================== Memory Dump ======================"
        << std::endl;
  ofile << this->memory->dumpMemory();
  ofile << "========================================================="
        << std::endl;
  ofile << std::endl;

  ofile.close();
}

//decode module
uint32_t Simulator::imm_gen(uint32_t inst){
  uint32_t imm_gen__opcode = inst & 0x7F;
  InstType imm_gen__type=NULL_TYPE;
  //decode the type
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
    case OP_SYSTEM: imm_gen__type=R_TYPE; break; //0X73
  }
  //generate the imm
  int32_t imm_data=0;
  if(imm_gen__type==I_TYPE)        imm_data=int32_t(inst) >> 20;
  else if(imm_gen__type==S_TYPE)   imm_data=int32_t(((inst >> 7) & 0x1F) | ((inst >> 20) & 0xFE0)) << 20 >> 20;
  else if(imm_gen__type==SB_TYPE)  imm_data=int32_t(((inst >> 7) & 0x1E) | ((inst >> 20) & 0x7E0) |
                                        ((inst << 4) & 0x800) | ((inst >> 19) & 0x1000))<< 19 >>19;
  else if(imm_gen__type==U_TYPE)   imm_data=int32_t(inst) >> 12;
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
  else if(opcode==OP_SYSTEM)
  {
    this->ID_EXRegNew.RegWrite = 1;
  }
}

uint32_t Simulator::Writedata_back(uint32_t wb_reg_pc,uint32_t wb_readdata,uint32_t wb_AluResult,uint32_t wb_memtoreg){
  uint32_t writedata=0;
  if(this->MEM_WBReg.MemtoReg==0x0)       writedata = wb_reg_pc;
  else if(this->MEM_WBReg.MemtoReg==0x1)  writedata = wb_readdata;
  else if(this->MEM_WBReg.MemtoReg==0x2)  writedata = wb_AluResult;
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
  this->dumpHistory();
  fprintf(stderr, "Execution history and memory dump in dump.txt\n");
  exit(-1);
}