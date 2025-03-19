$productCodes = @( 
    "{A5340DA7-FAD1-4775-86A7-3E165A5A5449}",
    "{CF97C4B7-41C6-4A22-8F7A-D2D2B14927ED}"
)

$computers = @(
    "tdc-gme13-a-w2",
    "tdc-gme13-a-w1"
)
foreach ($computer in $computers){
    foreach ($productCode in $productCodes){
    invoke-command -ComputerName $computer -ScriptBlock{
        param ($productCode)
        $wmiClass = Get-WmiObject -Class Win32_Product -Filter "IdentifyingNumber='$productCode'"
        if ($wmiClass){
            
            Write-Output "MariaDB with product code $productCode uninstalled on $env:COMPUTERNAME"

        }else{
            Write-Output "MariaDB with product code $productCode not found on $env:COMPUTERNAME"

            }
        } -ArgumentList $productCode
    }
}