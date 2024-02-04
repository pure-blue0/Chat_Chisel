#include "BranchPredictor.h"

BranchPredictor::BranchPredictor() {
  for (int i = 0; i < PRED_BUF_SIZE; ++i) {
    this->predbuf[i] = WEAK_TAKEN;
  }
  for (int i = 0; i < BHT_SIZE; ++i) {
    this->bht_entry[i].tag = 0;
    this->bht_entry[i].valid = false;
    this->bht_entry[i].target_pc = 0;
  }
}

BranchPredictor::~BranchPredictor() {}

bool BranchPredictor::BTB_Predict(uint32_t pc) {
  PredictorState state = this->predbuf[pc % PRED_BUF_SIZE];
  if (state == STRONG_TAKEN || state == WEAK_TAKEN) {
    return true;
  } else if (state == STRONG_NOT_TAKEN || state == WEAK_NOT_TAKEN) {
    return false;
  } else {
    printf("Strange Prediction Buffer!\n");
  }   
}

void BranchPredictor::update(uint32_t pc, bool branch) {
  int id = pc % PRED_BUF_SIZE;
  PredictorState state = this->predbuf[id];
  if (branch) {
    if (state == STRONG_NOT_TAKEN) {
      this->predbuf[id] = WEAK_NOT_TAKEN;
    } else if (state == WEAK_NOT_TAKEN) {
      this->predbuf[id] = WEAK_TAKEN;
    } else if (state == WEAK_TAKEN) {
      this->predbuf[id] = STRONG_TAKEN;
    } // do nothing if STRONG_TAKEN
  } else { // not branch
    if (state == STRONG_TAKEN) {
      this->predbuf[id] = WEAK_TAKEN;
    } else if (state == WEAK_TAKEN) {
      this->predbuf[id] = WEAK_NOT_TAKEN;
    } else if (state == WEAK_NOT_TAKEN) {
      this->predbuf[id] = STRONG_NOT_TAKEN;
    } // do noting if STRONG_NOT_TAKEN
  }
}
bool BranchPredictor::bht_match(uint32_t pc)
{
  int index = pc % BHT_SIZE;

  if(this->bht_entry[index].tag==pc>>BHT_SIZE_BIT){
    //printf("Will get data from BHT_entry[%-2d]:tag:0x%.4x , valid:%d ,targetpc:0x%.5x\n",index,this->bht_entry[index].tag,this->bht_entry[index].valid,this->bht_entry[index].target_pc);
    return true;
  }
  else 
    return false;
}
uint32_t BranchPredictor::get_bht_address(uint32_t pc)
{
  int index = pc % BHT_SIZE;
  return this->bht_entry[index].target_pc;
}
bool BranchPredictor::get_bht_valid(uint32_t pc)
{
  int index = pc % BHT_SIZE;
  if(this->bht_entry[index].valid==1)return true;
  else return false;
}
void BranchPredictor::update_bht(uint32_t pc,uint32_t target_pc)
{
  int index = pc % BHT_SIZE;
  this->bht_entry[index].tag = pc>>BHT_SIZE_BIT;
  this->bht_entry[index].valid = true;
  this->bht_entry[index].target_pc = target_pc;
  //printf("updata BHT_entry[%-2d]:tag:0x%.4x , valid:%d ,targetpc:0x%.5x\n",index,this->bht_entry[index].tag,this->bht_entry[index].valid,this->bht_entry[index].target_pc);
}
void BranchPredictor::print_bht()
{
  for (int i = 0; i < BHT_SIZE; ++i) {
    printf("BHT_entry[%-2d]:tag:0x%.4x , valid:%d ,targetpc:0x%.5x\n",i,this->bht_entry[i].tag,this->bht_entry[i].valid,this->bht_entry[i].target_pc);
  }
  printf("--------------------------------------------\n");

}
std::string BranchPredictor::strategyName() {
  
  return "Branch Prediction Buffer";
}