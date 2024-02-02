rm -rf build
mkdir build
cd build
cmake ..
make

./Simulator ../32riscv-elf/ackermann.riscv
./Simulator ../32riscv-elf/helloworld.riscv
./Simulator ../32riscv-elf/matrixmult.riscv
./Simulator ../32riscv-elf/quicksort.riscv
./Simulator ../32riscv-elf/test_arithmetic.riscv
./Simulator ../32riscv-elf/test_branch.riscv