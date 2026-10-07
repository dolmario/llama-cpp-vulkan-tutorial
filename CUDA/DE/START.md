# NVIDIA: dein erster lokaler llama.cpp-Server mit CUDA

Für RTX 3080 Ti und RTX 3090 Ti ist hier CUDA der vorgesehene Weg. Nicht das AMD/Vulkan-Paket benutzen. Die Skripte und offiziellen Asset-Metadaten werden geprüft; diese neue Installation und eine neue Modellantwort wurden auf den beiden Zielrechnern noch nicht ausgeführt. Kein Geschwindigkeitsversprechen.

1. ZIP vollständig entpacken; im Explorer-Adressfeld `powershell` eingeben. Skripte zuerst im Texteditor lesen.
2. NVIDIA-Treiber und freie Ressourcen auf deinem PC prüfen. System-RAM und GPU-VRAM sind getrennt. Keine unbekannten Prozesse beenden. Eine funktionierende Installation behalten; einen neuen Zielordner wählen.
3. Nur ansehen, ohne Downloads oder Installation:
```powershell
.\INSTALL-CUDA.ps1 -Destination "$env:USERPROFILE\Dolmario-CUDA" -PrepareOnly
```
4. Danach die geprüften Downloadbefehle selbst ausführen:
```powershell
.\INSTALL-CUDA.ps1 -Destination "$env:USERPROFILE\Dolmario-CUDA"
```
Das Skript holt ZWEI getrennte offizielle ZIPs derselben Release b11078: Windows-x64-CUDA 12.4-Programm und die passenden CUDA-Laufzeitbibliotheken. Es prüft beide SHA256 vor dem Entpacken und überschreibt keine fremden DLLs. Diese Laufzeit-DLLs sind nicht der Grafiktreiber und keine Modellgewichte. Ein CUDA-Toolkit zum Kompilieren ist für diesen vorbereiteten Binärweg nicht der Arbeitsschritt; wir kompilieren nicht. Treiberkompatibilität muss der reale Gerätecheck bestätigen. `--version` und `--list-devices` prüfen; Ausgabe `CUDA0` und den echten Gerätenamen protokollieren. GPU-Erkennung ist noch keine Modellantwort.
5. Eine vorhandene unterstützte GGUF-Datei auswählen. Optionales kleines Beispiel in MODEL-EXAMPLE.json; DOWNLOAD-MODEL.ps1 ist ein separater freiwilliger Download, kein Teil des Installers. Modelllizenz/Quelle vorher lesen. Es sind keine Modelle im ZIP.
6. Eigene Pfade einsetzen; zunächst nur den Startplan ansehen:
```powershell
.\START-CUDA.ps1 -Installation "$env:USERPROFILE\Dolmario-CUDA" -ModelPath "C:\Deine-Modelle\modell.gguf" -Context 8192 -GpuLayers 999 -Port 8091 -Device CUDA0 -PrepareOnly
```
7. Wenn der Plan stimmt, Ressourcen frei sind und Port 8091 frei ist: denselben Befehl ohne `-PrepareOnly` ausführen; `START` nach eigener Ressourcenprüfung eingeben. Der Server wird im Vordergrund nur auf 127.0.0.1 gebunden. Startprotokoll auf CUDA, Gerätenamen, GPU-Layer und Fehler prüfen. `-ngl 999` ist eine Anforderung, keine Garantie vollständigen Offloads.
8. Browser: http://127.0.0.1:8091 . Eine kurze Frage stellen. Das Fenster mit dem Server muss offenbleiben. Für den optionalen API-Test:
```powershell
.\TEST-API.ps1 -Port 8091
```
9. Wirkliche Antworten/Fehler/Zeiten in TESTPROTOKOLL.csv eintragen. Keine Demo als frischen Test ausgeben. Nur den eigenen Server mit Strg+C im eigenen Fenster beenden.

Fehlerhilfe: Missing CUDA DLL → beide passenden Archive/DLLs prüfen; CUDA0 fehlt → Treiber/Archiv/Bitness prüfen; Port belegt → freien eigenen Port wählen; Out of memory → kleineres unterstütztes Modell, weniger Kontext oder weniger GPU-Layer; Browser leer → Serverfenster/Adresse/Port/health prüfen. Nicht blind andere Server stoppen oder CUDA-/Vulkan-DLLs mischen.

### Wenn PowerShell die Skriptausführung blockiert

+Die Offline-Prüfung auf unserem Rechner traf auf eine gesperrte Skriptausführung. Das ist kein CUDA-Fehler. Lies die heruntergeladenen Skripte zuerst. Falls du ihnen vertraust, kannst du in diesem eigenen PowerShell-Fenster `Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned` setzen. Das gilt nur für dieses Fenster; die dauerhafte Systemrichtlinie wird nicht verändert. Falls Windows die geprüften Dateien als Internetdownload markiert hat, entsperre nur diese Dateien:

+```powershell
+'INSTALL-CUDA.ps1','START-CUDA.ps1','DOWNLOAD-MODEL.ps1','TEST-API.ps1' | ForEach-Object { Unblock-File -LiteralPath $_ }
+```

+Bei einer verwalteten Firmenrichtlinie die zuständige Administration fragen; die Anleitung umgeht keine Gruppenrichtlinie.
