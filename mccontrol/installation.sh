#!/bin/bash
#install.sh
# mcControl / MultiCraft easy plugin Updater
# Instalation bash File
complete_install () {
				mkdir -p /etc/mccontrol
				cp $pwd/mccontrol.sh /usr/local/bin/mccontrol
				chmod +x /usr/local/bin/mccontrol
				cp $pwd/add.sh /etc/mccontrol/add.sh
				cp $pwd/update.sh /etc/mccontrol/update.sh
				cp $pwd/add.sh /etc/mccontrol/add.sh
				cp $pwd/push.sh /etc/mccontrol/push.sh
				cp $pwd/config.cfg /etc/mccontrol/config.cfg
				cp $pwd/urlRepos.txt /etc/mccontrol/urlRepos.txt
#				cp $pwd/ALLFILENAME /etc/mccontrol/FILENAME
#				-->> copy all SOURCE files i will need
				echo "What is your MultiCraft main Path? eg: /home/minecraft/multicraft"
					read multicraft_path 
					replacement=s:mc_path=.*:mc_path=$multicraft_path:
					sed -i $replacement /etc/mccontrol/config.cfg
				echo "Enter your first Server-ID"
					read first_server
					replacement=s/serversIDarray=.*/serversIDarray=(${first_server})/
					sed -i $replacement /etc/mccontrol/config.cfg
				echo "Config file done. config.cfg can be found here: /etc/mccontrol/config.cfg"
				echo "To start using mccontrol, Type: mccontrol help"
				echo "..Done"
								source /etc/mccontrol/config.cfg
					mkdir -p $mc_path/plugins
					chmod 755 -R /etc/mccontrol/
					chmod 777 /etc/mccontrol/config.cfg
					chmod 777 /etc/mccontrol/urlRepos.txt
}

pwd=`pwd`
#main code
if [ "$UID" -ne 0 ]
		then
		echo "Please run as root"
		exit
	#if /etc/mccontrol already exist
	elif [ -d /etc/mccontrol ]
		then
		echo "/etc/mccontrol Already exist. Do you want to overwrite the existing instalation? (y/n)"
		read overwrite_answer
			if [ $overwrite_answer == "n" ]
				then
				echo "Canceling instalation."
				exit
			elif [ $overwrite_answer == "y" ]
				then
					complete_install
			fi
			
	else
		complete_install
					
fi

