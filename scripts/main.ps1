#### main.ps1

####
#### This script creates the nessesary virtual machines for our windows environment using VirtualBox.
#### You can set the preferred variables in the corresponding variable files in the variables directory to customize the setup.
####

#------------------------------------------------

.\scripts\CreateVM_DC.ps1

Start-Sleep -Seconds 60

.\scripts\CreateVM_EP1-CA-SQL.ps1

Start-Sleep -Seconds 60

