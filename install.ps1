param(
    [string]$InstallDir = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'setting\capslock'),
    [string]$StartupFolder = [Environment]::GetFolderPath('Startup'),
    [string]$AutoHotkeyPath
)

$ErrorActionPreference = 'Stop'

$source = Join-Path $PSScriptRoot 'ime-switch.ahk'
if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "ime-switch.ahk was not found: $source"
}

if (-not $AutoHotkeyPath) {
    $candidates = @(
        (Join-Path $env:ProgramFiles 'AutoHotkey\v2\AutoHotkey64.exe'),
        (Join-Path $env:ProgramFiles 'AutoHotkey\v2\AutoHotkey.exe')
    )
    $AutoHotkeyPath = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
}
if (-not $AutoHotkeyPath -or -not (Test-Path -LiteralPath $AutoHotkeyPath -PathType Leaf)) {
    throw 'AutoHotkey v2 was not found. Install it first or specify -AutoHotkeyPath.'
}

$InstallDir = [IO.Path]::GetFullPath($InstallDir)
$StartupFolder = [IO.Path]::GetFullPath($StartupFolder)
$target = Join-Path $InstallDir 'ime-switch.ahk'
$shortcutPath = Join-Path $StartupFolder 'CapsLock IME Switch.lnk'

New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
New-Item -ItemType Directory -Path $StartupFolder -Force | Out-Null
if (-not [string]::Equals([IO.Path]::GetFullPath($source), $target, [StringComparison]::OrdinalIgnoreCase)) {
    Copy-Item -LiteralPath $source -Destination $target -Force
}

$validation = Start-Process -FilePath $AutoHotkeyPath -ArgumentList @('/Validate', ('"' + $target + '"')) -Wait -PassThru
if ($validation.ExitCode -ne 0) {
    throw "AutoHotkey validation failed (exit code $($validation.ExitCode)): $target"
}

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = [IO.Path]::GetFullPath($AutoHotkeyPath)
$shortcut.Arguments = '"' + $target + '"'
$shortcut.WorkingDirectory = $InstallDir
$shortcut.Description = 'Toggle Japanese input with CapsLock'
$shortcut.Save()

Write-Output "Script: $target"
Write-Output "Startup shortcut: $shortcutPath"
