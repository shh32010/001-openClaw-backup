# Stop Gateway first
Write-Output "Stopping Gateway..."
Stop-Service -Name 'OpenClaw Gateway' -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

$sessionDir = 'C:\Users\001\.openclaw\agents\main\sessions'

# 1. Delete stale session files
Write-Output "Deleting stale sessions..."
Remove-Item "$sessionDir\85fae54a-9b55-4791-9db8-9886604cc082.*" -Force -ErrorAction SilentlyContinue
Remove-Item "$sessionDir\9eeb5cfa-0aad-4327-bf77-5bb95ab4ca44.*" -Force -ErrorAction SilentlyContinue

# 2. Delete backup files for stale sessions
Write-Output "Deleting backup files..."
Get-ChildItem $sessionDir -Filter "*.bak-*" -File | Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $sessionDir -Filter "*.reset.*" -File | Remove-Item -Force -ErrorAction SilentlyContinue

# 3. Truncate current session to last 3 lines
$currentSession = "$sessionDir\643b6267-151e-4dad-9f8e-6c02582eb194.jsonl"
if (Test-Path $currentSession) {
    Write-Output "Truncating current session..."
    $lines = Get-Content $currentSession
    $keep = $lines | Select-Object -Last 3
    $keep | Set-Content $currentSession -NoNewline
    Write-Output "Current session now $(($keep | Measure-Object).Count) lines"
}

# 4. Also truncate trajectory
$traj = "$sessionDir\643b6267-151e-4dad-9f8e-6c02582eb194.trajectory.jsonl"
if (Test-Path $traj) {
    $tlines = Get-Content $traj
    $tkeep = $tlines | Select-Object -Last 3
    $tkeep | Set-Content $traj -NoNewline
    Write-Output "Trajectory truncated"
}

# 5. Update sessions.json - remove entries for the two stale sessions
Write-Output "Updating sessions.json..."
$sessionsFile = "$sessionDir\sessions.json"
$j = Get-Content $sessionsFile -Raw | ConvertFrom-Json
$removed = 0
$j.compactions = @($j.compactions | Where-Object {
    $keep = $_.sessionId -notmatch '85fae54a|9eeb5cfa'
    if (-not $keep) { $removed++ }
    $keep
})
$j.overflowRetries = @($j.overflowRetries | Where-Object {
    $keep = $_.sessionId -notmatch '85fae54a|9eeb5cfa'
    if (-not $keep) { $removed++ }
    $keep
})
$j.PSObject.Properties.Remove('overflowRetries')
$j | ConvertTo-Json -Depth 20 | Set-Content $sessionsFile -NoNewline
Write-Output "Removed $removed session entries"

# 6. Report disk freed
$remaining = Get-ChildItem $sessionDir -File | Measure-Object -Property Length -Sum
$freedGB = [math]::Round($remaining.Sum / 1GB, 2)
Write-Output "Done. Session dir now $([math]::Round($remaining.Sum/1MB,1)) MB"

# Restart Gateway
Write-Output "Restarting Gateway..."
Start-Service -Name 'OpenClaw Gateway' -ErrorAction SilentlyContinue
Write-Output "Done!"
