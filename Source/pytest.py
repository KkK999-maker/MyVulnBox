import subprocess
import pytest

@pytest.fixture(scope="module")
def setup_target_machine():
    # 基本設定
    subprocess.run(["./setup_target_machine.sh"], check=True)

def test_check_ubuntu():
    # 檢查系統是否為 Ubuntu
    result = subprocess.run(["lsb_release", "-si"], capture_output=True, text=True)
    assert result.stdout.strip() == "Ubuntu"

def test_user_K999_created(setup_target_machine):
    # 檢查是否建立了管理者帳號 K999
    result = subprocess.run(["id", "-u", "K999"], capture_output=True, text=True)
    assert result.returncode == 0

def test_ssh_service_installed(setup_target_machine):
    # 檢查 SSH 服務是否安裝
    result = subprocess.run(["dpkg", "-l", "openssh-server"], capture_output=True, text=True)
    assert "openssh-server" in result.stdout

# 添加更多測試...

if __name__ == "__main__":
    pytest.main()
