param([string]$Destination = (Join-Path $PWD 'Dolmario-CUDA'), [switch]$PrepareOnly)
$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($Destination)) { throw 'Destination is empty.' }
$root = [IO.Path]::GetFullPath($Destination)
if (Test-Path -LiteralPath $root) { throw 'Destination exists. Choose a NEW folder; do not overwrite your working server.' }
$items = @(
    @{Name='cudart-llama-bin-win-cuda-12.4-x64.zip';Url='https://github.com/ggml-org/llama.cpp/releases/download/b11078/cudart-llama-bin-win-cuda-12.4-x64.zip';Sha256='8c79a9b226de4b3cacfd1f83d24f962d0773be79f1e7b75c6af4ded7e32ae1d6';Folder='cuda-runtime-source'}
    @{Name='llama-b11078-bin-win-cuda-12.4-x64.zip';Url='https://github.com/ggml-org/llama.cpp/releases/download/b11078/llama-b11078-bin-win-cuda-12.4-x64.zip';Sha256='8130691194045481dc6ebe190c7b7e87772d437fe086e47524def7bee4cda84d';Folder='runtime'}
)
if ($PrepareOnly) {
    [pscustomobject]@{Destination=$root;Backend='CUDA';Release='b11078';Archives=$items;DownloadsStarted=$false;ModelStarted=$false} | ConvertTo-Json -Depth 8
    return
}
New-Item -ItemType Directory -Path $root | Out-Null
foreach ($item in $items) {
    $archive = Join-Path $root $item.Name
    Invoke-WebRequest -Uri $item.Url -OutFile $archive
    if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $item.Sha256) { throw 'Official archive SHA256 mismatch. Stop; preserve the file for inspection.' }
    Expand-Archive -LiteralPath $archive -DestinationPath (Join-Path $root $item.Folder)
}
$servers = @(Get-ChildItem -LiteralPath (Join-Path $root 'runtime') -Recurse -File -Filter llama-server.exe)
if ($servers.Count -ne 1) { throw 'Server executable is not unique.' }
$exeDir = $servers[0].DirectoryName
$runtimeDlls = @(Get-ChildItem -LiteralPath (Join-Path $root 'cuda-runtime-source') -Recurse -File -Filter '*.dll')
if ($runtimeDlls.Count -eq 0) { throw 'CUDA runtime archive has no DLLs. Stop and inspect the original files.' }
if (@($runtimeDlls | Group-Object Name | Where-Object Count -gt 1).Count -gt 0) { throw 'Ambiguous CUDA runtime DLL names.' }
foreach ($dll in $runtimeDlls) {
    $target = Join-Path $exeDir $dll.Name
    if (Test-Path -LiteralPath $target) {
        if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $dll.FullName -Algorithm SHA256).Hash) { throw 'Different existing DLL; do not overwrite or mix backends.' }
    } else { Copy-Item -LiteralPath $dll.FullName -Destination $target }
}
Push-Location -LiteralPath $exeDir
try {
    & $servers[0].FullName --version
    if ($LASTEXITCODE -ne 0) { throw 'Version check failed.' }
    $devices = & $servers[0].FullName --list-devices 2>&1
    if ($LASTEXITCODE -ne 0) { throw 'CUDA device check failed.' }
    $devices | Tee-Object -FilePath (Join-Path $root 'CUDA-DEVICES.txt')
    if (($devices -join "`n") -notmatch 'CUDA[0-9]+') { throw 'No CUDA device reported. This is not a successful GPU setup.' }
} finally { Pop-Location }
Write-Host 'Runtime/device check only. No model started. Read START.md and verify the actual NVIDIA card before START-CUDA.ps1.'
