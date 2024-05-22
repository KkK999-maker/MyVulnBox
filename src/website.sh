#!/bin/bash

# 使用說明
# 1. 將此腳本複製到您的目標 Docker 映像中的 /usr/local/bin/ 目錄中
# 2. 在 Dockerfile 中複製相關文件，然後運行此腳本

# 基本設定
echo ""
echo "基本設定"
useradd -m K999
usermod -aG sudo K999
echo 'congragulation' | base64 -d | chpasswd

# 不再需要 apt-get update 和 apt-get install，因為我們已經在 Dockerfile 中處理了

# 確認 ssh 服務是否存在，如果不存在，則建立
echo ""
echo "確認 ssh 服務是否存在"
if [ ! -f /etc/ssh/sshd_config ]; then
    echo "建立 ssh 服務"
    apt-get install -y openssh-server
else
    echo "ssh 服務已存在"
fi

# 確認 http 服務是否存在，如果不存在，則建立
echo ""
echo "確認 http 服務是否存在"
if [ ! -f /etc/apache2/apache2.conf ]; then
    echo "建立 http 服務"
    apt-get install -y apache2
else
    echo "http 服務已存在"
fi

# 確認 https 服務是否存在，如果不存在，則建立
echo ""
echo "確認 https 服務是否存在"
if [ ! -f /etc/apache2/sites-available/default-ssl.conf ]; then
    echo "建立 https 服務"
    apt-get install -y openssl
    a2enmod ssl
    a2ensite default-ssl
    service apache2 restart
else
    echo "https 服務已存在"
fi

# 確認 sudo 函數是否存在，如果不存在，則建立
echo ""
echo "確認 sudo 函數是否存在"
if ! grep -q "#includedir /etc/sudoers.d" /etc/sudoers; then
    echo "建立 sudo 函數"
    echo "#includedir /etc/sudoers.d" >> /etc/sudoers
else
    echo "sudo 函數已存在"
fi

# 漏洞設定
echo ""
echo "漏洞設定"
useradd Allin
echo 'admin' | chpasswd
cp website.sh /home/K999/website.sh
chown K999:K999 /home/K999/website.sh
chmod +x /home/K999/website.sh
mkdir /home/Allin
echo "some random text" > /home/Allin/user.txt

# 網站設定
echo ""
echo "網站設定"
bash website.sh

# 提權設定
echo ""
echo "提權設定"
echo "root's flag" > /root/root.txt
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

echo ""
echo "完成設定"
