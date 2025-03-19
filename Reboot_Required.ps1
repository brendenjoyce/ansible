$remotemachines = @(
    "mdc-dwm",
    "mws-sccm"

)

foreach ($machine in $remotemachines){
    Invoke-Command -ComputerName $machine -ScriptBlock {
        $rebootpath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
    if (Test-path $rebootpath){
        Write-Output "$env:COMPUTERNAME Requires a Reboot"

      } else {
        Write-Output "Reboot is not Required" 
    }
}
}
