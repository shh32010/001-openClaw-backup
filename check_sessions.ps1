$files = Get-ChildItem 'C:\Users\001\.openclaw\agents\main\sessions' -File | Sort-Object Length -Descending | Select-Object -First 10
foreach ($f in $files) {
    $mb = [math]::Round($f.Length / 1MB, 2)
    Write-Output "$($f.Name)  ${mb}MB"
}
$total = (Get-ChildItem 'C:\Users\001\.openclaw\agents\main\sessions' -File | Measure-Object -Property Length -Sum).Sum
Write-Output "Total: $([math]::Round($total/1MB,1)) MB"
