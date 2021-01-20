# TJAPlayer3 on Linux
![Screenshot on Linux](https://i.imgur.com/wDMtzLC.png)

# 流程講解
這些資料一定程度參考於
https://github.com/darkcl/TJAPlayerMac

以下的最基本環境請先準備好:
 - wine 4.16
 - winetricks
 - ttf-vlgothic
 - TJAPlayer3 1.3.2

這邊先用 winetricks 安裝了 `dotnet45`
```sh
WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks dotnet35
```

這邊另外有安裝 VL Gothic 的字體，為了取代掉 MS UI Gothic。
打開 `regedit` 編輯登錄檔 ` \HKEY_CURRENT_USER\ Software\ Wine\ Fonts\ Replacements`
在底下新增一個字串值
 - 名稱 `MS UI Gothic`
 - 內容 `VL Gothic`

之後，再將 `ＤＦＰ勘亭流.ttf` 等字體先擺到 `.font` 資料夾中
*不過目前這字體並沒有正常起作用*

因為 設定 介面無法正常啟動，所以必須藉由自行手動編輯 `Config.ini` 才行。
下面是我參考並找出來的按鍵設定：
```ini
LeftRed=K015
RightRed=K019
LeftBlue=K014
RightBlue=K018

```
 上述準備完成後，可以直接使用指令的方式開啟 TJAPlayer
 ```sh
 WINEARCH=win32 WINEPREFIX=~/.wine32 wine TJAPlayer3.exe
 ```

# 目前已知問題:
  - [ ] Config 介面無法打開
  - [ ] Theme 的字體無法正常運作
