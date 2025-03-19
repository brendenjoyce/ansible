$username = "acas_local"
$password = "BrVa06152021!1121@" | ConvertTo-SecureString -AsPlainText -Force
$accountexists = Get-LocalUser -Name $username -ErrorAction SilentlyContinue

if ($accountexists){
    Remove-LocalUser -Name $username -Confirm:$false -Verbose

    Write-Host "User $username has been removed."
} else {
    Write-Host "User $username doesn't exist."
}

#New-LocalUser -Name $username -Password $password -PasswordNeverExpires
New-LocalUser -Name $username -NoPassword -Verbose

Add-LocalGroupMember -Group "Administrators" -Member $username
Add-LocalGroupMember -Group "Users" -Member $username

Get-LocalUser -Name $username

Start-Sleep -Seconds 60

Remove-LocalUser -Name $username -Confirm:$false -Verbose

Get-LocalUser -Name $username -ErrorAction SilentlyContinue

if ($?){
    Write-Host "User $username was not removed."
} else {
    Write-Host "User $username was successfully removed."
} 