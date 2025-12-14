#!/bin/bash

# Termux 软件源更新脚本
# 用于生成 Packages 和 Release 文件

echo "开始更新 Termux 软件源..."

# 检查 dpkg-dev 是否已安装
if ! command -v dpkg-scanpackages &> /dev/null; then
    echo "错误: 未找到 dpkg-scanpackages。请先安装 dpkg-dev。"
    echo "在 Ubuntu/Debian 系统上运行: sudo apt-get install dpkg-dev"
    exit 1
fi

# 为每个架构生成 Packages 文件
for arch_dir in dists/termux/extras/binary-*; do
    if [ -d "$arch_dir" ]; then
        echo "处理架构目录: $arch_dir"
        
        # 生成 Packages 文件（基于 pkgs 目录中的 .deb 文件）
        if [ -d "pkgs" ] && [ -n "$(ls pkgs/*.deb 2>/dev/null)" ]; then
            dpkg-scanpackages pkgs /dev/null > "$arch_dir/Packages"
            echo "已生成 $arch_dir/Packages"
            
            # 压缩 Packages 文件
            gzip -k -f "$arch_dir/Packages"
            echo "已生成 $arch_dir/Packages.gz"
        else
            # 如果没有包文件，创建空的 Packages 文件
            touch "$arch_dir/Packages"
            echo "# 暂无软件包" > "$arch_dir/Packages"
            gzip -k -f "$arch_dir/Packages"
            echo "已创建空的 Packages 文件和 Packages.gz"
        fi
        
        # 更新 Release 文件
        arch_name=$(basename "$arch_dir" | sed 's/binary-//')
        echo "Archive: termux" > "$arch_dir/Release"
        echo "Component: extras" >> "$arch_dir/Release"
        echo "Origin: alhkxsj" >> "$arch_dir/Release"
        echo "Label: Termux Third-Party" >> "$arch_dir/Release"
        echo "Architecture: $arch_name" >> "$arch_dir/Release"
        
        echo "已更新 $arch_dir/Release"
    fi
done

echo "Termux 软件源更新完成！"