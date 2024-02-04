#include "MemoryManager.h"

#include <cstdio>
#include <string>

MemoryManager::MemoryManager() {
  this->icache = nullptr;
  this->dcache = nullptr;
  for (uint32_t i = 0; i < 1024; ++i) {
    this->memory[i] = nullptr;
  }
}

MemoryManager::~MemoryManager() {
  for (uint32_t i = 0; i < 1024; ++i) {
    if (this->memory[i] != nullptr) {
      for (uint32_t j = 0; j < 1024; ++j) {
        if (this->memory[i][j] != nullptr) {
          delete[] this->memory[i][j];
          this->memory[i][j] = nullptr;
        }
      }
      delete[] this->memory[i];
      this->memory[i] = nullptr;
    }
  }
}

bool MemoryManager::addPage(uint32_t addr) {
  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  if (this->memory[i] == nullptr) {
    this->memory[i] = new uint8_t *[1024];
    memset(this->memory[i], 0, sizeof(uint8_t *) * 1024);
  }
  if (this->memory[i][j] == nullptr) {
    this->memory[i][j] = new uint8_t[4096];
    memset(this->memory[i][j], 0, 4096);
  } else {
    printf("Addr 0x%x already exists and do not need an addPage()!\n", addr);
    return false;
  }
  return true;
}

bool MemoryManager::isPageExist(uint32_t addr) {
  return this->isAddrExist(addr);
}

bool MemoryManager::copyFrom(const void *src, uint32_t dest, uint32_t len) {
  for (uint32_t i = 0; i < len; ++i) {
    if (!this->isAddrExist(dest + i)) {
      printf("Data copy to invalid addr 0x%x!\n", dest + i);
      return false;
    }
    this->setByte(dest + i, ((uint8_t *)src)[i]);
  }
  return true;
}

bool MemoryManager::setByte(uint32_t addr, uint8_t val, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Byte write to invalid addr 0x%x!\n", addr);
    return false;
  }
  if (this->dcache != nullptr) {
    this->dcache->setByte(addr, val, cycles);
    return true;
  }

  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  this->memory[i][j][k] = val;
  return true;
}
bool MemoryManager::set_iByte(uint32_t addr, uint8_t val, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Byte write to invalid addr 0x%x!\n", addr);
    return false;
  }
  if (this->icache != nullptr) {
    this->icache->setByte(addr, val, cycles);
    return true;
  }

  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  this->memory[i][j][k] = val;
  return true;
}
bool MemoryManager::setByteNoCache(uint32_t addr, uint8_t val) {
  if (!this->isAddrExist(addr)) {
    printf("Byte write to invalid addr 0x%x!\n", addr);
    return false;
  }

  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  this->memory[i][j][k] = val;
  return true;
}

uint8_t MemoryManager::getByte(uint32_t addr, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Byte read to invalid addr 0x%x!\n", addr);
    return false;
  }
  if (this->dcache != nullptr) {
    return this->dcache->getByte(addr, cycles);
  }
  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  return this->memory[i][j][k];
}
uint8_t MemoryManager::get_iByte(uint32_t addr, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Byte read to invalid addr 0x%x!\n", addr);
    return false;
  }
  if (this->icache != nullptr) {
    return this->icache->getByte(addr, cycles);
  }
  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  return this->memory[i][j][k];
}
uint8_t MemoryManager::getByteNoCache(uint32_t addr) {
  if (!this->isAddrExist(addr)) {
    printf("Byte read to invalid addr 0x%x!\n", addr);
    return false;
  }
  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  uint32_t k = this->getPageOffset(addr);
  return this->memory[i][j][k];
}

bool MemoryManager::setShort(uint32_t addr, uint16_t val, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Short write to invalid addr 0x%x!\n", addr);
    return false;
  }
  this->setByte(addr, val & 0xFF, cycles);
  this->setByte(addr + 1, (val >> 8) & 0xFF);
  return true;
}

uint16_t MemoryManager::getShort(uint32_t addr, uint32_t *cycles) {
  uint32_t b1 = this->getByte(addr, cycles);
  uint32_t b2 = this->getByte(addr + 1);
  return b1 + (b2 << 8);
}

bool MemoryManager::setInt(uint32_t addr, uint32_t val, uint32_t *cycles) {
  if (!this->isAddrExist(addr)) {
    printf("Int write to invalid addr 0x%x!\n", addr);
    return false;
  }
  this->set_iByte(addr, val & 0xFF, cycles);
  this->set_iByte(addr + 1, (val >> 8) & 0xFF);
  this->set_iByte(addr + 2, (val >> 16) & 0xFF);
  this->set_iByte(addr + 3, (val >> 24) & 0xFF);
  return true;
}

uint32_t MemoryManager::getInt(uint32_t addr, uint32_t *cycles) {
  uint32_t b1 = this->get_iByte(addr, cycles);
  uint32_t b2 = this->get_iByte(addr + 1);
  uint32_t b3 = this->get_iByte(addr + 2);
  uint32_t b4 = this->get_iByte(addr + 3);
  return b1 + (b2 << 8) + (b3 << 16) + (b4 << 24);
}


void MemoryManager::printInfo() {
  printf("Memory Pages: \n");
  for (uint32_t i = 0; i < 1024; ++i) {
    if (this->memory[i] == nullptr) {
      continue;
    }
    printf("0x%x-0x%x:\n", i << 22, (i + 1) << 22);
    for (uint32_t j = 0; j < 1024; ++j) {
      if (this->memory[i][j] == nullptr) {
        continue;
      }
      printf("  0x%x-0x%x\n", (i << 22) + (j << 12),
             (i << 22) + ((j + 1) << 12));
    }
  }
}

void MemoryManager::printStatistics() {
  printf("---------- CACHE STATISTICS ----------\n");
  this->icache->printStatistics();
  this->dcache->printStatistics();
}

std::string MemoryManager::dumpMemory() {
  char buf[65536];
  std::string dump;

  dump += "Memory Pages: \n";
  for (uint32_t i = 0; i < 1024; ++i) {
    if (this->memory[i] == nullptr) {
      continue;
    }
    sprintf(buf, "0x%x-0x%x:\n", i << 22, (i + 1) << 22);
    dump += buf;
    for (uint32_t j = 0; j < 1024; ++j) {
      if (this->memory[i][j] == nullptr) {
        continue;
      }
      sprintf(buf, "  0x%x-0x%x\n", (i << 22) + (j << 12),
              (i << 22) + ((j + 1) << 12));
      dump += buf;

      for (uint32_t k = 0; k < 1024; ++k) {
        sprintf(buf, "    0x%x: 0x%x\n", (i << 22) + (j << 12) + k,
                this->memory[i][j][k]);
        dump += buf;
      }
    }
  }
  return dump;
}

uint32_t MemoryManager::getFirstEntryId(uint32_t addr) {
  return (addr >> 22) & 0x3FF;
}

uint32_t MemoryManager::getSecondEntryId(uint32_t addr) {
  return (addr >> 12) & 0x3FF;
}

uint32_t MemoryManager::getPageOffset(uint32_t addr) { return addr & 0xFFF; }

bool MemoryManager::isAddrExist(uint32_t addr) {
  uint32_t i = this->getFirstEntryId(addr);
  uint32_t j = this->getSecondEntryId(addr);
  if (memory[i] && memory[i][j]) {
    return true;
  }
  return false;
}

void MemoryManager::set_iCache(Cache *icache) { this->icache = icache;}
void MemoryManager::set_dCache(Cache *dcache) { this->icache = icache;}
