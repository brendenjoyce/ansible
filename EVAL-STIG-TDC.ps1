$csvfiles = @(
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME1a.txt"
    #"C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME2a.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME3a.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME4a.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME5a.txt"
    "C:\Users\pkizzjoyceb\Documents\Text_files_for_Windows_Evaluate-STIG_Scans\20250213\TDCWindows10GME6a.txt"
)

$evalSTIGDir = "C:\Users\pkizzjoyceb\Documents\Evaluate-STIG\Evaluate-STIG_1.2501.0\Evaluate-STIG"

foreach ($csvfile in $csvfiles){
    Write-Host "Running Evaluate-STIG against $($csvfile)......"

        try {
            Set-Location -Path $evalSTIGDir
            & .\Evaluate-STIG.ps1 -ComputerName $csvfile -ThrottleLimit 25
            #& .\Evaluate-STIG.ps1 -ComputerName $csvfile -SelectSTIG Win10 -SelectVuln V-268315 -VulnTimeout 5 -ThrottleLimit 25 
        } catch {
            Write-Error "Error scanning $computer"
        }
     Write-Host "Waiting 15 seconds before the next scan..."

     Start-Sleep -Seconds 15
}