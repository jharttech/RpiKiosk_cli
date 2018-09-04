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
	_Prev_Ran=$(ls /boot/ | grep "config.txt.DSbackup")
	if [ "" == "$_Prev_Ran" ];
	then
		#echo "IF ONE MADE"
		#sleep 3
		echo "Please specify what screen orientation you will be using. (Answer with 'landscape' or 'portrait')"
		read _Rotate
		if [ "$_Rotate" == "landscape" ];
		then
			#echo "IF TWO MADE"
			#sleep 3
			echo "Now writing orientation to config file."
			sleep 2
			sudo cp /boot/config.txt /boot/config.txt.DSbackup
			echo -e "# Display orientation.  Landscape = 0, Portrait = 1\ndisplay_rotate=0" | sudo tee -a /boot/config.txt
			echo -e "\n# Use 24 bit colors\nframebuffer_depth=24" | sudo tee -a /boot/config.txt
			break
		else
			if [ "$_Rotate" == "portrait" ];
			then
				#echo "ELSE TWO MADE"
				#sleep 3
				echo "Now writing orientation to config file."
				sleep 2
				echo -e "# Display orientation.  Landscape = 0, Portrait = 1\ndisplay_rotate=1" | sudo tee -a /boot/config.txt
				echo -e "\n# Use 24 bit colors\nframebuffer_depth=24" | sudo tee -a /boot/config.txt
				break
			fi
		fi
	else
		#echo "ELSE ONE MADE"
		#sleep 3
		sudo mv /boot/config.txt.DSbackup /boot/config.txt
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
	_Prev_RanTwo=$(ls ~/.config/lxsession/LXDE-pi/ | grep "autostart.DSbackup")
	if [ "" == "$_Prev_RanTwo" ];
	then
		echo "Please enter the URL of the kiosk, video, or slideshow that you wish to show."
		read _URL
		echo "You entered the URL as '$_URL'.  Is that correct? y/n"
		read _yn
		if [ "$_yn" == "y" ];
			then
				echo "Now writing chromium and kiosk configurations to config file.  There will be a backup of original config file created.  It will be located ~/.config/lxsession/LXDE-pi/autostart.backup."
				sleep 5
				cp ~/.config/lxsession/LXDE-pi/autostart ~/.config/lxsession/LXDE-pi/autostart.DSbackup
				echo -e "@xset s off\n@xset -dpms\n@xset s noblank" | sudo tee -a ~/.config/lxsession/LXDE-pi/autostart
				echo -e "@chromium-browser --noerrdialogs --disable-infobars --disable-session-crashed-bubble --incognito --kiosk $_URL" | sudo tee -a ~/.config/lxsession/LXDE-pi/autostart
				break
			fi
		else
			sudo mv ~/.config/lxsession/LXDE-pi/autostart.DSbackup ~/.config/lxsession/LXDE-pi/autostart
		fi
	done
##########################################################

# Here we edit the chromium defualt preferences file so that there will be no crash flag upon reboot

sudo sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sudo sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences
##########################################################

# Here we edit the /etc/lightdm/lightdm.conf file to completely remove the mouse cursor from the system.
echo -e "\n"
echo "##################################################"
echo "##################################################"
echo -e "\n"
while true; do
	echo "The mouse cursor has been hidden until moved in your kiosk.  Would you like to remove the mouse cursor permenantly (Even when moved)? Answer 'Yes' or 'No'"
	read _rmCursor
	if [ "$_rmCursor" == "Yes" ];
		then
			echo "Now going to back up the lightdm.conf file and edit the new lightdm.conf to remove mouse cursor."
			sleep 5
			sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.DSbackup
			sudo sed -i 's/#xserver-command=X/xserver-command=X -nocursor/' /etc/lightdm/lightdm.conf
			break
		else
			if [ "$_rmCursor" == "No" ];
				then
					break
			fi
		fi
	done

#########################################################

# Here we ask the user if they would like to change the RPi Memory split

echo -e "\n"
echo "##################################################"
echo "##################################################"
echo -e "\n"
echo "Finally, would you like to change your Pi's Memory Split? Type YES or NO. (If you do not know what this means type NO)"
read _Mem_Split
if [ "$_Mem_Split" == "YES" ];
then
	while true; do
		echo "Please enter the Memory Split you would like. (Must be one of the following values '64, 128, 256, 512' NOTE 64 is the default)"
		read _Mem_Val
		if [ "$_Mem_Val" == "64" ] || [ "$_Mem_Val" == "128" ] || [ "$_Mem_Val" == "256" ] || [ "$_Mem_Val" == "512" ];
		then
			echo " You have entered your desired memory split to be '$_Mem_Val', is that correct? y/n"
			read _Mem_Yn
			if [ "$_Mem_Yn" == "y" ];
			then
				_Mem_Set=$(cat /boot/config.txt | grep "gpu_mem=")
				if [ "" == "$_Mem_Set" ];
				then
					echo -e "\ngpu_mem=$_Mem_Val" | sudo tee -a /boot/config.txt
					echo "Your new memory split has been added to /boot/config file!"
					sleep 3
					break
				else
					sudo sed -i "s/gpu_mem=[0-9]\+/gpu_mem=$_Mem_Val/" /boot/config.txt
					echo "Your new memory split has been added to /boot/config file!"
					break
				fi
			fi
		fi
	done
	else if [ "$_Mem_Split" == "NO" ];
	then
		echo "Your Pi's memory split will remain set to default."
		sleep 3
		break
	fi
fi


##########################################################
echo "All done!! Please restart your Raspberry Pi now. Chromium will start in kiosk mode displaying the page you specified with the URL you specfied. Thank you -JHart"
sleep 5
exit
