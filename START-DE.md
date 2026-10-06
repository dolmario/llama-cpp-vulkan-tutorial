# Dein erster lokaler Chat-Server – Windows und Vulkan

Ziel: Ein Programm auf deinem eigenen Rechner beantwortet eine Frage im Browser. Das kleine Tutorial-ZIP enthält Anleitungen und Startvorlagen, keine KI-Gewichte. Das optionale Beispielmodell ist ein zusätzlicher Download von2.50 GB. Der Weg ist eine prüfbare Vorlage; eine neue Installation oder Modellantwort wurde damit hier noch nicht ausgeführt.

## 1. Vorbereitung

Windows64Bit, passender aktueller Grafiktreiber mit Vulkan, freier Speicher und ein geeigneter Rechner. Lies dein Hardwareprofil PROFILE-STRIX-HALO.md, PROFILE-RTX3080TI.md oder PROFILE-RTX3090TI.md. Beende deine eigenen konkurrierenden KI-Aufgaben vor dem Modellstart; keine fremden Prozesse stoppen. Prüfe freie RAM-/GPU-Ressourcen. Der Treiber stammt von AMD/NVIDIA oder dem Gerätehersteller. Das Vulkan-Entwicklungspaket ist für den vorkompilierten Download normalerweise nicht erforderlich.

## 2. Das kleine Paket holen

Auf der Repository-Startseite klickst du auf DOLMARIO-VULKAN-DE.zip, dann Download raw file. In Windows: Rechtsklick auf die ZIP → Alle extrahieren. Öffne den entpackten Ordner. Lies die Skripte vorher. Öffne PowerShell in diesem Ordner, etwa über die Explorer-Adressleiste: powershell eingeben und Enter. Keine Administratorrechte vorausgesetzt. ExecutionPolicy nicht global abschalten; bei einer Sperre nur die geprüften eigenen Downloadskripte über Dateieigenschaften entsperren.

## 3. Programm herunterladen und Grafikkarte sehen

```powershell
.\INSTALL-LLAMA.ps1 -Destination "$env:USERPROFILE\Dolmario-Vulkan"
```

Wähle einen neuen, bisher nicht vorhandenen Installationsordner. Das Skript lädt das vollständige offizielle b11078-Vulkan-Archiv, prüft SHA256, entpackt es und zeigt Version/Geräte. Alle DLLs bei der EXE lassen. Notiere den tatsächlich ausgegebenen Gerätenamen und den Build in TESTPROTOKOLL.csv. Fehlt deine GPU, zuerst den Grafiktreiber und das gewählte Paket prüfen. Ein Gerätefund ist noch keine Modellantwort.

## 4. Ein überschaubares GGUF-Modell

Wenn du bereits ein unterstütztes GGUF hast, benutze dessen vollständigen Pfad. Optional lädt DOWNLOAD-MODEL.ps1 das festgehaltene Qwen3-4B-Instruct-2507-Q4_K_M von Quantisierer bartowski; SHA/Größe/Revision stehen in MODEL-EXAMPLE.json. Basisanbieter ist Qwen. Die Basis-Modellkarte nennt Apache2.0; die Quantisierer-Metadaten haben kein eigenes Lizenzfeld. Lies daher beide Modellkarten und ihre Hinweise; hier werden keine Modellgewichte weiterverteilt.

```powershell
.\DOWNLOAD-MODEL.ps1 -Destination "$env:USERPROFILE\Dolmario-Modelle"
```

Programm und Modell sind verschiedene Downloads. Kein Flash-Next-Spezialmodell für diesen ersten Standardversuch. Die Modelldateigröße ist nicht der gesamte RAM-/VRAM-Bedarf.

## 5. Server starten

Im folgenden Beispiel musst du beide Pfade an deine Ordner anpassen:

```powershell
.\START-LLAMA.ps1 -Installation "$env:USERPROFILE\Dolmario-Vulkan" -ModelPath "$env:USERPROFILE\Dolmario-Modelle\Qwen_Qwen3-4B-Instruct-2507-Q4_K_M.gguf" -Context 8192 -GpuLayers 999 -Port 8091
```

Das Skript prüft die Pfade und den Port und fragt START nach deiner Ressourcenprüfung. Das Terminal bleibt offen, solange der Server arbeitet. -m wählt das Modell, -c den Kontext, -ngl die GPU-Schichten.999 fordert möglichst vollständiges Offload, schafft aber keinen Speicher. Kontext8192 ist ein erster Arbeitswert, kein größtmöglicher Anspruch. Bei Speicherfehlern kleineres Modell/Kontext prüfen, jeweils nur eine Änderung. Host127.0.0.1 beschränkt den Dienst auf deinen Rechner.

## 6. Bereit prüfen und im Browser fragen

Öffne ein zweites PowerShell-Fenster im Begleitordner:

```powershell
.\TEST-API.ps1 -Port 8091
```

Es prüft /health und fordert anschließend eine echte Antwort an. Nur eine tatsächlich zurückgegebene Antwort ins Protokoll eintragen. Browser öffnen: http://127.0.0.1:8091. Frage zum Beispiel: „Erkläre in drei kurzen Sätzen, was ein lokaler KI-Server macht.“ Lies die Antwort und prüfe ihren Inhalt. Das Terminal allein oder ein grüner Bereitschaftsstatus beweist die Antwort nicht.

## 7. Speichern, wieder starten und Fehler finden

Notiere Modellpfad, Build, GPU, Kontext und den Startbefehl in TESTPROTOKOLL.csv. So kannst du morgen denselben geprüften Weg wiederholen. Zum Beenden nur im eigenen Serverterminal Strg+C. Beim Neustart muss dasselbe Modell noch am gleichen Pfad liegen. Fehlerhilfe: FEHLERHILFE-DE.md. Fortgeschrittene Programme verwenden die lokale API-Basis http://127.0.0.1:8091/v1 und Modellalias lokales-modell. Ein Chat-Server hat damit noch keine Firmenquellen oder Werkzeuge; das ist ein späterer eigener Schritt.
