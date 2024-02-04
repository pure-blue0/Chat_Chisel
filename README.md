## Project Introduction

Supports the RV32I instruction set, has implemented all functions except CSR, can run elf files and output correct results

## Correction Record

2.4 modified the code related to branch prediction, encapsulated most modules into functions, and added some information output prompts (need to turn on the corresponding verify flag bit) to facilitate testing.

## Project document description:

1. 32riscv-elf->mainly composed of some executable files (.riscv) and some disassembled files.
2. src->contains the source code for the project, including the main function entry
3. test-> are some related c programs, compiled through the tool chain to obtain an executable file
4. run-inclass-> project compilation script; 
5. gen_RV32I_elf->script that generates an executable file from C code 

## Compile

```
mkdir build
cd build
cmake ..
make
----------
Or run ./run-inclass-tests.sh
```

## Usage

```
./model riscv-elf-file-name [-v] [-s]  
(eg: ./build/model  ./32riscv-elf/test_branch.riscv -s -v)
```
Parameters:

1. `-v` for verbose output, can redirect output to file for further analysis
2. `-s` for single step execution, often used in combination with `-v`.