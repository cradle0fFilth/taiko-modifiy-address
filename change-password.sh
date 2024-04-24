#!/bin/bash

# 指定输入文件和输出文件前缀
input_file="private-key.txt"
# 指定ssh到的主机名
ssh_file="address.txt"
i=1
# 读取前11行文件内容并处理
head -n 11 "$input_file" | while IFS= read -r line; do
    # 使用行号作为文件名
    output_file="${i}.sh"

    # 写入文件内容
    echo "#!/bin/bash" > "$output_file"
    echo "mv *.sh 1.sh"
    echo "sed -i \"s|L1_PROPOSER_PRIVATE_KEY=.*|L1_PROPOSER_PRIVATE_KEY=${line}|\" .env" >> "$output_file"
    ((i++))
    # 添加执行权限
    chmod +x "$output_file"

    # 输出文件名
    echo "已生成文件：$output_file"
done
i=1
# 读取目标主机地址

head -n 11 "$ssh_file" | while IFS= read -r line; do
    ./password.exp $i $line
    ./ssh.exp ${i}.sh $line
    ((i++))
done
