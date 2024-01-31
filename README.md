## Compile

```
mkdir build
cd build
cmake ..
make
```
or run ./run-inclass-tests.sh

## Usage

```
./Simulator riscv-elf-file-name [-v] [-s] [-d] [-b strategy]
```
Parameters:

1. `-v` for verbose output, can redirect output to file for further analysis
2. `-s` for single step execution, often used in combination with `-v`.
3. `-d` for creating memory and register history dump in `dump.txt`