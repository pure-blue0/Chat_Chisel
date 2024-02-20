rm -rf build
mkdir build
cd build
cmake ..
make
./model ../32riscv-elf/rv32ui-p-add -s -v
# ./model ../32riscv-elf/ackermann.riscv
# ./model ../32riscv-elf/helloworld.riscv
# ./model ../32riscv-elf/matrixmult.riscv
# ./model ../32riscv-elf/quicksort.riscv
# ./model ../32riscv-elf/test_arithmetic.riscv
# ./model ../32riscv-elf/test_branch.riscv