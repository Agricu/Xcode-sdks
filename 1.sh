#!/bin/bash

# 脚本说明：将当前目录下的每个子文件夹打包为单独的zip文件
# 使用方法：将此脚本放在目标目录下，然后执行 ./pack_folders_to_zip.sh

echo "开始打包当前目录下的所有子文件夹..."

# 获取当前目录路径
current_dir=$(pwd)

# 计数器
count=0

# 遍历当前目录下的所有子文件夹
for folder in */; do
    # 移除路径末尾的斜杠
    folder_name=${folder%/}
    
    # 检查是否是目录
    if [ -d "$folder_name" ]; then
        # 设置zip文件名（与文件夹同名）
        zip_file="${folder_name}.zip"
        
        echo "正在打包: $folder_name -> $zip_file"
        
        # 打包文件夹为zip文件
        zip -r -q "$zip_file" "$folder_name"
        
        # 检查zip命令是否成功
        if [ $? -eq 0 ]; then
            echo "✅ 成功打包: $zip_file"
            ((count++))
        else
            echo "❌ 打包失败: $folder_name"
        fi
    fi
done

echo "完成！共打包了 $count 个文件夹。"

# 显示创建的zip文件
echo "创建的zip文件:"
ls -l *.zip
