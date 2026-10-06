# Fehler Schritt für Schritt eingrenzen

| Problem | Nächster eigener Check |
|---|---|
| Skript fehlt | ZIP vollständig entpacken, PowerShell im richtigen Ordner öffnen |
| Pfad nicht gefunden | Vollständigen echten Pfad in Anführungszeichen verwenden |
| DLL fehlt | Ganzes offizielles Archiv zusammen lassen, nicht nur EXE kopieren |
| GPU fehlt | --list-devices-Ausgabe, Treiber und Vulkan-x64-Paket prüfen |
| Unbekanntes Modell | Architektur und Build-Kompatibilität prüfen; nicht durch Treiberwechsel kaschieren |
| Speicherfehler | Freie Ressourcen prüfen, Kontext oder Modell verkleinern; eine Änderung je Versuch |
| Port belegt | Eigenen freien Port wählen; keinen fremden Prozess beenden |
| Browser lädt nicht | Serverterminal lesen und /health prüfen; richtigen Port verwenden |
| Health gut, Antwort fehlt | TEST-API ausführen, konkrete erste Fehlermeldung dokumentieren |
| Falsche Antwort | Modellinhalt anhand eigener Quelle prüfen; Serverstart garantiert keine fachliche Richtigkeit |

Keine automatische Treiberinstallation, fremde Stops, globale Sicherheitsabschaltung oder erfundene Testresultate.
