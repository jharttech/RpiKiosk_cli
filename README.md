# RpiKiosk

Create a simple kiosk or digital sign using your raspberry pi 3.  These scripts will do the heavy lifting by writing the config files needed based upon your entries.

This is still in development, if you wish to use this as of 20180126 you will need to clone or download the zip file onto your Raspberry Pi 3, you can then run any one of the scripts that you desire.

This was specifically written for use on an armhf architeture Raspberry Pi 2 or 3 running Raspbian-stretch OS.

INSTRUCTIONS

These instructions are for the RpiKiosk_cli scripts.  These scripts were designed to help wth the heavy lifting of creating a kiosk or digital sign using a raspberry pi 2 or 3 with armhf architecture.

To install Rapian Strech to your pi please go to https://www.raspberrypi.org/downloads/raspbian/ and follow the instructions there.

DEPENDENCY

These scripts do not directly depend on any packages. However, there are a few packages that will help the user should they want to make further changes. The KioskInstall script will look for these and install them if they are not found on your pi.  If you want to install them before running the script then run the following commands on your pi.

$ sudo apt-get update

$ sudo apt-get install git

$ sudo apt-get install vim clutter

The "git" package is if you are familiar with using git and want to clone the RpiKiosk_cli Repositry rather than downloading the zip file.

The "vim" package is simply a text editor.  This package is not crucial but will be of benefit if you are an advance linux or pi user.

The "clutter" package will hide your mouse cursor when it is not being used.  This is good for locations that your kiosk or digital sign will not be with in reach of public.  In the case that your kiosk or digital sign is, the KioskInstall script will allow you to completely disable your mouse cursor on your pi. (Can be Reverted using the EnableCursor script)

STEPS

1.	Clone the RpiKiosk_cli from https://github.com/jharttech/RpiKiosk_cli.git into your github repository location onto your pi.

		$ git clone https://github.com/jharttech/RpiKiosk_cli.git

OR

1.	Download the RpiKiosk_cli from https://github.com/jharttech/RpiKiosk_cli/archive/master.zip to your pi.

	extract the files:

		$ cd Downloads

		$ unzip RpiKiosk_cli-master.zip

		$ mv -r RpiKiosk_cli-master /home/pi/RpiKiosk_cli

2.	Go into the RpiKiosk_cli folder.

		$ cd

		$ cd RpiKiosk_cli

3.	Run the Install script

		$ ./KioskInstall.sh

	This will start the Installation script and will walk you through the setup of your kiosk or digital sign.  Simply follow the script and answer with the desired inputs.  Once the script has finished you should restart your pi for the changes to take effect.

NOTES

I recommend you setting up a free Dakboard account at https://dakboard.com/site.  This company will help you quickly set up a nice digital display for free. (The free version is limited on customizations)

Screen Orientation:
	This setting is dependant upon which way your digital sign (monitor or TV) is mounted.  Your options are "Landscape" or Portrait".

Enter your URL:
	The KioskInstall script will ask you for a URL to your kiosk, video, or slideshow.  If you are using DAKBoard, you will find this url under your account settings.  If will be called your Private URL.  If you are using google slides this will be your public published URL.  This URL can be a URL to any type of legal media that you wish to display on your digital sign.

Mouse Cursor Disable:
	The KioskInstall script will ask if you would like to disable your mouse cursor.  If you choose to do so, you can revert this at a later date by choosing the "Enable Mouse" option in the RpiKioskMain script.  If you choose not to disable the mouse cursor during install, you can disable it later by selecting "Disable Mouse" option in the RpiKioskMain script.

Memory Split:
	The KioskInstall script will ask if you would like to change the memory split of your pi.  If you do not know what this means please indicate that you would not like to change this value by entering "NO" when prompted.  You can change this later by running the "$ raspi-config" command.

How to get to the terminal once you have installed the kiosk:
	You may want to run other scripts or exit out of your newely created Kiosk.  To do this on your pi, press the "windows" key on your keyboard.  Next arrow down to "Accessories", arrow to the right one time, then arrow down to terminal and press the "enter" key.  Once the terminal is up, type the following command to stop the Kiosk:

		$ killall chromium-browsers

	(This will stop the kiosk and allow you to run other scripts or use your pi how ever you desire.)

UNINSTALL

To uninstall the kiosk simply return to the terminal and run the UndoPiKiosk.sh.  This script will revert all config files back to the orignial states and will enable the mouse if it has been disabled.



http://www.gnu.org/copyleft/gpl.html

Information on this Site is Copyright (C) 2009-2018 JHart Technology.
This information is free; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This work is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
​
On Debian systems, the complete text of the GNU General Public License can be found in /usr/share/common-licenses/GPL file.


IN NO EVENT WILL WE BE LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, SPECIAL OR EXEMPLARY DAMAGES FOR ANY USE OF THIS SITE, OR USE OF ANY OTHER LINKED SITE, OR SOFTWARE, EVEN IF WE ARE ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

Privacy Policy
https://jharttech.weebly.com/uploads/9/5/0/7/95072548/jhartprivacypolicy.htm
