# CapsLock で日本語入力を切り替える

Windows で CapsLock キーを「全角/半角」キーとして使う AutoHotkey v2 のスクリプトです。

## 使い方

1. [AutoHotkey v2](https://www.autohotkey.com/) をインストールします。
2. [`ime-switch.ahk`](ime-switch.ahk) をダブルクリックします。
3. CapsLock キーで日本語入力のオンとオフを切り替えられることを確認します。

このスクリプトは `#NoTrayIcon` を指定しているため、通知領域にアイコンは表示されません。同じファイルを再度起動すると、実行中のスクリプトが置き換わります。

## Windows 起動時に実行する

1. `Win + R` を押し、`shell:startup` と入力して Enter を押します。
2. `ime-switch.ahk` のショートカットを作成します。
3. 作成したショートカットを、開いたスタートアップフォルダに置きます。

スクリプトを移動した場合は、ショートカットのリンク先も更新してください。

## 動作確認

AutoHotkey v2 がインストールされていれば、次のコマンドで構文を確認できます。

```powershell
& 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe' /Validate .\ime-switch.ahk
```

実際のキー操作と日本語入力の切り替えは、Windows 上で確認してください。
