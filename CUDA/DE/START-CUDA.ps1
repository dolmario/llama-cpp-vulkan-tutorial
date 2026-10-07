param([Parameter(Mandatory=$true)][string]$Installation,[Parameter(Mandatory=$true)][string]$ModelPath,[int]$Context=8192,[int]$GpuLayers=999,[int]$Port=8091,[string]$Device='CUDA0',[switch]$PrepareOnly)
$ErrorActionPreference = 'Stop'
if ($Context -lt 512 -or $Port -lt 1024 -or $Port -gt 65535 -or $GpuLayers -lt 0 -or $Device -notmatch '^CUDA[0-9]+$') { throw 'Invalid context, port, GPU layers or CUDA device.' }
$model = (Resolve-Path -LiteralPath $ModelPath).Path
if (-not (Test-Path -LiteralPath $model -PathType Leaf) -or [IO.Path]::GetExtension($model) -ne '.gguf') { throw 'Select an existing supported GGUF model.' }
$root = (Resolve-Path -LiteralPath $Installation).Path
$servers = @(Get-ChildItem -LiteralPath (Join-Path $root 'runtime') -Recurse -File -Filter llama-server.exe)
if ($servers.Count -ne 1) { throw 'Server executable is not unique.' }
$arguments = @('-m',$model,'-c',[string]$Context,'-ngl',[string]$GpuLayers,'--device',$Device,'--alias','lokales-modell','--host','127.0.0.1','--port',[string]$Port)
if ($PrepareOnly) {
    [pscustomobject]@{Executable=$servers[0].FullName;Arguments=$arguments;Backend='CUDA';ServerStarted=$false;ModelStarted=$false} | ConvertTo-Json -Depth 8
    return
}
if (Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue) { throw 'Port occupied. Do not terminate another server.' }
Write-Host 'Check free system RAM, GPU VRAM and your own competing tasks. 999 layers does not create memory. Confirm that the selected GGUF fits your current resources.'
if ((Read-Host 'Type START after your resource check') -cne 'START') { throw 'Not started.' }
Push-Location -LiteralPath $servers[0].DirectoryName
try {
    $devices = & $servers[0].FullName --list-devices 2>&1
    if ($LASTEXITCODE -ne 0 -or ($devices -join "`n") -notmatch [regex]::Escape($Device)) { throw 'Selected CUDA device not reported; stop and check installation/driver.' }
    $devices | Write-Host
    & $servers[0].FullName @arguments
    if ($LASTEXITCODE -ne 0) { throw 'llama-server exited with an error; preserve the log and inspect memory/driver/model.' }
} finally { Pop-Location }
