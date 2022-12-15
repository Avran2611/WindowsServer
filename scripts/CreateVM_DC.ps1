#### CreateVM_DC.ps1

####
#### This script creates the nessesary virtual machine for the EP1-DC server using VirtualBox.
#### You can set the preferred variables below to customize the setup for this VM.
####

#------------------------------------------------

#### Load variables for Domain Controller VM

. .\scripts\variables\VM_DC.ps1

#------------------------------------------------

# Add Virtual Box bin-path to PATH environment variable if necessary:
if ($null -eq (get-command VBoxManage.exe -errorAction silentlyContinue)) {
    $env:path="C:\Program Files\Oracle\VirtualBox;$env:path"
 }

# Delete previously created VM with the same name
VBoxManage controlvm $vmName poweroff
VBoxManage unregistervm $vmName --delete
Remove-Item -Recurse -Force $vmPath
Remove-Item -recurse -Force $sharedFolder
#Remove-Item -recurse $vmPath\hard-drive.vdi

# Detect OS of given iso
VBoxManage.exe unattended detect --iso=$isoFile

# Create the virtual machine definition file
VBoxManage createvm --name $vmName --ostype $osType --register

if (! (test-path $vmPath\$vmName.vbox)) {
   Write-Output "I expected a .vbox"
   return
}

# Register the VM
VboxManage registervm $vmPath\$vmName.vbox

# Add the VM to the WinII group
VBoxManage modifyvm $vmName --groups "/WinII"

# Add a virtual hard disk
VBoxManage createmedium --filename $vmPath\hard-drive.vdi --size $hdSizeMb

if (! (test-path $vmPath\hard-drive.vdi)) {
   Write-Output "I expected a .vdi"
   return
}

# Add SATA controller and attach hard disk to it
VBoxManage storagectl    $vmName --name       'SATA Controller' --add sata --controller IntelAHCI
VBoxManage storageattach $vmName --storagectl 'SATA Controller' --port 0 --device 0 --type hdd --medium $vmPath/hard-drive.vdi

# Add IDE controller and virtual DVD drive and mount the iso to the IDE controller
VBoxManage storagectl    $vmName --name       'IDE Controller' --add ide
VBoxManage storageattach $vmName --storagectl 'IDE Controller' --port 0 --device 0 --type dvddrive --medium $isoFile

# Add a second NIC for the winnet internal network
VBoxManage modifyvm $vmName --nic2 intnet --cableconnected2 on --intnet2 winnet

# Enable APIC for the virtual motherboard 
VBoxManage modifyvm $vmName --ioapic on

# Specify boot order to DVD drive -> hard drive
VBoxManage modifyvm $vmName --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Specify amount of RAM and vRAM
VBoxManage modifyvm $vmName --memory $vmMemoryMb --vram $vmVideoMemoryMb

# Specify amount of vCPUs
VBoxManage modifyvm $vmName --cpus $nofCPU

# Specify (host) location of shared folder and mount it
$null = mkdir $sharedFolder
VBoxManage sharedfolder add $vmName --name shr --hostpath $sharedFolder --automount

# Enable clipboard content sharing
VBoxManage modifyvm  $vmName --clipboard-mode bidirectional

# Specify graphics controller as VBoxSVGA
VBoxManage modifyvm  $vmName --graphicscontroller vboxsvga

# Specify the desire to do an unattended install. Image-index specifies the flavour of the OS. 1 = Standard (Headless), 2 = Standard (GUI)
VBoxManage unattended install $vmName      `
  --iso=$isoFile                           `
  --user=$userName                         `
  --password=$password                     `
  --full-user-name=$fullUserName           `
  --install-additions                      `
  --time-zone=CET                          `
  --hostname=$vmName.ws2-2223-arne.hogent  `
  --image-index=2                          `
  --post-install-command='VBoxControl guestproperty set installation_finished y'

# Start the Virtual Machine and perform the unattended install
  #VBoxManage startvm $vmName

# Set size of display
  #VBoxManage controlvm $vmName setvideomodehint 1200 900  32
