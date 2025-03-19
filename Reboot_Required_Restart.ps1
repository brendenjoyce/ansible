$computers = @(
    "mws-sccm",
    "mdc-dwm",
    "tdc-dwm",
    "hsv-tableau"
)

foreach ($computer in $computers){
    try{
    $result = Invoke-Command -ComputerName $computer -ScriptBlock {
       Function Test-PendingReboot {
        if (Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) {
            return $true
        }
        if (Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPening" -EA Ignore) {
            return $true
        }
        if (Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore){
            return $true
        }
        try {
            $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
            $status = $util.DetermineIfRebootPening
            if (($status -ne $null) -and $status.RebootPending){
                return $true
            }
        } Catch {
            # Handle any exceptions throwwn by the WMI query
            }
            return $false
    }
     Test-PendingReboot
    } -ErrorAction Stop

    Write-Output "Machine: $computer - Reboot Pending: $result"

        if ($result -eq $true){
            Restart-Computer -ComputerName $computer -Force -Verbose -EA Stop
        }

    } Catch {
        Write-Output "Failed to execute command on $computer. Error: $_"
    }
}