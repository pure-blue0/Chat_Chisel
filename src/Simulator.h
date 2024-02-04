#ifndef SIMULATOR_H
#define SIMULATOR_H

#include <cstdarg>
#include <cstdint>
#include <string>
#include <vector>

#include "BranchPredictor.h"
#include "MemoryManager.h"

namespace RISCV {

const int REGNUM = 32;
extern const char *REGNAME[32];
typedef uint32_t RegId;
enum Reg {
  REG_ZERO = 0,
  REG_RA = 1,
  REG_SP = 2,
  REG_GP = 3,
  REG_TP = 4,
  REG_T0 = 5,
  REG_T1 = 6,
  REG_T2 = 7,
  REG_S0 = 8,
  REG_S1 = 9,
  REG_A0 = 10,
  REG_A1 = 11,
  REG_A2 = 12,
  REG_A3 = 13,
  REG_A4 = 14,
  REG_A5 = 15,
  REG_A6 = 16,
  REG_A7 = 17,
  REG_S2 = 18,
  REG_S3 = 19,
  REG_S4 = 20,
  REG_S5 = 21,
  REG_S6 = 22,
  REG_S7 = 23,
  REG_S8 = 24,
  REG_S9 = 25,
  REG_S10 = 26,
  REG_S11 = 27,
  REG_T3 = 28,
  REG_T4 = 29,
  REG_T5 = 30,
  REG_T6 = 31,
};

enum InstType {
  R_TYPE,
  I_TYPE,
  S_TYPE,
  SB_TYPE,
  U_TYPE,
  UJ_TYPE,
  NULL_TYPE,
};
enum Inst {
  LUI = 0,
  AUIPC = 1,
  JAL = 2,
  JALR = 3,
  BEQ = 4,
  BNE = 5,
  BLT = 6,
  BGE = 7,
  BLTU = 8,
  BGEU = 9,
  LB = 10,
  LH = 11,
  LW = 12,
  LD = 13,
  LBU = 14,
  LHU = 15,
  SB = 16,
  SH = 17,
  SW = 18,
  SD = 19,
  ADDI = 20,
  SLTI = 21,
  SLTIU = 22,
  XORI = 23,
  ORI = 24,
  ANDI = 25,
  SLLI = 26,
  SRLI = 27,
  SRAI = 28,
  ADD = 29,
  SUB = 30,
  SLL = 31,
  SLT = 32,
  SLTU = 33,
  XOR = 34,
  SRL = 35,
  SRA = 36,
  OR = 37,
  AND = 38,
  ECALL = 39,
  ADDIW = 40,
  MUL = 41,
  MULH = 42,
  DIV = 43,
  REM = 44,
  LWU = 45,
  SLLIW = 46,
  SRLIW = 47,
  SRAIW = 48,
  ADDW = 49,
  SUBW = 50,
  SLLW = 51,
  SRLW = 52,
  SRAW = 53,
  UNKNOWN = -1,
};
extern const char *INSTNAME[];

// Opcode field
const int OP_REG = 0x33;
const int OP_IMM = 0x13;
const int OP_LUI = 0x37;
const int OP_BRANCH = 0x63;
const int OP_STORE = 0x23;
const int OP_LOAD = 0x03;
const int OP_AUIPC = 0x17;
const int OP_JAL = 0x6F;
const int OP_JALR = 0x67;
const int OP_SYSTEM = 0x73;

inline bool isBranch(Inst inst) {
  if (inst == BEQ || inst == BNE || inst == BLT || inst == BGE ||
      inst == BLTU || inst == BGEU) {
    return true;
  }
  return false;
}

inline bool isJump(Inst inst) {
  if (inst == JAL || inst == JALR) {
    return true;
  }
  return false;
}

inline bool isReadMem(Inst inst) {
  if (inst == LB || inst == LH || inst == LW || inst == LD || inst == LBU ||
      inst == LHU || inst == LWU) {
    return true;
  }
  return false;
}

} // namespace RISCV

class Simulator {
public:
  bool isSingleStep;
  bool verbose;
  bool ispcsrc;
  bool BP_mux;//The first mux value in PCgen
  //BHT
  bool BHT_verify;
  bool BHT_match;
  uint32_t BHT_target_pc;
  bool BHT_valid;

  bool write_data_back_verify;
  bool immGen_verify;
  bool hazard_verify;
  bool dcache_verify;
  bool targetGen_verify;
  
