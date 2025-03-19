$productCodes = @( 
    "{A5340DA7-FAD1-4775-86A7-3E165A5A5449}",
    "{415B99DF-A485-451B-AB0B-8AF6825CDDDF}"
)
foreach ($productCode in $productCodes){
    $wmiClass = Get-WmiObject -Class Win32_Product -Filter "IdentifyingNumber='$productCode'" -ComputerName tdc-gme13-a-w2
    if ($wmiClass){
        $wmiClass.Uninstall()
        Write-Output "MariaDB with product code $productCode uninstalled"

    }else{
        Write-Output "MariaDB with product code $productCode not found"

    }
}
