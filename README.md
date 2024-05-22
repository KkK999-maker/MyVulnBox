# MyVulnBox
![Static Badge](https://img.shields.io/badge/114-K999-black)

* Static Info:
  ![Bash使用](https://img.shields.io/badge/Bash_Script-2A2Ba2)
  ![Docker使用](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
  ![Python使用](https://img.shields.io/badge/Python-14354C.svg?logo=python&logoColor=white)
* Development:
  ![版權宣告](https://img.shields.io/github/license/TwMoonBear-Arsenal/Box_PaperPass)

====

# 1. 功能簡介

* 提供一組Docker相關腳本，運行腳本後可建立簡單紅隊靶機，作為示範教學使用。

# 2. 項目介紹

## 2.1. Release Asset

- **src**:架設靶機所會用到的檔案
- **doc**:src的說明檔案
- **dockerfile檔案**：容器創建文件
- **LICENSE檔案**：版權宣告
- **README.md檔案**：說明文件

## 2.2. 外部依賴

- **Ubuntu Image**：執行dockerfile組建所需，可為遠端dockerhub或本地提供

# 3. 運用

## 3.1 Repo構管

* 此Repo為privite，直接修改main branch。
* 主要更新於develop branch執行後，pull request回main branch。

## 3.2. 模組設計

* 於README.md及/doc/design.vpp說明。
* 主要規格為：
  * 可組建靶機容器映像檔
  * 靶機具備外部滲透弱點：cmd injection
  * 靶機具備內部提權弱點：linux cp提權

## 3.3. 使用方式
+ 將最新release下載並解壓縮後，依序於本機執行以下命令，docker將自動建置靶機於端口80
```
docker build -t test .
docker run -d -p 80:80 --name test test
```



