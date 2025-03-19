$csvfiles = @(
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindows10.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindows10Physical.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindows10Virtual1.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindows10Virtual1a.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindows10Virtual2.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindowsSA.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\MDCWindowsServers.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Physical.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual1.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual1a.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual2.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual2a.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual3.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindows10Virtual3a.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\TDCWindowsServers.txt"
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
    & .\Evaluate-STIG.ps1 -ScanType $scanType -ComputerName $csvfile -ThrottleLimit $throttleLimit -Output $output -OutputPath $outputpath 
    Write-Host "Completed Evaluate-STIG against $($csvfile)......"
}