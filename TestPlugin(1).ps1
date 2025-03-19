$remotemachine = "tdc-gme4-a-w2"

Invoke-Command -ComputerName $remotemachine -ScriptBlock {
    $notepadPath = "C:\Program Files\Notepad++\notepad++.exe"
    $pluginPath = "C:\Program Files\Notepad++\plugins\HexEditor\HexEditor.dll"
    if ($notepadPath){
        Write-Output "Notepad++ is installed"

        if (Test-Path $pluginPath){
            Write-Output "The Hex Editor plugin is installed" 
        } else {
            Write-Output "The Hex Editor plugin is not installed"
        }
    } else {
        Write-Output "Notepad++ is not installed" 
    }
}