$adgroups = @("ms_admins", "Domain Admins")

$groupmembership = @()

#$searchbase = "OU=Groups,OU=Managed Objects,DC=mnet,DC=local"

foreach ($adgroup in $adgroups){
    $adgroup = Get-ADGroup -Identity $adgroup -ErrorAction Stop

    $users = Get-ADGroupMember -Identity $adgroup -Recursive

    foreach ($user in $users){
        
        $membership = [PSCustomObject]@{
            GroupName = $adgroup.Name
            UserName  = $user.Name
            SamAccountName = $user.SamAccountName  
        }

        $groupmembership += $membership
    }
}

$groupmembership | Export-Csv -Path "C:\Users\pkizzjoyceb\Desktop\GroupMembership.csv" -NoTypeInformation