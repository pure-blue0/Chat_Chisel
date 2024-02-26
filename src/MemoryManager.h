#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H

#include <cstdint>
#include <cstdio>

#include <elfio/elfio.hpp>

#include "Cache.h"

class Cache;

class MemoryManager
{
public:
  MemoryManager();
  ~MemoryManager();

  bool addPage(uint32_t addr);
  bool isPageExist(uint32_t addr);

  bool copyFrom(const void *src, uint32_t dest, uint32_t len);

  bool setByte(uint32_t addr, uint8_t val, uint32_t *cycles = nullptr);
  bool set_iByte(uint32_t addr, uint8_t val, uint32_t *cycles = nullptr);
  bool setByteNoCache(uint32_t addr, uint8_t val);
  uint8_t getByte(uint32_t addr, uint32_t *cycles = nullptr);
  uint8_t get_iByte(uint32_t addr, uint32_t *cycles = nullptr);
  uint8_t getByteNoCache(uint32_t addr);

  bool setShort(uint32_t addr, uint16_t val, uint32_t *cycles = nullptr);
  uint16_t getShort(uint32_t addr, uint32_t *cycles = nullptr);

  bool setInt(uint32_t addr, uint32_t val, uint32_t *cycles = nullptr);
  uint32_t getInt(uint32_t addr, uint32_t *cycles = nullptr);
  uint32_t get_iInt(uint32_t addr, uint32_t *cycles = nullptr);
  void printInfo();
  void printStatistics();

  std::string dumpMemory();

  void set_iCache(Cache *icache);  
  void set_dCache(Cache *dcache);

private:
  uint32_t getFirstEntryId(uint32_t addr);
  uint32_t getSecondEntryId(uint32_t addr);
  uint32_t getPageOffset(uint32_t addr);
  bool isAddrExist(uint32_t addr);

  uint8_t **memory[1024];
  Cache *icache,*dcache;
};

#endif