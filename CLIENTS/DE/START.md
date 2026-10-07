# Dein lokaler Server mit einem eigenen Client

Diese Ergänzung verwendet den Starter aus dem vorhandenen [Vulkan-Repo](https://github.com/dolmario/llama-cpp-vulkan-tutorial). Sie erklärt die Client-Anbindung für Anfänger. Keine zweite Runtime, keine privaten Konfigurationen und keine Gewichte enthalten. Vorhandene gemeinsame Router-/Client-Einstellungen bleiben erhalten. Dieses Begleitpaket ist für die eigene öffentliche Client-Ergänzung vorgesehen. Download und Anleitungen sind getrennt von der noch selbst auszuführenden Modellantwort und Client-Erprobung.

## Zuerst ein kleiner Weg
1. Grundtutorial für deine Hardware abschließen: eigene Installation, passende GGUF-Datei, tatsächliche Geräte-/Speicherprüfung und Start. Bei belegten Ressourcen anhalten. Der Startbefehl im unveränderten Starter verwendet --host 127.0.0.1, --port 8091 und --alias lokales-modell.
2. Terminal offenlassen und http://127.0.0.1:8091 im Browser öffnen. Die eingebaute Oberfläche braucht keinen zusätzlich installierten Chatclient. Eine eigene Frage wirklich stellen, Antwort sichern; eine Beispielantwort ist kein Messbefund.
3. Drei Werte notieren: Serverbasis http://127.0.0.1:8091, kompatible API-Basis http://127.0.0.1:8091/v1, exakte Modell-ID lokales-modell. Das Skript unten erwartet die erste Variante, ohne /v1.
4. Zuerst nur eine Anfrage vorbereiten:
   .\CLIENT-VERBINDUNG.ps1 -Action Prepare -OutputDirectory "C:\dein\Client-Vorbereitung"
   REQUEST.json enthält den geplanten Text; STATE.json nennt null Netzwerkaufrufe. Hier wird keine Antwort erzeugt.
5. Dann deinen bereits laufenden Server lesend prüfen:
   .\CLIENT-VERBINDUNG.ps1 -Action Inspect -OutputDirectory "C:\dein\Client-Verbindung"
   HEALTH.json und MODELS.json sind tatsächlich gelesene Zustände. Inspect sendet keine Chat-Anfrage. Eine gelistete Modell-ID ist kein bestandener Antworttest.
6. Für eine echte Anfrage: Ressourcen selbst prüfen, vorhandenen richtigen Server identifizieren, dann
   .\CLIENT-VERBINDUNG.ps1 -Action Ask -OutputDirectory "C:\dein\Client-Antwort"
   REQUEST eintippen. Ask vergleicht die exakte ID mit der Modellliste, wählt keinen Ersatz und sendet nur eine Frage. Standardfrage 4×6: rechnerischer Sollwert 24, kein vorweggenommenes Modellergebnis. ACTUAL-ANSWER.txt entsteht nur nach sichtbarer Antwort. Zeit, fehlende Antwort und Fehler ehrlich erfassen. Ausgabeordner muss neu sein; kein automatischer Retry.
7. Falls deine bestehende API eine Anmeldung benötigt: Token verdeckt über -ApiToken (Read-Host -AsSecureString) angeben. Token nicht in Skripte, URLs oder Ergebnisblätter schreiben. Keine Authentifizierung abschalten.

## Optionaler bereits eingerichteter Chatclient
Für einen normalen Open-WebUI-Windows-Prozess auf demselben Rechner: Einstellungen → Admin → Connections → OpenAI → eigene Verbindung hinzufügen, URL http://127.0.0.1:8091/v1, vorhandene Auth passend beibehalten, Alias prüfen. Provider Default reicht für den reinen Chat; Modellverwaltungs-/Eject-Aktionen benötigen wir hier nicht. Menübezeichnungen können je nach Version abweichen. Die genaue aktuelle Anleitung ist in SOURCES.json verlinkt. Keine bestehende gemeinsame Verbindung überschreiben. Container haben einen eigenen Netzwerkraum; deren 127.0.0.1 ist nicht der Windows-Host. Unser Loopback-Starter wird deshalb nicht einfach auf 0.0.0.0 umgestellt. Ein Docker-/LAN-Aufbau braucht eine eigene geprüfte Netzwerkkonfiguration.

## Nach dem ersten Chat
Mehrere Clients teilen die Serverressourcen. Erst einzeln testen, danach Parallelität und Kontext bewusst prüfen; keine Geschwindigkeitsgarantie. Ein Routeralias ist nicht automatisch ein gleichzeitig geladenes Modell. Für Wissen zunächst die synthetische Firmenübung manuell in einen neuen Chat einfügen. Für Wiki/Web/Dateien echte Anbindung, Protokolle und technische Rechte separat prüfen. Ein Dateiname in einer Antwort allein beweist keinen Toolzugriff. Ein Chatendpunkt ist kein fertiger Wiki-Ingest.

Fehlerfolge: eigenes Terminal → health → models/ID → API-Adresse → tatsächliche Antwort → Zusatzclient. Falscher Port, doppeltes /v1, Authfehler oder leere Antwort sind unterschiedliche Befunde. Nur eigenen Server mit Strg+C beenden; beim Wiederstart dieselben gespeicherten Pfade prüfen. VERBINDUNGSPROTOKOLL.csv selbst ausfüllen.

## Prüfstand
Vorbereitung und lesender Inspect sind getrennt von Ask, UI-Anbindung und neuen Installationen. Die lokale Prüfung am schon laufenden Archivbackend auf Port 8090 belegt nur dessen health/Modellliste und keine neue Vulkan-Installation auf 8091, keinen Chat und keinen Hardwarevergleich. Die neue Open-WebUI-Verbindung, ein echter Ask-Lauf und diese neuen Filme bleiben offen. Eigene Quellenaufgaben und Rechteprüfung sind keine Produktionsfreigabe.
