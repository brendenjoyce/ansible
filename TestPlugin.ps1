$remotemachine = "tdc-gme4-a-w2"

$notepadInstalled = get-wmiobject -class win32_product -ComputerName $remotemachine | where {$_.Name -like "*Notepad++*"}

if ($notepadInstalled){
    Write-Output "Notepad ++ is installed"


    $pluginPath = "\\$remotemachine\c$\Program Files\Notepad++\plugins\HexEditor.dll"

    if (Test-Path $pluginPath){
        Write-Output "The plugin is installed"
    } else {
        Write-Output "The plugin is not installed"
    }
} else {
    Write-Output "Notepad++ is not installed"
} 