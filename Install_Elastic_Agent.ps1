$computers = Import-Csv -Path "C:\Users\pkizzjoyceb\Desktop\ElasticAgent\installed.csv"

$agent = "C:\Users\pkizzjoyceb\Desktop\ElasticAgent\elastic-agent-8.17.2-windows-x86_64"

foreach ($computer in $computers){
    $computername = $computer.ComputerName

    $destinationpath = "\\$computername\c$\"

    if (Test-Connection -ComputerName $computername -Count 1 -Quiet){
    
        Write-Host "Copying Elastic Agent to $computername..."
        Copy-Item -Path $agent -Destination $destinationpath -Recurse -Force  -EA Stop

        Invoke-Command -ComputerName $computername -ScriptBlock {
            & "C:\elastic-agent-8.17.2-windows-x86_64\elastic-agent-8.17.2-windows-x86_64\elastic-agent.exe" install -f --url=https://mdc-fleet.mnet.local:8220 --enrollment-token=VmZjOHhZUUJiYmpxYXpVMGdvY2k6RVJHUGZZc1lSdnliQUZ5RDFrdXZadw== --insecure

            #DTR Policy
            #& "C:\elastic-agent-8.17.2-windows-x86_64\elastic-agent-8.17.2-windows-x86_64\elastic-agent.exe" install -f --url=https://mdc-fleet.mnet.local:8220 --enrollment-token=NklKdTZJZ0JsZnB0a3lhb2haMjk6U3dINGt4VXlTTkt3dUNUZE9WY3ZBQQ== --insecure 
        } -Verbose

        } else {
            Write-Host "$computername is offline or not reachable..... skipping agent installation..."
        }
}