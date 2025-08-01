#!/bin/bash

echo "请选择要创建软链接的对象类型："
echo "1. 目录"
echo "2. 文件"
echo "3. 源路径下的所有文件和文件夹"
read choice

echo "请输入源路径:"
read sourcePath

currentPath=$(pwd)
echo "请输入目标路径（直接回车将创建到当前路径：$currentPath）:"
read targetPath

if [ -z "$targetPath" ]; then
    targetPath="$currentPath"
fi

if [ $choice -eq 1 ]; then
    ln -s -d "$sourcePath" "$targetPath"
elif [ $choice -eq 2 ]; then
    ln -s "$sourcePath" "$targetPath"
elif [ $choice -eq 3 ]; then
    if [ -d "$sourcePath" ]; then
        cd "$sourcePath"
        find . -mindepth 1 -maxdepth 1 -exec ln -s "$sourcePath/{}" "$targetPath/{}" \;
        cd -
    else
        echo "源路径不是一个有效的目录"
    fi
else
    echo "无效的选择"
fi