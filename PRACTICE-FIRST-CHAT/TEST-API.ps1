param([int]$Port=18190,[string]$OutputFile='my-answer.json')
$ErrorActionPreference='Stop'
if ($Port -lt 1024 -or $Port -gt 65535) {throw 'Invalid port.'}
if (Test-Path -LiteralPath $OutputFile) {throw 'Output exists. Choose a new filename.'}
$base="http://127.0.0.1:$Port"
$health=Invoke-RestMethod "$base/health" -TimeoutSec 15
if ($health.status -ne 'ok') {throw 'Server is not ready.'}
$message='Summarize this workflow in three short bullet points. Use only this source: We generate a town image with FLUX.2 Klein. We save the motion prompts with Gemma. We animate that same image with LTX 2.5.'
$request=@{model='local-chat';messages=@(@{role='user';content=$message});max_tokens=180;temperature=0;stream=$false} | ConvertTo-Json -Depth 8
$reply=Invoke-RestMethod "$base/v1/chat/completions" -Method Post -ContentType 'application/json; charset=utf-8' -Body ([System.Text.Encoding]::UTF8.GetBytes($request)) -TimeoutSec 180
if ([string]::IsNullOrWhiteSpace($reply.choices[0].message.content)) {throw 'The response has no answer text.'}
$reply | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $OutputFile -Encoding UTF8
$reply.choices[0].message.content
