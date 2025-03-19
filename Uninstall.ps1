$productCodes = @()

$computers = @(
    "tdc-gme13-a-w2",
    "tdc-gme13-a-w1"
)
foreach ($computer in $computers){
    $productCodes += Invoke-Command -ComputerName $computer -ScriptBlock {
        Get-WmiObject -Class Win32_Product | Where {$_.Name -like "*MariaDB 10.6*"} | Select -ExpandProperty IdentifyingNumber
    }
}
foreach ($computer in $computers){
    foreach ($productCode in $productCodes){
    invoke-command -ComputerName $computer -ScriptBlock{
        param ($productCode)
        $wmiClass = Get-WmiObject -Class Win32_Product -Filter "IdentifyingNumber='$productCode'"
        if ($wmiClass){
            $wmiClass.Uninstall()
            Write-Output "MariaDB with product code $productCode uninstalled on $env:COMPUTERNAME"

        }else{
            Write-Output "MariaDB with product code $productCode not found on $env:COMPUTERNAME"

            }
        } -ArgumentList $productCode
    }
}