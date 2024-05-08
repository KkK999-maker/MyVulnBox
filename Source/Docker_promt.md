# Docker
[TOC]

# 使用官方的 Ubuntu 映像作為基礎
FROM ubuntu:latest

# 複製腳本到映像中
COPY setup_target_machine.sh /setup_target_machine.sh

# 設置可執行權限
RUN chmod +x /setup_target_machine.sh

# 執行腳本
RUN /setup_target_machine.sh
將你的腳本 setup_target_machine.sh 與 Dockerfile 放在同一個目錄下。
在該目錄下建立 Docker 映像。在終端中，切換到該目錄，然後運行以下命令：
docker build -t my_target_machine .
這將根據 Dockerfile 中的指示建立一個名為 my_target_machine 的映像。

現在你可以運行這個映像並在容器內運行你的目標機器環境。運行以下命令：
docker run -it my_target_machine
