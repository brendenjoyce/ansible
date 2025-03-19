
$computers = Get-ADComputer -Filter * -SearchBase "OU=802.1x,OU=Workstations,OU=Hosts,OU=Managed Objects,DC=mnet,DC=local" | Where {$_.Name -like "EEW-*"} | Select Name
#$computers = Import-Csv -Path "C:\Users\pkizzjoyceb\Desktop\ElasticAgent\installed.csv"

$searchbase = "OU=802.1x,OU=Workstations,OU=Hosts,OU=Managed Objects,DC=mnet,DC=local" 

$elasticagentpath = "C:\Program Files\Elastic\Agent"

$results = @()

foreach ($computer in $computers){
    $computername = $computer.Name

    if (Test-Path "\\$computername\c$\Program Files\Elastic\Agent\data"){
        
        Write-Host "$computername has an Elastic Agent installed..."


        } else {
        Write-Host "$computername does not have an Elastic Agent Installed..."

        $results += [PSCustomObject]@{
            ComputerName = $computername
            }
}
}

$results | Export-Csv -Path "C:\Users\pkizzjoyceb\Desktop\ElasticAgent\installed.csv" -NoTypeInformation