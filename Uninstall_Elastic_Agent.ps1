$computers = Import-Csv -Path "C:\Users\pkizzjoyceb\Desktop\ElasticAgent\installed.csv"

foreach ($computer in $computers){
    $computername = $computer.ComputerName

    if (Test-Connection -ComputerName $computername -Count 1 -Quiet){
        
        Invoke-Command -ComputerName $computername -ScriptBlock {
            
            & "C:\Program Files\Elastic\Agent\elastic-agent.exe" uninstall -f

        } -Verbose

        Write-Host "Agent Uninstalled on $computername..."
        
    } else {
        Write-Host "$computername is offline or not reachable..... skipping agent uninstallation..."
    }
}