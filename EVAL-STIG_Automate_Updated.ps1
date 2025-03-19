$csvfiles = @(
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\Windows10Physical.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10Virtual1.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10Virtual2.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10MCS.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10Virtual1.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10Virtual2.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10MCS.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME1.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME2.txt"
    

)

$scanType = "Classified"
$throttleLimit = "25"
#$vulntimeout = "5"
$output = "CKL,CKLB"
$outputpath = "C:\STIGS"
$evalSTIGDir = "C:\Users\pkizzjoyceb\Documents\Evaluate-STIG\Evaluate-STIG_1.2501.0\Evaluate-STIG"
#$Date = Get-Date -Format yyyyMMdd

#if (!(Test-Path -Path $outputpath)){
#   New-Item -ItemType Directory -Path $outputpath
#}

foreach ($csvfile in $csvfiles){
    Write-Host "Running Evaluate-STIG against $($csvfile)......"
    Set-Location -Path $evalSTIGDir
    & .\Evaluate-STIG.ps1 -ScanType $scanType -ComputerName $csvfile -ThrottleLimit $throttleLimit -Output $output -OutputPath $outputpath -VulnTimeout 5 
    Write-Host "Completed Evaluate-STIG against $($csvfile)......"
}