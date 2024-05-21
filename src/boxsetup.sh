#!/bin/bash

# 使用說明
# 1. Copy this script to the target Ubuntu machine.
# 2. Open terminal on the Ubuntu machine.
# 3. Navigate to the directory containing this script.
# 4. Make the script executable by running: chmod +x box.sh
# 5. Execute the script by running: sudo ./box.sh

# 靶機管理設定
echo "" 
echo "靶機管理設定"

# 1. 確認系統是Ubuntu
if [ -f /etc/lsb-release ]; then
  . /etc/lsb-release
  if [ "$DISTRIB_ID" != "Ubuntu" ]; then
    echo "此腳本僅適用於Ubuntu系統。"
    exit 1
  fi
else
  echo "此腳本僅適用於Ubuntu系統。"
  exit 1
fi

# 2. 建立使用者K999並加入root群組
useradd -m K999
usermod -aG root K999

# 3. 設定K999的密碼，並用base64儲存
echo "K999:$(echo -n 'congragulation' | base64)" | chpasswd

# 4. 確認ssh服務是否存在，如果不存在，把他建立起來
if ! systemctl is-active --quiet ssh; then
  apt-get update
  apt-get install -y openssh-server
  systemctl start ssh
  systemctl enable ssh
fi

# 5. 確認http服務是否存在，如果不存在，把他建立起來
if ! systemctl is-active --quiet apache2; then
  apt-get update
  apt-get install -y apache2
  systemctl start apache2
  systemctl enable apache2
fi

# 6. 確認https服務是否存在，如果不存在，把他建立起來
if ! systemctl is-active --quiet apache2; then
  apt-get update
  apt-get install -y apache2
  apt-get install -y openssl
  a2enmod ssl
  systemctl restart apache2
fi

# 7. 確認sudo是否存在，如果不存在，把他建立起來
if ! dpkg -l | grep -q sudo; then
  apt-get update
  apt-get install -y sudo
fi

# 外部滲透設定
echo ""
echo "外部滲透設定"

# 1. 新增一個普通的使用者Allin，他的密碼是admin，並用明文的方式儲存
useradd -m Allin
echo "Allin:admin" | chpasswd

# 2. 用K999的權限去執行一個叫website.sh的腳本
sudo -u K999 bash ./website.sh

# 3. 在Allin的主目錄建立名為user.txt的檔案，裡面有一串亂碼
echo "r4nd0mstr1ng" > /home/Allin/user.txt
chown Allin:Allin /home/Allin/user.txt

# 內部提權設定
echo ""
echo "內部提權設定"

# 1. 在root的主目錄下，建立一個叫root.txt的文件，並將root's flag放進此文件
echo "root's flag" > /root/root.txt

# 2. 授權所有使用者可以用root權限執行cp命令
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# 完成設定
echo ""
echo "完成設定"

