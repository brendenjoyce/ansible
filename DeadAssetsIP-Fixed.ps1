[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = "C:\"
$dialog.Filter = "TXT (*.txt)| *.txt"
$dialog.ShowDialog() | Out-Null

$TXTFile = $dialog.FileName

if([System.IO.File]::Exists($TXTFile)){
    Write-Host "Importing CSV...."
    $TXT = Import-Csv -LiteralPath $TXTFile
} else {
    Write-Host "File path specified was not valid"
}

$contents = Get-content -Path $TXTFile

$ipAddresses = $contents | Select-String -Pattern "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -AllMatches

$ipAddresses.Matches | ForEach-Object { $_.Value } 