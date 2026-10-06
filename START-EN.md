# Your first local chat server – Windows and Vulkan

Goal: ask a question in your browser and receive an answer from your own computer. The small tutorial ZIP contains instructions and templates, no AI weights. The optional example model is a separate2.50 GB download. These are verifiable templates; a fresh installation and inference have not been executed here.

1. Use64-bit Windows and the appropriate AMD/NVIDIA or device-vendor graphics driver with Vulkan. Read your PROFILE file. Check free RAM/GPU resources and idle competing AI jobs; do not stop someone else's work. A Vulkan development SDK is normally unnecessary for the prebuilt archive.
2. Open DOLMARIO-VULKAN-EN.zip on this repository, click Download raw file, then right-click the downloaded ZIP in Explorer and choose Extract All. Open PowerShell in the extracted folder. Read scripts first. Do not disable ExecutionPolicy globally; if Windows blocks a reviewed script, unblock only that downloaded file.
3. Install into a NEW directory:

```powershell
.\INSTALL-LLAMA.ps1 -Destination "$env:USERPROFILE\Dolmario-Vulkan"
```

The script downloads the complete official pinned b11078Vulkan archive, verifiesSHA256, extracts it, and lists version/devices. Keep all DLLs beside the executable. Record the actual GPU/build; device recognition is not successful inference.

4. Use an existing supported GGUF, or explicitly download the pinned optional Qwen3-4B-Instruct-2507-Q4_K_M example from quantizer bartowski:

```powershell
.\DOWNLOAD-MODEL.ps1 -Destination "$env:USERPROFILE\Dolmario-Modelle"
```

MODEL-EXAMPLE.json records exact revision, file size andSHA. Base model provider is Qwen; its model card declaresApache2.0. Quantizer API metadata does not declare a separate license field: read both model cards and their notices. No weights are redistributed here. Model file size is not total RAM/VRAM usage. FlashNext may require a different specialized runtime and is outside this first standard test.

5. Adjust these paths to your actual folders and start:

```powershell
.\START-LLAMA.ps1 -Installation "$env:USERPROFILE\Dolmario-Vulkan" -ModelPath "$env:USERPROFILE\Dolmario-Modelle\Qwen_Qwen3-4B-Instruct-2507-Q4_K_M.gguf" -Context 8192 -GpuLayers 999 -Port 8091
```

The script checks paths/port and asks you to type START after your own resource check. Keep the terminal open. -m is the model; -c is context; -ngl requestsGPU layers.999 creates no additional memory.8192 is a modest initial context, not a maximum capacity claim. Binding127.0.0.1 keeps the service on your computer.

6. In a second PowerShell window, run:

```powershell
.\TEST-API.ps1 -Port 8091
```

It checks /health and requests a real answer. Only record a result you actually received. Open http://127.0.0.1:8091 in your browser and ask: “Explain in three short sentences what a local AI server does.” Read and check the answer. A terminal window or health response alone does not establish successful inference.

7. Save your build, GPU, model path, context and command in TESTPROTOKOLL.csv. Stop only your own server withCtrl+C in its terminal. Restart with the same verified paths. SeeTROUBLESHOOTING-EN.md for errors. Later clients useAPI base http://127.0.0.1:8091/v1 and model alias lokales-modell. Company sources and tools are a separate step; a server alone does not provide them.
