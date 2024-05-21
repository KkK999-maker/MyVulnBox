# 1. 更新和安裝 Apache
echo "更新軟體包並安裝 Apache 伺服器"
apt-get update
apt-get install apache2 -y

echo

# 2. 安裝 PHP 和 MySQL
echo "安裝 PHP 和 MySQL"
apt-get install php libapache2-mod-php php-mysql -y
apt-get install mysql-server -y

echo

# 3. 啟動 Apache 和 MySQL 服務
echo "啟動 Apache 和 MySQL 服務"
systemctl start apache2
systemctl start mysql

echo

# 4. 建立 MySQL 資料庫和使用者
echo "建立 MySQL 資料庫和使用者"
mysql -e "CREATE DATABASE mydatabase;"
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';"
mysql -e "CREATE USER 'K999'@'localhost' IDENTIFIED BY 'congraduation';"
mysql -e "GRANT ALL PRIVILEGES ON mydatabase.* TO 'admin'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON mydatabase.* TO 'K999'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

echo

# 5. 建立資料表 users
echo "建立資料表 users"
mysql -e "USE mydatabase; CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), password VARCHAR(50));"
mysql -e "USE mydatabase; INSERT INTO users (username, password) VALUES ('admin', 'admin');"

echo

# 6. 建立網站目錄結構
echo "建立網站目錄結構"
mkdir -p /var/www/html/mywebsite
cd /var/www/html/mywebsite

echo

# 7. 建立 index.html 檔案
echo "建立 index.html 檔案"
cat <<EOF > /var/www/html/mywebsite/index.html
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>登入頁面</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>登入</h1>
        <form action="login.php" method="post">
            <input type="text" name="username" placeholder="使用者名稱" required><br><br>
            <input type="password" name="password" placeholder="密碼" required><br><br>
            <button type="submit">登入</button>
        </form>
    </div>
</body>
</html>
EOF

echo

# 8. 建立 login.php 檔案
echo "建立 login.php 檔案"
cat <<EOF > /var/www/html/mywebsite/login.php
<?php
\$servername = "localhost";
\$username = "admin";
\$password = "admin";
\$dbname = "mydatabase";

\$conn = new mysqli(\$servername, \$username, \$password, \$dbname);

if (\$conn->connect_error) {
    die("連接失敗: " . \$conn->connect_error);
}

\$user = \$_POST['username'];
\$pass = \$_POST['password'];

\$sql = "SELECT * FROM users WHERE username='\$user' AND password='\$pass'";
\$result = \$conn->query(\$sql);

if (\$result->num_rows > 0) {
    session_start();
    \$_SESSION['username'] = \$user;
    header("Location: dashboard.php");
    exit;
} else {
    echo "Login Failed";
}

\$conn->close();
?>
EOF

echo

# 9. 建立 dashboard.php 檔案
echo "建立 dashboard.php 檔案"
cat <<EOF > /var/www/html/mywebsite/dashboard.php
<?php
session_start();

if (!isset(\$_SESSION['username'])) {
    header("Location: index.html");
    exit;
}
?>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>控制台</title>
</head>
<body>
    <h1>輸入 IP</h1>
    <form action="exec.php" method="post">
        <input type="text" name="ip" placeholder="輸入 IP" required><br><br>
        <button type="submit">執行</button>
    </form>
</body>
</html>
EOF

echo

# 10. 建立 exec.php 檔案
echo "建立 exec.php 檔案"
cat <<EOF > /var/www/html/mywebsite/exec.php
<?php
session_start();

if (!isset(\$_SESSION['username'])) {
    header("Location: index.html");
    exit;
}

\$ip = \$_POST['ip'];
\$output = shell_exec("ping -c 4 " . escapeshellarg(\$ip));
echo "<pre>\$output</pre>";
?>
EOF

echo

# 11. 設定 Apache 網站配置檔案
echo "設定 Apache 網站配置檔案"
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/mywebsite
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

echo

# 12. 更改目錄擁有者和權限
echo "更改目錄擁有者和權限"
chown -R www-data:www-data /var/www/html/mywebsite
chmod -R 755 /var/www/html/mywebsite

echo

# 13. 重新啟動 Apache
echo "重新啟動 Apache 服務"
systemctl restart apache2

echo "網站已成功建立並運行在 http://localhost"

