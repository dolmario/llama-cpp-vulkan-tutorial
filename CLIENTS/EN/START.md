# Connect your local server to a client

This extension uses the starter from the existing [Vulkan repository](https://github.com/dolmario/llama-cpp-vulkan-tutorial). It explains client connections for beginners. No second runtime, private configuration or weights included. Preserve existing shared router/client settings. This companion kit is intended for the public client extension. Downloads and instructions are separate from the model response and client trials you still need to perform yourself.

## Start with a small path
1. Complete your hardware's basic tutorial: own installation, compatible GGUF, actual device/memory checks and startup. Stop when resources are occupied. The unchanged starter uses --host 127.0.0.1, --port 8091 and --alias lokales-modell.
2. Keep the terminal open and visit http://127.0.0.1:8091. The built-in interface needs no additional chat client. Actually ask a question and save its reply; a sample answer is not evidence.
3. Record server base http://127.0.0.1:8091, compatible API base http://127.0.0.1:8091/v1, and exact model ID lokales-modell. Our script expects the FIRST URL, without /v1.
4. Prepare one request only:
   .\CLIENT-VERBINDUNG.ps1 -Action Prepare -OutputDirectory "C:\your\Client-Preparation"
   REQUEST.json holds the planned question; STATE.json states zero network calls. No answer is generated.
5. Inspect your EXISTING server read-only:
   .\CLIENT-VERBINDUNG.ps1 -Action Inspect -OutputDirectory "C:\your\Client-Connection"
   HEALTH.json and MODELS.json hold actual read results. Inspect sends no chat request. A listed model ID does not demonstrate task success.
6. For one actual question, check available resources yourself and identify the correct existing server, then:
   .\CLIENT-VERBINDUNG.ps1 -Action Ask -OutputDirectory "C:\your\Client-Answer"
   Type REQUEST. Ask requires the exact ID in the model list, selects no substitute, and sends only one question. The default 4×6 has calculated expected value 24, not a pre-claimed model result. ACTUAL-ANSWER.txt is created only after a visible reply. Record duration, missing output and errors honestly. The output folder must be new; no automatic retry.
7. If your existing API requires authentication, supply the token securely via -ApiToken (Read-Host -AsSecureString). Never put it in scripts, URLs or assessment sheets. Preserve authentication.

## Optional existing chat client
For a normal Open WebUI Windows process on the same host: Settings → Admin → Connections → OpenAI → add a separate connection, URL http://127.0.0.1:8091/v1, preserve appropriate authentication, and check the alias. Provider Default is sufficient for simple chat; model-management/Eject actions are not needed. Menu labels can differ by version. SOURCES.json links the current detailed guide. Preserve shared connections. Containers have their own network namespace: their 127.0.0.1 is not the Windows host. Do not blindly change our loopback starter to 0.0.0.0. A Docker/LAN setup requires separately verified networking.

## After the first chat
Multiple clients share server resources. Test individually before deliberately checking parallelism/context; no speed guarantee. A router alias does not automatically mean a simultaneously loaded model. Start knowledge experiments by pasting the synthetic business exercise into a fresh chat. Wiki/web/files need actual integrations, logs and enforced permissions. A cited filename alone does not prove tool access. A chat endpoint is not a completed Wiki ingest.

Troubleshooting order: own terminal → health → models/ID → API URL → actual answer → additional client. Wrong port, duplicated /v1, authentication failure and empty output are different observations. Stop only your own server using Ctrl+C; verify saved paths on restart. Complete VERBINDUNGSPROTOKOLL.csv yourself.

## Evidence boundary
Preparation and read-only Inspect are separate from Ask, UI connections and new installations. The local inspection of the already running archived backend on port 8090 proves only health/model listing, not a new Vulkan installation on 8091, a chat response, or a hardware comparison. A new Open WebUI connection, actual Ask run and these new films remain pending. Source exercises and permission checks provide no operational approval.
