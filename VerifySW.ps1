$remotemachine = "mdc-dapc-a-w8"

$notepadInstalled = invoke-command -computername $remotemachine -ScriptBlock { test-path -Path 'C:\Program Files\Notepad++'}

if ($notepadInstalled){
    Write-Output "Notepad ++ is installed"

  } else {
    Write-Output "Notepad++ is not installed"
} 