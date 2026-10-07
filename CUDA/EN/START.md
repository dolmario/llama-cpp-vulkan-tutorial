# NVIDIA: your first local llama.cpp server with CUDA

CUDA is the intended path here for RTX 3080 Ti and RTX 3090 Ti. Do not follow the AMD/Vulkan installer. Script and official asset metadata checks are separate from a fresh installation and inference on either target machine, which remain untested. No speed promises.

1. Extract the complete ZIP. In File Explorer's address bar type `powershell`. Read the scripts in a text editor first.
2. Check your NVIDIA driver, free system RAM and separate GPU VRAM. Preserve your working setup and choose a new destination. Do not stop unrelated processes.
3. Inspect the installer plan without downloads:
```powershell
.\INSTALL-CUDA.ps1 -Destination "$env:USERPROFILE\Dolmario-CUDA" -PrepareOnly
```
4. Run the installer when you are ready:
```powershell
.\INSTALL-CUDA.ps1 -Destination "$env:USERPROFILE\Dolmario-CUDA"
```
It downloads TWO official b11078 archives: Windows-x64-CUDA 12.4 binaries and matching CUDA runtime libraries. Both SHA256 digests are checked before extraction. Existing differing DLLs are never overwritten. These runtime DLLs are not your graphics driver and contain no model weights. We are using prebuilt binaries, not compiling with a CUDA development toolkit. Actual driver compatibility must pass the device check. Record `--version`, `--list-devices`, `CUDA0` and the actual GPU name. Device detection is not successful inference.
5. Select an existing supported GGUF file. MODEL-EXAMPLE.json documents an optional small example; DOWNLOAD-MODEL.ps1 is a separate optional download. Read model source/licensing first. No weights are bundled.
6. Insert your own paths; inspect the launch plan first:
```powershell
.\START-CUDA.ps1 -Installation "$env:USERPROFILE\Dolmario-CUDA" -ModelPath "C:\Your-Models\model.gguf" -Context 8192 -GpuLayers 999 -Port 8091 -Device CUDA0 -PrepareOnly
```
7. If resources and port8091 are free, run the same command without `-PrepareOnly`. Enter `START` after your own resource check. Foreground server, loopback127.0.0.1 only. Inspect actual CUDA/device/offloaded-layer/error logs.999 layers is a request, not a guarantee that everything fits.
8. Open http://127.0.0.1:8091 and ask a short question. Keep the server window open. Optional API check:
```powershell
.\TEST-API.ps1 -Port 8091
```
9. Save actual responses, errors and measurements in TESTPROTOKOLL.csv. Do not report instructions as an executed test. Stop only your own foreground server usingCtrl+C.

Troubleshooting: missing DLLs → check both matching archives and runtime libraries; missingCUDA0 → check driver/archive/architecture; occupied port → choose an unused port; out of memory → smaller supported model, context or fewer GPU layers; browser unavailable → inspect server window/address/port/health. Never mix unrelated Vulkan/CUDA DLLs or stop somebody else's services.

### If PowerShell blocks script execution

+Our offline check encountered a local script-execution restriction. This is not a CUDA error. Read the downloaded scripts first. If you trust them, use `Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned` in your own PowerShell window. This affects only that window, not the permanent system policy. If Windows marked the reviewed files as Internet downloads, unblock only these files:

+```powershell
+'INSTALL-CUDA.ps1','START-CUDA.ps1','DOWNLOAD-MODEL.ps1','TEST-API.ps1' | ForEach-Object { Unblock-File -LiteralPath $_ }
+```

+For a managed company policy, ask your administrator; this guide does not bypass Group Policy.
