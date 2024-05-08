我想要做一台簡單的靶機用於資訊安全教育，靶機腳本會在VMware中執行，可以請你寫一個.sh腳本建立靶機，詳細的幫我注記此段程式的作用並在檔案的開頭用注解的方式告訴我應該如何設定及執行此腳本，須達到的規格如下:

基本設定
1. 系統是Ubuntu
2. 有一個管理者叫K999，擁有最高使用者的權限
3. K999這個管理者的密碼是congragulation用base64加密的方式儲存
4. 確認ssh服務是否存在，如果不存在，把他建立起來
5. 確認http服務是否存在，如果不存在，把他建立起來
6. 確認https服務是否存在，如果不存在，把他建立起來
7. 確認sudo函數是否存在，如果不存在，把他建立起來

漏洞設定
1.  ping_website.py，使用 chmod +x ping_website.py 將其設為可執行。以下是ping_website.py的程式
#!/usr/bin/python3

from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return '''
    <form action="/ping" method="get">
        Enter IP to ping: <input type="text" name="ip">
        <input type="submit" value="Ping">
    </form>
    '''

@app.route('/ping')
def ping():
    ip = request.args.get('ip')
    if ip:
        result = subprocess.run(['ping', '-c', '4', ip], capture_output=True, text=True)
        return f"<pre>{result.stdout}</pre>"
    else:
        return "Please provide an IP to ping."

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

2. 新增一個普通的使用者叫Allin，他的密碼是dsvq43#^$sdcsz，並用明文的方式儲存
3. 在Allin的主目錄下面新增一個叫user.txt的檔案，裡面放一串隨機的亂碼


提權設定
1. 在root的主目錄下，建立一個叫root.txt的文件，並將root's flag放進此文件
2. 在Allin的主目錄下，有一個檔案具有SUID漏洞，以下是建立的程式碼
#!/bin/bash

# 腳本名稱: create_suid_file.sh
# 使用前需將腳本設為可執行: chmod +x create_suid_file.sh
# 執行方式: ./create_suid_file.sh

# 建立具有 SUID 漏洞的檔案
echo '#include <stdio.h>' > suid_file.c
echo 'int main() { setuid(0); system("/bin/bash"); }' >> suid_file.c
gcc -o suid_file suid_file.c
sudo chown root:root suid_file
sudo chmod +s suid_file
rm suid_file.c

echo "SUID file created successfully."



在完成之後告訴我應該如何執行這個腳本



