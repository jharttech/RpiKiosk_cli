<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<title>RpiKiosk_cli Version</title>
		<link rel="stylesheet" media="screen and (min-width: 600px)" href="./css/style.css" />
		<link rel="stylesheet" media="screen and (max-width: 599px)" href="./css/mstyle.css" />
	</head>
	<?php if(($_POST['blog'])){
	header("Location: blogList.php");}?>
	<body>
		<table id="title">
			<tr>
				<td id="title">
					<h1>Creating Easy Digital Sign With Raspberry Pi 3 CLI Version</h1>
				</td>
			</tr>
		</table>
		<table id="blog">
			<tr>
				<td id="blog">
					<p id="blog"><h2><strong>How To</strong></h2></p>
					<p id="blog"><b>***NOTE*** This tutorial is for the CLI Version of RpiKiosk.</br>These scripts and this tutorial were designed for use with a raspberry pi 2 or 3 with armhf architecture.</br>These scripts are based on the 2017-11-29-raspbian-stretch version of raspbian.</b></br></p>
					<p id="blog">1. The first thing you will need to do is install Raspian onto your raspberry pi.  To Install Raspian Stretch to your pi please go to <a href="https://www.raspberrypi.org/downloads/raspbian/">https://www.raspberrypi.org/downloads/raspbian/</a> and follow the instructions there.</br></p>
					<p id="blog">There are a few packages that these scripts do not directly depend on but will help the user should they want to make further changes.  The RpiKioskInstall script will look for these and install them if they are not found on your pi.  However, if you wish to install them before running the script then run the following commands on your pi in the terminal:</br></p>
					<code><pre>$ sudo apt-get update
$ sudo apt-get install git vim clutter</pre></code>
					<p id="blog">The "git" package is for users that are familiar with using git and want to clone the RpiKiosk Repository rather than downloading the zip file.</br>The "vim" package is simply a terminal text editor.  This package is not crucial but will be of benefit if you are an advanced linux or pi user.</br>The "clutter" package will hide your pi's mouse cursor when it is not being used.  This is good for locations that your kiosk or digital sign will not be within reach of public.  In the case that your kiosk or digital sign is within reach of public, the RpiKioskCursorDisable script will allow you to completely disable your mouse cursor on your pi. (This can be reverted using the RpiKioskCursorEnable script)</br></p>
					<p id="blog">2. Clone the RpiKiosk_cli from https://github.com/jharttech/RpiKiosk_cli.git with the following command:</br></p>
					<code><pre>$ git clone https://github.com/jharttech/RpiKiosk_cli.git</code></pre>
					<p id="blog"><h2><strong>OR</strong></h2></p>
					<p id="blog"> Download the RpiKiosk_cli ZIP file from <a href="https://github.com/jharttech/RpiKiosk_cli/archive/master.zip">https://github.com/jharttech/RpiKiosk_cli/archive/master/zip</a> to your pi, then extract the files using the following commands:</br></p>
					<code><pre>$ cd /path/to/downloaded/RpiKiosk_cli-master.zip
$ unzip RpiKiosk_cli-master.zip
$ mv RpiKiosk_cli-master /home/pi/RpiKiosk_cli</pre></code>
					<p id="blog">3. Go into the RpiKiosk_cli folder:</br></p>
					<code><pre>$ cd
$ cd RpiKiosk_cli</pre></code>
					<p id="blog">4. Run the Install script: </br></p>
					<code><pre>$ chmod +x KioskInstall.sh
$ ./KioskInstall.sh</pre></code>
					<p id="blog">This will start the Installation script and will walk you through the setup of your kiosk or digital sign.  Simply follow the script and answer with the desired inputs.  Once the script has finished you should restart your pi for the changes to take effect.</br></p>
					<p id="blog"><h2><strong>NOTES</strong></h2></p>
					<p id="blog">I recommend you setting up a free Dakboard account at <a href="https://dakboard.com/site">Dakboard.com</a>.  This company will help you quickly set up a nice digital display for free. (The free version is limited on customizations).</br></p>
					<p id="blog">Screen Orientation:</br>This setting is dependant upon which way your digital sign (monitor or TV) is mounted.  Your options are "Landscape" or "Portrait".</br></br>Enter your URL:</br>The KioskInstall script will ask you for a URL to your kiosk, video, or slideshow.  If you are using DAKBoard, you will find this url under your account settings.  It will be called your Private URL.  If you are using google slides this will be your public published URL.  This URL can be an URL to any type of legal media that you wish to display on your digital sign.</br></br>Mouse Cursor Disable:</br>The KioskInstall script will ask if you would like to disable your mouse cursor.  If you choose to do so, you can revert this at a later time by running the "EnableCursor.sh" script in the RpiKiosk_cli folder.  If you choose not to disable the mouse cursor during installation, you can disable it later by running the "DisableCursor" script found in the RpiKiosk_cli folder.  The commands to run these scripts are:</br></p>
					<code><pre>$ cd /home/pi/RpiKiosk_cli
$ chmod +x EnableCursor.sh
$ ./EnableCursor</pre></code>
					<p id="blog">OR</br></p>
					<code><pre>$ cd /home/pi/RpiKiosk_cli
$ chmod +x DisableCursor
$ ./DisableCursor</pre></code>
					<p id="blog">Memory Split:</br>The KioskInstall script will ask if you would like to change the memory split of your pi.  If you do not no what this means please indicate that you would not like to change this value by entering "NO" when prompted.  You can change this later by running: </br></p>
					<code><pre>$ raspi-config</pre></code>
					<p id="blog">How to get to the terminal once you have installed the kiosk:</br>You may want to run other scripts or exit out of your newely created Kiosk.  To do this on your pi, press the "windows" key on your keyboard.  Next arrow down to "Accessories", arrow to the right one time, then arrow down to terminal and press the "enter" key.  Once the terminal is up, type the following command to stop the Kiosk:</br></p>
					<code><pre>$ killall chromium-browsers</pre></code>
					<p id="blog">(This will stop the kiosk and allow you to run other scripts or use your pi how ever you desire.)</br></p>
					<p id="blog"><h2><strong>UNINSTALL</strong></h2></p>
					<p id="blog">To uninstall the kiosk simply return to the terminal and run the following commands:</br></p>
					<code><pre>$ cd /home/pi/RpiKiosk_cli
$ chmod +x UndoPiKiosk.sh
$ ./UndoPiKiosk.sh</pre></code>
					<p id="blog">This will convert all config files back to original states and will enable the mouse if it has been disabled.</br></p>
					<p id="disclaim"><b>IN NO EVENT WILL WE BE LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, SPECIAL OR EXEMPLARY DAMAGES FOR ANY USE OF THIS SITE, OR USE OF ANY OTHER LINKED SITE, OR SOFTWARE, EVEN IF WE ARE ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.</b></br></br></p>

</html>
