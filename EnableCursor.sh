#!/bin/bash

####################################################

# This is a simple script to re-enable the mouse cursor
# if is has been disabled when creating kiosk.

# Logo Call

echo "###################################################"
echo "###################################################"
echo -e "\n"
cat jhart_shell_logo.txt
echo -e "\n"

echo "###################################################"
echo "###################################################"

#####################################################
_Kiosk_Ran=$(ls /etc/lightdm/ | grep "lightdm.conf.DSbackup")
echo -e "\nChecking to see if KioskInstall script has been previously ran : '$_Kiosk_Ran'"
if [ "" == "$_Kiosk_Ran" ];
then
	echo "Mouse was never disabled during Kiosk install.  No configuration changes need to be made."
	sleep 5
else
	echo "Reverting the /etc/lightdm/lightdm.conf file back to original state. This will allow your mouse cursor to return after rebooting your pi."
	sudo rm -rf /etc/lightdm/lightdm.conf
	sudo mv /etc/lightdm/lightdm.conf.DSbackup /etc/lightdm/lightdm.conf
fi

echo -e "\nAll done!  Thank you -JHart."
sleep 3
exit
