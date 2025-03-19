$computers = @(
    "mdc-ad1",
    "mdc-ad2",
    "mdc-ad3",
    "tdc-ad1",
    "tdc-ad2",
    "tdc-ad3"
)
foreach ($computer in $computers){
    invoke-command -ComputerName $computer -ScriptBlock {
        Get-WmiObject -Class Win32_OperatingSystem | select Caption, Version, BuildNumber
    }
    
}