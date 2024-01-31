echo "Building RISC-V ISA=RV32I ELFs..."

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/ackermann.c test/lib.c -o 32riscv-elf/ackermann.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/ackermann.riscv > 32riscv-elf/ackermann.s

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/helloworld.c test/lib.c -o 32riscv-elf/helloworld.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/helloworld.riscv > 32riscv-elf/helloworld.s

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/matrixmulti.c test/lib.c -o 32riscv-elf/matrixmulti.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/matrixmulti.riscv > 32riscv-elf/matrixmulti.s

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/quicksort.c test/lib.c -o 32riscv-elf/quicksort.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/quicksort.riscv > 32riscv-elf/quicksort.s

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/test_arithmetic.c test/lib.c -o 32riscv-elf/test_arithmetic.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/test_arithmetic.riscv > 32riscv-elf/test_arithmetic.s

/opt/riscv32i/bin/riscv32-unknown-elf-gcc -march=rv32i test/test_branch.c test/lib.c -o 32riscv-elf/test_branch.riscv
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -D 32riscv-elf/test_branch.riscv > 32riscv-elf/test_branch.s
 