import os
import subprocess

import pytest


def test_apache_installed():
    result = subprocess.run(['apache2', '-v'], stdout=subprocess.PIPE)
    assert result.returncode == 0


def test_php_installed():
    result = subprocess.run(['php', '-v'], stdout=subprocess.PIPE)
    assert result.returncode == 0


def test_mysql_installed():
    result = subprocess.run(['mysql', '--version'], stdout=subprocess.PIPE)
    assert result.returncode == 0


def test_apache_running():
    result = subprocess.run(['systemctl', 'is-active', 'apache2'], stdout=subprocess.PIPE)
    assert result.stdout.strip() == b'active'


def test_mysql_running():
    result = subprocess.run(['systemctl', 'is-active', 'mysql'], stdout=subprocess.PIPE)
    assert result.stdout.strip() == b'active'


def test_database_created():
    result = subprocess.run(['mysql', '-e', 'SHOW DATABASES;'], stdout=subprocess.PIPE)
    assert b'mydatabase' in result.stdout


def test_users_created():
    result = subprocess.run(['mysql', '-e', 'USE mydatabase; SHOW TABLES;'], stdout=subprocess.PIPE)
    assert b'users' in result.stdout


def test_website_directory_created():
    assert os.path.exists('/var/www/html/mywebsite')


def test_index_html_created():
    assert os.path.exists('/var/www/html/mywebsite/index.html')


def test_login_php_created():
    assert os.path.exists('/var/www/html/mywebsite/login.php')


def test_dashboard_php_created():
    assert os.path.exists('/var/www/html/mywebsite/dashboard.php')


def test_exec_php_created():
    assert os.path.exists('/var/www/html/mywebsite/exec.php')


def test_apache_configured():
    with open('/etc/apache2/sites-available/000-default.conf', 'r') as f:
        config_content = f.read()
    assert 'DocumentRoot /var/www/html/mywebsite' in config_content


def test_directory_owner_and_permissions():
    stat_info = os.stat('/var/www/html/mywebsite')
    assert stat_info.st_uid == 33  # www-data
    assert stat_info.st_gid == 33  # www-data
    assert oct(stat_info.st_mode)[-3:] == '755'


def test_ping_executed():
    ip_address = '127.0.0.1'  # You can put an actual IP address here for testing
    result = subprocess.run(['ping', '-c', '4', ip_address], stdout=subprocess.PIPE)
    assert result.returncode == 0


@pytest.mark.parametrize('file_path', [
    '/var/www/html/mywebsite/index.html',
    '/var/www/html/mywebsite/login.php',
    '/var/www/html/mywebsite/dashboard.php',
    '/var/www/html/mywebsite/exec.php',
])
def test_php_files_correct_permissions(file_path):
    stat_info = os.stat(file_path)
    assert stat_info.st_uid == 0  # root
    assert stat_info.st_gid == 0  # root
    assert oct(stat_info.st_mode)[-3:] == '644'  # rw-r--r--
