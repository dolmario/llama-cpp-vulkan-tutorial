# llama.cpp: AMD/Vulkan und NVIDIA/CUDA — Schritt für Schritt

**Backend-Korrektur 07.10.2026:** Für Jörgs RTX 3080 Ti und RTX 3090 Ti ist CUDA vorgesehen. Die bisherigen zusätzlichen RTX-Vulkan-Filme 54–57 sind deshalb zurückgezogen und noch nicht durch neue CUDA-Filme ersetzt. Die Änderung betrifft Bild, Text, Vertonung, Befehle und Downloads. Eine reine Titeländerung wäre falsch.

Der Repository-Name bleibt zur Erhaltung bestehender Links unverändert. Die Anleitungen sind jetzt nach tatsächlichem vorgesehenen Backend getrennt:

| Rechner | Weg | Deutsch | English | Download |
|---|---|---|---|---|
| Strix Halo/EVO-X2 | llama.cpp Vulkan | [START-DE.md](START-DE.md) | [START-EN.md](START-EN.md) | [VulkanDE](DOLMARIO-VULKAN-DE.zip) / [VulkanEN](DOLMARIO-VULKAN-EN.zip) |
| RTX 3080 Ti / RTX 3090 Ti | llama.cpp CUDA | [CUDA/DE/START.md](CUDA/DE/START.md) | [CUDA/EN/START.md](CUDA/EN/START.md) | [CUDADE](DOLMARIO-CUDA-DE.zip) / [CUDAEN](DOLMARIO-CUDA-EN.zip) |

**NVIDIA/CUDA:** Zwei passende offizielle Programm-/CUDA-Laufzeitarchive, deren SHA256-Prüfung, Geräteprüfung, vorhandenes GGUF, Vordergrundstart, Browser/API-Test, Fehlerhilfe und eigenes leeres Testprotokoll. Der Installer überschreibt keine vorhandene Installation. `-PrepareOnly` prüft die Befehle ohne Downloads oder Modellstart. Separate optionale Modell-Datei, keine Modellgewichte im ZIP.

**AMD/Vulkan:** Die bisherigen Strix-Halo-Anleitungen bleiben erhalten. Historische Geräteerkennung und eine neue Installation mit dem gepinnten Download sind unterschiedliche Belege. Für ComfyUI/Bildmodelle ist das Backend getrennt zu betrachten: der AMD-Aufbau verwendet dort seinen ROCm-Arbeitsweg; eine llama.cpp-Vulkan-Anleitung installiert kein ROCm oder CUDA für Bildmodelle.

**Prüfgrenzen:** Offizielle Release-Metadaten, Dateien, Offline-Vertragsprüfungen und ZIPs sind getrennt von der noch offenen frischen NVIDIA-Installation/GPU-Inferenz. Kein ausgeführter neuer Hardwaretest, gemessener Sieger oder Geschwindigkeit versprochen. Bilder sind erklärende Illustrationen. Die vollständige menschliche Endhörprüfung bleibt offen. Für die Videos 54–57 gilt bis zur tatsächlichen CUDA-Neuproduktion eine Uploadsperre.

Bestehende Client-Anleitungen und ihre ZIPs bleiben erhalten: [CLIENTS.md](CLIENTS.md). Frühere Dateien/Git-Versionen und Sammelrepo bleiben zur nachvollziehbaren Migration erhalten. Keine Rückdatierung alter Vulkan-Archive zu einem CUDA-Test.


## Preserved original archive / Erhaltenes Originalarchiv

[Historical aggregate-repository documents / Historische Sammelrepo-Dokumente](ARCHIV/SAMMELREPO-20261008/ARCHIV-HINWEIS.md). Current AMD Vulkan and NVIDIA CUDA entry points remain above.
