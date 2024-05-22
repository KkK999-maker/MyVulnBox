# boxsetup
```
我想要做一台簡單的靶機用於資訊安全教育，靶機腳本會在VMware中執行，可以請你寫一個名為box.sh腳本建立靶機，詳細的幫我注記此段程式的作用並在檔案的開頭用注解的方式告訴我應該如何設定及執行此腳本，須達到的規格如下:

# 基本設定
1. 系統是Ubuntu
2. 有一個使用者叫K999，把她加入root group
3. K999這個管理者的密碼是congragulation用base64加密的方式儲存
4. 確認ssh服務是否存在，如果不存在，把他建立起來
5. 確認http服務是否存在，如果不存在，把他建立起來
6. 確認https服務是否存在，如果不存在，把他建立起來
7. 確認sudo函數是否存在，如果不存在，把他建立起來

# 漏洞設定
1. 新增一個普通的使用者叫Allin，他的密碼是admin，並用明文的方式儲存
2. 用K999的權限去執行一個叫website.sh的腳本，檔案會跟這個腳本放在同一個資料夾
3. 在Allin的主目錄建立名為user.txt的檔案，裡面有一串亂碼

# 提權設定
1. 在root的主目錄下，建立一個叫root.txt的文件，並將root's flag放進此文件
2. authorize all users the privilege that can execute cp command with root privileged.

在完成之後告訴我應該如何執行這個腳本，以下為參考格式
#!/bin/bash

# 使用說明  
# 1. Copy this script to...
# 2. Open terminal...
# 3. Navigate to ...
# 4. chmod +x ...
# 5. Run the command...

# 靶機管理設定
echo "" 
echo "靶機管理設定"
useradd -m...
usermod -aG ...
echo... | chpasswd
service ssh ...

# 外部滲透設定
echo ""
echo "外部滲透設定"
useradd ...
service ssh ...


# 內部提權設定
echo ""
echo "內部提權設定"
if ...sudo...  

# 完成設定
echo ""
echo "完成設定"
```
