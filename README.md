# CapsLock で日本語入力を切り替える

Windows で CapsLock キーを「全角/半角」キーとして使う AutoHotkey v2 のスクリプトです。

## 自動セットアップ

1. [AutoHotkey v2](https://www.autohotkey.com/) をインストールします。
2. このフォルダで PowerShell を開き、次のコマンドを実行します。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

このコマンドは「ドキュメント\setting\capslock」フォルダを作成して `ime-switch.ahk` を配置し、Windows のスタートアップフォルダにショートカットを作ります。繰り返し実行すると、スクリプトとショートカットを更新できます。配置先を変える場合は `-InstallDir 'C:\任意の場所\capslock'` を追加します。

今すぐ使う場合は、配置された `ime-switch.ahk` をダブルクリックしてください。CapsLock キーで日本語入力のオンとオフを切り替えられることを確認します。

このスクリプトは `#NoTrayIcon` を指定しているため、通知領域にアイコンは表示されません。同じファイルを再度起動すると、実行中のスクリプトが置き換わります。

## 動作確認

AutoHotkey v2 がインストールされていれば、次のコマンドで構文を確認できます。

```powershell
& 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe' /Validate .\ime-switch.ahk
```

実際のキー操作と日本語入力の切り替えは、Windows 上で確認してください。
