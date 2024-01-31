#ifndef BRANCH_PREDICTOR_H
#define BRANCH_PREDICTOR_H

#include <cstdint>
#include <string>

const int PRED_BUF_SIZE = 16;
const int BHT_SIZE=16;
const int BHT_SIZE_BIT=4;

class BranchPredictor {
public:
  enum Strategy {
    BPB, // Branch Prediction Buffer with 2bit history information
  } strategy;

  BranchPredictor();
  ~BranchPredictor();

  bool predict(uint32_t pc, int32_t offset);
  void update(uint32_t pc, bool branch);

  bool bht_hit(uint32_t pc);
  uint32_t get_bht_address(uint32_t pc);
  void update_bht(uint32_t pc,uint32_t target_pc);
  std::string strategyName();
  
private:
  enum PredictorState {
    STRONG_TAKEN = 0, WEAK_TAKEN = 1,
    STRONG_NOT_TAKEN = 3, WEAK_NOT_TAKEN = 2,
  } predbuf[PRED_BUF_SIZE]; // initial state: WEAK_TAKEN
  struct bht_entry{
    uint32_t tag;
    bool valid;
    uint32_t target_pc;
  }bht_entry[BHT_SIZE];
};

#endif