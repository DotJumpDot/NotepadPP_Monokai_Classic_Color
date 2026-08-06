# install_maki_json.ps1
# Adds `.maki` to Notepad++'s JSON lexer so the DJD Classic Monokai
# theme's Monokai-palette JSON highlighting applies to .maki files
# (Maki Cutting plugin JSON).
#
# Run this from PowerShell — right-click the .ps1 file and choose
# "Run with PowerShell", or run from an elevated prompt:
#
#     powershell -ExecutionPolicy Bypass -File .\install_maki_json.ps1
#
# A backup of langs.xml is saved next to it as `langs.xml.bak`.
# Restart Notepad++ after this script runs.

$ErrorActionPreference = 'Stop'

$langsPath = Join-Path $env:APPDATA 'Notepad++\langs.xml'
$bakPath   = "$langsPath.bak"

if (-not (Test-Path $langsPath)) {
    Write-Error "Could not find: $langsPath`nOpen Notepad++ at least once so it creates the file, then re-run."
}

# Stop Notepad++ if running so it doesn't overwrite our patch on close.
$notepadProcs = Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue
$wasRunning = $false
if ($notepadProcs) {
    $wasRunning = $true
    Write-Host "Notepad++ is running. Saving user's open files..." -ForegroundColor Yellow
    # Close gracefully; N++ saves the workspace automatically on a normal shutdown.
    $notepadProcs | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    # Wait up to 10 seconds for it to exit.
    for ($i = 0; $i -lt 20; $i++) {
        Start-Sleep -Milliseconds 500
        if (-not (Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue)) { break }
    }
    if (Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue) {
        Write-Error 'Notepad++ did not exit in time. Please close it manually and re-run.'
    }
}

# Back up the existing file (only once per install).
if (-not (Test-Path $bakPath)) {
    Copy-Item -Path $langsPath -Destination $bakPath
    Write-Host "Backup created: $bakPath" -ForegroundColor DarkGray
}

$content = Get-Content -Raw -LiteralPath $langsPath -Encoding UTF8

# Idempotent: only patch if "maki" isn't already in the JSON entry's ext.
if ($content -match '<Language\s+name="json"\s+ext="(?<ext>[^"]*)"') {
    $currentExt = $Matches['ext']
    $extensions = @($currentExt -split '\s+' | Where-Object { $_ })
    if ($extensions -contains 'maki') {
        Write-Host "`.maki` is already mapped to the JSON lexer. Nothing to do." -ForegroundColor Green
        return
    }
    $newExt = ($extensions + 'maki') -join ' '
    $oldLine = '<Language name="json" ext="' + $currentExt + '"'
    $newLine = '<Language name="json" ext="' + $newExt + '"'
    $patched = $content -replace [regex]::Escape($oldLine), $newLine
    if ($patched -eq $content) {
        Write-Error "Could not find the JSON entry to patch. Update manually: $langsPath"
    }
    Set-Content -LiteralPath $langsPath -Value $patched -Encoding UTF8 -NoNewline
    Write-Host "Patched: $oldLine  ->  $newLine" -ForegroundColor Green
} else {
    Write-Error "Unexpected: no <Language name=`"json`" ...> line found in $langsPath."
}

Write-Host "`nDone. Reopen Notepad++ and open any .maki file." -ForegroundColor Cyan
if ($wasRunning) {
    Write-Host "(Notepad++ was closed by this script; start it again yourself.)" -ForegroundColor DarkGray
}
