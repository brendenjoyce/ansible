#Make sure to chang the source path to the location you want to gathe the CKLs from
#$sourcepath = 'C:\STIGS\20250305'
$sourcepath = '\\mdc-bf34-ds06-nas\mdc_sysad\cyber\STIG Checklists\archive\20250315'
#$sourcepath = '\\mdc-bf34-ds06-nas\mdc_sysad\cyber\RedSeal\xccdf exports\2025\Feb\21-FEB\Eval-STIG'
$Date = Get-Date -Format yyyyMMdd
#Update the location where you want the CKLs to be stored. Automatically adds date
$destinationpath = 'C:\Users\pkizzjoyceb\Desktop\STIGCKLs\RHEL' + $Date

# Checks to see if destination file already exists and creates it if it doesn't
if (!(Test-Path -Path $destinationpath)){
    New-Item -ItemType Directory -Path $destinationpath
}

#Collects the ckls from the source path and looks recusrsivley through directory. Copies them to location you specify.
Get-ChildItem -Path $sourcepath -Filter *.ckl -Recurse | Copy-Item -Destination $destinationpath