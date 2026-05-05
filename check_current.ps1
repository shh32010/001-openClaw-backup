$pattern = 'C:\Users\001\.openclaw\agents\main\sessions\643b6267*'
$items = Get-ChildItem $pattern
foreach ($i in $items) {
    $kb = [math]::Round($i.Length / 1KB, 1)
    Write-Output "$($i.Name)  ${kb}KB"
}
