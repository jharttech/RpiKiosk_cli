#!/bin/bash

##################################################

# Simple script to disable mouse cursor if it has been
# re-enabled using the EnableCursor script

##################################################

# Logo Call

echo "###################################################"
echo "###################################################"
echo -e "\n"
cat jhart_shell_logo.txt
echo -e "\n"

echo "###################################################"
echo "###################################################"

##################################################

_Cursor_Enabled=$(ls /etc/lightdm/ | grep "lightdm.conf.backup")
echo -e "\nChecking to see if mouse cursor is already disabled."
if [ "" == "$_Cursor_Enabled" ];
then
	echo "Now backing up the lightdm.conf file and then editing the file to disable the mouse cursor."
	sleep 5
	sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.backup
	sudo sed -i 's/#xserver-command=X/xserver-command=X -nocursor/' /etc/lightdm/lightdm.conf
else
	echo "Nothing to be done.  Your mouse cursor has already been enabled."
	sleep 3
fi

##################################################
echo "All done!! Please reboot your pi for mouse cursur to be disabled. Thank you -JHart"
exit
