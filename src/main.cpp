#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>

#include <elfio/elfio.hpp>

#include "BranchPredictor.h"
#include "Cache.h"
#include "MemoryManager.h"
#include "Simulator.h"

bool parseParameters(int argc, char **argv);
void printUsage();
void printElfInfo(ELFIO::elfio *reader);
void loadElfToMemory(ELFIO::elfio *reader, MemoryManager *memory);

char *elfFile = nullptr;
bool verbose = 0;
bool isSingleStep = 0;
uint32_t stackBaseAddr = 0x8000f000;
uint32_t stackSize = 0x8000;
MemoryManager memory;
Cache *l1i_Cache, *l1d_Cache;
BranchPredictor::Strategy strategy = BranchPredictor::Strategy::BPB;
BranchPredictor branchPredictor;
Simulator simulator(&memory, &branchPredictor);

int main(int argc, char **argv) {
  if (!parseParameters(argc, argv)) {
    printUsage();
    exit(-1);
  }

  // Init cache
  Cache::Policy l1i_Policy, l1d_Policy;

  l1i_Policy.cacheSize = 32 * 1024;
  l1i_Policy.blockSize = 64;
  l1i_Policy.blockNum = l1i_Policy.cacheSize / l1i_Policy.blockSize;
  l1i_Policy.associativity = 8;
  l1i_Policy.hitLatency = 0;
  l1i_Policy.missLatency = 8;

  l1d_Policy.cacheSize = 32 * 1024;
  l1d_Policy.blockSize = 64;
  l1d_Policy.blockNum = l1d_Policy.cacheSize / l1d_Policy.blockSize;
  l1d_Policy.associativity = 8;
  l1d_Policy.hitLatency = 0;
  l1d_Policy.missLatency = 8;

  l1i_Cache = new Cache(&memory, l1i_Policy);
  l1d_Cache = new Cache(&memory, l1d_Policy);

  memory.set_iCache(l1i_Cache);
  memory.set_dCache(l1d_Cache);
  // Read ELF file
  ELFIO::elfio reader;
  if (!reader.load(elfFile)) {
    fprintf(stderr, "Fail to load ELF file %s!\n", elfFile);
    return -1;
  }

  if (verbose) {
    printElfInfo(&reader);
  }

  loadElfToMemory(&reader, &memory);

  

  simulator.isSingleStep = isSingleStep;
  simulator.verbose = verbose;
  simulator.branchPredictor->strategy = strategy;
  simulator.pcNew = reader.get_entry();
  simulator.initStack(stackBaseAddr, stackSize);
  if (verbose) {
    memory.printInfo();
  }
  simulator.simulate();
  

  delete l1i_Cache;
  delete l1d_Cache;
  return 0;
}

bool parseParameters(int argc, char **argv) {
  // Read Parameters
  for (int i = 1; i < argc; ++i) {
    if (argv[i][0] == '-') {
      switch (argv[i][1]) {
      case 'v':
        verbose = 1;
        break;
      case 's':
        isSingleStep = 1;
        break;
      default:
        return false;
      }
    } else {
      if (elfFile == nullptr) {
        elfFile = argv[i];
      } else {
        return false;
      }
    }
  }
  if (elfFile == nullptr) {
    return false;
  }
  return true;
}

void printUsage() {
  printf("Usage: Simulator riscv-elf-file [-v] [-s] \n");
  printf("Parameters: \n\t[-v] verbose output \n\t[-s] single step\n");
}

void printElfInfo(ELFIO::elfio *reader) {
  printf("==========ELF Information==========\n");

  if (reader->get_class() == ELFCLASS32) {
    printf("Type: ELF32\n");
  } else {
    printf("Type: ELF64\n");
  }

  if (reader->get_encoding() == ELFDATA2LSB) {
    printf("Encoding: Little Endian\n");
  } else {
    printf("Encoding: Large Endian\n");
  }

  if (reader->get_machine() == EM_RISCV) {
    printf("ISA: RISC-V(0x%x)\n", reader->get_machine());
  } else {
    printf("ISA: Unsupported(0x%x)\n", reader->get_machine());
    exit(-1);
  }

  ELFIO::Elf_Half sec_num = reader->sections.size();
  printf("Number of Sections: %d\n", sec_num);
  printf("ID\tName\t\t\tAddress\t\tSize\n");

  for (int i = 0; i < sec_num; ++i) {
    const ELFIO::section *psec = reader->sections[i];

    printf("[%d]\t%-16s\t0x%-6lx\t%ld\n", i, psec->get_name().c_str(),
           psec->get_address(), psec->get_size());
  }

  ELFIO::Elf_Half seg_num = reader->segments.size();
  printf("Number of Segments: %d\n", seg_num);
  printf("ID\tFlags\tAddress\t\tFSize\tMSize\n");

  for (int i = 0; i < seg_num; ++i) {
    const ELFIO::segment *pseg = reader->segments[i];

    printf("[%d]\t0x%x\t0x%lx\t%ld\t%ld\n", i, pseg->get_flags(),
           pseg->get_virtual_address(), pseg->get_file_size(),
           pseg->get_memory_size());
  }

  printf("===================================\n");
}

void loadElfToMemory(ELFIO::elfio *reader, MemoryManager *memory) {
  ELFIO::Elf_Half seg_num = reader->segments.size();
  for (int i = 0; i < seg_num; ++i) {
    const ELFIO::segment *pseg = reader->segments[i];

    uint64_t fullmemsz = pseg->get_memory_size();
    uint64_t fulladdr = pseg->get_virtual_address();
    if (fulladdr + fullmemsz > 0xFFFFFFFF) {
      printf(
          "ELF address space larger than 32bit! Seg %d has max addr of 0x%lx\n",
          i, fulladdr + fullmemsz);
      exit(-1);
    }

    uint32_t filesz = pseg->get_file_size();
    uint32_t memsz = pseg->get_memory_size();
    uint32_t addr = (uint32_t)pseg->get_virtual_address();

    for (uint32_t p = addr; p < addr + memsz; ++p) {
      if (!memory->isPageExist(p)) {
        memory->addPage(p);
      }
      if (p < addr + filesz) {
        memory->setByteNoCache(p, pseg->get_data()[p - addr]&0xff);
      } else {
        memory->setByteNoCache(p, 0);
      }
    }
  }
  
}