rm -rf build
mkdir build
cd build
cmake ..
make
# ./model ../riscv-tests/rv32ui/rv32ui-p-jalr 
# #./model ../riscv-tests/rv32ui/rv32ui-v-lw -s -v
# ./model ../riscv-tests/rv32mi/rv32mi-p-lh-misaligned 
# ./model ../riscv-tests/rv32mi/rv32mi-p-ma_addr 
# ./model ../riscv-tests/rv32mi/rv32mi-p-mcsr
#./model ../riscv-tests/rv32mi/rv32mi-p-sbreak -s -v
./model ../riscv-tests/rv32mi/rv32mi-p-scall -s -v
#  ./model ../32riscv-elf/rv32ui-p-add
#  ./model ../32riscv-elf/rv32ui-p-lui 
# ./model ../32riscv-elf/ackermann.riscv
#./model ../32riscv-elf/helloworld.riscv -s -v
# ./model ../32riscv-elf/matrixmult.riscv
# ./model ../32riscv-elf/quicksort.riscv
# ./model ../32riscv-elf/test_arithmetic.riscv
# ./model ../32riscv-elf/test_branch.riscv