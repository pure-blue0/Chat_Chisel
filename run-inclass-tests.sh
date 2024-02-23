rm -rf build
mkdir build
cd build
cmake ..
make
./model ../riscv-tests/rv32ui/rv32ui-p-xor 
./model ../riscv-tests/rv32ui/rv32ui-v-xor -s -v

#  ./model ../32riscv-elf/rv32ui-p-add
#  ./model ../32riscv-elf/rv32ui-p-lui 
# ./model ../32riscv-elf/ackermann.riscv
#./model ../32riscv-elf/helloworld.riscv -s -v
# ./model ../32riscv-elf/matrixmult.riscv
# ./model ../32riscv-elf/quicksort.riscv
# ./model ../32riscv-elf/test_arithmetic.riscv
# ./model ../32riscv-elf/test_branch.riscv