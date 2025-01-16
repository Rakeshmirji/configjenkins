$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$hereParent = Split-Path -Path $here -Parent
Write-Host "here = $here"
Write-Host "hereParent = $hereParent"

$repository_path = "$hereParent"
Write-Host "repository_path = $repository_path"

$json = (Get-Content "$here\Automation.json" -Raw) | ConvertFrom-Json
$Global:jsondata = $json
#### Read Values supplied in JSON file ######
### CWA Values ###
write-host "the json is $json"
write-host "the json is convert to json before"
$json | ConvertTo-Json -Depth 10 | Write-Host
write-host "the json is convert to json after"

[string]$Global:BRANCH_NAME = $json.BRANCH_NAME
Write-Host "BRANCH_NAME = $BRANCH_NAME"
#$Global:AntiDLLInjectionTestScriptLink = "https://use-repo.citrite.net/artifactory/sesbld-virtual-releases/Jenkins/sesbuild-cwa-jm/sen/ctx-entryprotect-v2/ctx-master/278/ctx-entryprotect-v2.zip"
$Global:AntiDLLInjectionTestScriptLink = $json.ctxentryprotectv2_download_LINK1
Write-Host "AntiDLLInjectionTestScriptLink = $Global:AntiDLLInjectionTestScriptLink"
$wc = new-object System.Net.WebClient
$wc_jenkins = new-object System.Net.WebClient
$wc.DownloadFile($Global:AntiDLLInjectionTestScriptLink, "$here\ctx-entryprotect-v2.zip")
function Extract-ZipFolder {
  param (
    [string]$SourceZip,
    [string]$DestinationPath
  )

  if (!(Test-Path $SourceZip)) {
    throw "Source zip file not found: $SourceZip"
  }

  if (!(Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force | Out-Null
  }

  Expand-Archive -Path $SourceZip -DestinationPath $DestinationPath -Force
}
function Create-Folder {
    param (
      [string]$FolderPath
    )
  
    if (Test-Path $FolderPath) {
      Remove-Item -Path $FolderPath -Recurse -Force
      Write-Host "Existing folder deleted: $FolderPath"
    }
  
    New-Item -Path $FolderPath -ItemType Directory -Force | Out-Null
    Write-Host "Folder created: $FolderPath"
  }
  
  function Get-FilesAndFolders {
    param (
      [string]$FolderPath
    )
  
    if (!(Test-Path $FolderPath)) {
      throw "Folder not found: $FolderPath"
    }
  
    $filesAndFolders = Get-ChildItem -Path $FolderPath
  
    # Separate files and folders
    $files = $filesAndFolders | Where-Object {$_.PSIsContainer -eq $false}
    $folders = $filesAndFolders | Where-Object {$_.PSIsContainer -eq $true}
  
    # Print files and folders
    Write-Host "Files:"
    foreach ($file in $files) {
      Write-Host $file.Name
    }
  
    Write-Host "Folders:"
    foreach ($folder in $folders) {
      Write-Host $folder.Name
    }
  }
    
Create-Folder -FolderPath "$here\extracted_ctx_folder"
Create-Folder -FolderPath "$here\signedbinaries"
Extract-ZipFolder -SourceZip "$here\ctx-entryprotect-v2.zip" -DestinationPath "$here\extracted_ctx_folder"
$extractedctxpath = "$here\extracted_ctx_folder"
Write-Host "ctx-entryprotect-v2.zip is extracted to extractedctxpath $extractedctxpath"
Get-FilesAndFolders -FolderPath $extractedctxpath

write-host "the Get-FilesAndFolders in $repository_path are"
Get-FilesAndFolders -FolderPath $repository_path

Write-Host "signedbinariespath is $signedbinariespath"
