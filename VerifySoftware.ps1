$computers = Get-ADComputer -Filter * | Select Name

foreach ($computer in $computers){
    $computerName = $computer.Name

Invoke-Command -ComputerName $computerName  -ScriptBlock {
    $softwareInstalled = "C:\Program Files\Git"
 if (Test-Path $softwareInstalled){
    Write-Output "Computer: $computerName - Software Found"
    
    } else {
    Write-Output "Computer: $computerName Git Not Installed"
}
}
}