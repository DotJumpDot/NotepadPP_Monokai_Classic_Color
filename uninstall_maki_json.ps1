# uninstall_maki_json.ps1
# Reverses `install_maki_json.ps1`: removes `.maki` from the JSON lexer's
# `ext` attribute in `%APPDATA%\Notepad++\langs.xml` so .maki files stop
# being highlighted as JSON.
#
# Run from PowerShell:
#
#     powershell -ExecutionPolicy Bypass -File .\uninstall_maki_json.ps1

$ErrorActionPreference = 'Stop'

$langsPath = Join-Path $env:APPDATA 'Notepad++\langs.xml'

if (-not (Test-Path $langsPath)) {
    Write-Error "Could not find: $langsPath"
}

# Stop Notepad++ if running so the file isn't held.
$notepadProcs = Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue
if ($notepadProcs) {
    Write-Host "Notepad++ is running. Closing it..." -ForegroundColor Yellow
    $notepadProcs | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    for ($i = 0; $i -lt 20; $i++) {
        Start-Sleep -Milliseconds 500
        if (-not (Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue)) { break }
    }
    if (Get-Process -Name 'notepad++' -ErrorAction SilentlyContinue) {
        Write-Error 'Notepad++ did not exit in time. Please close it manually and re-run.'
    }
}

$content = Get-Content -Raw -LiteralPath $langsPath -Encoding UTF8

if ($content -match '<Language\s+name="json"\s+ext="(?<ext>[^"]*)"') {
    $currentExt = $Matches['ext']
    $extensions = @($currentExt -split '\s+' | Where-Object { $_ })
    if ($extensions -notcontains 'maki') {
        Write-Host "`.maki` is not mapped to JSON. Nothing to do." -ForegroundColor Green
        return
    }
    $extensions = @($extensions | Where-Object { $_ -ne 'maki' })
    $newExt = ($extensions -join ' ').Trim()
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

Write-Host "`nDone. Reopen Notepad++." -ForegroundColor Cyan
