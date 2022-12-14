#
# Add Virtual Box bin-path to PATH environment variable if necessary:
#
if ( (get-command VBoxManage.exe -errorAction silentlyContinue) -eq $null) {
    $env:path="C:\Program Files\Oracle\VirtualBox;$env:path"
 }