# Explicit optional 2.50 GB download; no installation or server start.
param([string]$Destination=(Join-Path $PWD 'models'))
$ErrorActionPreference='Stop'
$name='Qwen_Qwen3-4B-Instruct-2507-Q4_K_M.gguf'
$revision='ae44f08e1392f39c0e474af10c3ff8355c8b6688'
$url="https://huggingface.co/bartowski/Qwen_Qwen3-4B-Instruct-2507-GGUF/resolve/$revision/${name}?download=true"
$expected='2fde00ce69dd4899c70d020845e2638353015bba0fdf161b3eb965f2bca4464e'
$expectedBytes=2497280736
New-Item -ItemType Directory -Path $Destination -Force | Out-Null
$root=(Resolve-Path -LiteralPath $Destination).Path
$target=Join-Path $root $name
$partial=$target+'.part'
if ((Test-Path -LiteralPath $target) -or (Test-Path -LiteralPath $partial)) {throw 'File already exists. Preserve it; choose another folder.'}
Write-Host 'Optional model: 2.50 GB, separate from the small tutorial ZIP. Read START-DE.md/START-EN.md and MODEL-EXAMPLE.json first.'
Invoke-WebRequest -Uri $url -OutFile $partial
if ((Get-Item -LiteralPath $partial).Length -ne $expectedBytes) {throw 'Unexpected size; partial file preserved, do not use.'}
if ((Get-FileHash -LiteralPath $partial -Algorithm SHA256).Hash.ToLowerInvariant() -ne $expected) {throw 'SHA256 mismatch; partial file preserved, do not use.'}
Move-Item -LiteralPath $partial -Destination $target
Write-Host "Verified model file: $target. No model has been loaded."
