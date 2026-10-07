param(
    [ValidateSet('Prepare','Inspect','Ask')][string]$Action='Prepare',
    [Parameter(Mandatory=$true)][string]$OutputDirectory,
    [string]$BaseUrl='http://127.0.0.1:8091',
    [string]$Model='lokales-modell',
    [string]$Prompt='Berechne 4 mal 6. Antworte nur mit der Zahl.',
    [Security.SecureString]$ApiToken
)
$ErrorActionPreference='Stop'
$uri=[Uri]$BaseUrl
if ($uri.Scheme -notin @('http','https') -or -not $uri.IsLoopback -or $uri.UserInfo -or $uri.Query -or $uri.Fragment -or $uri.AbsolutePath -ne '/') {
    throw 'Use an existing loopback server base without path, credentials, query or fragment. /v1 is appended by this script.'
}
if ([string]::IsNullOrWhiteSpace($Model) -or [string]::IsNullOrWhiteSpace($Prompt)) { throw 'Exact model ID and a nonempty prompt are required.' }
if (Test-Path -LiteralPath $OutputDirectory) { throw 'Output exists. Choose a new directory; earlier evidence is preserved.' }
$body=[ordered]@{model=$Model;messages=@(@{role='user';content=$Prompt});temperature=0;max_tokens=128;stream=$false}
$state=[ordered]@{action=$Action;base_url=$BaseUrl;model=$Model;get_attempts=0;chat_post_attempts=0;model_response_received=$false;model_started=$false;server_started=$false;auth_changed=$false;expected_arithmetic_if_using_default_prompt=24;arithmetic_expected_not_measured=$true;status='prepared'}
New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
$body | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'REQUEST.json') -Encoding UTF8
$state | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $OutputDirectory 'STATE.json') -Encoding UTF8
if ($Action -eq 'Prepare') { Write-Host 'Request prepared. ZERO network calls, server/model starts or inference.'; return }
$headers=@{}
if ($ApiToken -and $ApiToken.Length -gt 0) {
    $pointer=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($ApiToken)
    try { $headers.Authorization='Bearer '+[Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer) }
    finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer) }
}
try {
    $root=$BaseUrl.TrimEnd('/')
    $state.get_attempts++
    $health=Invoke-RestMethod -Uri ($root+'/health') -Method Get -Headers $headers -MaximumRedirection 0 -TimeoutSec 15
    $health | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'HEALTH.json') -Encoding UTF8
    $state.get_attempts++
    $models=Invoke-RestMethod -Uri ($root+'/v1/models') -Method Get -Headers $headers -MaximumRedirection 0 -TimeoutSec 15
    $ids=@($models.data | ForEach-Object { $_.id })
    [pscustomobject]@{ids=$ids;requested_model_listed=($Model -in $ids);list_is_not_a_chat_result=$true} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'MODELS.json') -Encoding UTF8
    $state.status='inspected_no_inference'
    if ($Action -eq 'Ask') {
        if ($Model -notin $ids) { throw 'Exact requested model ID is not listed. No alternative chosen, loaded or downloaded.' }
        Write-Host 'ASK sends one real request. Check free resources and your own existing server; this is not a benchmark.'
        if ((Read-Host 'Type REQUEST to send this exact prompt to this exact existing model') -cne 'REQUEST') { throw 'No request sent.' }
        $state.chat_post_attempts++
        $json=$body | ConvertTo-Json -Depth 8 -Compress
        $watch=[Diagnostics.Stopwatch]::StartNew()
        try { $reply=Invoke-RestMethod -Uri ($root+'/v1/chat/completions') -Method Post -Headers $headers -MaximumRedirection 0 -ContentType 'application/json; charset=utf-8' -Body ([Text.Encoding]::UTF8.GetBytes($json)) -TimeoutSec 180 }
        finally { $watch.Stop();$state.elapsed_seconds=[Math]::Round($watch.Elapsed.TotalSeconds,3) }
        $text=[string]$reply.choices[0].message.content
        if ([string]::IsNullOrWhiteSpace($text)) { throw 'No visible answer. Do not report successful arithmetic or a working chat.' }
        $text | Set-Content -LiteralPath (Join-Path $OutputDirectory 'ACTUAL-ANSWER.txt') -Encoding UTF8
        $state.model_response_received=$true;$state.status='actual_answer_received_review_required'
        Write-Host $text
    } else { Write-Host ('Read-only health/model-list inspected. IDs: '+($ids -join ', ')+'. ZERO chat requests.') }
} catch {
    $state.status='stopped_error_preserved';$state.error=$_.Exception.Message
    throw
} finally {
    $state | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'STATE.json') -Encoding UTF8
    $headers.Clear()
}