  uint32_t pcNew;
  uint32_t pc;
  uint32_t pcWrite;
  uint32_t predictedPC; // for branch prediction module, predicted PC destination
  uint32_t reg[RISCV::REGNUM];
  uint32_t stackBase;
  uint32_t maximumStackSize;
  MemoryManager *memory;
  BranchPredictor *branchPredictor;

  Simulator(MemoryManager *memory, BranchPredictor *predictor);
  ~Simulator();

  void initStack(uint32_t baseaddr, uint32_t maxSize);

  void simulate();

  void printInfo();

  void printStatistics();
  //void print_BHT_Info();

private:
  struct FReg {
    // Control Signals
    bool bubble;
    uint32_t stall;

    uint32_t id_pc;
    uint32_t inst;

    bool prediction_jump;
  } IF_IDReg, IF_IDRegNew;
  struct DReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    

    uint32_t pc;
    RISCV::Inst insttype;
    uint32_t op1;
    uint32_t op2;
    RISCV::RegId dest;
    bool prediction_jump;

    //new control
    uint32_t ALUOp;     //4bit
    uint32_t ImmSrc;    //1bit
    uint32_t isBranch;
    uint32_t MemRead;
    uint32_t MemWrite;
    uint32_t RegWrite;
    uint32_t MemtoReg; //2bit
    uint32_t pcsel;
    uint32_t rdsel;
    uint32_t isJump;
    uint32_t islui;

    //new other
    RISCV::RegId rs1, rs2;
    RISCV::RegId rd;
    uint32_t ex_pc;
    uint32_t  Rs1_op;
    uint32_t  Rs2_op;
    uint32_t      imm;
    int32_t      funct3;
    
  } ID_EXReg, ID_EXRegNew;
  struct EReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    RISCV::Inst insttype;
    RISCV::RegId rd;

    uint32_t Rs2_op;
    uint32_t AluResult;
    int32_t  funct3;

    
    uint32_t mem_pc;
    uint32_t reg_pc;
    uint32_t target_pc;

    bool Branch_zero;
    bool predictedbranch;
    
    //Control
    uint32_t isBranch;
    uint32_t isJump;
    uint32_t MemRead;
    uint32_t MemWrite;
    uint32_t RegWrite;
    uint32_t MemtoReg; //2bit

  } EX_MEMReg, EX_MEMRegNew;
  struct MReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    RISCV::Inst insttype;

    RISCV::RegId rd;
    //data
    uint32_t reg_pc;
    uint32_t ALU_Result;
    uint32_t Mem_Result;
    //control
    uint32_t RegWrite;
    uint32_t MemtoReg; //2bit
  } MEM_WBReg, MEM_WBNew;

  // Pipeline Related Variables
  // To avoid older values(in MEM) overriding newer values(in EX)
  bool executeWriteBack;
  RISCV::RegId executeWBReg;
  bool memoryWriteBack;
  RISCV::RegId memoryWBReg;

  struct History {
    uint32_t instCount;
    uint32_t cycleCount;
    uint32_t stalledCycleCount;

    uint32_t predictedBranch; // Number of branch that is predicted successfully
    uint32_t unpredictedBranch; // Number of branch that is not predicted
                                // successfully

    uint32_t dataHazardCount;
    uint32_t controlHazardCount;
    uint32_t memoryHazardCount;

    std::vector<std::string> instRecord;
    std::vector<std::string> regRecord;

    std::string memoryDump;
  } history;

  void fetch();
  void decode();
  void execute();
  void memoryAccess();
  void writeBack();

  

  int32_t handleSystemCall(int32_t op1, int32_t op2);

  std::string getRegInfoStr();
  //decode module
  uint32_t imm_gen(uint32_t inst);
  void control(uint32_t opcode,uint32_t funct3,uint32_t funct7);
  //hazard
  void DataHazard(uint32_t memRead,RISCV::RegId id_rs1,RISCV::RegId id_rs2,RISCV::RegId ex_rd);
  void ForwardData();
  //mem
  int32_t Dcache_Read(uint32_t mem_read,int32_t funct3,int32_t AluResult,uint32_t *cycles);
  bool Dcache_Write(uint32_t mem_write, int32_t funct3,int32_t AluResult,int32_t RS2_op,uint32_t *cycles);

  //wb
  uint32_t Writedata_back(uint32_t wb_reg_pc,uint32_t wb_readdata,uint32_t wb_AluResult,uint32_t wb_memtoreg);
  

  void panic(const char *format, ...);
};

#endif
