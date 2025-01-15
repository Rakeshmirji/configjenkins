$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$hereParent = Split-Path -Path $here -Parent
Write-Host "here = $here"
Write-Host "hereParent = $hereParent"

$json = (Get-Content "$here\Automation.json" -Raw) | ConvertFrom-Json
$Global:jsondata = $json
#### Read Values supplied in JSON file ######
### CWA Values ###
write-host "the json is $json"
write-host "the json is convert to json before"
$json | ConvertTo-Json -Depth 10 | Write-Host
write-host "the json is convert to json after"
print("hello world")