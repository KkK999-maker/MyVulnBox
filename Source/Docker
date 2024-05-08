# 使用官方的 Ubuntu 映像作為基礎
FROM ubuntu:latest

# 複製腳本到映像中
COPY setup_target_machine.sh /setup_target_machine.sh

# 設置可執行權限
RUN chmod +x /setup_target_machine.sh

# 執行腳本
RUN /setup_target_machine.sh
