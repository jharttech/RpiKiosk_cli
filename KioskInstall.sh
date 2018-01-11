#!/bin/bash

#######################################################

# This script will help do the heavy lifting when trying
# to create a simple Kiosk on a Rpi 3.


#######################################################

# Logo Call

echo "###################################################"
echo "###################################################"
echo -e "\n"
cat jhart_shell_logo.txt
echo -e "\n"

echo "###################################################"
echo "###################################################"

#######################################################

sudo apt-get update

echo -e "\n"
echo "###################################################"
echo "###################################################"
echo " Going to check for needed tools.  If they are not found they will be installed."
_PKG_OK=$(dpkg-query -W --showformat='${Status}\n' unclutter|grep "install ok installed")
echo -e "\nChecking for unclutter: '$_PKG_OK'"
if [ "" == "$_PKG_OK" ]; then
	echo "No unclutter tool found.  Installing and Setting up unclutter now."
	sleep 3
	sudo apt-get -y install unclutter
fi

_PKG_OKTwo=$(dpkg-query -W --showformat='${Status}\n' vim|grep "install ok installed")
echo -e "\nChecking for vim: '$_PKG_OKTwo'"
if [ "" == "$_PKG_OKTwo" ]; then
	echo "No vim editor found.  Installing and Setting up vim now."
	sleep 3
	sudo apt-get -y install vim
fi


#######################################################

# Now going to ask the user for input about the desired screen rotation
# and write it to the appropriate config file.
echo -e "\n"
echo "###################################################"
echo "###################################################"
echo -e "\n"
while true; do
	echo "Please specify what screen orientation you will be using. (Answer with 'landscape' or 'portrait')"
	read _Rotate
	if [ "$_Rotate" == "landscape" ];
	then
		echo "Now writing orientation to config file."
		sleep 2
		echo -e "# Display orientation.  Landscape = 0, Portrait = 1\ndisplay_rotate=0" | sudo tee -a /boot/config.txt
		echo -e "\n# Use 24 bit colors\nframebuffer_depth=24" | sudo tee -a /boot/config.txt
		break
	else
		if [ "$_Rotate" == "portrait" ];
		then
			echo "Now writing orientation to config file."
			sleep 2
			echo -e "# Display orientation.  Landscape = 0, Portrait = 1\ndisplay_rotate=1" | sudo tee -a /boot/config.txt
			echo -e "\n# Use 24 bit colors\nframebuffer_depth=24" | sudo tee -a /boot/config.txt
			break
		fi
	fi
done


#######################################################

# Here we ask the user to input their desired kiosk, video, or slideshow
# URL.   Then we write remaining settings to the appropriate config file.

echo -e "\n"
echo "##################################################"
echo "##################################################"
echo -e "\n"
while true; do
	echo "Please enter the URL of the kiosk, video, or slideshow that you wish to show."
	read _URL
	echo "You entered the URL as '$_URL'.  Is that correct? y/n"
	read _yn
	if [ "$_yn" == "y" ];
		then
			echo "Now writing chromium and kiosk configurations to config file.  There will be a backup of original config file created.  It will be located ~/.config/lxsession/LXDE-pi/autostart.backup."
			sleep 5
			cp ~/.config/lxsession/LXDE-pi/autostart ~/.config/lxsession/LXDE-pi/autostart.backup
			echo -e "@xset s off\n@xset -dpms\n@xset s noblank" | sudo tee -a ~/.config/lxsession/LXDE-pi/autostart
			echo -e "@chromium-browser --noerrdialogs --disable-infobars --disable-session-crashed-bubble --kiosk $_URL" | sudo tee -a ~/.config/lxsession/LXDE-pi/autostart
			break
		fi
	done
##########################################################

# Here we edit the chromium defualt preferences file so that there will be no chrash flag upon reboot

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences
##########################################################

echo "All done!! Please restart your Raspberry Pi now. Chromium will start in kiosk mode displaying the page you specified with the URL you specfied. Thank you -JHart"
sleep 5
exit
