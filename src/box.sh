#!/bin/bash

# 使用說明  
# 1. 將此腳本複製到您的目標主機上，例如/home/user目錄
# 2. 在終端中執行以下命令：
#    cd /home/user
#    chmod +x box.sh
#    ./box.sh

# 基本設定
echo ""
echo "基本設定"
useradd -m K999
usermod -aG sudo K999
echo 'congragulation' | base64 -d | chpasswd
apt-get update
apt-get install -y openssh-server apache2

# 確認ssh服務是否存在，如果不存在，則建立
echo ""
echo "確認ssh服務是否存在"
if [ ! -f /etc/ssh/sshd_config ]; then
    echo "建立ssh服務"
    apt-get install -y openssh-server
else
    echo "ssh服務已存在"
fi

# 確認http服務是否存在，如果不存在，則建立
echo ""
echo "確認http服務是否存在"
if [ ! -f /etc/apache2/apache2.conf ]; then
    echo "建立http服務"
    apt-get install -y apache2
else
    echo "http服務已存在"
fi

# 確認https服務是否存在，如果不存在，則建立
echo ""
echo "確認https服務是否存在"
if [ ! -f /etc/apache2/sites-available/default-ssl.conf ]; then
    echo "建立https服務"
    apt-get install -y openssl
    a2enmod ssl
    a2ensite default-ssl
    service apache2 restart
else
    echo "https服務已存在"
fi

# 確認sudo函數是否存在，如果不存在，則建立
echo ""
echo "確認sudo函數是否存在"
if ! grep -q "#includedir /etc/sudoers.d" /etc/sudoers; then
    echo "建立sudo函數"
    echo "#includedir /etc/sudoers.d" >> /etc/sudoers
else
    echo "sudo函數已存在"
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
