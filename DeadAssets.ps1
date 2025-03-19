$Date = Get-Date -Format yyyyMMdd

[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = "C:\"
$dialog.Filter = "CSV (*.csv)| *.csv"
$dialog.ShowDialog() | Out-Null

$CSVFile = $dialog.FileName

if([System.IO.File]::Exists($CSVFile)){
    Write-Host "Importing CSV...."
    $CSV = Import-Csv -LiteralPath $CSVFile
} else {
    Write-Host "File path specified was not valid"
}

$results = @()

foreach ($entry in $CSV){
    $ip = $entry.IP

    $nslookupoutput = nslookup $ip

    $match = $nslookupoutput | Select-String -Pattern "Name"
        if($match){
            $systemname = $match.ToString().Trim() -replace "Name:", ""
        } else {
            $systemname = "No Matches Found"
        }
    $pingoutput = ping $ip -n 1
        if ($pingoutput -match "Destination host unreachable" -or $pingoutput -match "Request timed out"){
            $ping = "Host machine is offline :("
        } else {
            $ping = "Host machine is online!"
        }

    $tracerouteoutput = tracert $ip | Out-String
    $tracerouteinfo = $tracerouteoutput.Trim()


    $results += [PSCustomObject]@{
        IP         = $ip
        SystemName = $systemname
        Ping       = $ping
        LastHop    = $tracerouteinfo
    }

}

$results | Export-Csv -Path "C:\Users\pkizzjoyceb\Desktop\DeadAssets_$Date.csv" -NoTypeInformation