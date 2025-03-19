$Logs = Get-ChildItem -Path C:\data\events\'Archive-ForwardedEvents-2024-07-*.evtx'
$Destination = "C:\data\Archive\2024\07-JUL\CompressedLogs.zip"

for($i=0;$i -le $Logs.Count;$i=$i+50){
    Compress-Archive -Path $Logs[$i..($i+49)] -DestinationPath $Destination -Update -Verbose
}