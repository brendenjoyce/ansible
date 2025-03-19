#Import both CSV files
$iplist = Import-csv -path "C:\Users\pkizzjoyceb\Desktop\HostDisco-20250116.csv"
$dnslist = Import-csv -path "C:\Users\pkizzjoyceb\Desktop\EWSCombined.csv"

$dnslookup = @{}
foreach ($entry in $dnslist){
    $key = $entry.'MNET IP'
    $value = [PSCustomObject]@{
        DNSName       = $entry.'System Name'
        OS            = $entry.'OS'
        Description   = $entry.'Description'
        Zone          = $entry.'Zone'
        NetworkName   = $entry.'Network Name'
      }

      if (-not $dnslookup.ContainsKey($key)){
          $dnslookup[$key] = @()
      }
   
    Write-Host "Adding to hashtable: Key = $key, Values = $value"
    $dnslookup[$key] += $value
}

$results = @()

foreach ($ip in $iplist){
    Write-Host "Processing IP: $($ip.IP)"
    $trimmedIP = $ip.IP.Trim()
    $dnsentries = $dnslookup[$trimmedIP]


    $dnsnames = "Not Found"
    $os = "Not Found"
    $description = "Not Found"
    $zone = "Not Found"
    $networkname = "Not Found"

    if ($dnsentries){
        $dnsnames = ($dnsentries | ForEach-Object {$_.DNSName}) -join ','
        $os = ($dnsentries | ForEach-Object {$_.OS}) -join ','
        $description = ($dnsentries | ForEach-Object {$_.Description}) -join ','
        $zone = ($dnsentries | ForEach-Object {$_.Zone}) -join ','
        $networkname = ($dnsentries | ForEach-Object {$_.NetworkName}) -join ','
    }

    $results += [PSCustomObject]@{
        IP               = $trimmedIP
        DNSName          = $dnsnames
        OS               = $os
        Description      = $description
        Zone             = $zone
        NetworkName      = $networkname  
        
    }

}

$results | Export-Csv -Path "C:\Users\pkizzjoyceb\Desktop\HostDiscoDNS.csv" -NoTypeInformation
Write-Host "Results Exported to HostDiscoDNS.csv"