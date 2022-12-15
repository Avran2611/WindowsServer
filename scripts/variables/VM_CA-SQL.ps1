#------------------------------------------------

#### Variables for Certificate Authority VM

$vmName='EP1-CA-SQL'
$vmPath="$home\VirtualBox VMs\$vmName"
$userName='Administrator' # Username for Windows.  Default user name is vboxuser
$fullUserName='Administrator' 
$password='Admin2223' # Password for Windows.  Default password is changeme
$isoFile='.\ISOs\en_windows_server_2019_x64_dvd_4cb967d8.iso' #  Location of the .iso File. This must be an OS with TypeId Windows10_64 for the script to work.
$osType='Windows2019_64'
$vmMemoryMb = 1024 # Amount of RAM in megabytes
$vmVideoMemoryMb = 128 # Amount of vRAM in megabytes
$hdSizeMb = 51200 #  Size of harddisk in megabytes
$sharedFolder = "$pwd\sharedFolder" #  Path of shared folder
$nofCPU = 1

#------------------------------------------------