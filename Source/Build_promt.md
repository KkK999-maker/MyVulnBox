# Script
{TOC}
我想要做一台簡單的靶機用於資訊安全教育，靶機腳本會在VMware中執行，可以請你寫一個腳本建立靶機，詳細的幫我注記此段程式的作用並在檔案的開頭用注解的方式告訴我應該如何設定及執行此腳本，須達到的規格如下:
## 基本設定
1. 系統是Ubuntu
2. 有一個管理者叫K999，擁有最高使用者的權限
3. K999這個管理者的密碼是congragulation用base64加密的方式儲存
4. 確認ssh服務是否存在，如果不存在，把他建立起來

## 漏洞設定
1.  漏洞是 CVE-2017-5638
2. 新增一個普通的使用者叫Allin，他的密碼是dsvq43#^$sdcsz，並用明文的方式儲存
3. 在Allin的主目錄下面新增一個叫user.txt的檔案，裡面放一串隨機的亂碼

## 提權設定
1. 在root的主目錄下，建立一個叫root.txt的文件，並將root's flag放進此文件
2. 在Allin的主目錄下，有一個檔案具有SUID漏洞