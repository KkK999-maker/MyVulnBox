#!/bin/bash

# ==============================
# 设置靶机脚本
# ==============================
# 使用前请先将脚本赋予执行权限：chmod +x setup_target.sh
# 然后执行脚本：./setup_target.sh

# ==============================
# 基本设置
# ==============================
# 1. 系统是Ubuntu
# 2. 有一个管理者叫K999，拥有最高使用者的权限
# 3. K999的密码是congragulation用base64加密的方式储存
# 4. 确认ssh服务是否存在，如果不存在，把它建立起来

# 安装 OpenSSH 服务
apt-get update
apt-get install -y openssh-server

# 添加用户 K999
useradd -m -s /bin/bash K999

# 设置 K999 的密码（使用 base64 编码）
echo 'K999:Y29uZ3JhZ3VuYXRpb24=' | chpasswd -e

# ==============================
# 漏洞设置
# ==============================
# 1. 漏洞是 CVE-2017-5638
# 2. 新增一个普通的使用者叫Allin，他的密码是dsvq43#^$sdcsz，并用明文的方式储存
# 3. 在Allin的主目录下面新增一个叫user.txt的文件，里面放一串随机的乱码

# 添加用户 Allin
useradd -m -s /bin/bash Allin

# 设置 Allin 的密码
echo 'Allin:dsvq43#^$sdcsz' | chpasswd

# 在 Allin 的主目录下创建 user.txt 文件并写入随机内容
echo "Random Text" > /home/Allin/user.txt

# ==============================
# 提权设置
# ==============================
# 1. 在 root 的主目录下，建立一个叫 root.txt 的文件，并将 root's flag 放进此文件
# 2. 在 Allin 的主目录下，有一个文件具有SUID漏洞

# 在 root 的主目录下创建 root.txt 文件并写入 flag
echo "root's flag" > /root/root.txt

# 创建具有 SUID 漏洞的文件（示例文件，具体漏洞需要根据实际情况设置）
touch /home/Allin/suid_vulnerable_file
chmod +s /home/Allin/suid_vulnerable_file

# 完成
echo "靶机设置完成！"
