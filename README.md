# llama.cpp local AI server: AMD Strix Halo (Vulkan) and NVIDIA RTX (CUDA)

Run your own local chat server with llama.cpp, step by step, with scripts and an API test.

| Computer | Backend | English | Deutsch | Download |
|---|---|---|---|---|
| AMD Strix Halo / GMKtec EVO-X2 | Vulkan | [START-EN.md](START-EN.md) | [START-DE.md](START-DE.md) | [EN](DOLMARIO-VULKAN-EN.zip) · [DE](DOLMARIO-VULKAN-DE.zip) |
| RTX 3080 Ti / RTX 3090 Ti | CUDA | [CUDA/EN/START.md](CUDA/EN/START.md) | [CUDA/DE/START.md](CUDA/DE/START.md) | [EN](DOLMARIO-CUDA-EN.zip) · [DE](DOLMARIO-CUDA-DE.zip) |

What the kit does:
- downloads the pinned official llama.cpp release for your backend, checks its SHA256 and lists the detected GPU,
- starts the server in the foreground and tests the browser chat and API (`START-LLAMA.ps1` / `START-CUDA.ps1`, `TEST-API.ps1`),
- CUDA kit: never overwrites an existing installation; `-PrepareOnly` shows all commands without downloading or starting anything.

Model files are separate downloads (see `MODEL-EXAMPLE.json` and `DOWNLOAD-MODEL.ps1`). Hardware profiles: [Strix Halo](PROFILE-STRIX-HALO.md) · [RTX 3080 Ti](PROFILE-RTX3080TI.md) · [RTX 3090 Ti](PROFILE-RTX3090TI.md). Troubleshooting: [EN](TROUBLESHOOTING-EN.md) · [DE](FEHLERHILFE-DE.md). Chat clients: [CLIENTS.md](CLIENTS.md). [SHA256](SHA256SUMS.txt) · [CUDA SHA256](CUDA-SHA256SUMS.txt) · [Sources](SOURCES.md)

Tested on the hardware named above; other systems can behave differently.

## Deutsch

Dein eigener lokaler Chat-Server mit llama.cpp, Schritt für Schritt, mit Skripten und API-Test. Strix Halo nutzt Vulkan, RTX 3080 Ti und 3090 Ti nutzen CUDA. Anleitung und Download stehen in der Tabelle oben. Das Skript lädt das gepinnte offizielle Release, prüft den SHA256 und zeigt die erkannte Grafikkarte; danach Server starten und Chat und API testen. Das CUDA-Paket überschreibt keine vorhandene Installation; `-PrepareOnly` zeigt alle Befehle ohne Download oder Start. Modelldateien werden separat geladen.

Older archive documents: [ARCHIV/SAMMELREPO-20261008/ARCHIV-HINWEIS.md](ARCHIV/SAMMELREPO-20261008/ARCHIV-HINWEIS.md)
