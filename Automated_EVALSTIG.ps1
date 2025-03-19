$csvfiles = @(
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\Windows10Physical.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10Virtual1.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10Virtual2.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\MDCWindows10MCS.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10Virtual1.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10Virtual2.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10MCS.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME1.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME2.txt"
)

$evalSTIGDir = "C:\Users\pkizzjoyceb\Documents\Evaluate-STIG\Evaluate-STIG_1.2501.0\Evaluate-STIG"

foreach ($csvfile in $csvfiles){
    Write-Host "Running Evaluate-STIG against $($csvfile)......"

        try {
            Set-Location -Path $evalSTIGDir
            & .\Evaluate-STIG.ps1 -ComputerName $computer -VulnTimeout 5 -ThrottleLimit 50 
        } catch {
            Write-Error "Error scanning $computer"
        }
     Write-Host "Waiting 15 seconds before the next scan..."

     Start-Sleep -Seconds 15
}