$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$hereParent = Split-Path -Path $here -Parent
Write-Host "here = $here"
Write-Host "hereParent = $hereParent"

$json = (Get-Content "$here\Automation.json" -Raw) | ConvertFrom-Json
$Global:jsondata = $json
#### Read Values supplied in JSON file ######
### CWA Values ###
write-host "the json is $json"
$json | ConvertTo-Json -Depth 10 | Write-Host
print("hello world")