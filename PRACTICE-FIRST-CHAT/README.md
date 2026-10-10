# Your first local chat with llama.cpp and Vulkan

Download the Windows Vulkan runtime, load the supplied small Qwen GGUF example, and ask a question in the built-in browser chat. Our recorded task summarizes three lines from our image workflow, then rewrites the answer as one sentence.

![Actual browser answer from our newly started local server](example/CHAT.png)

## Start the example

Extract the practice ZIP and open PowerShell in its folder. Keep your other GPU jobs finished while loading the model. The four commands below use new folders inside the extracted kit:

```powershell
.\INSTALL-LLAMA.ps1 -Destination .\my-vulkan
.\DOWNLOAD-MODEL.ps1 -Destination .\my-models
.\START-LLAMA.ps1 -Installation .\my-vulkan -ModelPath .\my-models\Qwen_Qwen3-4B-Instruct-2507-Q4_K_M.gguf -Context 4096 -Port 18190
```

The installer downloads the complete official **b11078 Windows x64 Vulkan archive**, checks SHA256, extracts it, prints the version and lists devices. Keep the runtime DLLs beside the executable. It returns PowerShell to the companion folder. The model helper downloads the pinned **2.50 GB Qwen3-4B-Instruct-2507 Q4_K_M GGUF from bartowski**, checks size and SHA256, and preserves an incomplete `.part` file if the check fails. Model weights are not in this ZIP; [MODEL-EXAMPLE.json](MODEL-EXAMPLE.json) identifies their source.

The start script uses the selected model, 4096 context tokens, one conversation slot, two CPU threads, GPU-layer request `999`, and alias `local-chat`. It stays in the foreground. Open **http://127.0.0.1:18190** and type:

> Summarize this workflow in three short bullet points. Use only this source: We generate a town image with FLUX.2 Klein. We save the motion prompts with Gemma. We animate that same image with LTX 2.5.

Then ask **Make those three steps one short sentence.** The complete answer we copied from our browser is in [example/ANSWER.txt](example/ANSWER.txt). The context indicator shows used and remaining tokens. Use Copy below an answer to take it into your notes.

## Check the same server from a script

In a second PowerShell terminal, return to the extracted companion folder and run:

```powershell
.\TEST-API.ps1 -Port 18190 -OutputFile .\my-answer.json
```

It checks readiness, submits the same three-line task, prints the returned answer and saves the full JSON response to a new file. A client uses API base `http://127.0.0.1:18190/v1` and model alias `local-chat`.

Finish by pressing **Ctrl+C in your server terminal**. Run the same start command for the next session. If your model path is wrong, compare it with the actual `.gguf` file; if the port is occupied, choose another free port and update the browser/API addresses too. Existing model files and installation folders are preserved.

## Recorded execution

We freshly downloaded and hash-checked the official runtime and pinned GGUF, started the server, received an API answer, and sent the source task and follow-up in the real built-in browser. Our existing Windows graphics driver was reused on a 64 GB Strix Halo machine with Radeon 8060S. [VALIDATION.json](VALIDATION.json) separates this recorded run, the script checks and any still-open tests. It does not claim a fresh driver installation or a test on other GPUs.

Sources: [official runtime release](https://github.com/ggml-org/llama.cpp/releases/tag/b11078), [pinned quantized model](https://huggingface.co/bartowski/Qwen_Qwen3-4B-Instruct-2507-GGUF/tree/ae44f08e1392f39c0e474af10c3ff8355c8b6688), [original Qwen model card](https://huggingface.co/Qwen/Qwen3-4B-Instruct-2507). Read their model notices for your use. We redistribute our scripts and recorded example, no model weights or runtime binaries.

## Deutsch

Entpacke das Praxis-ZIP, öffne dort PowerShell und führe die drei Startbefehle oben aus. Die erste Datei lädt und prüft llama.cpp, die zweite das kleine Qwen-Modell. Der Server bleibt im Vordergrund; der Browserchat ist unter `http://127.0.0.1:18190` erreichbar. Eine Nachfrage funktioniert im selben Gespräch. Copy übernimmt die Antwort; die Kontextanzeige nennt belegte und freie Tokens. `TEST-API.ps1` prüft denselben Server in einem zweiten Terminal. Beenden mit Strg+C im eigenen Serverterminal. Die Befehle und unser echtes Beispiel gehören zusammen; die Modellgewichte werden separat geladen.
