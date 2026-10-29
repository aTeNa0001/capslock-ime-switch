# CapsLock で日本語入力を切り替える

Windows で CapsLock キーを「全角/半角」キーとして使う AutoHotkey v2 のスクリプトです。

## 1 行でセットアップ

PowerShell に次のコマンドを貼り付けて実行します。

```powershell
irm https://raw.githubusercontent.com/aTeNa0001/capslock-ime-switch/main/install.ps1 | iex
```

このコマンドはこのリポジトリの [`install.ps1`](install.ps1) を取得して実行します。AutoHotkey v2 がなければ `winget` でユーザー単位にインストールし、「ドキュメント\setting\capslock」フォルダとスタートアップのショートカットを作成します。次回の Windows 起動時から自動実行されます。`winget` がない環境では、先に Windows App Installer を導入してください。

## このリポジトリからセットアップする場合

このフォルダで PowerShell を開き、次のコマンドを実行します。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

このコマンドも同じセットアップを行います。繰り返し実行すると、スクリプトとショートカットを更新できます。配置先を変える場合は `-InstallDir 'C:\任意の場所\capslock'` を追加します。

今すぐ使う場合は、配置された `ime-switch.ahk` をダブルクリックしてください。CapsLock キーで日本語入力のオンとオフを切り替えられることを確認します。

このスクリプトは `#NoTrayIcon` を指定しているため、通知領域にアイコンは表示されません。同じファイルを再度起動すると、実行中のスクリプトが置き換わります。

## 動作確認

AutoHotkey v2 がインストールされていれば、次のコマンドで構文を確認できます。

```powershell
& 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe' /Validate .\ime-switch.ahk
```

実際のキー操作と日本語入力の切り替えは、Windows 上で確認してください。
