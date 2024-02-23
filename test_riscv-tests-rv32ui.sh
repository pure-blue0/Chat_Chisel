#!/bin/bash
test_dir="./riscv-tests/rv32ui"
count=0
for test_file in $test_dir/rv32ui-p-*; do
    file_name=$(basename "$test_file")  # get file name
    if [[ ! "$file_name" =~ \.dump$ ]]; then
         # 打印测试文件名
        test_command="./build/model $test_dir/$file_name"
        echo "正在测试第<$count>个文件 文件名：$file_name"
        $test_command
        ((count++))
        read -p "按下回车键继续..."
    fi
   
done




