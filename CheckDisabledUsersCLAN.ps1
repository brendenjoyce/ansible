$ou = "OU=Users,OU=Managed Objects,DC=MNET,DC=local"
$disableduserscsv = "C:\Users\pkizzjoyceb\Desktop\disabledusers.csv"
$outputfile = "C:\Users\pkizzjoyceb\Desktop\Output.csv"

$enabledusers = Get-ADUser -Filter * -SearchBase $ou | Select SamAccountName

$disabledusers = Import-Csv -Path $disableduserscsv

$results = @()

foreach ($user in $disabledusers){
    $aduser = Get-ADUser -Identity $user.SamAccountName -ErrorAction Stop
    
    if ($aduser){
        Write-Host "Checking User: $($user.SamAccountName)"

        if ($aduser.Enabled -eq $true){
            $results += [PSCustomObject]@{
                SamAccountName = $user.SamAccountName
                Status = "Listed as Disabled but still Active in AD"
        }
    } else {
        $results += [PSCustomObject]@{
            SamAccountName = $user.SamAccountName
            Status = "Listed in CSV and Disabled in AD"
        }
    }

    } else {
        $results += [PSCustomObject]@{
        SamAccountName = $user.SamAccountName
        Status = "Not Found in AD"
        }
    } 
}

$output = @()

foreach ($result in $results){
    $output += "$($result.SamAccountName): $($result.Status)`r`n"

}

$output | Out-Host
$output | Out-File -FilePath $outputfile -Encoding utf8