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

[string]$Global:StoreTypeX1 = $json.BRANCH_NAME
Write-Host "StoreTypeX1 = $StoreTypeX1"
$Global:AntiDLLInjectionTestScriptLink = "https://use-repo.citrite.net/artifactory/sesbld-virtual-releases/Jenkins/sesbuild-cwa-jm/sen/ctx-entryprotect-v2/ctx-master/278/ctx-entryprotect-v2.zip"
$wc = new-object System.Net.WebClient
$wc_jenkins = new-object System.Net.WebClient
$wc.DownloadFile($Global:AntiDLLInjectionTestScriptLink, "$here\ctx-entryprotect-v2.zip")