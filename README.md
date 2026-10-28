# CapsLock で日本語入力を切り替える

Windows で CapsLock キーを「全角/半角」キーとして使う AutoHotkey v2 のスクリプトです。

## フォルダがまだない場合

[AutoHotkey v2](https://www.autohotkey.com/) をインストールしてから、PowerShell に次の **1 行**を貼り付けて実行します。作成先は「ドキュメント\setting\capslock」です。

```powershell
$d=Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'setting\capslock'; $a=Join-Path $env:ProgramFiles 'AutoHotkey\v2\AutoHotkey64.exe'; if (!(Test-Path -LiteralPath $a)) { throw 'Install AutoHotkey v2 first' }; New-Item -ItemType Directory -Path $d -Force | Out-Null; $f=Join-Path $d 'ime-switch.ahk'; @('#Requires AutoHotkey v2.0','#SingleInstance Force','#NoTrayIcon','','CapsLock::Send "{vkF3sc029}"') | Set-Content -LiteralPath $f -Encoding utf8; $s=(New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path ([Environment]::GetFolderPath('Startup')) 'CapsLock IME Switch.lnk')); $s.TargetPath=$a; $s.Arguments='"'+$f+'"'; $s.WorkingDirectory=$d; $s.Save()
```

フォルダと `ime-switch.ahk` が作られ、スタートアップにショートカットが登録されます。次回の Windows 起動時から自動実行されます。

## このリポジトリからセットアップする場合

このフォルダで PowerShell を開き、次のコマンドを実行します。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

このコマンドも「ドキュメント\setting\capslock」フォルダを作成して `ime-switch.ahk` を配置し、Windows のスタートアップフォルダにショートカットを作ります。繰り返し実行すると、スクリプトとショートカットを更新できます。配置先を変える場合は `-InstallDir 'C:\任意の場所\capslock'` を追加します。

今すぐ使う場合は、配置された `ime-switch.ahk` をダブルクリックしてください。CapsLock キーで日本語入力のオンとオフを切り替えられることを確認します。

このスクリプトは `#NoTrayIcon` を指定しているため、通知領域にアイコンは表示されません。同じファイルを再度起動すると、実行中のスクリプトが置き換わります。

## 動作確認

AutoHotkey v2 がインストールされていれば、次のコマンドで構文を確認できます。

```powershell
& 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe' /Validate .\ime-switch.ahk
```

実際のキー操作と日本語入力の切り替えは、Windows 上で確認してください。
