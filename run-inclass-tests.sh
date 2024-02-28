rm -rf build
mkdir build
cd build
cmake ..
make
#./model ../riscv-tests/rv32ui/rv32ui-p-lui
#./model ../riscv-tests/rv32ui/rv32ui-v-lw -s -v

#./model ../riscv-tests/rv32mi/rv32mi-p-lh-misaligned 
#./model ../riscv-tests/rv32mi/rv32mi-p-lw-misaligned 
#./model ../riscv-tests/rv32mi/rv32mi-p-ma_addr
#./model ../riscv-tests/rv32mi/rv32mi-p-mcsr
#./model ../riscv-tests/rv32mi/rv32mi-p-sh-misaligned 
#./model ../riscv-tests/rv32mi/rv32mi-p-zicntr -s -v
#./model ../riscv-tests/rv32mi/rv32mi-p-sw-misaligned  #pass address 0x800002b0

#./model ../riscv-tests/rv32mi/rv32mi-p-shamt #pass address 800001f4
#./model ../riscv-tests/rv32mi/rv32mi-p-sbreak #pass address 800001dc

#./model ../riscv-tests/rv32mi/rv32mi-p-csr -s -v



#./model ../riscv-tests/rv32mi/rv32mi-p-scall -s -v


#./model ../riscv-tests/rv32mi/rv32mi-p-illegal -s -v
#./model ../riscv-tests/rv32mi/_rv32mi-p-ma_fetch -s -v

#  ./model ../32riscv-elf/rv32ui-p-add
#  ./model ../32riscv-elf/rv32ui-p-lui 
# ./model ../32riscv-elf/ackermann.riscv
#./model ../32riscv-elf/helloworld.riscv -s -v
# ./model ../32riscv-elf/matrixmult.riscv
# ./model ../32riscv-elf/quicksort.riscv
# ./model ../32riscv-elf/test_arithmetic.riscv
# ./model ../32riscv-elf/test_branch.riscv