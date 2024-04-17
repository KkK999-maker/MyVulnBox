善用工具-Github
====

# 壹、REPO內容說明

## 一、運用目標

* 提供一個腳本，執行後可建立簡單靶機環境。

## 二、運用架構

* 本Repo提供一個bash script。

## 三、運作流程

* 將bash script複製到Ubuntu的VM或DockerContainer中。
* 以Root權限執行後，可：
  * 自動設定弱密碼之ssh服務。
  * 自動設定一般使用者CP提權弱點
* 使用者可以此設定後之VM或DockerContainer，作為練習破密及提權靶機

# 貳、REPO內容結構

* Github Repo<br/>
  📁.github資料夾<br/>
  └ 📁actions<br/>
  　└ ◻️UnitTest.yml<br/>
  　└ ◻️ModuleTest.yml<br/>
  　└ ◻️TestThenPublishZip.yml<br/>
  　└ ◻️TestThenPublishContainer.yml<br/>
  📁.vs資料夾<br/>
  📁doc資料夾<br/>
  ◻️.gitignore檔案<br/>
  ◻️docker-compose.yml檔案<br/>
  ◻️Dockerfile檔案<br/>
  ◻️Mod_Gundam1.sln檔案<br/>
  ◻️README.md<br/>
