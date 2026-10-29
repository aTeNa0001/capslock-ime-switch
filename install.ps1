param(
    [string]$InstallDir = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'setting\capslock'),
    [string]$StartupFolder = [Environment]::GetFolderPath('Startup'),
    [string]$AutoHotkeyPath
)

$ErrorActionPreference = 'Stop'

if (-not $AutoHotkeyPath) {
    $roots = @($env:ProgramFiles, (Join-Path $env:LOCALAPPDATA 'Programs'))
    $candidates = foreach ($root in $roots) {
        foreach ($name in @('AutoHotkey64.exe', 'AutoHotkey32.exe', 'AutoHotkey.exe')) {
            Join-Path $root "AutoHotkey\v2\$name"
        }
    }
    $AutoHotkeyPath = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1

    if (-not $AutoHotkeyPath) {
        $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $winget) {
            throw 'winget was not found. Install Windows App Installer or install AutoHotkey v2 manually.'
        }
        & $winget.Source install --id AutoHotkey.AutoHotkey --exact --source winget --scope user --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -ne 0) {
            throw "winget failed to install AutoHotkey (exit code $LASTEXITCODE)."
        }
        $AutoHotkeyPath = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
    }
}
if (-not $AutoHotkeyPath -or -not (Test-Path -LiteralPath $AutoHotkeyPath -PathType Leaf)) {
    throw 'AutoHotkey v2 was not found after installation. Specify -AutoHotkeyPath if it is installed elsewhere.'
}

$InstallDir = [IO.Path]::GetFullPath($InstallDir)
$StartupFolder = [IO.Path]::GetFullPath($StartupFolder)
$target = Join-Path $InstallDir 'ime-switch.ahk'
$shortcutPath = Join-Path $StartupFolder 'CapsLock IME Switch.lnk'

New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
New-Item -ItemType Directory -Path $StartupFolder -Force | Out-Null
$source = if ($PSScriptRoot) { Join-Path $PSScriptRoot 'ime-switch.ahk' } else { $null }
if ($source -and (Test-Path -LiteralPath $source -PathType Leaf)) {
    if (-not [string]::Equals([IO.Path]::GetFullPath($source), $target, [StringComparison]::OrdinalIgnoreCase)) {
        Copy-Item -LiteralPath $source -Destination $target -Force
    }
} else {
    Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/aTeNa0001/capslock-ime-switch/main/ime-switch.ahk' -OutFile $target
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
